module ApiParser

  class ApiControllers
    attr_accessor :name, :routes

    def initialize(name)
      @name = name
      @routes = []
    end

    def add_route(route)
      @routes += [route]
    end
  end
end