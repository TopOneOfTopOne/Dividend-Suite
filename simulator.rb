# require_relative 'HPC'
# 4000 yield period franking transaction_cost (assume price of share does not matter)

# No difference between low yield and high yield 
# yield:50%            yield:80%
# ma = 100 wealth = 100  ma = 100 wealth = 100 (t0)
# ma = 50  wealth = 121.43 ma = 20 wealth = 134.28 (t1)
# ma = 25 wealth = 132.14 ma = 4 wealth = 141.14
# ma = 12.5 wealth = 137.5 ma = 0.8 wealth = 142.5
# ma = 6.25 wealth = 


# key assumptions: price drops by dividend amount for now franking is at 100%
starting_money = 4000
money = starting_money
wealth = starting_money
period = 30 # (length of time until you get dividends back)
time =  0 
year = 365
pending_dividends = {}
franking = 1 
transaction_cost = 40
transactions = 0 
_yield = 0.025


while time < year 
  if money > 2000
  	dividend = money*(_yield)
  	franking_credit = (dividend/0.7)-dividend
  	pending_dividends[time+period] = dividend
  	wealth += franking_credit # assuming price drops by dividend we just add the franking credits to total wealth
  	money = money*(1-_yield) - transaction_cost
  	transactions += 1
  end
  money += pending_dividends[time] if pending_dividends.has_key?(time)
  # puts "Money: #{money} Wealth: #{wealth}"
  # p pending_dividends
  time += 1
end
puts "Transactions: #{transactions}"
puts "Ending money: #{money} wealth: #{wealth}"