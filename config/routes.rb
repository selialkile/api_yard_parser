Rails.application.routes.draw do
  get "/docs" => "api_yard_parser/api_docs#index" , :as => :docs_page
end