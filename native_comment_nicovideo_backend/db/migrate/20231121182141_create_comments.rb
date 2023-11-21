class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :comment_id
      t.string :comment

      t.timestamps
    end
  end
end
