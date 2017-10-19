require 'sinatra'
require 'sinatra/reloader'

@@number = rand(1..100)
@@remaining_guesses = 5

@background_color = "#fff"
@cheat = ""

check_guess = "Guess a number 1 - 100"

get '/' do
  if params['cheat'] == "true"
 	  @cheat = "CHEAT: #{@@number}"
  end
  
  if params['guess'] != nil
    guess = params["guess"]
    check_guess = check_guess(guess.to_i)
  end
  
  erb :index, :locals => {:check_guess => check_guess,
                          :cheat => @cheat,
                          :remaining_guesses => @@remaining_guesses,
                          :background_color => @background_color}
end

def new_game
  @@remaining_guesses = 5
  @@number = rand(1..100)
  
  if params['cheat'] == "true"
 	  @cheat = "CHEAT: #{@@number}"
  else
    @cheat = "" # clear @cheat if not in use
  end
end

def check_guess(guess)
  @@last_number = @@number
  
  if @@remaining_guesses != 1
    @@remaining_guesses -= 1
  elsif @@remaining_guesses == 1 && guess != @@number
    @background_color = "red"
    new_game
    return "Game Over! #{@@last_number} was the correct answer.<br>Enter guess (1-100) to start new game:"
  end
  
  
  case guess
    when @@number
      new_game
      @background_color = "green"
      return "Yes! The secret number was #{@@last_number}!<br>Enter guess (1-100) to start new game:"
    when (@@number+10..100)
      @background_color = "red"
      return "Way too high!"
    when (@@number...100)
      @background_color = "orange"
      return "Too high!"
    when (1...@@number)
      @background_color = "yellow"
      return "Too low!"
    when (1..@@number-10) 
      @background_color = "blue"
      return "Way too low!"
    else
      @@remaining_guesses += 1
      return "Invalid: Guess a number 1 - 100"
  end
end