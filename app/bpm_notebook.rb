class BPMNotebook

    def run
      RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")
      interface = Interface.new
      interface.welcome
      user_id = interface.create_or_log_in_user
      choice = nil
      while true
        choice = interface.main_menu( User.find( user_id ) )
        if choice == :new_setlist
          interface.create_new_setlist( User.find( user_id ) )
        elsif choice == :goodbye
          break
        else
          interface.manage_setlist( choice.to_s, User.find( user_id ) )
        end
      end
      interface.goodbye
    end

    def main_loop
      #
    end

end
