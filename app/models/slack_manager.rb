require 'net/http'
require 'uri'
require 'json'

require 'dotenv'

class SlackManager


  def self.sendMessage(sendMsg,sendChannel)
  	Dotenv.load! "config/setting/globalconfig.env"
  	data = { "text" => "#{sendMsg}", "username" => "checkScript","channel" => "#{sendChannel}"}
    request_url = "#{ENV['WEBHOOK_URL']}"
    uri = URI.parse(request_url)
    Net::HTTP.post_form(uri, {"payload" => data.to_json})  
  end
end