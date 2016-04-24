# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable,
    :token_authenticatable
  acts_as_voter
  acts_as_follower
  acts_as_followable

  before_save :ensure_authentication_token

  has_many :posts
  has_many :comments
  has_many :events

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader

  validates_presence_of :name

  self.per_page = 10

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  fastapi_standard_interface [
    :id,
    :name,
    :email,
    :about,
    :posts_count,
    :avatar,
    :cover,
    :phone_number,
    :dob,
    :sex,
    :slug
  ]


  def skip_confirmation
    self.confirmed_at = Time.now
  end
end
