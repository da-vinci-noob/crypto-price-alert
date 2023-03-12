class CreatePriceAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :price_alerts do |t|
      t.integer :status, default: 0
      t.decimal :target_price, precision: 10, scale: 3
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
