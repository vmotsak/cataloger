class Product < ActiveRecord::Base
  belongs_to :user
  attachment :photo
end
