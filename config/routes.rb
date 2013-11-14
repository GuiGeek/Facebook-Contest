Guildecontest::Application.routes.draw do
  match 'subscriptions/liked' => 'subscriptions#liked'
  match 'subscriptions/csv' => 'subscriptions#subscriptionsToCsv'
  match 'subscriptions/thanks/:id' => 'subscriptions#thanks', :as => :thanks
  match 'subscriptions/closed' => 'subscriptions#closed'
  
  resources :subscriptions, :except => :edit
  
  root :to => 'subscriptions#liked'
  #root :to => 'subscriptions#closed' #Change to this root path to close contest
end
