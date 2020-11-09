require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }
  end


  def score
    @word = params[:word]
    @letters = params[:letters].split
    if included?(@word.upcase, @letters)
      if english_word?(@word)
        @result = "Valid Word"
      else
        @result = "not an english word"
      end
    else
      @result = "not in the grid"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read.to_s)
      return json['found']
  end
end



  # def run_game(attempt, grid, start_time, end_time)
  #   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
  #   result = { time: end_time - start_time }

  #   score_and_message = score_and_message(attempt, grid, result[:time])
  #   result[:score] = score_and_message.first
  #   result[:message] = score_and_message.last

  #   result
  # end

#   def compute_score(attempt, time_taken)
#     time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
#   end



