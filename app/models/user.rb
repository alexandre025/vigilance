class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_follower

  has_many :assignments
  has_many :organizations, through: :assignments

  has_many :contents

  def new_token!
    SecureRandom.hex(16).tap do |random_token|
      update_attributes auth_token: random_token
    end
  end

end
