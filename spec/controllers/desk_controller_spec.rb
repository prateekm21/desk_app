require 'spec_helper'

describe DeskController do

  describe "GET :cases" do
    it "should return cases" do
      case_info = {okay: true}
      Desk.should_receive(:retrive_all_cases).and_return(case_info)

      get :cases

      response.status.should eql(200)
      JSON.parse(response.body)['okay'].should be_true
    end
  end

  describe "GET :labels" do
    it "should return labels" do
      case_info = {okay: true}
      Desk.should_receive(:retrive_all_labels).and_return(case_info)

      get :retrive_labels

      response.status.should eql(200)
      JSON.parse(response.body)['okay'].should be_true
    end
  end

end