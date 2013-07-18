class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :microposts

  validates :email, :length => { :minimum => 4, :maximum => 30 }
  validates :name, :length => { :minimum => 4, :maximum => 30 }
end
