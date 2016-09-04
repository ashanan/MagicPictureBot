require 'net/http'
require 'json'
require "open-uri"

require_relative 'config.rb'

class MagicBot
	attr_reader :client

	def initialize
		@client = Configuration.twitter_client
	end
	
	def find_image(text="magic")
		image = {}
	
		page_size = 100
		page = rand(23)
		uri = URI("http://api.dp.la/v2/items/?q=#{text}&api_key=#{DPLibrary.api_key}&sourceResource.type=image&page=#{page}&page_size=#{page_size}")
		response = Net::HTTP.get(uri)
		response_hash = JSON.parse(response)
		items = response_hash['docs']
		item = items[rand(items.length)]
		
		image['url'] = item['object']
		image['title'] = item["sourceResource"]['title']
		
		image
	end
	
	def post(image)
		image_path = 'tmp_magic_img.png'
		File.open(image_path, 'wb') do |fo|
		  fo.write open(image['url']).read 
		end

		if image['title'].length < 140
			@client.update_with_media("#{image['title']}", File.new(image_path))
		else
			puts '140, wtf'
		end		
	end

	def post_random
		image = nil
		loop do
			image = find_image
			break if image['title'].length < 140
		end
	
		post(image)
	end

end


bot = MagicBot.new

bot.post_random