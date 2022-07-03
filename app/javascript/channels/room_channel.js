import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
  },

  disconnected(data) {
  },

  unsubscribe(data){
  },

  received(data) {
    console.log(data)
    function updateParticipants(participants_uuids) {
      $('#cards-container .estimate-card').filter(function(i, obj) {
        return !participants_uuids.includes(obj.id)
      }).parent('div').remove()
    }

    if (data.origin == 'add_participant_card') {
      let participant = data.participant
      $('#cards-container').append($('<div>', { class: 'me-5 display-center flex-column custom-color-title' }).text(participant.name).append($('<div>', { class: 'estimate-card display-center fs-4', id: participant.uuid }).text('?') ))
    } 
    if (data.origin == 'update_estimate') {
      let participant = data.participant
      $('#' + participant.uuid).addClass('card-voted')
      $('#estimate-buttons-' + participant.uuid + ' form button').prop('disabled', true)
    }
    if (data.origin == 'reset_room') {
      updateParticipants(data.participants_uuids)
      $('#forms-container div form button').removeAttr('disabled')      
      $('#cards-container div div').text('?').removeClass('card-voted')
    }
    if (data.origin == 'reveal') {
      data.participants.map(function(p) {
        $('#' + p.uuid).addClass('card-voted').text(p.estimate)
      })
    }
  }
});
