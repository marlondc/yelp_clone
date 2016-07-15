require 'rails_helper'

feature 'reviewing' do

  before do
    user_sign_up
    add_restaurant('KFC')
    review_restaurant('KFC', 'so so', '3')
  end

  scenario 'allows users to leave a review using a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    click_link 'Sign out'
    user_sign_up('another@user.com')
    review_restaurant('KFC', 'fried chicken', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

end
