class Interface

    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        system "clear"
        song = SongPlayer.new
        song.start_playing
        puts Equalizer.animation
        self.wait_for_keypress
        song.stop_playing
    end

    def wait_for_keypress
      self.prompt.keypress("Press any key to continue")
    end

    def main_menu( user )
      # Main menu:
      # - list of all setlists
      # - (create new setlist)
      # - (delete setlist)
      # - (quit)
      system "clear"
      menu_hash = user.setlists.map{ | setlist | [ "#{setlist.name} (#{Setlist.find_by(name: setlist.name).tempo} BPM)", setlist.name.to_sym ] }.to_h
      menu_hash.store( "(new setlist)".to_sym, :new_setlist )
      menu_hash.store( "(import setlist)".to_sym, :import_setlist )
      menu_hash.store( "(delete setlist)".to_sym, :delete_setlist )
      menu_hash.store( "(quit)".to_sym, :goodbye )
      self.prompt.select("Choose a setlist or create a new setlist:", menu_hash )
    end

    def setlist_menu( setlist_name )
      # Setlist menu:
      #   -print a list of current songs
      #   -option to add a song from spotify
      #   -option to remove a song from spotify
      #   -clear playlist
      #   -go back to main menu
      system "clear"
      puts "Setlist name: #{setlist_name} (#{Setlist.find_by(name: setlist_name).tempo} BPM)"
      if Setlist.find_by(name: setlist_name).songs.empty?
        puts "(no songs)"
      else
        Setlist.find_by(name: setlist_name).songs.each_with_index {|song, index| puts "#{index + 1}. #{song.to_s}" }
      end
      menu_hash = {"Add song from Spotify": :add, "Suggest song from Spotify": :suggest, "Remove song from setlist": :remove, "Export setlist": :export,  "Clear setlist": :clear, "Go back to main menu": :back}
      self.prompt.select("Options:", menu_hash)
    end

    def delete_setlist_menu( user )
      return nil if user.setlists.empty?
      menu_hash = user.setlists.map{ | setlist | [ setlist.name, setlist.name.to_sym ] }.to_h
      menu_hash.store( "(cancel)".to_sym, :cancel )
      self.prompt.select( "Select a setlist to delete:", menu_hash )
    end

    def remove_from_setlist_menu( setlist_name )
      system "clear"
      return nil if Setlist.find_by( name: setlist_name ).songs.empty?
      menu_hash = Setlist.find_by( name: setlist_name ).songs.map{ | song | [ song.name, song.name.to_sym ] }.to_h
      menu_hash.store( "(cancel)".to_sym, :cancel )
      self.prompt.select("Choose a song or cancel:", menu_hash )
    end

    def choose_playlist_to_add_or_suggest_from_menu( setlist_name, add_or_suggest )
      system 'clear'
      puts "User #{Setlist.find_by(name: setlist_name).user.name}'s Spotify playlists: "
      user_spotify_playlists = Setlist.find_by(name: setlist_name).user.all_spotify_playlists
      return nil if user_spotify_playlists.empty?
      menu_hash = user_spotify_playlists.map{|playlist| [playlist.name, playlist]  }.to_h
      menu_hash.store("Go back".to_sym, :back)
      self.prompt.select("Choose a playlist to #{ add_or_suggest == :add ? "add" : "suggest" } songs from", menu_hash)
    end

    def choose_song_from_playlist_menu(playlist , setlist_name)
      system 'clear'
      puts "#{Setlist.find_by(name: setlist_name).user.name}'s playlist: #{playlist.name}"
      menu_of_spotify_songs = playlist.tracks.map{|song| [song.name, song.id]   }.to_h
      menu_of_spotify_songs.store("Go back".to_sym, :back)
      self.prompt.select("Choose a song from playlist #{playlist.name} to add to #{setlist_name}", menu_of_spotify_songs)
    end

    def add_song_to_setlist_confirmation(song_spotify_id, setlist_name)
      self.prompt.yes?("Are you sure you want to add this song to #{setlist_name}?")
    end

    def choose_feature_menu
      self.prompt.select( "Choose a feature to suggest by", { "Tempo": :tempo, "Danceability": :danceability, "Energy": :energy, "Valence": :valence, "Loudness": :loudness} )
    end

    def suggestion_filter_menu( feature_to_suggest_by, setlist_name )
      case feature_to_suggest_by
      when :tempo
        tempo_min_max = self.prompt.ask( "How close to setlist's tempo should the suggested song be?", convert: :float )
        this_setlist = Setlist.find_by( name: setlist_name )
        return ( ( this_setlist.tempo - tempo_min_max )..( this_setlist.tempo + tempo_min_max ) )
      when :loudness
        return ( -Float::INFINITY..self.prompt.ask( "What's the loudest the suggested song should be?", convert: :float ) )
      else
        feature_adjective = { danceability: "danceable", energy: "energetic", valence: "compressed" }
        feature_min_max = self.prompt.ask( "How #{ feature_adjective[ feature_to_suggest_by ] } should the suggested song be?", convert: :float )
        return ( ( feature_min_max - 0.15 )..( feature_min_max + 0.15 ) )
      end
    end

    def suggested_songs_menu( playlist_to_choose_from, feature_to_suggest_by, how_to_suggest, setlist_name )
      system "clear"
      puts "Suggestions from #{Setlist.find_by(name: setlist_name).user.name}'s playlist '#{playlist_to_choose_from.name}' - filtered by #{ feature_to_suggest_by.to_s } ±#{ how_to_suggest.to_s }"
      playlist_spotify_ids = playlist_to_choose_from.tracks.map( &:id )
      suggested_song_ids = nil
      case feature_to_suggest_by
      when :tempo
        suggested_song_ids = playlist_spotify_ids.select{ | song_id | how_to_suggest.cover?( RSpotify::AudioFeatures.find( song_id ).tempo ) }
      when :danceability
        suggested_song_ids = playlist_spotify_ids.select{ | song_id | how_to_suggest.cover?( RSpotify::AudioFeatures.find( song_id ).danceability ) }
      when :energy
        suggested_song_ids = playlist_spotify_ids.select{ | song_id | how_to_suggest.cover?( RSpotify::AudioFeatures.find( song_id ).energy ) }
      when :valence
        suggested_song_ids = playlist_spotify_ids.select{ | song_id | how_to_suggest.cover?( RSpotify::AudioFeatures.find( song_id ).valence ) }
      when :loudness
        suggested_song_ids = playlist_spotify_ids.select{ | song_id | how_to_suggest.cover?( RSpotify::AudioFeatures.find( song_id ).loudness ) }
      end
      menu_of_suggested_song_ids = suggested_song_ids.map{ | song_id | [ RSpotify::Track.find( song_id ).name, song_id ] }.to_h
      menu_of_suggested_song_ids.store("Go back".to_sym, :back)
      self.prompt.select( "Choose a suggested song from playlist #{playlist_to_choose_from.name} to add to #{setlist_name}", menu_of_suggested_song_ids )
    end

    def goodbye
        goodbye_ascii =  <<-'EOF'


           ____      U  ___ u    U  ___ u   ____       ____     __   __ U _____ u   _
        U /"___|u     \/"_ \/     \/"_ \/  |  _"\   U | __")u   \ \ / / \| ___"|/ U|"|u
        \| |  _ /     | | | |     | | | | /| | | |   \|  _ \/    \ V /   |  _|"   \| |/
         | |_| |  .-,_| |_| | .-,_| |_| | U| |_| |\   | |_) |   U_|"|_u  | |___    |_|
          \____|   \_)-\___/   \_)-\___/   |____/ u   |____/      |_|    |_____|   (_)
          _)(|_         \\          \\      |||_     _|| \\_  .-,//|(_   <<   >>   |||_
         (__)__)       (__)        (__)    (__)_)   (__) (__)  \_) (__) (__) (__) (__)_)

         EOF
         puts goodbye_ascii.colorize(:red)
        puts "Successfully logged out! Goodbye!"
    end

end
