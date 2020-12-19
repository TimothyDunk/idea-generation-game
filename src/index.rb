# import gems
require "timers"
require "artii"
require "colorize"
require "tty-prompt"

# fix gets
def gets
    STDIN.gets
end

# parse command line arguments
def parse_argv()
    # if there's no command line arguments
    if ARGV.size == 0
        welcome_menu()
    # if there's a help argument passed
    elsif ARGV[0] == "--help" || ARGV[0] == "-h"
        puts "This is a game where you try to come up with as many ideas in a time limit" 
        puts "as possible."
        puts "Play the game using $ ruby index.rb"
        puts "See the version you have installed using $ ruby index.rb -v"
        puts "If you need any further help, please see README.md"
    # if there's a version argument passed
    elsif ARGV[0] == "--version" || ARGV[0] == "-v"
        puts "The version of the idea game you have is v1.0"
    # if another, unrecognised argument is passed
    else 
        puts "#{ARGV[0]} is not a recognised command for this program."
        puts "Use $ ruby index.rb --help or $ ruby index.rb -h"
        puts "to see help information."
        puts "Otherwise just use $ ruby index.rb", "to play the game"
    end
end

# Welcome message
def welcome_menu()
    # clear previous text on terminal
    system("clear")
    #define artii for gem use
    artii = Artii::Base.new
    # define prompt for tty prompt gem for user interface
    prompt = TTY::Prompt.new
    # puts ascii version of "The Idea Game" with Artii gem
    # this title is white text on a blue bg through Colorize gem
    puts artii.asciify("The Idea Game").white.on_blue
    # welcome text
    puts "Welcome to the Idea Game!", ""
    puts "The aim of this game is to come up with as many ideas as possible" 
    puts "within the time limit.", ""
    puts "You will be given a prompt to inspire the ideas," 
    puts "and be able to choose a time limit.", ""
    # menu options
    menu_input = prompt.select("Options:", %w(Continue About Exit))
    #menu options
    # exit option
    if menu_input == "Exit"
        puts "Exiting...", "Have a good day!"
    # about option
    elsif menu_input == "About"
        puts "This game was created by Tim Dunk in 2020."
        puts "Press enter to continue."
        # this gets stops the app from moving on until user presses enter
        gets
        # return to start of loop
        welcome_menu()
    # continue option
    elsif menu_input == "Continue"
        # progresses to next method
        play_game()
    # rescuing invalid inputs, preventing errors
    else
        puts "Invalid input. Please try again." 
        puts "Press enter to continue."
        # this gets stops the app from moving on until user presses enter
        gets
        # return to start of loop
        welcome_menu()
    end
end
# options for game
def play_game()
    # define prompt for tty prompt gem for user interface
    prompt = TTY::Prompt.new

    # select time
    time_input = prompt.select("Select a timer amount:", "30 seconds", "1 minute", "2 minutes", "5 minutes")
    # case to set time_select based on user input
    case time_input
    when "30 seconds"
        puts "You have selected 30 seconds."
        time_select = 30
    when "1 minute"
        puts "You have selected 1 minute."
        time_select = 60
    when "2 minutes"
        puts "You have selected 2 minutes."
        time_select = 120
    when "5 minutes"
        puts "You have selected 5 minutes."
        time_select = 300
    # with tty prompt there should be no way for the user to have selected anything else
    # but this part of code is left in for safety
    else 
        puts "Invalid input. Please try again."
        # returns to start of this screen
        play_game()
    end
    # Select options for prompt category
    prompt_input = prompt.select("Select a prompt category:", "Band Names", "Sketch Ideas", "Observations", "Business Ideas.")
    # random number for use in randomizing prompt given to user
    prompt_num = Random.rand(5)
    # what happens when each option is selected
    case prompt_input
    when "Band Names"
        # array of prompts to be chosen from
        band_names = ["Snail", "Mouse", "Cold", "Valley", "Steep"]
        puts "You have selected band names."
        # sets prompt 
        prompt = "Come up with as many band names that contain the word #{band_names[prompt_num]} as you can."
        # Moves to next part of game
        guessing(time_select, prompt)
    when "Sketch Ideas"
        # array of prompts to be chosen from
        sketch_ideas = ["Restaurant", "Soup", "Doctor", "Grapes", "Houseplant"]
        puts "You have selected sketch ideas."
        # sets prompt
        prompt = "Come up with as many sketch ideas as you can, inspired by the word #{sketch_ideas[prompt_num]}."
        # moves to next part of game
        guessing(time_select, prompt)
    when "Observations"
        # array of prompts to be chosen from
        observations = ["Tea", "Breakfast", "Headlice", "Glass", "An Orange"]
        puts "You have selected observations."
        # sets prompt
        prompt = "Write as many observations about #{observations[prompt_num]} as you can."
        # moves to next part of game
        guessing(time_select, prompt)
    when "Business Ideas"
        # array of prompts to be chosen from
        business_ideas = ["Salt", "Bicycles", "Dating", "Technology", "Books"]
        puts "You have selected business ideas."
        # sets prompt
        prompt = "Come up with as many business ideas as you can, inspired by the word #{business_ideas[prompt_num]}"
        # moves to next part of game
        guessing(time_select, prompt)
    # with tty prompt there should be no way for the user to have selected anything else
    # but this part of code is left in for safety
    else 
        puts "Invalid input. Please try again."
        # returns user to start of section
        play_game()
    end
    # moves to next section
    
end
# actual gameplay
def guessing(number, phrase)
    puts "Press enter to continue."
    gets
    # clear screen
    system("clear")
    # ideas array is created
    ideas = []
    # timers is created for use with timers gem
    timers = Timers::Group.new
    # this will allow loop to be broken after timer expires
    still_time = true
    # puts the prompt from the last section
    puts phrase
    puts "Go!"
    # timer is created, when this expires it will turn still_time to false
    game_timer = timers.after(number) {still_time = false}
    # another timer is created to tell user that time's up
    game_timer2 = timers.after(number) {puts "", "Time's up! Press enter to continue."}
    # new thread is created so timers can run independently of gets
    timer_thread = Thread.new {timers.wait}
    # loop that will continue for more times than needed
    for num in 1..100 do
        # action conditional on the timer not having expired
        if still_time
            # gets is pushed into ideas array
            ideas << gets.chomp
        else
        end
    end
    # threads are joined back together
    timer_thread.join
    # the last item of the idea array is removed
    # because the user must press enter to continue
    ideas.pop
    # move to next section
    after_screen(ideas)
end

# end game screen
def after_screen(array)
    prompt = TTY::Prompt.new
    # screen is cleared
    system("clear")
    # end messages
    # if the user doesn't get any ideas
    if array.size == 0
        puts "You came up with nothing in the time limit! Better luck next time!"
    # if the user only gets one idea
    elsif array.size == 1
        puts "You came up with 1 idea! Try to judge your ideas less!"
        puts "Your idea was: "
        puts array
    # if the user gets more ideas
    else
        puts "You came up with #{array.size} ideas! Good work!"
        puts "This is what you came up with: "
        puts array
    end
    # end game options
    puts ""
    user_end = prompt.select("Options: ", "Exit", "Play Again")
    # 1 is the only other option, this will exit
    if user_end == "Exit"
        puts "Exiting...", "Have a good day!"
    # starts program over
    elsif user_end == "Play Again"
        puts "Press Enter to continue."
        gets
        welcome_menu()
    end
end

# triggers program start when index.rb is run
parse_argv()