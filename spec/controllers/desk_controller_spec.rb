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

end