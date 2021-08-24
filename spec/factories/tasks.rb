FactoryBot.define do
    factory :task do
      # 下記の内容は実際に作成するカラム名に合わせて変更してください
      name { 'test_name1' }
      description { 'test_description1' }
      expiration_date {'2021/08/27 15:46'}
    end
    
    factory :second_task, class: Task do
    # 作成するテストデータの名前を「second_task」とします
    #（存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    name { 'test_name2' }
    description { 'test_description2' }
    expiration_date {'2021/08/20 15:46'}
    end
end