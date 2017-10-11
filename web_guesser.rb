require 'sinatra'
require 'sinatra/reloader'

number = rand(100).to_i
@color_var = '#fff'

def guess(guess, n)
  #case guess
  if guess == 0
    guess = " "
  elsif guess > n
    @color_var = '#f00' # red
    guess = "Too high!"
  elsif guess < n
    @color_var = '#ff0' # yellow
    guess = "Too low!"
  elsif guess == n
    @color_var = '#0f0' # green
    guess = "Correct! The secret number is #{n}!"
  end
end 

get '/' do
 guess = params["guess"]
 check_guess = guess(guess.to_i, number)
 erb :index, :locals => {:number => number, :guess => guess, :check_guess => check_guess, :color_var => @color_var}
end