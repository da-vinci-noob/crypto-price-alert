class PagesController < ApplicationController
  respond_to :json

  def home
    render json: { message: 'Nothing is here'}
  end
end
