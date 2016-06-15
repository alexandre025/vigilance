class ContentsSaved < ApplicationRecord

  belongs_to :content
  belongs_to :user

  def self.is_saved_to_read?(content, user)
    object = ContentsSaved.where(user: user, content: content, relation: :to_read)
    return object.empty? ? false : object
  end

  def self.is_liked?(content, user)
    object = ContentsSaved.where(user: user, content: content, relation: :liked)
    return object.empty? ? false : object
  end

end
