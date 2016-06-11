class Organization < ApplicationRecord

  has_many :tags
  accepts_nested_attributes_for :tags

  has_many :assignments
  has_many :users, through: :assignments

  scope :by_assignments, -> (current_user) {
    joins(:assignments).where(assignments: {user_id: current_user.id})
  }

end
