class Content < ApplicationRecord
  require 'metainspector'

  acts_as_followable

  belongs_to :organization
  belongs_to :user

  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  scope :by_organization, -> (organization) {
    where(organization: organization)
  }

  validates :source, presence: true

  after_save do
    page = MetaInspector.new(source)
    update_attributes(title: page.title) if title.blank?
    update_attributes(description: page.description) if description.blank?
    update_attributes(image_url: page.images.best) if image_url.blank?
  end

end
