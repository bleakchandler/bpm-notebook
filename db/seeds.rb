# .destroy_all
# .reset_pk_sequence

start_seeding = Time.now

# seed data goes here

done_seeding = Time.now

puts "Seeded: #{ done_seeding - start_seeding }"