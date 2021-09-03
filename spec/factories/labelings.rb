FactoryBot.define do
  factory :labeling do
    association :label
    association :task
  end
end
