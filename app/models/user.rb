class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_relationships, foreign_key: 'user_id'
  has_many :related_users, through: :user_relationships
  
  attr_accessor :money
  before_validation :set_default_money, on: :create

  def set_default_money
    self.money ||= 1
  end

  def money
    self[:money]
  end

  def money=(value)
    self[:money] = value
  end
  validates :money, presence: true, numericality: { greater_than_or_equal_to: 0 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
