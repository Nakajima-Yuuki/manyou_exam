require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
    before do
        @user = FactoryBot.create(:user,full_name:'TestUser', email: 'testuser@example.com')
        @admin_user = FactoryBot.create(:admin_user)
        
        
    end
    describe ''
end