class User < ApplicationRecord
  has_secure_password
  # mount_base64_uploader :image, ImageUploader
  has_many :schedules
  has_many :interests
end
