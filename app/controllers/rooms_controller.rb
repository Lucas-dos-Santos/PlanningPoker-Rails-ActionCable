class RoomsController < ApplicationController
	def new
		byebug
		user_session_id = session[:session_id]
		room = Room.new
		room.save


	end
end