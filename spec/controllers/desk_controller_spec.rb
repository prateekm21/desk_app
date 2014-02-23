require 'spec_helper'

describe DeskController do

  describe "GET :cases" do
    it "should return cases" do
      case_info = {info: true, status: 200}
      Desk.should_receive(:retrive_all_cases).and_return(case_info)

      get :cases

      response.status.should eql(200)
      response.body.should be_true
    end
  end

  describe "GET :labels" do
    it "should return labels" do
      case_info = {info: true, status: 200}
      Desk.should_receive(:retrive_all_labels).and_return(case_info)

      get :retrive_labels

      response.status.should eql(200)
      response.body.should be_true
    end
  end

  describe "POST :create_label" do
    it "should return error if :label is missing in request" do

      post :create_label

      response.body.should be_true

      (JSON.parse(response.body))['error'].should eql('label missing')
      response.status.should eql(422)
    end

    it "should return info after label create request" do
      case_info = {info: true, status: 200}
      Desk.should_receive(:add_label).and_return(case_info)

      post :create_label, :label => "test"

      response.body.should be_true
      response.status.should eql(200)
    end
  end

end