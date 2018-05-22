require 'mechanize'

class MainPage
  def perform(url='https://raleigh.craigslist.org/search/apa')
    @url          = url
    @param_slices = Navigation.new(Mechanize.new.get(url)).call

    listing_range_urls.each do |range_url|
      ListingRange.new.perform(Mechanize.name, ListingMaker.name, range_url)
    end
  end

  private

  attr_reader :url, :param_slices

  def listing_range_urls
    param_slices.map do |slice|
      url.sub(/\/apa$/, "/apa?s=#{slice.to_s}")
    end
  end
end
