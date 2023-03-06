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

    @valid = word_check['found']? 'yes' : 'no'
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
