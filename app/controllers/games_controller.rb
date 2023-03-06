require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params['word']
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_attempt = URI.open(url).read
    word_check = JSON.parse(word_attempt)
    grid = params['grid'].split
    attempt_array = @word.upcase.chars
    possible_words = grid.permutation(@word.length).to_a

    if word_check['found'] && possible_words.include?(attempt_array)
      # @calculated_score = attempt_array.length / time_taken
      @message = "Congratulations! #{@word.upcase} is a valid English word!"
    elsif !possible_words.include?(attempt_array)
      @message = "Sorry but #{@word.upcase} can't be built out of #{grid.join}"
    elsif !word_check['found']
      @message = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    end

  end
end


# /new (new action)
# displays grid letters
# form for user to type the word -> button to submit
# submit to /score


# /score (score action)
# receives this form info in params
# compute the user score
# display the score
