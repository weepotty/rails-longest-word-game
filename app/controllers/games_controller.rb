class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score

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
