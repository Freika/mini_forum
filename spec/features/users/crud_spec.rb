feature 'User' do
  feature 'resets a password' do
    scenario 'enters a valid email' do
      user = create :user

      visit new_user_password_path

      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'

      expect(page).to have_text 'You will receive an email with instructions'
      expect(page).to have_current_path new_user_session_path
    end

    scenario 'enters an invalid email' do
      visit new_user_password_path

      fill_in 'Email', with: 'username@example.com'
      click_button 'Send me reset password instructions'

      expect(page).to have_text 'Email not found'
    end

    scenario 'changes password' do
      token = create(:user).send_reset_password_instructions

      visit edit_user_password_path(reset_password_token: token)

      fill_in 'New password', with: 'p4ssw0rd'
      fill_in 'Confirm new password', with: 'p4ssw0rd'
      click_button 'Change my password'

      expect(page).to have_text 'Your password has been changed successfully.'
      expect(page).to have_current_path root_path
    end

    scenario 'password reset token is invalid' do
      visit edit_user_password_path(reset_password_token: 'token')

      fill_in 'New password', with: 'p4ssw0rd'
      fill_in 'Confirm new password', with: 'p4ssw0rd'
      click_button 'Change my password'

      expect(page).to have_text 'Reset password token is invalid'
    end
  end

  feature 'User signs up' do
    scenario 'with valid data' do
      visit new_user_registration_path

      fill_in 'Email', with: 'username@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_text 'Welcome! You have signed up successfully.'
      expect(page).to have_link 'Logout'
      expect(page).to have_current_path root_path
    end

    scenario 'with invalid data' do
      visit new_user_registration_path

      click_button 'Sign up'

      expect(page).to have_text "Email can't be blank"
      expect(page).to have_text "Password can't be blank"
      expect(page).to have_no_link 'Logout'
    end
  end

  feature 'existed' do
    let!(:user) { create(:user) }

    feature 'User signs out' do
      scenario 'user signed in' do
        sign_in user

        visit root_path

        click_link 'Logout'

        expect(page).to have_text 'Log in'
        expect(page).to have_link 'Sign up'
        expect(page).to have_link 'Forgot your password?'
      end
    end

    feature 'User signs in' do
      scenario 'with valid credentials' do
        user = create :user

        visit new_user_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_text 'Signed in successfully.'
        expect(page).to have_link 'Logout'
        expect(page).to have_current_path root_path
      end

      scenario 'with invalid credentials' do
        user = build :user

        visit new_user_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_text 'Invalid Email or password.'
        expect(page).to have_no_link 'Logout'
      end
    end

    scenario 'Updates first and last name' do
      sign_in user

      visit edit_user_registration_path

      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Doe'

      click_on 'Update'

      expect(page).to have_content 'Your account has been updated successfully.'
      expect(user.reload.first_name).to eq 'John'
      expect(user.reload.last_name).to eq 'Doe'
    end
  end
end
