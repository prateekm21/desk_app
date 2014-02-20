require 'spec_helper'

describe TokenHandler do

  describe ".initialize" do
    it "should create instance of class" do
      obj = TokenHandler.new

      obj.should be_instance_of(TokenHandler)
    end

    it "should call method create_access_token" do
      TokenHandler.any_instance.should_receive(:create_access_token)
      obj = TokenHandler.new
    end

    it "should call method create_consumer_obj" do
      TokenHandler.any_instance.should_receive(:create_consumer_obj)
      obj = TokenHandler.new
    end
  end

  describe "#create_consumer_obj" do
    it "should return instance of OAuth::Consumer" do
      obj  = TokenHandler.new
      resp = obj.create_consumer_obj

      resp.should be_instance_of(OAuth::Consumer)
    end

    it "should contain desired keys in the instance of OAuth::Customer" do
      obj  = TokenHandler.new
      resp = obj.create_consumer_obj

      resp.secret.should eql(TokenHandler::SECRET)
      resp.key.should eql(TokenHandler::KEY)
    end
  end

  describe "#create_access_token" do
    it "should return instance of OAuth::AccessToken" do
      obj  = TokenHandler.new
      resp = obj.create_access_token

      resp.should be_instance_of(OAuth::AccessToken)
    end

    it "should contain desired keys in the instance of OAuth::Customer" do
      obj  = TokenHandler.new
      resp = obj.create_access_token

      resp.params[:oauth_token_secret].should eql(TokenHandler::TOKEN_S)
      resp.params[:oauth_token].should eql(TokenHandler::TOKEN)
    end
  end

  describe ".data" do
    it "should return desired json" do
      _url = "https://pmcompany.desk.com/api/v2/labels"
      obj  = TokenHandler.new

      mock_http = mock('http')
      res       = mock(Net::HTTPOK, :body => "{\"x\":\"data\"}")

      obj.access_token.stub(:get).with(_url).and_return(res)

      resp = obj.data(_url)

      resp['x'].should eql('data')
    end

  end
end
