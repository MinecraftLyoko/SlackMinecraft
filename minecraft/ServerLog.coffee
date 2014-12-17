
module.exports = ->
  class ServerLog

    constructor: (logString) ->
      pattern = /\[+[^\]]+\]+:?/g
      splitter = logString.match pattern

      userPattern = /\<.+\>/g
      userSplitter = logString.match userPattern

      splitter = ["",""] if not splitter
      userSplitter = [""] if not userSplitter

      logString = logString.replace splitter[0], ""
      logString = logString.replace splitter[1], ""
      logString = logString.replace userSplitter[0], ""
      
      @time = splitter[0].replace /(\[|\])/g, ""

      if not userSplitter[0]
        @category = splitter[1].replace /(\[|\]|:)/g, "" 
      else 
        @category = "Chat"

      @message = logString
      @user = userSplitter[0].replace /(\<|\>)/g, ""


    toString: ->
      "Server: #{@category} #{@user} #{@message}"