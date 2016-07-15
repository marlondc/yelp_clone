require 'rails_helper'

feature 'endorsing reviews' do
  scenario 'a user can endorse a review, which updates the review endorsement count' do
    user_sign_up
    add_restaurant('KFC')
    review_restaurant('KFC', 'Amazing', '4')
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end
end
