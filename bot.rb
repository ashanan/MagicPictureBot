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
	
		page_size = 500
		page = 1
		uri = URI("http://api.dp.la/v2/items/?q=#{text}&api_key=#{DPLibrary.api_key}&sourceResource.type=image&page=#{page}&page_size=#{page_size}")
		response = Net::HTTP.get(uri)
		response_hash = JSON.parse(response)
		items = response_hash['docs']
		item = items[rand(items.length)]
		
		image['url'] = item['object']
		image['title'] = item["sourceResource"]['title']
		
		image
	end
	
	def post_random
		image = find_image
		
		
	
		File.open('tmp_magic_img.png', 'wb') do |fo|
		  fo.write open(image['url']).read 
		end
		
		
		@client.update_with_media("#{image['title']}", File.new("tmp_magic_img.png"))
	end

end


bot = MagicBot.new

bot.post_random