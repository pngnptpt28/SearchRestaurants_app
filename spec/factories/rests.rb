FactoryBot.define do

  # create some rests model
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
