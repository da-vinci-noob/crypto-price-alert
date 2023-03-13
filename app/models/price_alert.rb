class PriceAlert < ApplicationRecord
  require 'net/http'
  BINANCE_API_URL = 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'
  enum :status, { created: 0, triggered: 1, deleted: 2 }, default: :created, prefix: true
  belongs_to :user
  validates :target_price, numericality: { other_than: 0 }
  validates :target_price, uniqueness: { scope: :status, if: -> { status == 'created' } }

  before_save :add_operator

  private

  def add_operator
    uri = URI(BINANCE_API_URL)
    res = Net::HTTP.get_response(uri)
    price = JSON.parse(res.body).fetch('price') { nil }
    self.operator_check = if target_price.to_f > price.to_f
      '<='
    else
      '>='
    end
  end
end
