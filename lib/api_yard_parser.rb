
require "active_support/dependencies"

module ApiYardParser

	attr_accessor :no_docs_in_production
	# %w(api_comment api_controllers ap_docs).each do |entity|
 #    require_relative "api_yard_parser/#{entity}"
 #  end
 require_relative "api_yard_parser/api_comment"
 require_relative "api_yard_parser/api_controllers"
 require_relative "api_yard_parser/api_docs"

  def no_docs_in_production
  	@no_docs_in_production || true
  end

end

require "api_yard_parser/engine"