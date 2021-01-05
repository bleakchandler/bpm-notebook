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

# User.create(name: "Josh", password: '123', spotify_username: "2ig2t4utlvmi19fp9th7ogvck")
User.create(name: "James", password: '456', spotify_username: "1288694230")
#
# User.find_by(name: "Josh").create_setlist( name: "Josh's awesome set", tempo: 130.5, user_id: 1 )
User.find_by(name: "James").create_setlist( name: "James's amazing set", tempo: 110.25, user_id: 2 )
#
thriller_id = "3S2R0EVwBSAVMd5UMgKTL0"
bad_id = "3FvQH46A4B37eNHjooIXcu"

Song.create( spotify_id: thriller_id )
Song.create( spotify_id: bad_id )
#
# User.find_by(name: "Josh").setlists.first.add_song(Song.all.first)
User.find_by(name: "James").setlists.first.add_song(Song.all.first)
User.find_by(name: "James").setlists.first.add_song(Song.all.last)
done_seeding = Time.now

puts "Seeded: #{ done_seeding - start_seeding }"

# binding.pry
0
