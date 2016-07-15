class Endorsement < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :user, uniqueness: { scope: :review, message: "has reviewed this restaurant already" }
end
