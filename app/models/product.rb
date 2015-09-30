class Product < ActiveRecord::Base
  belongs_to :user
  attachment :photo
  validates_presence_of :name

  def sellable?
    !is_pro? && shop_name.present?
  end
end
