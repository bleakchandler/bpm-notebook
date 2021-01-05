class Interface

    attr_reader :prompt
    
    def initialize
        @prompt = TTY::Prompt.new
    end

end