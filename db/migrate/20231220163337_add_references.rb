class AddReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :answers, :theme, null: false, foreign_key: true
    add_reference :answers, :user, null: false, foreign_key: true
    add_reference :themes, :user, null: false, foreign_key: true
  end
end
