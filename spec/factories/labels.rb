FactoryBot.define do
  factory :label do
    label_name {'LabelTest'}
  end
  factory :second_label, class: Label do
    label_name{ 'label01' }
  end
  factory :third_label, class: Label do
    label_name{ 'label02' }
  end
end
