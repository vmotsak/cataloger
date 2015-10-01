class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :products
  attachment :avatar
  attachment :passport_photo

  validates_format_of :email, :with => /@/
  validates_presence_of :name
  validates_presence_of :avatar, :passport_photo, :last_name, if: 'admin?'
  validates_presence_of :shop_name, if: 'owner?'

  validates_length_of :password, within: 6..128, allow_blank: true, if: 'visitor?'
  validates_length_of :password, within: 8..128, allow_blank: true, if: 'owner?'
  validates_length_of :password, within: 10..128, allow_blank: true, if: 'admin?'

  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?

  scope :admins, -> { where(role: 'admin') }

  def admin?
    role == 'admin'
  end

  def owner?
    role == 'owner'
  end

  def visitor?
    role.nil? || role=='visitor'
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
