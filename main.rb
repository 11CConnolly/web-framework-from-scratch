require_relative 'framework'

APP = App.new do
	get '/' do
		[1, 2 ,3]
	end

	get '/:foo' do |params|
		params.fetch('foo')
	end

	get '/user/:username' do |params|
		"This is #{params.fetch('username')}!"
	end
end