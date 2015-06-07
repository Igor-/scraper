Rails.application.routes.draw do
  
  root 'home#index'
  
  post 'home/create' => 'home#create'

  
end
