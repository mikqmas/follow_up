class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :merchant_id, null: false, unique: true
      t.string :session_token, null: false
      t.string :token

      t.timestamps
    end
  end
end
