import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('conectado')
  },

  disconnected(data) {
    console.log('desconectado')
    console.log(data)
  },

  unsubscribe(data){
    console.log('unsubscribe')
  },

  received(data) {
    console.log(data)
    function updateParticipants(participants_uuids) {
      console.log('to aKI')
      $('#cards-container .estimate-card').filter(function(i, obj) {
        return !participants_uuids.includes(obj.id)
      }).parent('div').remove()
    }

    if (data.origin == 'add_participant_card') {
      let participant = data.participant
      $('#cards-container').append($('<div>', { class: 'me-5' }).text(participant.name).append($('<div>', { class: 'estimate-card', id: participant.uuid }).text('?') ))
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
