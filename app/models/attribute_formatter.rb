require 'date'

class AttributeFormatter
  def initialize(attrs)
    @attrs = attrs
  end

  def call
    attrs.merge({
      available_date: available_date,
      price: price,
      latitude: latitude,
      longitude: longitude
    })
  end

  private

  attr_reader :attrs

  def available_date
    Date.parse(attrs[:available_date]) if attrs[:available_date].present?
  end

  def price
    BigDecimal(attrs[:price].sub('$', '')) if attrs[:price].present?
  end

  def latitude
    Float(attrs[:latitude]) if attrs[:latitude].present?
  end

  def longitude
    Float(attrs[:longitude]) if attrs[:longitude].present?
  end
end
