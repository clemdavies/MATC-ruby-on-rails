# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  name       :string(255)
#  date_saved :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bookmark < ActiveRecord::Base
  attr_accessible :date_saved, :name, :url
  belongs_to :user

  validates :name, :length => { :minimum => 5, :maximum => 50 }
  validates :url, :length => { :minimum => 9, :maximum => 100 }
  validates :user_id, presence: true

end
