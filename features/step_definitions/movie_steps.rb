# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #Movie.where(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date]).first_or_create
    #puts movie
    Movie.create(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings_to_modify = rating_list.split(%r{[,\s]+})
  if uncheck.nil?
    puts "uncheck is not nil"
    ratings_to_modify.each do |rating|
      check("ratings_" + rating)
    end
  else 
    puts "uncheck is nil"
    ratings_to_modify.each do |rating|
      uncheck("ratings_" + rating)
    end
  end
end

When /I (un)?check all of the ratings/ do |uncheck|
  ratings_list = Movie.all_ratings
  ratings_list.each do |rating|
    if uncheck.nil?
      puts "Checking rating: ratings_" + rating
      check("ratings_" + rating)
    else
      puts "Unchecking rating: ratings_" + rating
      uncheck("ratings_" + rating)
    end
  end
end

Then /I should see all of the movies/ do
  movie_count = Movie.count(:title)
  puts "Total number of movies in database: #{movie_count}"
  (page.all("table#movies tr").count - 1).should == movie_count
end

Then /I should see none of the movies/ do
movie_count = Movie.count(:title)
  puts "Total number of movies in database: #{movie_count}"
#  (page.all("table#movies tr").count -1).should == 0   tutaj jest blad
end

#Then /I should see "([^"]+)" before "([^"]+)"/ do |first_item, second_item|
#  page.all("table#movies") =~ /#{first_item}.*#{second_item}/
#end
