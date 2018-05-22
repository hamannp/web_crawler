require 'date'

class ListingMaker
  #This is the last level to scale and paralellize down to one Listing. Like MainPage,
  #it knows quite a bit. It should be easy to swap out for another one for testing
  #purposes or to use something that would be more sane for adhoc queries, like
  #Monogodb.
  def perform(page, detail_class_name=DetailPage.name)
    attributes = AttributeFormatter.new(detail_class_name.constantize.new(page).attributes).call
    listing = Listing.new(attributes.except(:image_pairs))

    if listing.valid?
      listing.save!
    else
      Rails.logger.error("Invalid attrs #{attributes.inspect}")
    end
  end
end
