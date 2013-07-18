class RemoveDateSavedFromBookmarks < ActiveRecord::Migration
  def up
    remove_column :bookmarks, :date_saved
  end
end
