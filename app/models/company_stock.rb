require 'net/http'
require 'json'

class CompanyStock < ApplicationRecord

  def self.new_lookup(ticker_symbol) 
    params    = { :access_key => Rails.application.credentials.market_stack[:api_key], 
                  :symbols => "#{ticker_symbol}",
                  :limit => 1 
                }
    uri       = URI('http://api.marketstack.com/v1/eod')
    uri.query = URI.encode_www_form(params)
    json      = Net::HTTP.get(uri)
    data      = JSON.parse(json)['data'].first

    closing_price = data['close']
  end
end
