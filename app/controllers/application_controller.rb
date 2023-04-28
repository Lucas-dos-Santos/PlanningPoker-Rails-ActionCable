class ApplicationController < ActionController::Base
  before_action :set_user

  def set_user
    participant = Participant.last
    @current_user = participant.empty? ? nil : participant
  end
end
