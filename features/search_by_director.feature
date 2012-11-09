Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and search on director information in movies I enter

Background: movies in database
Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  | THX-1131     | G      | George Lucas |   1971-03-11 |


Scenario: find movie with same director
  Given I am on the RottenPotatoes home page
  And I check the following ratings: PG
  And I press "Refresh"
  When I follow "More about Star Wars"
  Then  I should be on the details page for "Star Wars"
  And   I should see "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"
