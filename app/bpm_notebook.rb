class BPMNotebook

    def run
      interface = Interface.new
      interface.welcome
      user = interface.create_or_log_in_user

    end

end
