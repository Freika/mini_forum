feature 'Message', js: true do
  let!(:user) { create(:user) }

  before(:each) do
    login_as user, scope: :user
    visit root_path
    create_message
  end

  scenario 'creating' do
    expect(page).to have_content('Uniq Message')
  end

  feature 'existing' do
    scenario 'deleting' do
      click_link '[x]'

      expect(page).to_not have_content('Uniq Message')
    end

    scenario 'editing' do
      click_link '[Edit]'

      within "##{dom_id(Message.last)}" do
        fill_in 'message_content', with: 'Updated Uniq Message'
        click_button 'Post'
      end

      expect(page).to have_content('Updated Uniq Message')
    end
  end

  private

  def create_message
    click_link 'New message'

    fill_in 'message_content', with: 'Uniq Message'
    click_button 'Post'
  end
end
