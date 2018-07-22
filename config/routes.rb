Rails.application.routes.draw do
  root to: 'tweet#add'
  get '/add' => 'tweet#add'
  get '/search' => 'tweet#search'
end
ElasticsearchMiniProject::Application.routes.draw do
end
