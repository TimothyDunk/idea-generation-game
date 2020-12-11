# Welcome message
def welcome_menu()
    system('clear')
    puts 'Welcome to the Idea Game!', ''
    puts 'The aim of this game is to come up with as many ideas as possible' 
    puts 'within the time limit.', ''
    puts 'You will be given a prompt to inspire the ideas,' 
    puts 'and be able to choose a time limit.', ''
    puts 'Press "1" to Continue, "2" to see about information, or "3" to Exit'
    menu_input = gets.chomp
    if menu_input.to_i == 3
        puts 'Exiting...', 'Have a good day!'
    elsif menu_input.to_i == 2
        puts 'This game was created by Tim Dunk in 2020.'
        puts 'press enter to continue'
        gets
        welcome_menu()
    elsif menu_input.to_i == 1
        play_game()
    else
        puts "Invalid input. Please try again. Press enter to continue."
        gets
        welcome_menu()
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