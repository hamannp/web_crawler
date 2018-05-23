class Listing < ApplicationRecord
  serialize :listing_attributes, Array
  serialize :image_pairs, Hash

  GROUPED_RANGES_SQL = <<-SQL
    select t.range as [range],
    count(*) as [occurences]
    from (
      select case
        when price between  600 and  799 then '600-799'
        when price between  800 and  999 then '800-999'
        when price between 1000 and 1199 then '1000-1199'
        when price between 1200 and 1399 then '1200-1399'
        when price between 1400 and 1599 then '1400-1599'
        when price between 1600 and 1799 then '1600-1799'
        when price between 1800 and 1999 then '1800-1999'
        when price between 2000 and 2199 then '2000-2199'
        when price between 2200 and 2399 then '2200-2399'
        when price between 2400 and 2599 then '2400-2599'
        when price between 2600 and 2799 then '2600-2799'
        when price between 2800 and 3000 then '2800-3000'
        else 'out of range' end as range
    from listings) t
    group by t.range
    SQL

  DEFAULT_RANGE_GROUPS = {
                          "600-799"=>0,
                          "800-999"=>0,
                          "1000-1199"=>0,
                          "1200-1399"=>0,
                          "1400-1599"=>0,
                          "1600-1799"=>0,
                          "1800-1999"=>0,
                          "2000-2199"=>0,
                          "2200-2399"=>0,
                          "2400-2599"=>0,
                          "2600-2799"=>0,
                          "2800-3000"=>0,
                          "out of range"=>0}.freeze

  def self.in_grouped_ranges
     DEFAULT_RANGE_GROUPS.merge(connection.execute(GROUPED_RANGES_SQL).inject({}) do |memo, group_range|
                            memo[group_range['range']] = group_range['occurences']
                            memo
                          end)
  end
end
