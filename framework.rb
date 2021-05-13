class App
	def initialize(&block)
		@routes = RouteTable.new(block)
	end

	def call(env)
		[200, {}, ["Hello world!"]]
	end

	class RouteTable
		def initialize(block)
			@routes = []
			instance_eval(&block)
		end

		def get(route_spec, &block)
			@routes << Route.new(route_spec, block)
			p @routes
		end
	end

	class Route < Struct.new(:route_spec, :block)
	end
end