
require "active_support/dependencies"

module ApiYardParser
	# %w(api_comment api_controllers ap_docs).each do |entity|
 #    require_relative "api_yard_parser/#{entity}"
 #  end
 require_relative "api_yard_parser/api_comment"
 require_relative "api_yard_parser/api_controllers"
 require_relative "api_yard_parser/api_docs"

  def force_no_docs_production
  	true || @production
  end

end

require "api_yard_parser/engine"