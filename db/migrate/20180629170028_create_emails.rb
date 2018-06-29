class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :email_address
      t.string :order_uuid
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
