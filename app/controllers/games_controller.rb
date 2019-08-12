require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @alphabet = ("A".."Z").to_a
    @letters = 10.times.map { @alphabet.sample }
  end

  def score
    @alphabet = ("A".."Z").to_a
    @letters = params[:letters]
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english = english?(@word)
    # @word_array = @word.split('')
    # @score = @word_array.map { |letter| value = @alphabet.index(letter) }
  end

  private

  def included?(word, letters)
    word_array = word.split('')
    word_array.all? { |letter| word_array.count(letter) <= letters.count(letter) }
  end

  def english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    words_serialized = open(url).read
    word = JSON.parse(words_serialized)
    word['found']
  end

end
