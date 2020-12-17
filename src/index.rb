# import gems
require "timers"
require "artii"
require "colorize"

# fix gets
def gets
    STDIN.gets
end

# Welcome message
def welcome_menu()
    # clear previous text on terminal
    system("clear")
    #define artii for gem use
    artii = Artii::Base.new
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
    puts "Press 1 to Continue."
    puts "Press 2 to see about information."
    puts "Press 3 to Exit."
    #user input
    menu_input = gets.chomp
    #menu options
    # exit option
    if menu_input.to_i == 3
        puts "Exiting...", "Have a good day!"
    # about option
    elsif menu_input.to_i == 2
        puts "This game was created by Tim Dunk in 2020."
        puts "Press enter to continue."
        # this gets stops the app from moving on until user presses enter
        gets
        # return to start of loop
        welcome_menu()
    # continue option
    elsif menu_input.to_i == 1
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
    puts "", "Select a timer amount:"
    puts "Press 1 for 30 seconds."
    puts "Press 2 for 1 minute."
    puts "Press 3 for 2 minutes."
    puts "Press 4 for 5 minutes."
    # user gets to select time
    time_input = gets.chomp.to_i
    case time_input
    when 1
        puts "You have selected 30 seconds."
        time_select = 30
    when 2
        puts "You have selected 1 minute."
        time_select = 60
    when 3
        puts "You have selected 2 minutes."
        time_select = 120
    when 4
        puts "You have selected 5 minutes."
        time_select = 300
    else 
        puts "Invalid input. Please try again."
        # returns to start of this screen
        play_game()
    end
    puts "", "Select a prompt category:"
    puts "Press 1 for band names."
    puts "Press 2 for sketch ideas."
    puts "Press 3 for observations."
    puts "Press 4 for business ideas."
    # random number for use in randomizing prompt given to user
    prompt_num = Random.rand(5)
    # user input to decide prompt category
    prompt_input = gets.chomp.to_i
    case prompt_input
    when 1
        # array of prompts to be chosen from
        band_names = ["Snail", "Mouse", "Cold", "Valley", "Steep"]
        puts "You have selected band names."
        # sets prompt 
        prompt = "Come up with as many band names that contain the word #{band_names[prompt_num]} as you can."
    when 2
        # array of prompts to be chosen from
        sketch_ideas = ["Restaurant", "Soup", "Doctor", "Grapes", "Houseplant"]
        puts "You have selected sketch ideas."
        # sets prompt
        prompt = "Come up with as many sketch ideas as you can, inspired by the word #{sketch_ideas[prompt_num]}."
    when 3
        # array of prompts to be chosen from
        observations = ["Tea", "Breakfast", "Headlice", "Glass", "An Orange"]
        puts "You have selected observations."
        # sets prompt
        prompt = "Write as many observations about #{observations[prompt_num]} as you can."
    when 4
        # array of prompts to be chosen from
        business_ideas = ["Salt", "Bicycles", "Dating", "Technology", "Books"]
        puts "You have selected business ideas."
        # sets prompt
        prompt = "Come up with as many business ideas as you can, inspired by the word #{business_ideas[prompt_num]}"
    else 
        puts "Invalid input. Please try again."
        # returns user to start of section
        play_game()
    end
    # moves to next section
    guessing(time_select, prompt)
end
# actual gameplay
def guessing(number, phrase)
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
    puts "", "Press 1 to exit."
    puts "Press enter to play again."
    # get user input
    user_end = gets.chomp.to_i
    # 1 is the only other option, this will exit
    if user_end == 1
        puts "Exiting...", "Have a good day!"
    # starts program over
    else
        welcome_menu()
    end
end

# triggers program start when index.rb is run
welcome_menu()