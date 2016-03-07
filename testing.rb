require 'yaml'

array = []
YAML.load_stream(File.read File.expand_path('data/past_divs.yml', File.dirname(__FILE__))) {|doc| array << doc}
p array
