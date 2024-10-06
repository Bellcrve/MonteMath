# Distributed Computing of the Monte Carlo Simulation on Options Pricing

The Monte Carlo Simulation is a stochastic method for estimating the option price of a financial instrument by simulating various future paths and averaging the discounted payoff. This is useful when pricing complex derivatives where close-formed solutions are not available.

The goal of this research is to distribute the simulations across 10 virtual machines where each machine handles 2,000 simulations each.

We define variables:

$$
let \begin{cases}
r &= \text{Risk-free interest} \\
S_{0} &= \text{Current stock price} \\
Z &\sim \mathcal{N}(0, 1) \\
\Delta t &= \text{Time increment} \\
\sigma &= \text{Volatility} \\
K &= \text{Strike price} \\
T &= \text{Expiration date}
\end{cases}
$$

Then we can calculate the

## Geometric Brownian Motion

## Black Scholes
