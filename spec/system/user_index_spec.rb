require 'rails_helper'

RSpec.describe 'UserIndex', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when a user is logged out' do
    it 'redirects to the sign in page' do
      visit users_path

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
