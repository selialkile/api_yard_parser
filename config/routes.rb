Rails.application.routes.draw do
	unless Rails.env == 'production'
	  get "/docs" => "api_yard_parser/api_docs#index" , :as => :docs_page
	end
end