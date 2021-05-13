require_relative 'framework'

APP = App.new do
	get '/' do
		'This is the root'
	end

	get 'user/:username' do
		'This is a user'
	end
end