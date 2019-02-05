Rails.application.routes.draw do
  mount Jsql::Engine => "/jsql"
end
