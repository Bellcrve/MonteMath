MonteCarloSimulation[stockValue_, strike_, volatility_, steps_, simulations_] := Module[
  {
    stockValueLocal = stockValue,
    strikeLocal = strike,
    sigmaLocal = volatility,
    stepsLocal = steps,
    simulationsLocal = simulations,
    payoffs = {},
    riskFreeInterest = 0.03969,
    timeToExpiration = 1,
    deltaTime = 1 / 252
  },
  
  Association[
    "GeometricBrownianMotion" -> (Function[
      optionType,
      Module[
        {stDeltaTSum = stockValueLocal, gaussian, exponent, payoff},
        
        Do[
          gaussian = RandomVariate[NormalDistribution[0, 1]];
          exponent = (riskFreeInterest - 0.5 * sigmaLocal^2) * deltaTime + sigmaLocal * Sqrt[deltaTime] * gaussian;
          stDeltaTSum *= Exp[exponent],
          {stepsLocal}
        ];
        
        payoff = Which[
          ToLowerCase[optionType] == "call", Max[stDeltaTSum - strikeLocal, 0],
          ToLowerCase[optionType] == "put", Max[strikeLocal - stDeltaTSum, 0],
          True, Throw["Invalid option type"]
        ];
        
        AppendTo[payoffs, payoff];
        
        stDeltaTSum
      ]
    ]),
    
    "BlackScholes" -> (Function[
      optionType,
      Module[
        {N, d1, d2, cost},
        
        N[x_] := CDF[NormalDistribution[0, 1], x];
        
        d1 = (Log[stockValueLocal / strikeLocal] + (riskFreeInterest + 0.5 * sigmaLocal^2) * timeToExpiration) / (sigmaLocal * Sqrt[timeToExpiration]);
        d2 = d1 - sigmaLocal * Sqrt[timeToExpiration];
        
        cost = Which[
          ToLowerCase[optionType] == "call",
          stockValueLocal * N[d1] - strikeLocal * Exp[-riskFreeInterest * timeToExpiration] * N[d2],
          
          ToLowerCase[optionType] == "put",
          strikeLocal * Exp[-riskFreeInterest * timeToExpiration] * N[-d2] - stockValueLocal * N[-d1],
          
          True,
          Throw["Invalid option type"]
        ];
        
        cost
      ]
    ]),
    
    "Payoffs" -> payoffs
  ]
];

sim = MonteCarloSimulation[45, 47, 0.015, 252, 100];


gbmResult = sim["GeometricBrownianMotion"]["call"];
Print["Geometric Brownian Motion Result: ", gbmResult];

bsPrice = sim["BlackScholes"]["call"];
Print["Black-Scholes Price: ", bsPrice];

Print["Results: ", {gbmResult, bsPrice}];
