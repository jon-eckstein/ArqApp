Slot = require("models/Slot")

class NetworkNode
  constructor: (@windowSize) ->
    @frameSize=0
    @seqNum=0
    @frameBuffer = []
    @frameCount=0
    @lastFrameReceived=0
    @frameSlots = []
    @frameSlots.push new Slot num for num in [1..window.TOTAL_SLOTS]
    console.log "Network node created."
  
  draw: (@context) ->
    for num in [0..10]
      @context.fillStyle = 'rgba(0,0,0,.8)'
      #@context.strokeRect (num*40),0,10,10
    
    #@context.fillStyle = 'rgba(0,0,0,.8)'
    #@context.fillRect 10,10,10,10
    #@context.lineWidth = 30
    #@context.fillStyle = "black"
    #@context.fillRect(0,0,100,100)
    #@context.strokeStyle = "red"
    #@context.strokeRect(0,0,100,100)


module.exports = NetworkNode
