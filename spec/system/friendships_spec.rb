require 'rails_helper'

RSpec.describe 'Friendships', js: true, type: :system do
  before do
    driven_by :selenium, using: :chrome
  end

  include_context 'users'

  shared_context 'with friends added' do
    before do
      sign_in user
      user.add_friend(other_user)
    end
  end

  it_behaves_like 'a users resource' do
    let(:visiting_url) { user_friends_path(user) }
  end

  context 'when visiting the friends page' do
    include_context 'with friends added'

    before do
      visit user_friends_path(user)
    end
    it 'shows friends' do
      expect(main).to have_content other_user.name
    end

    it 'can remove friends' do
      expect(main).to have_button 'Remove friend', id: other_user.id
    end

    context 'when the remove friend button is clicked' do
      before do
        accept_confirm do
          click_button 'Remove friend', id: other_user.id
        end
      end

      it 'renders a flash message' do
        expect(main).to have_content 'removed'
      end

      it 'removes the friend' do
        visit user_friends_path(user)

        expect(main).to have_no_content other_user.name
      end
    end
  end

  context "when visiting another user's friend page" do
    include_context 'with friends added'

    before do
      visit user_friends_path(other_user)
    end

    it 'hides the remove friend button' do
      expect(main).to have_no_button 'Remove friend'
    end
  end
end
