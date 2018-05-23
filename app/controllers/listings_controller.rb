class ListingsController < ApplicationController
  def index
    @rows = Listing.in_grouped_ranges
  end
end
