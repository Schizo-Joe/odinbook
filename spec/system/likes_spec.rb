require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  before do
    driven_by(:rack_test)
  end

  include_context 'users'

  context 'when a post is liked' do
    before do
      user.add_friend(other_user)
      post
      sign_in user
      visit posts_path
    end

    let(:post) { other_user.posts.create(content: Faker::Lorem.paragraph) }

    it 'increments by 1' do
      post_element = post_element_for(post)

      within post_element do
        click_button '0 Likes'
        expect(post_element).to have_button '1 Like'
      end
    end

    context 'when a post is unliked' do
      it 'decrements by 1' do
        post_element = post_element_for(post)

        within post_element do
          click_button '0 Likes'
          expect(post_element).to have_button '1 Like'
          click_button '1 Like'
          expect(post_element).to have_button '0 Likes'
        end
      end
    end
  end
end
