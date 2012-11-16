class Movie < ActiveRecord::Base
  validates_presence_of :title
  #validates_uniqueness_of :tmdb_id, :imdb_id

 def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_directors(director)
    Movie.where(:director => director)
  end

end
