#global configuration settings
window.TOTAL_PROP_DELAY = 10
window.RTT = window.TOTAL_PROP_DELAY*2
window.TOTAL_SLOTS = 20
#end settings



Receiver = require("models/Receiver")
Sender = require("models/Sender")
Data = require("models/Data")
Network = require("models/Network")


module.exports = App =
  init: ->
    @receiver = new Receiver 2
    @sender = new Sender 2
    @network = new Network @sender, @receiver
    @entities=[]
    @entities.push @receiver
    @entities.push @sender
    #@entities.push @network
    #@createCanvas()
    @runLoop()
  

   runLoop: ->
    setInterval =>
      @network.run()
      #@clearCanvas()
      #console.log @context
      #@entities.forEach (e) => e.draw @context
    ,300


   createCanvas: ->
     @canvas = document.getElementById 'canvas'
     @context = @canvas.getContext '2d'
     @canvas.width = 500
     @canvas.height = 500
     

   clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

