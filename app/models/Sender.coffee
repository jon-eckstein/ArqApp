NetworkNode = require("models/NetworkNode")
Data = require("models/Data")
Ack = require("models/Ack")
Slot = require("models/Slot")

class Sender extends NetworkNode
  constructor:  (@windowSize) ->
    super(@windowSize)
    @lastAckReceived=0
    @lastFrameSent=0
    @seqNum=1

  send : () ->
    #perform slot management
    #foreach slot in the window increment the timer
    for slot in @frameSlots when slot.num <= @lastFrameSent and slot.num > @lastAckReceived and slot.isSent
       slot.timeLive++
       if(slot.timeLive >= window.RTT+5)
           console.log "slot num:#{slot.num}, liveTime:#{slot.timeLive}"
           slot = new Slot @seqNum
           @lastFrameSent = @lastAckReceived
	   #return new Data @seqNum++

    #send one frame at time for each network iteration...    
    if((@lastFrameSent - @lastAckReceived) <= @windowSize-1)
      frame = new Data @seqNum++ #@seqNum++ % (@windowSize*2)
      @lastFrameSent = frame.seqNum
      @frameSlots[frame.seqNum].isSent = true
      return frame
  
  receive : (ackFrame) ->
    if ackFrame instanceof Ack
      @lastAckReceived = ackFrame.seqNum
      #console.log "Ack received with seqNum: #{ackFrame.seqNum}"
    else
      console.error "Data received on Sender something very wrong happened."
  
module.exports = Sender
