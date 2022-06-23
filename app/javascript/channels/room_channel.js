import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    if (data.origin == 'add_participant_card') {
      let participant = data.participant
      $('#cards-container').append($('<div>', { class: 'me-5' }).text(participant.name).append($('<div>', { class: 'estimate-card', id: 'participant_' + participant.id }).text('?') ))
    } 
    if (data.origin == 'update_estimate') {
      let participant = data.participant
      $('#estimate-buttons-' + participant.id + ' form input').prop('disabled', true)
      $('#participant_' + participant.id).text(participant.estimate)
    }
  }
});
