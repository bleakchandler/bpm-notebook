class Interface

    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        system "clear"
        puts "Awesome Welcome Screen"
        self.prompt.keypress("Press any key to continue")
    end

    def main_menu( user )
        # Main menu:
        # - list of all setlists
        # - (create new setlist)
        # - (delete setlist)
        # - (quit)
        system "clear"
        menu_hash = user.setlists.map{ | setlist | [ setlist.name, setlist.name.to_sym ] }.to_h
        menu_hash.store( "(new setlist)".to_sym, :new_setlist )
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
        puts "Setlist name: #{setlist_name}"
        if Setlist.find_by(name: setlist_name).songs.empty?
          puts "(no songs)"
        else
          Setlist.find_by(name: setlist_name).songs.each_with_index {|song, index| puts "#{index + 1}. #{song.to_s}" }
        end
        menu_hash = {"Add song from Spotify": :add, "Remove song from setlist": :remove, "Clear setlist": :clear, "Go back to main menu": :back}
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

    def goodbye
        puts "Awesome Goodbye screen"
        puts "Successfully logged out! Goodbye!"
    end

end
