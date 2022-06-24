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
      $('#participant_' + participant.id).addClass('card-voted')
      $('#estimate-buttons-' + participant.id + ' form button').prop('disabled', true)
    }
    if (data.origin == 'reset_room') {
      $('#forms-container div form button').removeAttr('disabled')      
      $('#cards-container div div').text('?').removeClass('card-voted')
    }
    if (data.origin == 'reveal') {
      data.participants.map(function(p) {
        console.log(p)
        $('#participant_' + p.id).addClass('card-voted').text(p.estimate)
      })
    }
  }
});
