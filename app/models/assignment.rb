class Assignment < ApplicationRecord

  belongs_to :user
  belongs_to :organization

  def new_token!
    SecureRandom.hex(16).tap do |random_token|
      update_attributes assignment_token: random_token
    end
  end

  def activate!
    update_attributes(assignment_token: nil, is_active: true)
  end

end
