class ListingRange
  def perform(agent_class_name, detail_class_name, url)
    agent        = agent_class_name.constantize.new
    detail_class = detail_class_name.constantize
    @page        = agent.get(url)

    detail_page_links.each do |detail_page_link|
      detail_class.new.perform(store(agent.get(detail_page_link)))
    end
  end

  private

  attr_reader :page

  def store(document)
    #TODO: Add to data lake. If ListingMaker becomes a job, consider
    #Just passing the ID of this document rather than the document itself.
    #Jobs have to get serialized / deserialized.
    #Could also just as easily be called 'publish' and write to
    #a Kafka topic, or some other suitable message bus. I just return it here.
    #I like this ListingRange abstraction since it's simple and logical to the
    #problem domain, and an obvious place to parallelize.
    document
  end

  def detail_page_links
    page.search('li.result-row a.result-title').map { |link| link[:href] }
  end
end
