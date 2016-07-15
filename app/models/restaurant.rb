class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    tot = 0
    count = 0
    reviews.each do |review|
      tot += review.rating
      count+=1
    end
    return tot/count
    # can use this instead
    # reviews.average(:rating)
  end

end
