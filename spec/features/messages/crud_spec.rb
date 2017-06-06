feature 'Message', js: true do
  let!(:user) { create(:user) }

  before(:each) do
    login_as user, scope: :user
    visit root_path
  end

  scenario 'creating' do
    create_message

    expect(page).to have_content('MyString')
  end

  feature 'existing' do
    before(:each) { create_message }

    scenario 'deleting' do
      click_link '[x]'

      expect(page).to_not have_content('MyString')
    end

    scenario 'editing' do
      click_link '[Edit]'

      within "##{dom_id(Message.last)}" do
        fill_in 'message_content', with: 'Updated MyString'
        click_button 'Post'
      end

      expect(page).to have_content('Updated MyString')
    end
  end

  private

  def create_message
    click_link 'New message'

    fill_in 'message_content', with: 'MyString'
    click_button 'Post'
  end
end
