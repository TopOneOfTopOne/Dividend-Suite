module StockInfo
	require 'yaml'
	require 'nokogiri'
	require 'open-uri'

	stocks_to_scrape_file = 'dividends.yml'
	STOCK_QUOTES_URL =  'http://www.morningstar.com.au/Stocks/NewsAndQuotes/'
	inFile = YAML.load_file(File.expand_path("../data/#{stocks_to_scrape_file}",File.dirname(__FILE__)))
	outFile = File.open(File.expand_path("../data/stock_info.yml", File.dirname(__FILE__)),'w')
	@stocks_info = []

	def self.get_info(code)
		puts "Attempting to get #{code}"
		page = Nokogiri::HTML(open("#{STOCK_QUOTES_URL}/#{code}"))
		last_price = page.css("div#wrapper div#maincontent div.LayerFatter5NoBorder.N_Q div.N_QPriceContainer div.N_QPriceLeft div span span").last.text
		datas = page.css('html body div#wrapper div#maincontent div.LayerFatter5NoBorder.N_Q div.N_QPriceContainer div.N_QPriceRight table tbody tr td span')
		info = datas.map do |data|
			data.text.gsub(/\s+/,'').gsub("\u00A0M",'')
		end
		info.pop(2) 
		info.insert(0, last_price)
		info #=> Format(last_price, open_price, day_range, year_range, market_cap, prev_close, today_volume, month_avg_volume, outstanding_shares, sector, industry)

	end

	def self.get_info_from_array(array = [])
		array.each do |el|
			add_to_stocks_info_array(el)
		end
		@stocks_info
	end

	def self.add_to_stocks_info_array(code)
		last_price, open_price, day_range, year_range, market_cap, prev_close, today_volume, month_avg_volume, outstanding_shares, sector, industry = get_info(code)
		@stocks_info <<  
		{
			last_price: last_price, open_price: open_price, day_range: day_range, year_range: year_range, market_cap: market_cap, \
			prev_close: prev_close, today_volume: today_volume, month_avg_volume: month_avg_volume, \
			outstanding_shares: outstanding_shares, sector: sector, industry: industry
		}
		sleep(2) # If you bombard MorningStar they seem to delay your requests
	end

	# def self.get_info_from_file
	# @stocks_info = []
	# inFile.each do |stock|
	# 	last_price, open_price, day_range, year_range, market_cap, prev_close, today_volume, month_avg_volume, outstanding_shares, sector, industry = get_info(stock[:code])
	# 	@stocks_info <<  
	# 	{
	# 		open_price: open_price, day_range: day_range, year_range: year_range, market_cap: market_cap, \
	# 		prev_close: prev_close, today_volume: today_volume, month_avg_volume: month_avg_volume, \
	# 		outstanding_shares: outstanding_shares, sector: sector, industry: industry
	# 	}
	# 	sleep(1)
	# end
	# outFile.puts stock_info
end

p StockInfo.get_info_from_array(['CBA', 'RIO', 'CIN'])