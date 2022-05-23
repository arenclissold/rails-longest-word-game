require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    cookies[:total_score] = 0 unless cookies[:total_score]
    guess = params[:guess].upcase
    letters = params[:letters].chars
    @response = if !letter_test(guess, letters)
                  "Sorry but #{guess} can't be built out of #{letters.to_sentence}"
                elsif !api_test(guess)
                  "Sorry but #{guess} does not seem to be a valid English word..."
                else
                  @score = guess.length**2
                  cookies[:total_score] = cookies[:total_score].to_i + @score
                  "Congradulations #{guess} is a valid English word! You scored #{@score}"
                end
    @total_score = cookies[:total_score]
  end

  private

  def letter_test(guess, letters)
    guess.chars.tally.each do |letter, value|
      return false if value > letters.tally[letter].to_i
    end
    true
  end

  def api_test(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    api_data = JSON.parse(URI.open(url).read)
    api_data['found']
  end
end
