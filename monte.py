import random
import math
import scipy.stats
import constants as c

class MonteCarloSimulation:
    def __init__(self, stock_value, strike, volatility):
        # class vars for GBM
        self.stock_value = stock_value
        self.risk_free_interest = c.RISK_FREE_INTEREST 
        self.strike = strike 
        self.sigma = volatility 
        self.delta_time = c.DELTA_TIME 

    def Geometric_Brownian_Motion(self):
        gaussian = random.gauss(0, 1)

        exponent = ((self.risk_free_interest - 0.5 * self.sigma ** 2) 
                    * self.delta_time + self.sigma * math.sqrt(self.delta_time) * gaussian)

        st_delta_t = self.stock_value * math.exp(exponent)

        return st_delta_t

    def Black_Scholes(self, option_type="call"):
        N = scipy.stats.norm.cdf

        d1 = (math.log(self.stock_value / self.strike) + (self.risk_free_interest 
            + 0.5 * self.sigma ** 2) * self.delta_time) / (self.sigma * math.sqrt(self.delta_time))
        d2 = d1 - self.sigma * math.sqrt(self.delta_time)

        if option_type == "call":
            cost = self.stock_value * N(d1) - self.strike * math.exp(-self.risk_free_interest * self.delta_time) * N(d2)
        elif option_type == "put":
            cost = self.strike * math.exp(-self.risk_free_interest * self.delta_time) * N(-d2) - self.stock_value * N(-d1)
        else:
            raise ValueError
        
        return cost

