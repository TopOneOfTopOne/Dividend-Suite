require_relative 'HPC'
		
		def get_items(items)
			code = items[0]
			pcum = items[1].to_f 
			div = items[2].to_i
			frank = items[3].to_i
			[code,pcum,div,frank]
		end


		o = File.open('data/O.txt','a+')
		i = File.open("data/I.txt",'r').readlines
		

		i.each do |line|
			code, pcum, div, frank = get_items(line.split)
			hypo_price = HPC::hpc(pcum, div, frank)
			o.puts "#{code}: #{hypo_price}"
		end

		puts 'done..'
