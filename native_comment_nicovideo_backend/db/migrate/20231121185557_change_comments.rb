class ChangeComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :comment
    add_column :comments, :content, :string
    add_column :comments, :status, :string
  end
end
