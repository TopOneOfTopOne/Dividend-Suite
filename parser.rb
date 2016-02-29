require_relative 'HPC'
		
		def get_items(items)
			code = items[0]
			pcum = items[1].to_f 
			div = items[2].to_f
			frank = items[3].to_i
			div_yield = (div/pcum).round(2)
			[code,pcum,div,frank,div_yield]
		end

		o_path = File.expand_path('data/O.txt', File.dirname(__FILE__))
		research_path = File.expand_path('data/research.txt', File.dirname(__FILE__))
		i_path = File.expand_path('data/I.txt', File.dirname(__FILE__))
		o = File.open(o_path,'a+')
		research = File.open(research_path,'a+')
		i = File.open(i_path,'r').readlines
		

		i.each do |line|
			code, pcum, div, frank, div_yield = get_items(line.split)
			hypo_price = HPC::hpc(pcum, div, frank)
			o.puts "#{code}: #{hypo_price}"
			research.puts "#{code}: #{hypo_price} #{frank} #{div_yield}"
		end

		puts 'done..'
