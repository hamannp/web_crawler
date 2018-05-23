# README

Design considerations:

* We would ultimately want to add more crawlers. Scraping one site doesn't make
much sense. There are pieces that are plainly tied to CraigsList, but I tried to
keep what I can generic. I do in fact plan to add a second crawler at some point.
I realized that I don't have any examples of my work that I own, so this is the
beginning of an effort to change that. Also, I have a few itches that I want to
scratch, and this might be the right toy project. As such, I pulled more data
(in terms of fields) and more data (in terms of listings).

* I'm a fan of the 'Data Lake' philosopy. If you really want to limit the number
of listings to 1000, I would do it by limiting the number of ListingRanges and
then making ListingRange take a max number of listings. But most POs would not
want to spend more to get less, and I think the default 3000 that I get is a good number.

* I set some classes up to look like some kind of 'job' by giving them a 'perform'
method and passing arguments to that method. In general, arguments need to be simple
since they get serialized/deserialized. Thats why I pass the class name to the
classes that are meant to become jobs. They 'new' some things up, but they don't decide
who to 'new' up. In general, I think jobs should get some smoke tests, but their
collaborators should do most of the heavy lifting, and those should be well tested.
But I don't see a need to pick a queuing system for this toy program. I think
pub/sub would be a natural, but again, this is a toy.

* I went with SQLite for the same reason, although I would be the first to concede
that a schemaless solution that was easy to shard and support add-hoc queries would
make a lot of sense. I heard from the 10-gen guys that CL takes 3 months to run
a single schema migration.

* In general, I'm a fan of clean, OO code and doing 'The simplest thing that could
possibly work.' (TSTTCPW)

* This repo has the fewest tests of anything that I've written in a long time, but
that will change if I keep working on it.  I made sure to inject dependencies and
keep responsibilities focused. Mocking and stubbing would be pretty easy for the most part.
I will say that it was a joy to work with and debug against live data.
'Good OO code is synonymous with testable code.'

Deployment instructions:

* I tried to keep to keep setup to a minimum. Just :

From the project root,
`bundle`
`bundle exec rake db:migrate`
`bundle exec rails c`
`MainPage.new.perform` and watch it scrape away. You should get 3000 records.

From there:
`bundle exec rails s` assuming you don't have anything running on 3000. And then
go to localhost:3000.
