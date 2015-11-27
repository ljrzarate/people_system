class AddCorrectPictureModelToPerson < ActiveRecord::Migration
  def up
    remove_column :people, :picture
    add_attachment :people, :picture
  end

  def down
    remove_attachment :people, :picture
    add_column :people, :picture, :string
  end
end
