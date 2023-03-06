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
    message(params)
  end

  private

  def message(params)
    if word_english?(params) && word_from_grid?(params)
      # @calculated_score = attempt_array.length / time_taken
      @message_prefix = 'Congratulations!'
      @message_suffix = 'is a valid English word!'
    elsif !word_from_grid?(params)
      @message_prefix = 'Sorry but'
      @message_suffix = "can't be built out of #{params['grid'].split.join(', ')}"
    elsif !word_english?(params)
      @message_prefix = 'Sorry but'
      @message_suffix = 'does not seem to be a valid English word...'
    end
  end

  def word_english?(params)
    @word = params['word']
    word_check = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    word_check['found']
  end

  def word_from_grid?(params)
    grid = params['grid'].split
    possible_words = grid.permutation(@word.length).to_a
    attempt_array = params['word'].upcase.chars
    possible_words.include?(attempt_array)
  end
end
