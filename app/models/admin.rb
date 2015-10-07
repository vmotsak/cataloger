class Admin < User
  attachment :avatar
  attachment :passport_photo

  validates_length_of :password, within: 10..128, allow_blank: true
  validates_presence_of :avatar, :passport_photo, :last_name

  def admin?
    true
  end

  def visitor?
    false
  end
end
