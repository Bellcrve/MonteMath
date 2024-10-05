import random
import math

class MonteCarlo:
    def __init__(self, stock_value, strike, volatility):
        self.stock_value = stock_value
        self.risk_free_interest = 0.0396 # 10 year treasury
        self.strike = strike # just one value for sim
        self.sigma = volatility # volatility
        self.delta_time = 1 # time in years

    # Geometric Brownian Motion
    def GBM(self):
        gaussian = random.gauss(0, 1)

        exponent = math.e ** ((self.risk_free_interest - (self.sigma ** 2) / 2) * self.delta_time
        + self.sigma * math.sqrt(self.delta_time) * gaussian) 

        st_delta_t = self.stock_value * exponent
        return st_delta_t
    

    def black_sholes():
        pass

def main():
    m = MonteCarlo(45.76, 45, .015)
    m = m.GBM()
    print(m)

if __name__ == "__main__":
    main()