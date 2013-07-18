class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :name
      t.string :date_saved

      t.timestamps
    end
    add_index :bookmarks, [:created_at]
  end
end
