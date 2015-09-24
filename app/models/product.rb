class Product < ActiveRecord::Base
  belongs_to :user
  attachment :photo
  validates_presence_of :name
end
