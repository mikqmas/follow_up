class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :customer_uuid
      t.string :merchant_uuid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
