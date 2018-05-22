require 'rails_helper'

RSpec.describe MainPage, type: :model do
  context 'divides the listing into ranges, returning the count' do
    Given(:url) { 'https://raleigh.craigslist.org/search/apa?s=120' }
    Then { expect(MainPage.new(url).perform).to eq  }
  end
end
