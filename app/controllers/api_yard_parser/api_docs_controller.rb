module ApiYardParser
  class ApiDocsController < ::ActionController::Base

    def index
      if Rails.env == "production" && ApiYardParser.no_docs_in_production
        render :text => "no docs in production"
        return true
      end
      @list_apis = ApiDocs.get_all

      @without = params[:without].split(",") if !params[:without].nil?

      if !@without.nil?
        @list_apis.select!{|api| @without.index(api.name) == nil }
      end
      render "index", :layout => false
    end

  end
end