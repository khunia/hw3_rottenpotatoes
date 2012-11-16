Feature: movies when added should appear in movie list

Scenario: view movie list after adding movie (declarative and DRY)

  Given I have added "Zorro" with rating "PG-13"
  And   I have added "Apocalypse Now" with rating "R"
  And   I am on the RottenPotatoes home page sorted by title
  Then  I should see "Apocalypse Now" before "Zorro"
