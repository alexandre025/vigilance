class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :tags
  accepts_nested_attributes_for :tags

  has_many :assignments
  has_many :users, through: :assignments

  has_many :contents

  scope :by_assignments, -> (current_user) {
    joins(:assignments).where(assignments: {user_id: current_user.id, is_active: true})
  }

end
