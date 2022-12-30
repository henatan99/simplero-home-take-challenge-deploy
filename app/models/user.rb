class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, inverse_of: 'creator'
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :posts
  has_many :comments  
end
