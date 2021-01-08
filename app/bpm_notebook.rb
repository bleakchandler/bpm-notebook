require 'find'
require 'dotenv'
Dotenv.load

class BPMNotebook

    attr_accessor :user_id

    def run
      RSpotify.authenticate( ENV[ 'CLIENT_ID' ], ENV[ 'CLIENT_SECRET' ] )
      interface = Interface.new
      interface.welcome
      self.user_id = create_or_log_in_user( interface )
      main_loop( interface )
    end

    def main_loop( interface )
      loop do
        choice = interface.main_menu( User.find( self.user_id ) )
        case choice
        when :new_setlist
          create_new_setlist( User.find( self.user_id ), interface )
        when :import_setlist
          import_setlist( User.find( self.user_id ), interface )
        when :delete_setlist
          delete_setlist( User.find( self.user_id ), interface )
        when :goodbye
          interface.goodbye
          break
        else
          setlist_loop( choice, interface )
        end
      end
    end

    def create_or_log_in_user( interface )
      system "clear"
      user_logged_in = nil
      while user_logged_in.nil?
        user_logging_in = interface.prompt.ask("Enter Username")
        if User.where( name: user_logging_in ).empty?
          user_logged_in = create_new_user( user_logging_in, interface )
        else
          user_logged_in = User.find_by(name: user_logging_in)
          puts "Welcome back, #{user_logged_in.name}!"
          validate_password( user_logged_in, interface )
          puts "#{ user_logged_in.name } has logged in successfully!"
          interface.wait_for_keypress
        end
      end
      user_logged_in.id
    end

    def create_new_user( new_username, interface )
      puts "Hm... looks like there is no User '#{ new_username }'."
      if interface.prompt.yes?( "Would you like to create a new User '#{ new_username }'?" )
        new_user_arguments = { name: new_username }
        new_user_arguments[ :spotify_username ] = validate_spotify_username( interface )
        new_user_arguments[ :password ] = interface.prompt.mask("Enter a password")
        confirm_new_user_password( new_username, new_user_arguments, interface )
      else
        puts "New user not created. Please enter an extant user."
        return nil
      end
      User.create(new_user_arguments)
    end

    def validate_spotify_username( interface )
      spotify_user_search = nil
      while spotify_user_search.nil?
        begin
          user_to_find = interface.prompt.ask( "Enter your Spotify username:" )
          spotify_user_search = RSpotify::User.find( user_to_find )
        rescue RestClient::NotFound
          puts "Not a valid Spotify username!"
        else
          return spotify_user_search.id
        end
      end
    end

    #############################################
    # Another way to validate Spotify usernames #
    #############################################
    # def validate_spotify_username( interface )
    #   begin
    #     user_to_find = interface.prompt.ask( "Enter your Spotify username:" )
    #     spotify_user_search = RSpotify::User.find( user_to_find )
    #   rescue RestClient::NotFound
    #     puts "Not a valid Spotify username!"
    #     validate_spotify_username( interface )
    #   else
    #     return spotify_user_search.id
    #   end
    # end

    def validate_password( user_logged_in, interface )
      password_attempt = interface.prompt.mask("Enter your password")
      while password_attempt != user_logged_in.password do
        puts "Incorrect password, please try again."
        password_attempt = interface.prompt.mask("Enter your password")
      end
    end

    def confirm_new_user_password( new_user_name, new_user_arguments, interface )
      password_confirmation = interface.prompt.mask("Confirm your password")
      while password_confirmation != new_user_arguments[:password] do
        puts "Passwords do not match, please try again"
        password_confirmation = interface.prompt.mask("Confirm your password")
      end
    end

    def create_new_setlist( user, interface )
      system "clear"
      new_setlist_name = interface.prompt.ask( "Enter a name for your new setlist" )
      new_setlist_tempo = interface.prompt.ask( "Enter a tempo for your new setlist", convert: :float )
      Setlist.create( name: new_setlist_name, tempo: new_setlist_tempo, user_id: user.id )
      puts "Setlist '#{ new_setlist_name }' successfully created!"
      interface.wait_for_keypress
    end

    def import_setlist( user, interface )
      system "clear"
      setlist_to_search_for = interface.prompt.ask( "Enter the name of the setlist to import:" )
      setlist_search = Find.find( Dir.pwd ).to_a.find{ |filepath| filepath.include?( setlist_to_search_for ) }
      if setlist_search.nil?
        puts "Search failed! No exported setlist with name '#{ setlist_to_search_for }' found!"
      else
        create_setlist_from_filepath( setlist_search, setlist_to_search_for, user )
        puts "User successfully imported setlist with name '#{ setlist_to_search_for }'!"
      end
      interface.wait_for_keypress
    end

    def create_setlist_from_filepath( filepath, new_setlist_name, user )
      file_lines_array = File.open( filepath ).read.split( "\n" )
      imported_setlist = Setlist.create( name: new_setlist_name, tempo: file_lines_array[ 0 ], user_id: user.id )
      file_lines_array[ 1..-1 ].each do | spotify_id |
        imported_song = Song.create( spotify_id: spotify_id )
        Performance.create( setlist_id: imported_setlist.id, song_id: imported_song.id )
      end
    end

    def delete_setlist( user, interface )
      system "clear"
      setlist_to_delete = interface.delete_setlist_menu( user )
      case setlist_to_delete
      when nil
        puts "User '#{ user.name }' has no setlists!"
      when :cancel
        puts "Deletion cancelled - setlist '#{ setlist_to_delete.to_s }' not deleted"
      else
        confirm_deletion_of_setlist( user, setlist_to_delete.to_s, interface )
      end
      interface.wait_for_keypress
    end

    def confirm_deletion_of_setlist( user, setlist_name, interface )
      confirm = interface.prompt.yes?( "Are you sure you want to delete setlist '#{ setlist_name }?'" )
      if confirm
        Setlist.find_by( name: setlist_name ).destroy
        puts "User #{ user.name } has deleted setlist '#{ setlist_name }' successfully"
      else
        puts "Deletion cancelled! Setlist '#{ setlist_name }' not deleted."
      end
    end

    def setlist_loop( setlist_name_symbol, interface )
      choice = nil
      while ( choice = interface.setlist_menu( setlist_name_symbol.to_s ) ) != :back
        case choice
        when :add
          add_to_setlist( setlist_name_symbol.to_s, interface)
        when :suggest
          suggest_for_setlist( setlist_name_symbol.to_s, interface )
        when :remove
          remove_from_setlist( setlist_name_symbol.to_s, interface )
        when :export
          export_setlist( setlist_name_symbol.to_s, interface)
        when :clear
          clear_setlist( setlist_name_symbol.to_s, interface )
        end
      end
    end

    def add_to_setlist(setlist_name, interface)
      #add_to_setlist:
      # => display a list of a users spofity playlists to select a song from
      # => once a user chooses a list, display a list of the spotify songs in the playlist
      # => once a song is chosen, confirm, create a new song object, create a new performance object, and display confirmation message
      playlist_to_choose_from = interface.choose_playlist_to_add_or_suggest_from_menu( setlist_name, :add )
      if playlist_to_choose_from == :back
        puts "Add song canceled."
        interface.wait_for_keypress
        return
      end
      song_from_chosen_playlist = interface.choose_song_from_playlist_menu(playlist_to_choose_from , setlist_name)
      if song_from_chosen_playlist != :back
        confirmed = interface.add_song_to_setlist_confirmation(song_from_chosen_playlist, setlist_name)
      end
      if confirmed || song_from_chosen_playlist == :back
        created_song = Song.create(spotify_id: song_from_chosen_playlist)
        setlist_to_add_to = Setlist.find_by(name: setlist_name)
        Performance.create(song_id: created_song.id, setlist_id: setlist_to_add_to.id)
        puts "#{created_song.name} has been successfully added to #{setlist_name}"
      else
        puts "Add song canceled."
      end
      interface.wait_for_keypress
    end

    def suggest_for_setlist( setlist_name, interface )
      #suggest_for_setlist
      # => display a list of a user's spofity playlists to suggest a song from
      # => once a user chooses a list, display a list of features to suggest by and then ask how to suggest:
        # :tempo, :danceability, :energy, :valence, :loudness
      # => once a user selects a filter for suggestion, display a list of songs to choose from that match that filter
      # => once a song is chosen, confirm, create a new song object, create a new performance object, and display confirmation message
      playlist_to_choose_from = interface.choose_playlist_to_add_or_suggest_from_menu( setlist_name, :suggest )
      if playlist_to_choose_from != :back
        feature_to_suggest_by = interface.choose_feature_menu
        how_to_suggest = interface.suggestion_filter_menu( feature_to_suggest_by, setlist_name )
        confirm_song_suggestion( playlist_to_choose_from, feature_to_suggest_by, how_to_suggest, setlist_name, interface )
      else
        puts "Cancelled - suggestion not made for setlist '#{ setlist_name }'"
      end
      interface.wait_for_keypress
    end

    def confirm_song_suggestion( playlist_to_choose_from, feature_to_suggest_by, how_to_suggest, setlist_name, interface )
      suggested_song = interface.suggested_songs_menu( playlist_to_choose_from, feature_to_suggest_by, how_to_suggest, setlist_name )
      if suggested_song != :back
        created_song = Song.create( spotify_id: suggested_song )
        Performance.create( song_id: created_song.id, setlist_id: Setlist.find_by( name: setlist_name ).id )
        puts "Suggested song '#{ created_song.name }'' has been successfully added to #{ setlist_name }"
      else
        puts "Cancelled - suggestion not added to setlist '#{ setlist_name }'"
      end
    end

    def remove_from_setlist( setlist_name, interface )
      song_to_remove_symbol = interface.remove_from_setlist_menu( setlist_name )
      case song_to_remove_symbol
      when nil
        puts "Setlist '#{ setlist_name }' setlist is empty!"
      when :cancel
        puts "Cancelled - no songs removed from setlist '#{ setlist_name }'"
      else
        setlist_to_remove_from = Setlist.find_by( name: setlist_name )
        song_to_remove = Song.find_by( name: song_to_remove_symbol )
        performance_to_destroy = Performance.find_by( setlist_id: setlist_to_remove_from.id, song_id: song_to_remove.id )
        performance_to_destroy.destroy
        puts "Song '#{ song_to_remove_symbol }' successfully removed from setlist '#{ setlist_name }'"
      end
      interface.wait_for_keypress
    end

    def export_setlist( setlist_name, interface )
      system 'clear'
      setlist_to_export = Setlist.find_by(name: setlist_name)
      if setlist_to_export.songs.empty?
        puts "Cannot export an empty setlist!"
        interface.wait_for_keypress
        return
      end
      confirm = interface.prompt.yes?("Are you sure you want to export setlist #{setlist_name}?")
      if confirm
        File.open( setlist_name, "w+") do |line|
          line.puts( setlist_to_export.tempo )
          setlist_to_export.songs.each{|song| line.puts(song.spotify_id) }
        end
        puts "Setlist #{setlist_name} successfully exported."
      else
        puts "Export canceled. Setlist #{setlist_name} not exported."
      end
      interface.wait_for_keypress
    end

    def clear_setlist( setlist_name, interface )
      system "clear"
      if Setlist.find_by( name: setlist_name ).songs.empty?
        puts "Setlist '#{ setlist_name }' has no songs!"
      else
        confirm_clear_setlist( setlist_name, interface )
      end
      interface.wait_for_keypress
    end

    def confirm_clear_setlist( setlist_name, interface )
      confirm = interface.prompt.yes?("Are you sure you want to remove all songs from setlist '#{ setlist_name }?'")
      if confirm
        Setlist.find_by( name: setlist_name ).clear
        puts "Setlist '#{ setlist_name }' cleared successfully."
      else
        puts "Setlist '#{ setlist_name }' was not cleared."
      end
    end

end
