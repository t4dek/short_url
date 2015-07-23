FactoryGirl.define do
  factory :link do
    given_url { Faker::Internet.url('example.com', '/foobar')}
  end
end
