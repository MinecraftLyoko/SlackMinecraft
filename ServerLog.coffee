
module.exports = ->
  class ServerLog

    constructor: (logString) ->
      pattern = /\[+[^\]]+\]+:?/g
      console.log "Original: #{logString}"
      splitter = logString.match pattern

      
      logString = logString.replace splitter[0], ""
      logString = logString.replace splitter[1], ""
      @time = splitter[0]
      @category = splitter[1]
      @message = logString
      console.log "FIX time:#{@time}, category#{@category}, message: #{@message}"


    toString: ->
      "#{@category} #{@message}"