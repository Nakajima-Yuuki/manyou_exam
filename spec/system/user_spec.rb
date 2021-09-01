require 'rails_helper'
RSpec.describe 'ユーザー登録のテスト', type: :system do
    before do
        @user = FactoryBot.create(:user, full_name:'User11', email: 'user11@example.com' )
        @admin_user = FactoryBot.create(:admin_user, full_name:'TestAdmin', email: 'testadmin@example.com')
        FactoryBot.create(:task, user:@user)
    end
    describe 'ユーザーの新規登録' do
        context 'ユーザの新規登録ができること' do
            it 'ユーザが新規登録される' do
              visit new_user_path
              fill_in 'user[full_name]', with: 'User10'
              fill_in 'user[email]', with: 'user10@example.com'
              fill_in 'user[password]', with: 'password'
              fill_in 'user[password_confirmation]', with: 'password'
              click_on '登録する'
      
              expect(page).to have_content 'User10'
            end
          end
        end
        describe 'ログインせずタスク一覧画面に飛ぶと、ログイン画面に遷移する' do
          context 'ログインせずタスク一覧画面に飛ぶと、ログイン画面に遷移される' do
            it 'ログイン画面に遷移される' do
              visit tasks_path
              expect(page).to have_content 'ログイン画面'
            end
          end
        end
        describe 'セッション機能のテスト' do
          context 'ログインができること' do
            it 'ログインができること' do
              visit new_session_path
              fill_in 'session[email]', with: 'user11@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
              expect(page).to have_content 'ログインしました'
            end
          end
          context '自分の詳細画面(マイページ)に飛べること' do
            it '自分の詳細画面(マイページ)に飛べること' do
              visit new_session_path
              fill_in 'session[email]', with: 'user11@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
              binding.irb
              click_on '詳細'
              
      
              expect(page).to have_content 'タスク詳細画面'
            end
          end
          context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'user11@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
              visit "users/2"
      
              expect(page).to have_content 'タスク一覧'
            end
          end
          context 'ログアウトができること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'user11@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it 'ログアウトができること' do
              click_link 'Logout'
      
              expect(page).to have_content 'ログアウトしました'
            end
          end
        end
        describe '管理画面のテスト' do
          context '管理ユーザは管理画面にアクセスできること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'testadmin@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '管理ユーザは管理画面にアクセスできること' do
              click_link '管理者画面'
              expect(page).to have_content '管理画面'
            end
          end
          context '一般ユーザは管理画面にアクセスできないこと' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'user11@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '一般ユーザは管理画面にアクセスできないこと' do
              visit admin_users_path
              expect(page).to have_content 'タスク一覧'
            end
          end
          context '管理ユーザはユーザの新規登録ができること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'testadmin@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '管理ユーザはユーザの新規登録ができること' do
              click_link '管理者画面'
              click_button '新規ユーザー登録'
              fill_in 'user[full_name]', with: 'User20'
              fill_in 'user[email]', with: 'user20@example.com'
              fill_in 'user[password]', with: 'password'
              fill_in 'user[password_confirmation]', with: 'password'
              click_on '登録する'
              expect(page).to have_content 'ユーザーを登録しました'
            end
          end
          context '管理ユーザはユーザの詳細画面にアクセスできること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'testadmin@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '管理ユーザはユーザの詳細画面にアクセスできること' do
              click_link '管理者画面'
              #task_list = all('.user_name')
              all('.user_name')[0].click_on '詳細'
              expect(page).to have_content 'User11'
            end
          end
          context '管理ユーザはユーザの編集画面からユーザを編集できること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'testadmin@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '管理ユーザはユーザの編集画面からユーザを編集できること' do
              click_link '管理者画面'
              all('.user_name')[0].click_on '編集'
              fill_in 'user[full_name]', with: 'User11'
              fill_in 'user[email]', with: 'user11@example.com'
              fill_in :user_password, with: 'password'
              fill_in :user_password_confirmation, with: 'password'
              click_on '登録する'
              expect(page).to have_content 'ユーザーを更新しました'
            end
          end
          context '管理ユーザはユーザの削除をできること' do
            before do
              visit new_session_path
              fill_in 'session[email]', with: 'testadmin@example.com'
              fill_in 'session[password]', with: 'password'
              click_on 'ログイン'
            end
            it '管理ユーザはユーザの削除をできること' do
              click_link '管理者画面'
              all('.user_name')[0].click_on '削除'
              page.driver.browser.switch_to.alert.accept
              expect(page).to have_content 'ユーザーを削除しました'
            end
          end
        end
      end