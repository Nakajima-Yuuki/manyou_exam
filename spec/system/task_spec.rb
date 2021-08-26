#describeには、「何の仕様についてなのか」（テスト対象）、contextには「状況・状態を分類」したテスト内容、
#itには「期待する動作」を記載
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # テストで使用するためのタスクを作成
      task = FactoryBot.create(:task)
      task = FactoryBot.create(:second_task)
      
      # タスク一覧ページに遷移
      visit tasks_path #タスクページへ行く
      # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
      # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
      expect(page).to have_content 'test_name1'
      expect(page).to have_content 'タスク一覧'
      click_on '新規投稿'
      click_on '登録する'
      # わざと間違った結果を期待するテストを記載する
      #expect(page).to have_content 'task_failure'
      # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
   end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      task = FactoryBot.create(:task)
      task = FactoryBot.create(:second_task)
      # タスク一覧ページに遷移
      visit tasks_path
      expect(page).to have_content 'test_name1'
      expect(page).to have_content 'test_name2'
      expect(page).to have_content 'test_description1'
      expect(page).to have_content 'test_description2'
    end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
      # タスク一覧ページに遷移
       visit tasks_path(:task)
       expect(page).to have_content 'test_name1'
       expect(page).to have_content 'test_name2'
       expect(page).to have_content 'test_description1'
       expect(page).to have_content 'test_description2'
       end
     end
  end
      # テスト内容を追加で記載する
     context 'タスクが作成日時の降順に並んでいる場合' do
       it '新しいタスクが一番上に表示される' do
          # ここに実装する
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
          visit tasks_path #タスクページへ行く
          task_list = all('.task_row') 
          expect(task_list[0]).to have_content 'test_description2'
          expect(task_list[1]).to have_content 'test_description1'
          click_on '終了期限でソート'
        end
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row') 
        # タスクの検索欄に検索ワードを入力する (例: task)
        expect(page).to have_content 'test_name1'
        # 検索ボタンを押す
        click_on '検索'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する 
        # プルダウンを選択する「select」について調べてみること
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row') 
        select "未着手", from: 'status'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        fill_in 'name', with:'test'
        select '未着手', from: 'status'
        click_on '検索'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'test_name1'
      end
     end
end