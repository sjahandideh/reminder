FactoryGirl.define do
  factory :staff do
    sequence(:email) { |n| "staff#{n}@company.com" }
    sequence(:payroll_number)
  end

  factory :appointment do
    association :staff
  end
end
