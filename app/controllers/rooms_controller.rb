class RoomsController < ApplicationController
	before_action :set_room, only: [ :reveal, :show, :estimate, :reset_room, :enter_room ]

	def new
		room = Room.new(team_name: params[:team_name])
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
		@user_session_id = session[:session_id]
		@participant = @room.participants.where(user_session_id: @user_session_id).first
		add_participant_card(@participant) if params[:commit] == "Enter Room"
		return redirect_to create_participant_path(room_identifier: @room.unique_identifier) if @participant.nil?
	end

	def create_participant
		user_session_id = session[:session_id]
		@room_identifier = params[:room_identifier]
	end

	def estimate
    session_id = session[:session_id]

    participant = @room.participants.where(user_session_id: session_id).first
		participant.update(estimate: params[:value], can_estimate: false)

		ActionCable.server.broadcast('room_channel', { participant: participant, origin: 'update_estimate' })
  end

	def reset_room
		@room.update(is_hidden: true)
		@room.participants.update_all(estimate: nil, can_estimate: true)

		ActionCable.server.broadcast('room_channel', { origin: 'reset_room', participants_uuids: @room.participants.pluck(:uuid) })
	end

	def reveal
		@room.update(is_hidden: false)

		ActionCable.server.broadcast('room_channel', { participants: @room.participants, origin: 'reveal' })
	end

	def enter_room
		if @room.present?
			redirect_to create_participant_path(room_identifier: @room.unique_identifier)
		else
			redirect_to root_path
		end
	end

	private

	def set_room
		@room = Room.where(unique_identifier: params[:room_identifier]).first
	end

	def add_participant_card(participant)
		ActionCable.server.broadcast('room_channel', { participant: participant, origin: 'add_participant_card' })
	end
end