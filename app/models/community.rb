class Community < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :name

  acts_as_followable

  has_many :posts
  has_many :comments
  has_many :events

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.per_page = 10

  # A "standard interface" is a list of user-exposed fields for the endpoint
 fastapi_standard_interface [
   :id,
   :name,
   :about,
   :user_id,
   :posts_count,
   :avatar,
   :cover,
   :slug
 ]
end
