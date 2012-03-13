require 'filsale_validator'

class Admin
  include Mongoid::Document
  include FilsaleValidator

  field :email, :type => String
  field :agree, :type => Boolean

  devise :database_authenticatable, :trackable, :timeoutable, :validatable
  # add these to devise- :registerable, :rememberable, :lockable, :recoverable
  attr_accessible :email, :agree, :password, :password_confirmation

  validates :email, :email_unique_in_filsale => true

  before_validation do |admin|
    admin.email.downcase!
  end
end
