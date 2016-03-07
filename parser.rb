require_relative 'HPC'
require_relative 'scraping/stock_info_scraper'
require_relative 'scraping/dividends_scraper' # update the dividends.yml file 
require 'yaml'
require 'time'

module Parser
	@research_File = File.open(File.expand_path('data/research.txt', File.dirname(__FILE__)),'a+')
	@dividends =  YAML.load_file(File.expand_path('data/dividends.yml', File.dirname(__FILE__)))
	@divs_to_eval_File = File.open(File.expand_path('data/divs.to_eval.yml', File.dirname(__FILE__)),'w')
	@divs_to_eval = []
	@EX_DIV_DATE = Time.parse('8/03/2016')

	def self.get_upcoming_dividends
		@dividends.map do |dividend|
			ex_div_date = Time.parse(dividend[:ex_div_date])
			dividend if (ex_div_date.strftime('%x') ==  @EX_DIV_DATE.strftime('%x'))
		end.compact 
	end

	def self.calculations(dividend) # calcs #=> yield, hypo
		stock_info = StockInfo.get_info(dividend[:code])
		div_yield = dividend[:amount].to_f/stock_info[:last_price].to_f
		hpc = HPC.hpc(stock_info[:last_price].to_f, dividend[:amount].to_f, dividend[:franking].to_f)
		{div_yield: div_yield, hpc: hpc}
	end

	def self.write_to_research_file #=> meant to write all the required information for today's dividends i.e. Tomorrow's ex-dividend dates
		@research_File.puts "==================================== #{@EX_DIV_DATE.strftime("%d/%m/%Y")} ===================================="
		get_upcoming_dividends.each do |dividend|
			calcs = calculations(dividend)
			@research_File.puts "(#{dividend[:code]}: #{calcs[:hpc].round(3)} #{dividend[:franking]} #{calcs[:div_yield].round(2)})"
			@divs_to_eval << dividend.merge({hpc: calcs[:hpc].round(3), div_yield: div_yield.round(2)})
		end
	end

	def self.write_to_divs_to_eval_file
		@divs_to_eval.collect! do |div|
			StockInfo.get_info(div[:code]).merge(div) # get latest info on stock 
		end
		@divs_to_eval_File.puts @divs_to_eval.to_yaml 
	end
end


Parser.write_to_research_file if Time.now < @EX_DIV_DATE # execute this day before ex-div date during market close
Parser.write_to_divs_to_eval_file if Time.now > @EX_DIV_DATE # excute this few hours after trading on ex-div date 
puts '============== Done writing to appropriate files =============='
