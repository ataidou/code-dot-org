@eyes_mobile
Feature: Look at mobile portait view

  Background:
    Given I am on "http://studio.code.org/reset_session"

  # When viewing our puzzles on a mobile phone in portrait mode, an image and text
  # should appear telling you to flip to landscape. We've regressed this multiple
  # times. This test is meant to prevent doing so again.
  Scenario Outline: Simple blockly level page view
    Given I am on "<url>"
    When I open my eyes to test "<test_name>"
    And I rotate to portrait
    And I wait for the page to fully load
    And I see no difference for "temp"
    And I close my eyes
    And I sign out
    Examples:
      | url                                                                       | test_name     |
      | https://studio.code.org/s/allthethings/stage/18/puzzle/5?noautoplay=true  | droplet level |
      | https://studio.code.org/s/allthethings/stage/37/puzzle/1?noautoplay=true  | artist level  |
