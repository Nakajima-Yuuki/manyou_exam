FactoryBot.define do
  factory :user do
    full_name { 'User01' }
    email { 'user01@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
  factory :admin_user, class: User do
    full_name { 'Admin01' }
    email { 'admin01@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
    
  end
end
