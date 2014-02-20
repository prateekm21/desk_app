require 'spec_helper'

describe Desk do
  let(:status_info) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/cases.json")) }
  let(:labels_info) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/labels.json")) }

  describe "#retrive_all_cases" do

    it "should return all cases" do
      host_keys = [:info, :status]
      Desk.should_receive(:token_handler_obj).and_return(status_info)
      response = Desk.retrive_all_cases

      response.should be_instance_of(Hash)
      response.keys.flatten.sort.uniq.should == host_keys.sort
      response[:status].should eql(200)
    end

    it "should return error if infomration not available" do
      Desk.should_receive(:token_handler_obj).and_return(nil)
      response = Desk.retrive_all_cases

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('Could not retrive case info')
      response[:status].should eql(422)
    end
  end

  describe "#retrive_all_labels" do

    it "should return all labels" do
      host_keys = [:info, :status]
      Desk.should_receive(:token_handler_obj).and_return(labels_info)
      response = Desk.retrive_all_labels

      response.should be_instance_of(Hash)
      response.keys.flatten.sort.uniq.should == host_keys.sort
      response[:status].should eql(200)
    end

    it "should return error if infomration not available" do
      Desk.should_receive(:token_handler_obj).and_return(nil)
      response = Desk.retrive_all_labels

      response.should be_instance_of(Hash)
      response[:info][:error].should eql('Could not retrive labels info')
      response[:status].should eql(422)
    end
  end

end