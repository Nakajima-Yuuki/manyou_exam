FactoryBot.define do
  factory :label do
    label_name {'LabelTest'}
  end
  factory :second_label, class: Label do
    label_name{ 'label01' }
  end
end
