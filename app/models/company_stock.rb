require 'net/http'
require 'json'

class CompanyStock < ApplicationRecord

  def self.new_lookup(ticker_symbol) 
    company_info = get_data('tickers', ticker_symbol)
    stock_prices = get_data('eod',     ticker_symbol)

    if company_info && stock_prices
      new(ticker: ticker_symbol, name: company_info['name'], last_price: stock_prices['close'])
    else 
      nil
    end
  end

  private

  def self.get_data(endpoint, ticker_symbol)
    params = { 
      :access_key => Rails.application.credentials.market_stack[:api_key], 
      :symbols => "#{ticker_symbol}",
      :limit => 1 
    }
    path      = endpoint.eql?('eod')? "eod" : "tickers/#{ticker_symbol}"
    uri       = URI("http://api.marketstack.com/v1/#{path}")
    uri.query = URI.encode_www_form(params)
    json      = Net::HTTP.get(uri)
    full_data = JSON.parse(json)

    begin    
       ret_data  = endpoint.eql?('eod')? full_data['data'].first : full_data
    rescue => exception
      nil
    end
  end
end