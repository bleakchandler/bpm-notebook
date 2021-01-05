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

    def create_or_log_in_user
        system "clear"
        user_logging_in = self.prompt.ask("Enter Username")
        user_logged_in = nil
        if User.where(name: user_logging_in).empty?
          puts "Hm.. looks like there is no user with that name. Let's create one!"
          user_logged_in = self.create_new_user(user_logging_in)
        else
          user_logged_in = User.find_by(name: user_logging_in)
          puts "Welcome back, #{user_logged_in.name}!"
          password_attempt = self.prompt.mask("Enter your password")
          while password_attempt != user_logged_in.password do
            puts "Incorrect password, please try again."
          end
          puts "#{ user_logged_in.name } has logged in successfully"
          self.prompt.keypress("Press any key to continue")
        end
        user_logged_in.id
    end

    def create_new_user(new_username)
        new_user_arguments = {name: new_username}
        new_user_arguments[:spotify_username] = self.prompt.ask("Enter your Spotify username")
        new_user_arguments[:password] = self.prompt.mask("Enter a password")
        password_confirmation = self.prompt.mask("Confirm your password")
        while password_confirmation != new_user_arguments[:password] do
          puts "Passwords do not match, please try again"
          password_confirmation = self.prompt.mask("Confirm your password")
        end
        User.create(new_user_arguments).id
    end

    def main_menu( user )
        # Main menu:
        # - list of all setlists
        # - (create new setlist)
        # - (quit)
        system "clear"
        menu_hash = user.setlists.map{ | setlist | [ setlist.name, setlist.name.to_sym ] }.to_h
        menu_hash.store( "(new setlist)".to_sym, :new_setlist )
        menu_hash.store( "(quit)".to_sym, :goodbye )
        self.prompt.select("Choose a setlist or create a new setlist:", menu_hash )
    end

    def manage_setlist( setlist_name, user )
        #
    end

    def create_new_setlist( user )
        system "clear"
        new_setlist_name = self.prompt.ask( "Enter a name for your new setlist" )
        new_setlist_tempo = self.prompt.ask( "Enter a tempo for your new setlist", convert: :float )
        Setlist.create( name: new_setlist_name, tempo: new_setlist_tempo, user_id: user.id )
        puts "Setlist '#{ new_setlist_name }' successfully created!"
        self.prompt.keypress("Press any key to continue")
    end

    def setlist_edit_menu
        #
    end

    def goodbye
        puts "Awesome Goodbye screen"
        puts "Successfully logged out! Goodbye!"
    end

end
