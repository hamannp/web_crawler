class ListingMaker
  #This is the last level to scale and paralellize down to one Listing. Like MainPage,
  #it knows quite a bit. It should be easy to swap out for another one for testing
  #purposes or to stuff data into something that would be more sane for adhoc queries, like
  #Monogodb.
  def perform(page, detail_class_name=DetailPage.name)
    attributes = AttributeFormatter.new(detail_class_name.constantize.new(page).attributes).call
    listing = Listing.new(attributes)

    # Assuming that this was a job, I don't think I want to raise an error here if it doesn't validate.
    # If it fails to process, then something about the page changed. I think it makes more sense to log it
    # and then investigate what could be done to improve the crawler.

    if listing.valid?
      listing.save!
    else
      Rails.logger.error("Invalid attrs #{attributes.inspect}")
    end
  end
end
