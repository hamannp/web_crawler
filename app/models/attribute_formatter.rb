require 'date'

class AttributeFormatter
  def initialize(attrs)
    @attrs = attrs
  end

  def call
    attrs.merge({
      listing_date: listing_date,
      available_date: available_date,
      price: price,
      latitude: latitude,
      longitude: longitude,
      image_pairs: image_pairs
    })
  end

  private

  attr_reader :attrs

  def image_pairs
    Hash[attrs[:image_pairs]]
  end

  def listing_date
    Date.parse(attrs[:listing_date]) rescue nil
  end

  def available_date
    Date.parse(attrs[:available_date]) rescue nil
  end

  def price
    Integer(attrs[:price].sub('$', '')) rescue nil
  end

  def latitude
    Float(attrs[:latitude]) rescue nil
  end

  def longitude
    Float(attrs[:longitude]) rescue nil
  end
end
