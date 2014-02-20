class DeskController < ApplicationController

  def index
    #
  end

  def cases
    data = Desk.retrive_all_cases
    render json: data[:info], status: data[:status]
  end

  def retrive_labels
    data = Desk.retrive_all_labels
    render json: data[:info], status: data[:status]
  end
end