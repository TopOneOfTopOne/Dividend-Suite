require 'yaml'
require_relative 'extensions/extend_yaml'
#mpast_divs = YAML.load_file(File.expand_path('data/past_divs.yml', File.dirname(__FILE__)))
@past_divs = YAML.load_stream_array(File.expand_path('data/past_divs.yml', File.dirname(__FILE__)))
@NUM_PAST_DIVS = @past_divs.count.to_f
@NUM_LIQUID = @past_divs.select {|div| div[:liquid]}.count.to_f
@NUM_NOT_LIQUID = @past_divs.select { |div| !div[:liquid] }.count.to_f
percent_reach_hypo = ((@past_divs.inject(0) {|total, div| div[:reach_hypo] ? total+1 : total}/@NUM_PAST_DIVS) * 100).round(2)
percent_liq_reach_hypo = (@past_divs.select {|div| (div[:reach_hypo]) && (div[:liquid])}.count/@NUM_LIQUID * 100).round(2)
percent_not_liq_reach_hypo = (@past_divs.select {|div| (div[:reach_hypo]) && (!div[:liquid])}.count/@NUM_NOT_LIQUID * 100).round(2)

def avg_percent_move
	count = 0
	sum = 0

	hash = yield 
	liquid = hash[:liquid]
	reach_hypo = hash[:reach_hypo]

	total = @past_divs.each do |div|
		if div[:liquid] == liquid && div[:reach_hypo] == reach_hypo
			count += 1
			sum += div[:percent_off]
		end
	end

	 sum/count unless count == 0 
end

puts "Satisfaction level: #{percent_reach_hypo}"
puts "Average percentage off hypo(liquid): #{avg_percent_move{{liquid: true, reach_hypo: false}}}"
puts "Average percentage off hypo(not liquid): #{avg_percent_move{{liquid: false, reach_hypo: false}}}"
puts "Average percentage gain (liquid): #{avg_percent_move{{liquid: true, reach_hypo: true}}}"
puts "Average percentage gain (not liquid): #{avg_percent_move{{liquid: false, reach_hypo: true}}}"