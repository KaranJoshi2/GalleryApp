class Album < ApplicationRecord
     
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many_attached :images
  validates :title, presence: true, uniqueness: true
  belongs_to :user
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "title", "updated_at", "user_id", "all_tags"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["images_attachments", "images_blobs", "profile_image_attachment", "profile_image_blob","tags", "user"]
  end
  
  def self.tagged_with(name)
    Tag.find_by_name!(name: name).albums
  end
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
  
  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
