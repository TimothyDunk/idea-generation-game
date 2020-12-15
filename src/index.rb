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
    puts 'Press "1" to Continue, press "2" to see about information, or press "3" to Exit'
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
    prompt_input = gets.chomp.to_i
    case prompt_input
    when 1
        puts 'You have selected band names.'
    when 2
        puts 'You have selected sketch ideas.'
    when 3
        puts 'You have selected observations.'
    when 4
        puts 'You have selected business ideas.'
    else 
        puts "Invalid input. Please try again."
        play_game()
    end
    guessing(time_select)
    case time_input
    when 1
        
    when 2
        puts 'You have 1 minute to...'
        sleep 60
        puts "Time over!"
    when 3
        puts 'You have 2 minutes to...'
        sleep 120
        puts "Time over!"
    when 4
        puts 'You have 5 minutes to...'
        sleep 300
        puts "Time over!"
    else 
        puts "Invalid input. Please try again."
        play_game()
    end
end

def guessing(number)
    ideas = []
    timers = Timers::Group.new
    still_time = true
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
end

welcome_menu()