class Owner < User
  validates_presence_of :shop_name
  validates_length_of :password, within: 8..128, allow_blank: true

  def owner?
    true
  end

  def visitor?
    false
  end
end
