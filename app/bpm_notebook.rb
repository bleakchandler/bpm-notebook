class BPMNotebook

    def run
      interface = Interface.new
      interface.welcome
      user_id = interface.create_or_log_in_user
      choice = nil
      while choice != :goodbye
        choice = interface.main_menu( User.find( user_id ) )
        if choice == :new_setlist
          interface.create_new_setlist( User.find( user_id ) )
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
