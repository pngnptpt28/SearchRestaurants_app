FactoryBot.define do
  # factory :rest do
  #   id    "test1"
  #   name  "Rest hoge"
  #   station "test station"
  #   walk  10
  #   shop_image1 "img_url1"
  #   shop_image2 "img_url2"
  #   address "Test test 111-222"
  #   tel "1234-5678"
  #   opentime "0:00"
  # end

  factory :rest do
    sequence(:id) { |n| "test_#{n}"}
    sequence(:name) { |n| "Rest TEST#{n}"}
    sequence(:station) { |n| "TEST#{n} Station"}
    sequence(:walk) { |n| n }
    sequence(:shop_image1) { |n| "img_url1_#{n}"}
    sequence(:shop_image2) { |n| "img_url2_#{n}"}
    sequence(:address) { |n| "Address Test#{n}"}
    sequence(:tel) { |n| "000-#{n}#{n}#{n}#{n}" }
    sequence(:opentime) { |n| "0:#{n}"}
  end

end
