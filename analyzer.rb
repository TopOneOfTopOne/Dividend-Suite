f_path = File.expand_path('data/O.txt', File.dirname(__FILE__))
F = File.open(f_path,'r').readlines

NUM_STOCKS = F.reject {|line| line == "\n"}.count 
total_trues = F.select {|line| line.include? 't'}.count
total_upstate = F.select {|line| line.include? 'u'}.count
trues_upstate = F.select {|line| (line.include? 't') && (line.include? 'u')}.count
total_illiquid = F.select {|line| line.include? 'i'}.count
trues_illiquid = F.select {|line| (line.include? 'i') && (line.include? 't')}.count
total_liquid = NUM_STOCKS - total_illiquid
trues_liquid = F.select { |line| (line.include? 'l') && (line.include? 't')}.count

percentage_true = (total_trues/NUM_STOCKS.to_f) * 100
percentage_true_up_state = (trues_upstate/total_upstate.to_f) * 100
percentage_true_liquid = (trues_liquid/total_liquid.to_f) * 100 
percentage_true_illiquid = (trues_illiquid/total_illiquid.to_f) * 100
puts "\n"
puts "Satisfaction level: %#{percentage_true.round(2)}"
puts "Liquid stocks:      %#{percentage_true_liquid.round(2)}"
puts "Illiquid stocks:    %#{percentage_true_illiquid.round(2)}"
puts "Up state:           %#{percentage_true_up_state.round(2)}"
