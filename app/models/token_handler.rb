class TokenHandler < ActiveRecord::Base

  attr_accessor :consumer, :access_token

  def initialize
    @key      = '2HRjyOBd0RmnkzJC7sIM'
    @secret   = 'FoCmm2r3XVp5lRkYIE8TbSNN9HZKMpmzWBf3HdKc'

    @token    = '2NmGyiRzCEV8ZeZoLJOY'
    @token_s  = '2SVwG9Rin2s8RrxviPShLoEIWyaXEUJvvVPGEIJl'

    self.consumer
    self.access_token
  end

  def consumer
    @consumer = OAuth::Consumer.new(
      @key,
      @secret,
      :site => "",
      :scheme => :header
    )
  end

  def access_token
    @access_token = OAuth::AccessToken.from_hash(
        @consumer,
        :oauth_token => @token,
        :oauth_token_secret => @token_s
    )
  end

  def data(url)
    response = @access_token.get(url)
    JSON.parse(response.body)
  end

end