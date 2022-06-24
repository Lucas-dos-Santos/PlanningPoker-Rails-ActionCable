class RoomsController < ApplicationController
	def new
		room = Room.new
		room.save
		join_room(room.unique_identifier, params[:name])
	end

	def join_room(unique_identifier, participant_name)
		session_id = session[:session_id]
		room = Room.where(unique_identifier: unique_identifier).first
		room.participants.new(user_session_id: session_id, name: participant_name)
		room.save

		redirect_to room_show_path(room_identifier: unique_identifier) 
	end

	def card_render(participant)
		render(partial: 'participants/participant', locals: { participant: participant })
	end

	def show
		if params[:name]
			join_room(params[:room_identifier], params[:name])
		end
		user_session_id = session[:session_id]
		@room = Room.where(unique_identifier: params[:room_identifier]).first
		@participant = @room.participants.where(user_session_id: user_session_id).first
		add_participant_card(@participant) if params[:commit] == "Enter Room"
		return redirect_to create_participant_path(room_identifier: @room.unique_identifier) if @participant.nil?
	end

	def create_participant
		user_session_id = session[:session_id]
		@room_identifier = params[:room_identifier]
	end

	def estimate
    session_id = session[:session_id]

    room = Room.where(unique_identifier: params[:room_identifier]).first

    participant = room.participants.where(user_session_id: session_id).first
		participant.update(estimate: params[:value], can_estimate: false)

		ActionCable.server.broadcast('room_channel', { participant: participant, origin: 'update_estimate' })
  end

	def reset_room
		room = Room.where(unique_identifier: params[:room_identifier]).first
		room.participants.update_all(estimate: nil, can_estimate: true)

		ActionCable.server.broadcast('room_channel', { origin: 'reset_room' })
	end

	def reveal
		
	end

	private

	def add_participant_card(participant)
		ActionCable.server.broadcast('room_channel', { participant: participant, origin: 'add_participant_card' })
	end
end