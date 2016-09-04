require 'DPLibrary'
require 'twitter'

DPLibrary.api_key = 'YOUR_DPLA_API_KEY'

module Configuration

	def self.twitter_client
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "YOUR_CONSUMER_KEY"
		  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
		  config.access_token        = "YOUR_ACCESS_TOKEN"
		  config.access_token_secret = "YOUR_ACCESS_SECRET"
		end
		
		client
	end

end
