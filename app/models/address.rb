class Address
  delegate :search, to: :page

  #This class is a simple natural abstraction. There is only going to be one
  #by the nature of apartment hunting. It would be very natural to embed it in a
  #Listing in a document store like MongoDB. I could use a has_one and associate a
  #DB record of its own to the Listing, but Sqlite is meant to be TSTTCPW, and it
  #is easier to search, even if this is a toy program. So I just merge the attributes
  #in the detail page and get on with it.

  def initialize(page)
    @page = page
  end

  def attributes
    {
      street_address: street_address,
      google_map_url: google_map_url,
      latitude: latitude,
      longitude: longitude
    }
  end

  private

  attr_reader :page

  # In the real world, I'd think twice about rescuing nil. I would look at
  # why I was hitting nil and iterate to improve the crawler.
  def street_address
    search('.mapaddress').children.first.text.chop rescue nil
  end

  def google_map_url
    search('.mapaddress a', text: 'google map').attr('href').value rescue nil
  end

  def latitude
    search('#map').attr('data-latitude').value rescue nil
  end

  def longitude
    search('#map').attr('data-longitude').value rescue nil
  end
end
