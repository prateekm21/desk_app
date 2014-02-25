require 'spec_helper'

describe Desk do
  let(:status_info) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/cases.json")) }
  let(:labels_info) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/labels.json")) }

  describe "#retrive_all_cases" do

    it "should return all cases" do
      host_keys = [:info, :status]
      Desk.should_receive(:token_handler_get).and_return(status_info)
      response = Desk.retrive_all_cases

      response.should be_instance_of(Hash)
      response.keys.flatten.sort.uniq.should == host_keys.sort
      response[:status].should eql(200)
    end

    it "should return error if infomration not available" do
      Desk.should_receive(:token_handler_get).and_return(nil)
      response = Desk.retrive_all_cases

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('Could not retrive case info')
      response[:status].should eql(400)
    end
  end

  describe "#retrive_all_labels" do

    it "should return all labels" do
      host_keys = [:info, :status]
      Desk.should_receive(:token_handler_get).and_return(labels_info)
      response = Desk.retrive_all_labels

      response.should be_instance_of(Hash)
      response.keys.flatten.sort.uniq.should == host_keys.sort
      response[:status].should eql(200)
    end

    it "should return error if infomration not available" do
      Desk.should_receive(:token_handler_get).and_return(nil)
      response = Desk.retrive_all_labels

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('Could not retrive labels info')
      response[:status].should eql(400)
    end
  end

  describe "#add_label" do

    it "should return return error if invalid color" do
      params   = {color: "bla", type: "case"}
      response = Desk.add_label params

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('invalid label color')
      response[:status].should eql(422)
    end

    it "should return return error if invalid type" do
      params   = {color: "blue", type: "bla"}
      response = Desk.add_label params

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('invalid label type')
      response[:status].should eql(422)
    end

    it "should return return response when label added" do
      Desk.should_receive(:update_case).and_return(true)

      params   = {color: "blue", type: "case"}
      Desk.should_receive(:token_handler_post).and_return({test: true})

      response = Desk.add_label params

      response.should be_instance_of(Hash)
      response[:status].should eql(200)
    end
  end

  describe "#update_case" do

    it "should apply label to first case" do
      Desk.should_receive(:token_handler_put).and_return({test: true})
      params   = {labels: "test"}
      response = Desk.update_case params

      response.should be_instance_of(Hash)
      response[:test].should be_true
    end
  end

end