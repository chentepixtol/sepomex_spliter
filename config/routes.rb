Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'file#index'

  post '/upload' => 'file#upload', as: 'upload'


end
