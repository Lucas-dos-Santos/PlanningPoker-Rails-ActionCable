module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      user_session_id = @request.session[:session_id]
      participant = Participant.where(user_session_id: user_session_id).first
      reject_unauthorized_connection if participant.nil?
    end
    
    def disconnect
      user_session_id = @request.session[:session_id]
      Participant.find_by(user_session_id: user_session_id)&.destroy
      session.clear
    end
  end
end
