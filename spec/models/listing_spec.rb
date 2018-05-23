require 'rails_helper'

RSpec.describe Listing, type: :model do
  context 'calculates price ranges in increments of 200' do
    Given!(:thousand_to_twelve_hundred) do
      FactoryBot.create(:listing, price: 1000)
      FactoryBot.create(:listing, price: 1150)
      FactoryBot.create(:listing, price: 1199)
    end
    Given!(:twelve_hundred_to_fourteen_hundred) do
      FactoryBot.create(:listing, price: 1205)
      FactoryBot.create(:listing, price: 1350)
    end
    Given!(:fourteen_hundred_to_sixteen_hundred) do
      FactoryBot.create(:listing, price: 1400)
    end
    Given!(:sixteen_hundred_to_eighteen_hundred) do
      #skip
    end
    Given!(:eighteen_hundred_two_thousand) do
      FactoryBot.create(:listing, price: 1900)
    end
    Given!(:two_thousand_to_twenty_two_hundred) do
      FactoryBot.create(:listing, price: 2100)
    end
    Given!(:twenty_two_hundred_to_twenty_four_hundred) do
      FactoryBot.create(:listing, price: 2300)
      FactoryBot.create(:listing, price: 2250)
      FactoryBot.create(:listing, price: 2370)
    end
    Given!(:twenty_four_hundred_to_twenty_six_hundred) do
      FactoryBot.create(:listing, price: 2500)
    end
    Given!(:twenty_six_hundred_twenty_eight_hundred) do
      FactoryBot.create(:listing, price: 2700)
    end
    Given!(:twenty_eight_hundred_3_thousand) do
      FactoryBot.create(:listing, price: 2800)
      FactoryBot.create(:listing, price: 2900)
      FactoryBot.create(:listing, price: 2900)
      FactoryBot.create(:listing, price: 2900)
    end
    Given!(:more) do
      FactoryBot.create(:listing, price: 5000)
    end
    When(:result){ Listing.in_grouped_ranges }
    Then do
      expected = {"1000-1199"=>3,
                  "1200-1399"=>2,
                  "1400-1599"=>1,
                  "1600-1799"=>0,
                  "1800-1999"=>1,
                  "2000-2199"=>1,
                  "2200-2399"=>3,
                  "2400-2599"=>1,
                  "2600-2799"=>1,
                  "2800-3000"=>4,
                  "3001-6000"=>1}
      expect(result).to eq expected
    end
  end
end
