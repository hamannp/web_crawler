class Navigation
  delegate :at, to: :page

  def initialize(page)
    @page = page
  end

  def call
    (0...total_count).step(step).entries
  end

  private

  attr_reader :page

  def step
    range_to - range_from + 1
  end

  def range_to
    at('span.rangeTo').text.to_i
  end

  def range_from
    at('span.rangeFrom').text.to_i
  end

  def total_count
    at('span.totalcount').text.to_i
  end
end
