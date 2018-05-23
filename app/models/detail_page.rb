require 'date'

class DetailPage
  delegate :search, to: :page

  def initialize(page, address_class=Address)
    @page          = page
    @address_class = address_class
  end

  def attributes
    {
      listing_date: listing_date,
      title_text: title_text,
      price: price,
      housing: housing,
      body: body,
      available_date: available_date,
      available_message: available_message,
      listing_attributes: listing_attributes,
      image_pairs: image_pairs
    }.merge(address_class.new(page).attributes)
  end

  private

  attr_reader :page, :address_class

  def listing_date
    search('#display-date time').attr('datetime').value
  end

  def title_text
    search('span.postingtitletext span#titletextonly').text
  end

  def price
    search('span.postingtitletext span.price').text
  end

  def housing
    search('span.postingtitletext span.housing').text
  end

  def body
    search('#postingbody').text
  end

  def available_date
    search('.housing_movein_now').attr('data-date').value rescue nil
  end

  def available_message
    search('.housing_movein_now').attr('data-today_msg').value rescue nil
  end

  def listing_attributes
    search('.mapAndAttrs p.attrgroup').children.map(&:text).map().reject(&:blank?)
  end

  def image_pairs
    search('a.thumb').map { |a| [a[:href], a.search('img').attr('src').value] }
  end
end
