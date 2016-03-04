require_relative 'HPC'
require 'yaml'
require 'time'
		
		# def get_items(items)
		# 	code = items[0]
		# 	pcum = items[1].to_f 
		# 	div = items[2].to_f
		# 	frank = items[3].to_i
		# 	div_yield = (div/pcum).round(2)
		# 	[code,pcum,div,frank,div_yield]
		# end

		# o_path = File.expand_path('data/O.txt', File.dirname(__FILE__))
		# research_path = File.expand_path('data/research.txt', File.dirname(__FILE__))
		# i_path = File.expand_path('data/I.txt', File.dirname(__FILE__))
		# o = File.open(o_path,'a+')
		# research = File.open(research_path,'a+')
		# i = File.open(i_path,'r').readlines
		
		# research.puts "========================== =========================="
		# i.each do |line|
		# 	code, pcum, div, frank, div_yield = get_items(line.split)
		# 	hypo_price = HPC::hpc(pcum, div, frank)
		# 	o.puts "#{code}: #{hypo_price}"
		# 	research.puts "(#{code}: #{hypo_price} #{frank} #{div_yield})"
		# end



		# puts 'done..'


outFile = File.open(File.expand_path('data/O.txt', File.dirname(__FILE__)),'a+')
dividends =  YAML.load_file(File.expand_path('data/dividends.yml', File.dirname(__FILE__)))
#outFile.puts "==================================== ============================="
dividends.each do |dividend|
	ex_div_date = Time.parse(dividend[:ex_div_date])
	cTime = Time.now
	if ex_div_date.year == cTime.year && ex_div_date.month == cTime.month && ex_div_date.day == 8
		outFile.puts "(#{dividend[:code]} #{dividend[:franking]})"
	end 
end
puts 'Done..'
