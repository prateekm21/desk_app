class TokenHandler

  attr_reader :consumer, :access_token

  KEY      = '2HRjyOBd0RmnkzJC7sIM'
  SECRET   = 'FoCmm2r3XVp5lRkYIE8TbSNN9HZKMpmzWBf3HdKc'

  TOKEN    = '2NmGyiRzCEV8ZeZoLJOY'
  TOKEN_S  = '2SVwG9Rin2s8RrxviPShLoEIWyaXEUJvvVPGEIJl'

  def initialize
    create_consumer_obj
    create_access_token
  end

  def create_consumer_obj
    @consumer = OAuth::Consumer.new(
      KEY,
      SECRET,
      :site   => "http://pmcompany.desk.com",
      :scheme => :header
    )
  end

  def create_access_token
    @access_token = OAuth::AccessToken.from_hash(
        @consumer,
        :oauth_token => TOKEN,
        :oauth_token_secret => TOKEN_S
    )
  end

  def data(url)
    response = @access_token.get(url)
    JSON.parse(response.body)
  end

end