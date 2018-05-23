FactoryBot.define do
  factory :listing do
    title_text "MyString"
    price ""
    housing ""
    body ""
    listing_attributes ['dogs', 'cats', 'pool']
    available_date "2018-05-22"
    available_message "MyString"
    street_address "MyString"
    google_map_url "MyText"
    latitude ""
    longitude 1.5
  end
end
