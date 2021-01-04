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

josh = User.create(name: "Josh", password: '123', spotify_username: "2ig2t4utlvmi19fp9th7ogvck")
james = User.create(name: "James", password: '456', spotify_username: "1288694230")

josh_setlist = josh.new_setlist( name: "Josh's awesome set", tempo: 130.5, user_id: 1 )
james_setlist = james.new_setlist( name: "James's amazing set", tempo: 110.25, user_id: 2 )

thriller_id = "3S2R0EVwBSAVMd5UMgKTL0"
bad_id = "3FvQH46A4B37eNHjooIXcu"

thriller = Song.create( spotify_id: thriller_id )
Performance.create( setlist_id: josh_setlist.id , song_id: thriller.id )
Performance.create( setlist_id: james_setlist.id , song_id: thriller.id )

bad = Song.create( spotify_id: bad_id )
Performance.create( setlist_id: james_setlist.id , song_id: bad.id  )

done_seeding = Time.now

puts "Seeded: #{ done_seeding - start_seeding }"

binding.pry
0
