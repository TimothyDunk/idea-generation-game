require 'timers'

# fix gets
def gets
    STDIN.gets
end

# Welcome message
def welcome_menu()
    # clear previous text on terminal
    system('clear')
    # welcome text
    puts 'Welcome to the Idea Game!', ''
    puts 'The aim of this game is to come up with as many ideas as possible' 
    puts 'within the time limit.', ''
    puts 'You will be given a prompt to inspire the ideas,' 
    puts 'and be able to choose a time limit.', ''
    puts "Press 1 to Continue."
    puts "Press 2 to see about information."
    puts "Press 3 to Exit."
    menu_input = gets.chomp
    # exit
    if menu_input.to_i == 3
        puts 'Exiting...', 'Have a good day!'
    # about
    elsif menu_input.to_i == 2
        puts 'This game was created by Tim Dunk in 2020.'
        puts 'press enter to continue'
        gets
        welcome_menu()
    # continue
    elsif menu_input.to_i == 1
        play_game()
    # saving invalid inputs
    else
        puts 'Invalid input. Please try again. Press enter to continue.'
        gets
        welcome_menu()
    end
end

def play_game()
    puts '', 'Select a timer amount:'
    puts 'Press 1 for 30 seconds.'
    puts 'Press 2 for 1 minute.'
    puts 'Press 3 for 2 minutes.'
    puts 'Press 4 for 5 minutes.'
    time_input = gets.chomp.to_i
    case time_input
    when 1
        puts 'You have selected 30 seconds.'
        time_select = 30
    when 2
        puts 'You have selected 1 minute.'
        time_select = 60
    when 3
        puts 'You have selected 2 minutes.'
        time_select = 120
    when 4
        puts 'You have selected 5 minutes.'
        time_select = 300
    else 
        puts "Invalid input. Please try again."
        play_game()
    end
    puts '', 'Select a prompt category:'
    puts 'Press 1 for band names.'
    puts 'Press 2 for sketch ideas.'
    puts 'Press 3 for observations.'
    puts 'Press 4 for business ideas.'
    prompt_num = Random.rand(5)
    prompt_input = gets.chomp.to_i
    case prompt_input
    when 1
        band_names = ["Snail", "Mouse", "Cold", "Valley", "Steep"]
        puts 'You have selected band names.'
        prompt = "Come up with as many band names that contain the word #{band_names[prompt_num]} as you can."
    when 2
        sketch_ideas = ["Restaurant", "Soup", "Doctor", "Grapes", "Houseplant"]
        puts 'You have selected sketch ideas.'
        prompt = "Come up with as many sketch ideas as you can, inspired by the word #{sketch_ideas[prompt_num]}."
    when 3
        observations = ["Tea", "Breakfast", "Headlice", "Glass", "An Orange"]
        puts 'You have selected observations.'
        prompt = "Write as many observations about #{observations[prompt_num]} as you can."
    when 4
        business_ideas = ["Salt", "Bicycles", "Dating", "Technology", "Books"]
        puts 'You have selected business ideas.'
        prompt = "Come up with as many business ideas as you can, inspired by the word #{business_ideas[prompt_num]}"
    else 
        puts "Invalid input. Please try again."
        play_game()
    end
    guessing(time_select, prompt)
end

def guessing(number, phrase)
    ideas = []
    timers = Timers::Group.new
    still_time = true
    puts phrase
    puts 'Go!'
    thirty_second_timer = timers.after(number) {still_time = false}
    thirty_second_timer2 = timers.after(number) {puts '', 'Time\'s up! Press enter to continue.'}
    timer_thread = Thread.new {timers.wait}
    for num in 1..100 do
        if still_time
            ideas << gets.chomp
        else
        end
    end
    timer_thread.join
    ideas.pop
    system("clear")
    if ideas.size == 0
        puts "You came up with nothing in the time limit! Better luck next time!"
    elsif ideas.size == 1
        puts "You came up with 1 idea! Try to judge your ideas less!"
        puts "Your idea was: "
        puts ideas
    else
        puts "You came up with #{ideas.size} ideas! Good work!"
        puts "This is what you came up with: "
        puts ideas
    end
    puts "", "Press 1 to exit."
    puts "Press enter to continue."
    user_end = gets.chomp.to_i
    if user_end == 1
        puts "Exiting...", "Have a good day!"
    else
        welcome_menu()
    end
end

welcome_menu()