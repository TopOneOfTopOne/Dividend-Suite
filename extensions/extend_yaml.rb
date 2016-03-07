require 'yaml'

module YAML
	def self.load_stream_array(file_path)
		array = []
		load_stream(File.read file_path) {|doc| array << doc}
		array
	end
end
