FactoryGirl.define do
  factory :message do
    content 'MyText'
    user
  end
end
