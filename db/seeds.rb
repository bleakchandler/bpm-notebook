User.destroy_all
User.reset_pk_sequence
Setlist.destroy_all
Setlist.reset_pk_sequence
Song.destroy_all
Song.reset_pk_sequence
Performance.destroy_all
Performance.reset_pk_sequence

start_seeding = Time.now

RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")

User.create(name: "Josh", password: '123', spotify_username: "2ig2t4utlvmi19fp9th7ogvck")
User.create(name: "James", password: '456', spotify_username: "1288694230")

User.find_by(name: "Josh").create_setlist( name: "Josh's awesome set", tempo: 130.5 )
User.find_by(name: "James").create_setlist( name: "James's amazing set", tempo: 110.25 )

done_seeding = Time.now

puts "Seeded: #{ done_seeding - start_seeding }"

# binding.pry
0
