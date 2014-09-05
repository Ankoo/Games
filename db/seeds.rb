# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['Newbie', 'Noob', 'Casual', 'Pro'].each do |rank|
  Rank.find_or_create_by({title: rank})
end


['Standard', 'Moderator', 'Admin', 'Banned'].each do |role|
  Role.find_or_create_by({name: role})
end