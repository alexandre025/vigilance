class Organization < ApplicationRecord

  has_many :tags

  has_many :users, through: :assignments

end
