Frame = require("models/Frame")

class Data extends Frame
  constructor: (@seqNum) ->
    super(@seqNum)
    
  incrementStep: () ->
    oldVal = @stepNumber()
    @stepNumber(oldVal + 1)

  isEndOfLife : () ->
     @stepNumber() == window.TOTAL_PROP_DELAY

module.exports = Data
