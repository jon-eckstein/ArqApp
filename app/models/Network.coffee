Data = require("models/Data")
Ack = require("models/Ack")
Entity = require("models/Entity")

class Network extends Entity
  constructor : (@sender, @receiver) ->
    @framesInFlight = ko.observableArray()
    @playSpeed = 10
    @isRunning=true
    console.log "Network created."
  
   incrementFrames: () ->
    #console.log @framesInFlight()
    @incrementFrame frame for frame in _.compact(@framesInFlight())
    #@incrementFrame frame for frame in @framesInFlight()
   
   incrementFrame: (currentFrame) ->
    currentFrame.incrementStep()
    if currentFrame.isEndOfLife()
      @removeFrame(currentFrame)
      @receiveFrame(currentFrame) if currentFrame instanceof Data
      @sender.receive(currentFrame) if currentFrame instanceof Ack


   addFrame: (aframe) ->
    @framesInFlight.push(aframe)
    #console.log "frame added."
   
   removeFrame: (rframe) ->
    @framesInFlight.remove rframe
    @framesInFlight.remove undefined
    #@framesInFlight() = _.compact(@framesInFlight())
    #console.log "frame removed."

   sendFrame: () ->
    #frames = @sender.send()
    #console.log "number of frames from sender #{frames.length}"
    #@addFrame newFrame for newFrame in @sender.send()
    newFrame = @sender.send()
    #console.log "frame sent #{newFrame.seqNum}"
    @addFrame newFrame
   
   receiveFrame: (f) ->
    ack = @receiver.receive f
    @addFrame ack

   run: () ->
    if @isRunning
      console.log "Network running with total frames #{@framesInFlight().length}"
      @incrementFrames()
      @sendFrame()
 
  	  	
   killFrame: (frame) ->
   killlRandomFrame: () ->

module.exports = Network
