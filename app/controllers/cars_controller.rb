class CarsController < ApplicationController
  before_action :set_car, only: %i[ show update destroy ]

  # GET /cars
  def index
    @cars = Car.all.reverse
    render json: 
       @cars.to_json(except: [:id, :created_at, :updated_at])
  end

  # GET /cars/1
  def show
    render json: @car
  end

  # POST /cars
  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created, location: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end
    
  def createFakeCars()  
    makers = ['Toyota', 'Volvo', 'Opel', 'Ford']
    models = ['x', 'y','z']
    for i in 1..params[:numberOfCars].to_i do
        Car.create(
            make: makers[rand(1..4)],
            model: models[rand(1..3)],
            price: rand(10000..50000)
        )
    end
  end
  
  def destroyRecentCars  
    #Check number of cars
    totalNumberOfCars = Car.all.count
    numberOfCarsToBeDeleted = params[:numberOfCars].to_i
    if totalNumberOfCars < numberOfCarsToBeDeleted
        numberOfCarsToBeDeleted = totalNumberOfCars
    end
    cars = Car.last(numberOfCarsToBeDeleted) 
    for car in cars do
      car.destroy
    end
  end
    

  # PATCH/PUT /cars/1
  def update
    if @car.update(car_params)
      render json: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
    @car.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:make, :model, :price)
    end
end
