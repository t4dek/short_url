Rails.application.routes.draw do
  root 'links#index' 
  get ':uniq_key' => 'links#show', as: 'short'
  resources :links
end
