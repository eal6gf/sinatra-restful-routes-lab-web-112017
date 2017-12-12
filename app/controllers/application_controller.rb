class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/recipes"
  end

  #INDEX RECIPES
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end


  #NEW RECIPES
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    #creates a recipe based on input params
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])

    #redirects to the show action just to view the new recipe.
    redirect to "/recipes/#{@recipe.id}"
  end


  #SHOW RECIPES
  get '/recipes/:id' do
    #find a recipe by a certain id.
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end


  #EDIT Recipes
  #*** NEEDS ALTERED FORM
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    #*** NEEDS ALTERED FORM
    #finds a recipe that is being updated and updates it.
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end


  #DELETE Recipe
  delete '/recipes/:id/delete' do
    #*** NEEDS ALTERED FORM
    #find a recipe and call activerecord delete on it.
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end


end
