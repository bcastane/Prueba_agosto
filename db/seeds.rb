# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Song.destroy_all
UserSong.destroy_all

3.times do |i|


	song=Song.create!(name:"Cancion #{i}",duration: i*100)
end
