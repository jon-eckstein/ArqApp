Frame = require("models/Frame")

class Ack extends Frame
  constructor: (@seqNum) ->
    super(@seqNum)
    @stepNumber(window.TOTAL_PROP_DELAY)
 
  incrementStep: () ->
    oldVal = @stepNumber()
    @stepNumber(oldVal - 1)


  isEndOfLife : () ->
     @stepNumber() == 1


module.exports = Ack
