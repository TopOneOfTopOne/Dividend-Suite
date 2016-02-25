f_path = File.expand_path('data/O.txt', File.dirname(__FILE__))
F = File.open(f_path,'r').readlines

NUM_STOCKS = F.reject {|line| line == "\n"}.count 
def calc_total_num_trues 
	F.select {|line| line.include? 't'}.count
end

def calc_num_trues_in_up_state
	F.select {|line| (line.include? 't') && (line.include? 'u')}.count 
end

def calc_num_trues_illiquid 
	F.select {|line| (line.incldue? 't') && (line.include? 'i')}.count 
end
# p F 
# puts NUM_STOCKS
# puts calc_total_num_trues
 percentage_true = (calc_total_num_trues/NUM_STOCKS.to_f) * 100
 puts "Satisfaction level: #{percentage_true.round(2)}"