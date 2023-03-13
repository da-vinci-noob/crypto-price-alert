class AddOperatorCheckToPriceAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :price_alerts, :operator_check, :string
  end
end
