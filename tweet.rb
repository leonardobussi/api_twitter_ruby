require 'oauth'
require 'json'


class ApiTwitter
  CONSUMER_KEY = 'akPt2HuGzBt8QwtrrZe3op6eJ'
  CONSUMER_SECRET = 'nQ1UMYVZbDpXc2gBLqgqCat7kIJtsj1mzJGshvUSd7I2luvPal'

  OA_TOKEN = '1309114298464075781-iOCBhYr8TqZxVXfjis409XZBMnlp2z'
  OA_SECRET = 'ndjcRDLfArc6nWe4KLzbWwxh5XjaIeYWfbfWX48QOphX0'


  BASE_URI = 'https://api.twitter.com/1.1/'

  def initialize
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, { site: 'https://api.twitter.com', scheme: :header })
    token_hash = { oauth_token: OA_TOKEN, oauth_token_secret: OA_SECRET }
    @access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def query(method_name, path,options=nil)
    JSON.parse(@access_token.request(method_name, "#{BASE_URI}#{path}", options).body)
  end

  def home_line
    # JSON.parse(@access_token.request(:get, "#{BASE_URI}statuses/home_timeline.json", options).body)
    puts response = query(:get, 'statuses/home_timeline.json')
    out = File.new("output.json", "w")
    out.puts JSON(response)
  end
end


a = ApiTwitter.new
a.home_line