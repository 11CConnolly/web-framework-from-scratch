class App
	def call(env)
		[200, {}, ["Hello world!"]]
	end
end

APP = App.new