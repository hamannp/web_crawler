class Listing < ApplicationRecord
  #In the real world, I would not use AR and SQL for any kind of query engine.
  #I think the key things that we would want, if we were aggregating data from
  #many sites and not just CL :
  #1. Schema-less-ness. I heard from the 10-gen guys that it takes 3 months to
  #migrate a single schema update at Craigslist.
  #2. Ad hoc queries. Users may have very specific kinds of queries. If we can't support
  #that, then there is no money for us to make.
  #3. Scalability. The data would shard nicely on many different dimensions.
  #
  #I would also add validations or filter CL, but my goal is gulp down everything I can for
  #future processing, analysis, and display. TSTTCPW is what I'm going for here. So I'm
  #just going to return the latest records and paginate.

  default_scope { order(created_at: :desc) }
end
