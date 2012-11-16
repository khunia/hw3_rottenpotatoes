class MoviesController < ApplicationController

  def show
    begin
     @id = params[:id] # retrieve movie ID from URI route
     @movie = Movie.find(params[:id])
     @director = @movie.director
    rescue ActiveRecord::RecordNotFound
 #     return flash[:warning] = 'Review must be for an existing movie.'
      redirect_to movies_path
     end
  end


  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
  end

  def create 
   if params[:commit] == 'Cancel'
     redirect_to movies_path
   else
     @movie = Movie.create!(params[:movie])
     flash[:notice] = "#{@movie.title} was successfully created."
     redirect_to movies_path
   end 
  end


  def edit
    begin
     @id = params[:id] # retrieve movie ID from URI route
     @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
 #     return flash[:warning] = 'Review must be for an existing movie.'
      redirect_to movies_path
     end
  end

  def update
   if params[:commit] == 'Cancel'
     redirect_to movies_path
   else
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
   end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

    def cancel
      redirect_to movie_path(@movie)
    end

  def search_tmdb
      Tmdb.api_key = "f0e3f36631f1fbb66d480a4b646b1993"
      Tmdb.default_language = "en"
      @tmdbmovies = TmdbMovie.find(:title => params[:search_terms],:expand_results => false)
  end


def movie_add

  logger.warn("========#{tmdbmovie.name}=============")
#  render :nothing => true

end



  def similar
    @id = params[:movie_id]
    @movie = Movie.find(@id)
    @director = @movie.director
    if not @director.blank?
      @movies = Movie.similar_directors(@director)
    else
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to movies_path
    end
  end

end
