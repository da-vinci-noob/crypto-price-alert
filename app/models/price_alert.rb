class PriceAlert < ApplicationRecord
  enum :status, { created: 0, triggered: 1, deleted: 2 }, default: :created, prefix: true
  belongs_to :user
  validates :target_price, numericality: { other_than: 0 }
  validates :target_price, uniqueness: { scope: :status, if: -> { status == 'created' } }
end
