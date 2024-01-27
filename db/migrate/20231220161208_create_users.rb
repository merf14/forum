class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 15, null: false
      t.string :email, limit: 30, null: false
      t.string :password, limit: 510, null: false
      t.timestamps
    end
  end
end
