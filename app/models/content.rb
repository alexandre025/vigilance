class Content < ApplicationRecord

  belongs_to :organization
  belongs_to :user

  has_and_belongs_to_many :tags

  scope :by_organization, -> (organization) {
    where(organization: organization)
  }

end
