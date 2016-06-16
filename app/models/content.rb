class Content < ApplicationRecord
  require 'metainspector'

  belongs_to :organization
  belongs_to :user

  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  default_scope { order('created_at DESC') }

  scope :by_organization, -> (organization) {
    where(organization: organization)
  }

  scope :accessible, -> (current_user) {
    where(organization: current_user.organizations)
  }

  validates :source, presence: true

  after_save do
    if title.blank? || description.blank? || image_url.blank?
      page = MetaInspector.new(source)
      update_attributes(title: page.title.delete!("\n").strip) if title.blank? && !page.title.blank?
      update_attributes(description: page.description) if description.blank? && !page.description.blank?
      update_attributes(image_url: page.images.best) if image_url.blank? && !page.images.best.blank?
    end
  end

end
