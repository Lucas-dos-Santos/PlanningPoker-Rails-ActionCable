module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_participant
    def connect
      self.current_participant = find_participant
    end

    def find_participant
      participant = Participant.where(user_session_id:  @request.session[:session_id]).first
      participant || reject_unauthorized_connection
    end

    def disconnect
      user_session_id = @request.session[:session_id]
      Participant.find_by(user_session_id: user_session_id)&.destroy
    end
  end
end
