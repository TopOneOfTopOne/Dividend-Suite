require 'yaml'
# evaluates todays dividends 

@dividends_to_eval = YAML.load_stream(File.read File.expand_path('data/divs_to_eval.yml', File.dirname(__FILE__)))

@past_divs_file = File.open(File.expand_path('data/past_divs.yml', File.dirname(__FILE__)), 'a+')

@past_divs = []

def eval_day_range(div_to_eval)

	low, high = div_to_eval[:day_range].split('-')

	{low: low, high: high}
	
end


def eval(div_to_eval)

	hpc = div_to_eval[:hpc].to_f
	high = eval_day_range(div_to_eval)[:high].to_f

	reach_hypo = hpc <= high ? true : false

	liquid = div_to_eval[:today_volume].gsub(',','').to_i * div_to_eval[:last_price].to_f > 800_000 ? true : false

	percent_off = ((high-hpc)/hpc * 100).round(2)

	{reach_hypo: reach_hypo, liquid: liquid, percent_off: percent_off}

end


def write_to_past_divs_file

	@dividends_to_eval.each do |div_to_eval|

		@past_divs_file.puts eval(div_to_eval).merge(div_to_eval).to_yaml
	end

end

write_to_past_divs_file
puts "\n============== Done evaluating ==============\n"