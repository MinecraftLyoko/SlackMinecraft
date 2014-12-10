
module.exports = ->
  class ServerLog

    constructor: (logString) ->
      pattern = /\[+[^\]]+\]+:?/g
      splitter = logString.match pattern

      
      logString = logString.replace splitter[0], ""
      logString = logString.replace splitter[1], ""
      @time = splitter[0]
      @category = splitter[1]
      @message = logString


    toString: ->
      "#{@category} #{@message}"