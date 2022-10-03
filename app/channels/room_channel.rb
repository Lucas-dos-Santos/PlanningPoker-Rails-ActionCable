class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room:#{current_participant.room_id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
