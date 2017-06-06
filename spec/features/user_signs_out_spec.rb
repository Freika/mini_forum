require 'rails_helper'

feature 'User signs out' do
  scenario 'user signed in' do
    user = create :user

    sign_in user

    visit root_path

    click_link 'Logout'

    expect(page).to have_text 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Forgot your password?'
  end
end
