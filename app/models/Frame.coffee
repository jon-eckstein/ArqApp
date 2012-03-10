
class Frame
  constructor : (@seqNum) ->
    @stepNumber=ko.observable(1)
    @xPosition=ko.observable(0)
    @yPosition=ko.observable(0)
  
  incrementStep : () ->

  isEndOfLife : () ->


module.exports = Frame
