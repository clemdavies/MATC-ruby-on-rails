class Bookmark < ActiveRecord::Base

  attr_accessible :date_saved, :name, :url

  validates :name, :length => { :minimum => 5, :maximum => 50 }
  validates :url, :length => { :minimum => 9, :maximum => 100 }

end
