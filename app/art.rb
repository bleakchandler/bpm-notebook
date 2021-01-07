class SongPlayer
  
  attr_reader :command, :file_path
  attr_accessor :pid
  
  def initialize
    @command = "afplay"
    @file_path = "because_you_move_me.mp3"
    @pid = nil
  end

  def start_playing
    self.pid = spawn(self.command, self.file_path)
  end

  def stop_playing
    Process.kill 'TERM', self.pid
    ""
  end
  
end

class Equalizer
def self.logo
  puts <<-'EOF'

                     ______     ______   __    __
                    /\  == \   /\  == \ /\ "-./  \
                    \ \  __<   \ \  _-/ \ \ \-./\ \
                     \ \_____\  \ \_\    \ \_\ \ \_\
                      \/_____/   \/_/     \/_/  \/_/
   __   __     ______     ______   ______     ______     ______     ______     __  __
  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/


  EOF
end

def self.frame1
  f1 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/







                                                 __    __    __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f1.colorize(:red)
  sleep(0.2)
  system "clear"
  end

def self.frame2
  f2 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/







                                              __ __    __ __ __    __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f2.colorize(:orange)
  sleep(0.2)
  system "clear"
end

def self.frame3
  f3 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/





                                              __ __    __          __
                                              __ __    __    __    __
                                              __ __    __ __ __    __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f3.colorize(:yellow)
  sleep(0.2)
  system "clear"
end

def self.frame4
  f4 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/




                                              __ __
                                              __ __                __
                                              __ __    __    __ __ __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f4.colorize(:green)
  sleep(0.3)
  system "clear"
end

def self.frame5
  f5 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/




                                                 __
                                              __ __
                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f5.colorize(:light_blue)
  sleep(0.2)
  system "clear"
end

def self.frame6
  f6 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/







                                              __ __    __ __ __    __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f6.colorize(:cyan)
  sleep(0.1)
  system "clear"
end

def self.frame7
  f7 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/




                                              __ __
                                              __ __                __
                                              __ __    __    __ __ __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f7.colorize(:light_green)
  sleep(0.2)
  system "clear"
end

def self.frame8
  f8 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/





                                              __ __    __          __
                                              __ __    __    __    __
                                              __ __    __ __ __    __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f8.colorize(:red)
  sleep(0.2)
  system "clear"
end

def self.frame9
  f9 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/




                                                 __
                                              __ __
                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f9.colorize(:yellow)
  sleep(0.3)
  system "clear"
end

def self.frame10
  f10 =  <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/






                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f10.colorize(:pink)
  sleep(0.1)
  system "clear"
end

def self.frame11
  f11 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/



                                              __ __    __    __    __
                                              __ __    __    __    __
                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f11.colorize(:green)
  sleep(0.3)
  system "clear"
end

def self.frame12
  f12 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/





                                              __ __    __    __    __
                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f12.colorize(:yellow)
  sleep(0.2)
  system "clear"
end

def self.frame13
  f13 = <<-'EOF'

                                     ______     ______   __    __
                                    /\  == \   /\  == \ /\ "-./  \
                                    \ \  __<   \ \  _-/ \ \ \-./\ \
                                     \ \_____\  \ \_\    \ \_\ \ \_\
                                      \/_____/   \/_/     \/_/  \/_/
                   __   __     ______     ______   ______     ______     ______     ______     __  __
                  /\ "-.\ \   /\  __ \   /\__  _\ /\  ___\   /\  == \   /\  __ \   /\  __ \   /\ \/ /
                  \ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \  __\   \ \  __<   \ \ \/\ \  \ \ \/\ \  \ \  _"-.
                   \ \_\\"\_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
                    \/_/ \/_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/\/_/





                                              __ __    __    __    __
                                              __ __    __    __    __
                                              __ __ __ __ __ __ __ __
                                              __ __ __ __ __ __ __ __
                                           🎶Josh Frank & James DeSousa🎶
  EOF
  puts f13.colorize(:yellow)
end

def self.animation
  2.times do
    Equalizer.frame1
    Equalizer.frame2
    Equalizer.frame3
    Equalizer.frame4
    Equalizer.frame5
    Equalizer.frame6
    Equalizer.frame7
    Equalizer.frame8
    Equalizer.frame9
    Equalizer.frame10
    Equalizer.frame12
    Equalizer.frame11
    Equalizer.frame12
    Equalizer.frame10
    Equalizer.frame12
    Equalizer.frame11
    Equalizer.frame12
    Equalizer.frame11
    Equalizer.frame12
  end
  Equalizer.frame13
  end
end
