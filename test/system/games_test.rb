require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "filling the form with a random word and click the play button, gives a message that the word is not in the grid" do
    visit new_url
    page.fill_in 'guess', with: 'kjfnjknfjknelnr'
    click_on 'play'
    assert_selector "p", text: "can't be built out of"
  end
end
