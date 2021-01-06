class BPMNotebook

    attr_accessor :user_id

    def run
      RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")
      interface = Interface.new
      interface.welcome
      self.user_id = create_or_log_in_user( interface )
      main_loop( interface )
      interface.goodbye
    end

    def main_loop( interface )
      choice = nil
      while true
        choice = interface.main_menu( User.find( self.user_id ) )
        if choice == :new_setlist
          create_new_setlist( User.find( self.user_id ), interface )
        elsif choice == :delete_setlist
          delete_setlist( User.find( self.user_id ), interface )
        elsif choice == :goodbye
          break
        else
          setlist_loop( choice, interface )
        end
      end
    end

    def create_or_log_in_user( interface )
      system "clear"
      user_logging_in = interface.prompt.ask("Enter Username")
      user_logged_in = nil
      if User.where(name: user_logging_in).empty?
        puts "Hm... looks like there is no user with that name. Let's create one!"
        user_logged_in = create_new_user(user_logging_in, interface)
        puts "Welcome, #{user_logged_in.name}!"
        interface.prompt.keypress("Press any key to continue")
      else
        user_logged_in = User.find_by(name: user_logging_in)
        puts "Welcome back, #{user_logged_in.name}!"
        password_attempt = interface.prompt.mask("Enter your password")
        while password_attempt != user_logged_in.password do
          puts "Incorrect password, please try again."
          password_attempt = interface.prompt.mask("Enter your password")
        end
        puts "#{ user_logged_in.name } has logged in successfully"
        interface.prompt.keypress("Press any key to continue")
      end
      user_logged_in.id
    end

    def create_new_user(new_username, interface)
        new_user_arguments = {name: new_username}
        new_user_arguments[:spotify_username] = interface.prompt.ask("Enter your Spotify username")
        new_user_arguments[:password] = interface.prompt.mask("Enter a password")
        password_confirmation = interface.prompt.mask("Confirm your password")
        while password_confirmation != new_user_arguments[:password] do
          puts "Passwords do not match, please try again"
          password_confirmation = interface.prompt.mask("Confirm your password")
        end
        User.create(new_user_arguments)
    end

    def create_new_setlist( user, interface )
      system "clear"
      new_setlist_name = interface.prompt.ask( "Enter a name for your new setlist" )
      new_setlist_tempo = interface.prompt.ask( "Enter a tempo for your new setlist", convert: :float )
      Setlist.create( name: new_setlist_name, tempo: new_setlist_tempo, user_id: user.id )
      puts "Setlist '#{ new_setlist_name }' successfully created!"
      interface.prompt.keypress("Press any key to continue")
    end

    def delete_setlist( user, interface )
      system "clear"
      setlist_to_delete = interface.delete_setlist_menu( user )
      if setlist_to_delete.nil?
        puts "User '#{ user.name }' has no setlists!"
      elsif setlist_to_delete == :cancel
        puts "Deletion cancelled - setlist '#{ setlist_to_delete.to_s }' not deleted"
      else
        confirm = interface.prompt.yes?( "Are you sure you want to delete setlist '#{ setlist_to_delete.to_s }?'" )
        if confirm
          Setlist.find_by( name: setlist_to_delete.to_s ).destroy
          puts "Setlist '#{ setlist_to_delete.to_s }' successfully deleted"
        else
          puts "Deletion cancelled - setlist '#{ setlist_to_delete.to_s }' not deleted"
        end
      end
      interface.prompt.keypress("Press any key to continue")
    end

    def setlist_loop( setlist_name_symbol, interface )
      while true
        choice = interface.setlist_menu( setlist_name_symbol.to_s )
        if choice == :add
          add_to_setlist( setlist_name_symbol, interface)
        elsif choice == :suggest
          suggest_for_setlist( setlist_name_symbol, interface )
        elsif choice == :remove
          remove_from_setlist( setlist_name_symbol, interface )
        elsif choice == :clear
          clear_setlist( setlist_name_symbol, interface )
        else
          break
        end
      end
    end

    def add_to_setlist(setlist_name_symbol, interface)
      #add_to_setlist:
      # => display a list of a users spofity playlists to select a song from
      # => once a user chooses a list, display a list of the spotify songs in the playlist
      # => once a song is chosen, confirm, create a new song object, create a new performance object, and display confirmation message
      playlist_to_choose_from = interface.choose_playlist_to_add_or_suggest_from_menu( setlist_name_symbol.to_s, :add )
      song_from_chosen_playlist = interface.choose_song_from_playlist_menu(playlist_to_choose_from , setlist_name_symbol.to_s)
      confirmed = interface.add_song_to_setlist_confirmation(song_from_chosen_playlist, setlist_name_symbol.to_s)
      if confirmed
        created_song = Song.create(spotify_id: song_from_chosen_playlist)
        Performance.create(song_id: created_song.id, setlist_id: Setlist.find_by(name: setlist_name_symbol.to_s).id)
        puts "#{created_song.name} has been successfully added to #{setlist_name_symbol.to_s}"
      else
        puts "Add song canceled."
      end
      interface.prompt.keypress("Press any key to continue")
    end

    def suggest_for_setlist( setlist_name_symbol, interface )
      #suggest_for_setlist
      # => display a list of a user's spofity playlists to suggest a song from
      # => once a user chooses a list, display a list of features to suggest by and then ask how to suggest:
        # :tempo, :danceability, :energy, :valence, :loudness
      # => once a user selects a filter for suggestion, display a list of songs to choose from that match that filter
      # => once a song is chosen, confirm, create a new song object, create a new performance object, and display confirmation message
      playlist_to_choose_from = interface.choose_playlist_to_add_or_suggest_from_menu( setlist_name_symbol.to_s, :suggest )
      if playlist_to_choose_from != :back
        feature_to_suggest_by = interface.choose_feature_menu
        how_to_suggest = interface.suggestion_filter_menu( feature_to_suggest_by, setlist_name_symbol.to_s )
        suggested_song = interface.suggested_songs_menu( playlist_to_choose_from, feature_to_suggest_by, how_to_suggest, setlist_name_symbol.to_s )
        if suggested_song != :back
          created_song = Song.create( spotify_id: suggested_song )
          Performance.create( song_id: created_song.id, setlist_id: Setlist.find_by( name: setlist_name_symbol.to_s ).id )
          puts "Suggested song '#{ created_song.name }'' has been successfully added to #{ setlist_name_symbol.to_s }"
          else
            puts "Cancelled - suggestion not added to setlist '#{ setlist_name_symbol.to_s }'"
          end
      else
        puts "Cancelled - suggestion not made for setlist '#{ setlist_name_symbol.to_s }'"
      end
      interface.prompt.keypress( "Press any key to continue" )
    end

    def remove_from_setlist( setlist_name_symbol, interface )
      song_to_remove = interface.remove_from_setlist_menu( setlist_name_symbol.to_s )
      if song_to_remove.nil?
        puts "Setlist '#{ setlist_name_symbol.to_s }' setlist is empty!"
      elsif song_to_remove == :cancel
        puts "Cancelled - no songs removed from setlist '#{ setlist_name_symbol.to_s }'"
      else
        Performance.find_by( setlist_id: Setlist.find_by( name: setlist_name_symbol.to_s ).id, song_id: Song.find_by( name: song_to_remove.to_s ).id ).destroy
        puts "Song '#{ song_to_remove.to_s }' successfully removed from setlist '#{ setlist_name_symbol.to_s }'"
      end
      interface.prompt.keypress("Press any key to continue")
    end

    def clear_setlist( setlist_name_symbol, interface )
      system "clear"
      if Setlist.find_by( name: setlist_name_symbol.to_s ).songs.empty?
        puts "Setlist '#{ setlist_name_symbol.to_s }' has no songs!"
      else
        confirm = interface.prompt.yes?("Are you sure you want to remove all songs from setlist '#{ setlist_name_symbol.to_s }?'")
        if confirm
          Setlist.find_by( name: setlist_name_symbol.to_s ).clear
          puts "Setlist '#{ setlist_name_symbol.to_s }' cleared successfully."
        else
          puts "Setlist '#{ setlist_name_symbol.to_s }' was not cleared."
        end
      end
      interface.prompt.keypress("Press any key to continue")
    end

end
