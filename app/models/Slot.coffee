
class Slot
  constructor : (@num) ->
    @isSent=false
    @isAckReceived=false
    @isInWindow=false
    @timeLive=3 #todo: figure out why seeding this to 3 is necessary. For some reason the count between stepNumber and timeLive is off even though i'm incrementing at the same rate.
  
module.exports = Slot
