class App
	def initialize(&block)
		@routes = RouteTable.new(block)
	end

	def call(env)
		request = Rack::Request.new(env)
		@routes.each do |route|
			content = route.match(request)
			return [200, {'Content-Type' => 'text/plain'}, [content.to_s]] if content				
		end
		return [404, {}, ["Page not found"]]
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

		def each(&block)
			@routes.each(&block)
		end
	end

	class Route < Struct.new(:route_spec, :block)
		def match(request)
			path_components = request.path.split('/')
			spec_components = route_spec.split('/')

			params = {}

			# Only proceed if req & spec have same number of parts
			return nil unless path_components.length == spec_components.length

			path_components.zip(spec_components).each do |path_comp, spec_comp|
				# Looks like ruby doesn't need any var keywords
				is_var = spec_comp.start_with?(":")
				if is_var 
					# Get the variable path without the :
					key = spec_comp.sub(/\A:/, '')
					params[key] = path_comp
				else
					# Match will return content unless match fails
					return nil unless path_comp == spec_comp
				end
			end

			p params

			block.call(params)
		end
	end
end