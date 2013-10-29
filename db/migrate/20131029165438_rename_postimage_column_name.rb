class RenamePostimageColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :postimage, :image
  end
end
