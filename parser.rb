require_relative 'HPC'
require_relative 'scraping/stock_info_scraper'
require 'yaml'
require 'time'

@research_File = File.open(File.expand_path('data/research.txt', File.dirname(__FILE__)),'a+')
@dividends =  YAML.load_file(File.expand_path('data/dividends.yml', File.dirname(__FILE__)))
@EX_DIV_DATE = Time.parse('8/03/2016')

def get_upcoming_dividends
	@dividends.map do |dividend|
		ex_div_date = Time.parse(dividend[:ex_div_date])
		cTime = Time.now
		dividend if (ex_div_date.strftime('%x') ==  @EX_DIV_DATE.strftime('%x'))
	end.compact 
end

def calculations(dividend) # calcs #=> yield, hypo
	stock_info = StockInfo.get_info(dividend[:code])
	div_yield = dividend[:amount].to_f/stock_info[:last_price].to_f
	hpc = HPC.hpc(stock_info[:last_price].to_f, dividend[:amount].to_f, dividend[:franking].to_f)
	{div_yield: div_yield, hpc: hpc}
end

def write_to_research_file #=> meant to write all the required information for today's dividends i.e. Tomorrow's ex-dividend dates
	@research_File.puts "==================================== #{@EX_DIV_DATE.strftime("%d/%m/%Y")} ===================================="
	get_upcoming_dividends.each do |dividend|
		calcs = calculations(dividend)
		@research_File.puts "(#{dividend[:code]}: #{calcs[:hpc].round(3)} #{dividend[:franking]} #{calcs[:div_yield].round(2)})"
	end
end

write_to_research_file
puts 'Done..'
