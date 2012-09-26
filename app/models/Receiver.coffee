NetworkNode = require("models/NetworkNode")
Ack = require("models/Ack")

class Receiver extends NetworkNode
  constructor: (@windowSize) ->
    super(@windowSize)
    @largestAccept=1
    @largestReceived=0
    #console.log "receiver created with window size #{@windowSize}"
  
  send : (frame) ->
    ack = new Ack frame.seqNum
    #console.log "ack sent for seqNum: " + ack.seqNum
    @lastAckSent = ack.seqNum
    ack
  
  receive : (frame) ->
    #console.log "frame received with seqNum #{frame.seqNum}"
    if(frame.seqNum <= @largestAccept)
      @largestReceived = frame.seqNum if frame.seqNum > @largestReceived
      @largestAccept = @largestReceived + @windowSize
    #console.log "last seqNum received " + frame.seqNum
      ack = @send(frame)
      return ack
    else return null
  
    
      
module.exports = Receiver
