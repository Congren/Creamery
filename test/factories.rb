FactoryGirl.define do
  # factory blueprint for stores
  factory :store do
    name "CMU Eats"
    street "Forbes AVE"
    city "Pittsburgh"
    state "PA"
    zip "15289"
    phone "5332535231"
    active 1
  end

  # factory blueprint for employees
  factory :employee do
    first_name "Andrew"
    last_name "Wang"
    ssn "125521623"
    date_of_birth 19.years.ago.to_date
    phone "1252631222"
    role "admin"
    active 1
  end

  # factory blueprint for assignments
  factory :assignment do
    association :store
    association :employee
    start_date 2.years.ago.to_date
    pay_level 2
  end
end