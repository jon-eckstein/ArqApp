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

  getFirstTimeout : () ->
    timeoutNum = 0
     
    for f in @frameBuffer
       console.log f.stepNumber()

    ###
    for slt in @frameSlots when slt.num <= @lastFrameSent and slt.num > @lastAckReceived and slt.isSent
       slt.timeLive++
       if(slt.timeLive >= window.RTT+5)
         timeoutNum = slt.num
         break
         #console.log "slot num:#{slt.num}, liveTime:#{slt.timeLive}"
         #slt = new Slot @seqNum
         #@lastFrameSent = @lastAckReceived
	 #return new Data @seqNum++
    console.log timeoutNum
    if timeoutNum != 0
       @frameSlots[timeoutNum] = new Slot timeoutNum
       @lastFrameSent = timeoutNum-1
       @lastAckReceived = timeoutNum-@windowSize
       @seqNum = timeoutNum
     ###

  send : () ->
    #perform slot management
    #foreach slot in the window increment the timer       
    #send one frame at time for each network iteration...    
    
    @getFirstTimeout()

    if((@lastFrameSent - @lastAckReceived) <= @windowSize-1)
      frame = new Data @seqNum++ #@seqNum++ % (@windowSize*2)
      @lastFrameSent = frame.seqNum
      @frameSlots[frame.seqNum].isSent = true
      @frameBuffer.push frame
      #console.log "got here lfs:#{@lastFrameSent}, lar:#{@lastAckReceived}"
      return frame
  
  receive : (ackFrame) ->
    if ackFrame instanceof Ack
      popFrame = @frameBuffer.shift()
      console.log "pop #{popFrame.seqNum}, ack #{ackFrame.seqNum}"
      if popFrame.seqNum == ackFrame.seqNum
      	 @lastAckReceived = ackFrame.seqNum
      #console.log "Ack received with seqNum: #{ackFrame.seqNum}"

    if ackFrame instanceof Data
      console.error "Data received on Sender something very wrong happened."
  
   

module.exports = Sender
