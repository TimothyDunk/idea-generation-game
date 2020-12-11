# Welcome message
def welcome_menu()
    system('clear')
    puts 'Welcome to the Idea Game!', ''
    puts 'The aim of this game is to come up with as many ideas as possible' 
    puts 'within the time limit.', ''
    puts 'You will be given a prompt to inspire the ideas,' 
    puts 'and be able to choose a time limit.', ''
    puts 'Press Enter to Continue, or "e" to Exit'
    menu_input = gets.chomp
    if menu_input.include?('e') || menu_input.include('E')
        puts 'Exiting...', 'Have a good day!'
    else
        play_game()
    end
end

def play_game()
    puts "playing game..."
end

# Select a time limit
# Select a prompt category
# Random prompt in category selected
# Prompt is shown to user
# Timer starts
# gets from user pushes into array

# When timer finishes if array size == 0
# puts "Sorry! You got nothing. Better luck next time!"
# if array size == 1 
# puts "Congratulations! You came up with 1 idea! You gotta start somewhere."
# puts idea from array
# else
# puts "Congratulations! You came up with number ideas!"
# puts numbered list of ideas from array

welcome_menu()