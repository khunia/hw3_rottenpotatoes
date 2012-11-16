class Movie < ActiveRecord::Base
  validates_presence_of :title, :release_year
  validates_uniqueness_of :tmdb_id, :imdb_id

 def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_directors(director)
    Movie.where(:director => director)
  end

  def update_from_tmdb_id(tmdb_id)
    tm_movie = TmdbMovie.find(:id => tmdb_id)
    self.map_tmdb(tm_movie)
  end

  def map_tmdb(tm_movie)
    self.title = tm_movie.name
    self.tmdb_id = tm_movie.id
    self.imdb_id = tm_movie.imdb_id
    self.tmdb_url = tm_movie.url
    self.released = tm_movie.released
    self.release_year = self.released.year
    self.overview = tm_movie.overview
  end  

end
