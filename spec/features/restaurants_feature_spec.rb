require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do

    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context '(C) ADDING restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      user_sign_up
      add_restaurant('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        user_sign_up
        add_restaurant('kf')
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context '(R) VIEWING restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context '(U) EDITING restaurants' do
    scenario 'let a user edit a restaurant' do
      user_sign_up
      add_restaurant('KFC')
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried Goodness'
      click_button 'Update Restaurant'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not let a user edit a restaurant they have not added' do
      user_sign_up
      add_restaurant('KFC')
      click_link 'Sign out'
      user_sign_up('tests@gmail.com')
      expect(page).not_to have_content 'Edit KFC'
    end
  end

  context '(D) DELETING restaurants' do
    scenario 'removes a restaurant when a user clicks a delete link if they have added it' do
      user_sign_up
      add_restaurant('KFC')
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

   scenario 'cannot remove a restaurant that user has not added' do
     user_sign_up
     add_restaurant('KFC')
     click_link 'Sign out'
     user_sign_up('tests@gmail.com')
     expect(page).not_to have_content 'Delete KFC'
   end
  end

end
