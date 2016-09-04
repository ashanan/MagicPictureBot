require 'sinatra'

require_relative 'bot'

get '/random' do
  @bot = MagicBot.new
  @bot.post_random

  'OK'
end
