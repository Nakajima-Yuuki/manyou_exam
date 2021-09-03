require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
    before do
        @user = FactoryBot.create(:user,full_name:'TestUser', email: 'testuser@example.com')
        @admin_user = FactoryBot.create(:admin_user)
        FactoryBot.create(:label)
        FactoryBot.create(:second_label)
        FactoryBot.create(:task, user: @user)
        FactoryBot.create(:second_task, user: @user)
    end
    describe 'ラベルの脱着機能' do
        context 'タスクに作成時、ラベルを選択した場合表示' do
            before do
                visit new_session_path
                fill_in 'session[email]', with: 'testuser@example.com'
                fill_in 'session[password]', with: 'password'
                click_on 'ログイン'
              end
              it '詳細画面で表示される' do
                visit new_task_path
                fill_in 'task[full_name]', with: 'Test User'
                fill_in 'task[name]', with: 'Test Name'
                fill_in 'task[description]', with: 'Test Description'
                select "2021", from: 'task[expiration_date(1i)]'
                select "11月", from: 'task[expiration_date(2i)]'
                select "10", from: 'task[expiration_date(3i)]'
                select "18", from: 'task[expiration_date(4i)]'
                select "15", from: 'task[expiration_date(5i)]'
                select "未着手", from: 'task[status]'
                select "高", from: 'task[priority]'
                check "LabelTest"
                click_on '登録する'
                expect(page).to have_content 'Test Name'
                expect(page).to have_content 'Test Description'
                expect(page).to have_content '2021/11/10 18:15'
                expect(page).to have_content '未着手'
                expect(page).to have_content '高'
                expect(page).to have_content 'LabelTest'
            end
        end
        context "タスクの編集した時に選択したラベルが表示される" do
          before do
            visit new_session_path
            fill_in 'session[email]', with: 'testuser@example.com'
            fill_in 'session[password]', with: 'password'
            click_on 'ログイン'
          end
          it '詳細画面で表示される' do
            all('.tasks_list')[0].click_on '編集する'
            fill_in 'task[full_name]', with: 'Test User'
            fill_in 'task[name]', with: 'test_name_01'
            fill_in 'task[description]', with: 'test_description_01'
            check "label01"
            click_on '更新する'
            expect(page).to have_content 'label01'
          end
        end
      end
        context 'ラベルの検索をした場合' do
          before do
            visit new_session_path
            fill_in 'session[email]', with: 'testuser@example.com'
            fill_in 'session[password]', with: 'password'
            click_on 'ログイン'
          end
          it "検索したラベルが検索結果に表示される" do
            visit new_task_path
            fill_in 'task[full_name]', with: 'Test User'
            fill_in 'task[name]', with: 'Test Name'
            fill_in 'task[description]', with: 'Test Description'
            check "LabelTest"
            click_on '登録する'
            visit tasks_path
            select 'LabelTest', from: :label_id
            click_on '検索'
            expect(page).to have_content 'LabelTest'
          end
        end
    end