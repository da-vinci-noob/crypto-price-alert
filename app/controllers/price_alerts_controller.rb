class PriceAlertsController < ApplicationController
  include Pagy::Backend
  respond_to :json
  before_action :authenticate_user!

  def create
    alert = current_user.price_alerts.new(price_alerts_params)
    @success = alert.save
    render_response
  end

  def delete
    alert = current_user.price_alerts.status_created.find_by(target_price: price_alerts_params['target_price'])
    @success = alert&.status_deleted!
    render_response
  end

  def all_alerts
    status = params[:status] ? "status_#{params[:status]}".downcase : 'all'
    cache_key = "user-#{current_user.id}-alerts-#{status}-page-#{params[:page]}-per-page#{params[:per_page]}"
    @pagy, @alerts = Rails.cache.fetch(cache_key, expires_in: 1.minute) do
      alerts = current_user.price_alerts.public_send(status).to_a
      pagy_array(alerts, items: params[:per_page])
    end
  rescue Pagy::OverflowError => e
    render json: { message: "Page Not Found, Total Pages are #{e.pagy.last}" }, status: :not_found
  rescue  Pagy::VariableError
    render json: { message: 'Invalid Page Number Provided' }, status: :unprocessable_entity
  rescue NoMethodError
    message = "Invalid Status Provided. Valid Status are [#{PriceAlert.statuses.keys.join(', ')}]"
    render json: { message: message }, status: :unprocessable_entity
  end

  private

  def price_alerts_params
    params.require(:alert).permit(:target_price, :status)
  end

  def render_response
    if @success
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end
end
