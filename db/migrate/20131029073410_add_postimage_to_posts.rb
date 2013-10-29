class AddPostimageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postimage, :string
  end
end