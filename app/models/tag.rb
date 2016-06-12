class Tag < ApplicationRecord

  belongs_to :organization

  has_and_belongs_to_many :contents

  scope :by_organization, -> (organization) {
    where(organization: organization)
  }

end
