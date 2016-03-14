module StockInfo
	require 'yaml'
	require 'nokogiri'
	require 'open-uri'

	stocks_to_scrape_file = 'dividends.yml'
	STOCK_QUOTES_URL =  'http://www.morningstar.com.au/Stocks/NewsAndQuotes/'
	inFile = YAML.load_file(File.expand_path("../data/#{stocks_to_scrape_file}",File.dirname(__FILE__)))
	# outFile = File.open(File.expand_path("../data/stock_info.yml", File.dirname(__FILE__)),'w')

	def self.get_info(code)
		puts "Attempting to get #{code}"
		begin
			page = Nokogiri::HTML(open("#{STOCK_QUOTES_URL}/#{code}"))
			last_price = page.css("div#wrapper div#maincontent div.LayerFatter5NoBorder.N_Q div.N_QPriceContainer div.N_QPriceLeft div span span").last.text
			datas = page.css('html body div#wrapper div#maincontent div.LayerFatter5NoBorder.N_Q div.N_QPriceContainer div.N_QPriceRight table tbody tr td span') 
		rescue Exception => e
			puts "\tError occured #{e}"
			return {last_price: 1, open_price: 1, day_range: 1, year_range: 1, market_cap: 1, \
			prev_close: 1, today_volume: 1, month_avg_volume: 1, \
			outstanding_shares: 1, sector: 1, industry: 1}
		end
		puts "\t Success!"
		info = datas.map do |data|
			data.text.gsub(/\s+/,'').gsub("\u00A0M",'').gsub('$','')
		end
		{
			last_price: last_price, open_price: info[0], day_range: info[1], year_range: info[2], market_cap: info[3], \
			prev_close: info[4], today_volume: info[5], month_avg_volume: info[6], \
			outstanding_shares: info[7], sector: info[8], industry: info[9]
		}
	end

	def self.get_info_from_array(array = [])
		array.map {|code| get_info(code)}
	end
end

# p StockInfo.get_info_from_array(['CBA', 'RIO', 'CIN'])
# p StockInfo.get_info('CBA')