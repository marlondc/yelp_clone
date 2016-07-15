class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  has_many :endorsements, dependent: :destroy

  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  validates :rating, inclusion: (1..5)

end
