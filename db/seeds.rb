User.destroy_all
User.reset_pk_sequence

start_seeding = Time.now
RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")
josh = User.create(name: "Josh", password: '123', spotify_username: "2ig2t4utlvmi19fp9th7ogvck")
james = User.create(name: "James", password: '456', spotify_username: "1288694230")

done_seeding = Time.now

puts "Seeded: #{ done_seeding - start_seeding }"
binding.pry
0
