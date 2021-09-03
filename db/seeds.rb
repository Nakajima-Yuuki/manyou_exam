User.create!(
    full_name: 'nakaji',
    email: 'nakaji@abc.com',
    password: '111111',
    password_confirmation: '111111',
    admin: 'true',
  )

20.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "password"
    password_confirmation = "password"
    User.create!(full_name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 admin: false,
                 )
end

10.times do |n|
  User.all.each do |user|
    rand1 = rand(0..2)
    status = ["未着手", "着手中", "完了"]
    user.tasks.create!(
      name: "Task_0#{n}",
      description: "Conten_0#{n}",
      expiration_date: Date.today+rand1,
      status: status[rand1],
      priority: rand1,
    )
  end
end

10.times do |n|
  Label.create!(label_name: "label_0#{n} ")
end