class Organization < ApplicationRecord

  has_many :tags

  belongs_to :admin, class_name: 'User'

end
