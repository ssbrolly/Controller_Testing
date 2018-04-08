class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bank_accounts, dependent: :destroy

  validates_presence_of :first_name, :last_name, :gender, :age
  validates_inclusion_of :gender, in: %w(Male Female Other)
  validates :age, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }

  def is_old_enough?
    age > 16 ? true : false
  end

  def self.by_age
    order(:age)
  end
end
