class Image < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  mount_uploader :image, ImageUploader
end
