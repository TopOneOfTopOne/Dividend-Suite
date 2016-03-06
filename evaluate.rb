require 'yaml'
# evaluates todays dividends 

dividends_to_eval = YAML.load_file(File.expand_path('data/divs_to_eval.yml', File.dirname(__FILE__)))

past_divs_file = File.open(File.expand_path('data/past_divs', File.dirname(__FILE__)))


def eval_day_range(div_to_eval)

	low, high = div_to_eval[:day_range].split('-')

	{low: low, high: high}
	
end


def eval(div_to_eval)

	hpc = div_to_eval[:hpc].to_f
	high = eval_day_range(div_to_eval)[:high].to_f

	reach_hypo = hpc <= high ? true : false

	liquid = div_to_eval[:today_volume].to_i > 100 ? true : false

	percent_off = ((high-hpc)/hpc * 100).round 

	industry = div_to_eval[:industry]

	sector = div_to_eval[:sector]

	div_yield = div_to_eval[:div_yield]

	{reach_hypo: reach_hypo, liquid: liquid, percent_off: percent_off, industry: industry, sector: sector, div_yield: div_yield}

end


def write_to_past_divs_file

	dividends_to_eval.each do |div_to_eval|
		past_divs_file.puts eval(div_to_eval)
	end

end