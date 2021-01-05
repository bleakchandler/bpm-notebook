class Interface

    attr_reader :prompt
    
    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        #
    end

    def create_or_log_in_user
        #
    end

    def main_menu
        #
    end

    def create_or_select_setlist
        #
    end

    def setlist_edit_menu
        #
    end

end