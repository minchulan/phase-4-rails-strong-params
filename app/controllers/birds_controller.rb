class BirdsController < ApplicationController
  wrap_parameters format: [] #Rails by default will wrap JSON params as a nested hash under a key based on the name of the controller

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  # explicitly specifying which attributes we'd like our new bird to be created with
      # bird = Bird.create(name: params[:name], species: params[:species])
  # use strong parameters to permit only the params we want to use:
      # bird = Bird.create(params.permit(:name, :species))

  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  private 
    #all methods below here are private

  def bird_params
    params.permit(:name, :species)
  end 

end
