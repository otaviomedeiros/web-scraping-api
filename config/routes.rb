Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    get :'page-info'
  end
end
