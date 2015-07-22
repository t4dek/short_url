Rails.application.routes.draw do
  root 'links#index' 
  get ':uniq_key' => 'links#show'
  resources :links
end
