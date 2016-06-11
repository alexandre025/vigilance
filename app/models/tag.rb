class Tag < ApplicationRecord

  belongs_to :organization

  scope :by_organization, -> (organization) {
    where(organization: organization)
  }

end
