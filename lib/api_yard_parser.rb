module ApiYardParser
	 %w(api_comment api_controller ap_docs).each do |entity|
    require_relative "api_yard_parser/#{entity}"
  end

  def force_no_docs_production
  	true || @production
  end
end
