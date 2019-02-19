require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letter_arr = ('A'..'Z').to_a
    @letters = 10.times.map { letter_arr.sample }
  end

  def score
    answer = params[:answer]
    letters = params[:letters]
    @score = 0
    if is_word?(answer) && is_in_grid?(answer, letters)
      @response = "#{answer} is #{answer.length} long, calculating score.."
      @score = answer.length
    else
      @response = "#{answer} not a word in grid"
      @score = 0
    end

  end

  def is_word?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    dict = open(url).read
    dict_hash = JSON.parse(dict)
    dict_hash["found"]
  end

  def is_in_grid?(answer, letters)
    answer = answer.upcase
    answer.chars.all? { |char| answer.count(char) <= letters.count(char)}
  end
end

