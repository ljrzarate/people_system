class AddCorrectPictureModelToPerson < ActiveRecord::Migration
  def up
    add_attachment :people, :picture
  end

  def down
    remove_attachment :people, :picture
  end
end
