class DeskController < ApplicationController

  def index
    #
  end

  def cases
    data = Desk.retrive_all_cases
    render json: data, status: 200
  end

  def retrive_labels
    data = Desk.retrive_all_labels
    render json: data, status: 200
  end
end