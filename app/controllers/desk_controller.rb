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

  def create_label
    if params[:label].blank?
      render json: {error: "label missing"}, status: 422
    else
      data = Desk.add_label params
      render json: data[:info], status: data[:status]
    end
  end
end