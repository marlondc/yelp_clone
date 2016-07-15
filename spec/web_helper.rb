def user_sign_up(email = 'test@example.com' )
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'testest'
  fill_in 'Password confirmation', with: 'testest'
  click_button 'Sign up'
end

def add_restaurant(name)
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end


def review_restaurant(restaurant, thoughts, rating)
  click_link "Review #{restaurant}"
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
