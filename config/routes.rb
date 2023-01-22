Rails.application.routes.draw do
  resources :cars
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   Defines the root path route ("/")
#   root "cars#index"
    post 'createFakeCars', to: 'cars#createFakeCars'
    get 'getSpecificModel', to: 'cars#getSpecificModel'
    post 'getSpecificMaker', to: 'cars#getSpecificMaker'
    post 'listOfCars', to: 'cars#listOfCars'
    delete 'destroyRecentCars', to: 'cars#destroyRecentCars'
end
