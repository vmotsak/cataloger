class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :products

  validates_format_of :email, :with => /@/
  validates_presence_of :name

  validates_length_of :password, within: 6..128, allow_blank: true, if: 'visitor?'
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?

  def admin?
    false
  end

  def owner?
    false
  end

  def visitor?
    true
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
