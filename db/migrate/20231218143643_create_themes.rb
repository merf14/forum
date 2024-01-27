class CreateThemes < ActiveRecord::Migration[7.1]
  def change
    create_table :themes do |t|
      t.string :title, limit: 90, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
