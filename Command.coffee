_ = require 'underscore'

module.exports = (minecraft) ->
  obj = {}


  obj.sendCommand = (command, params, callback) ->
    return callback "Minecraft not running" if not minecraft.started
    # return callback "Params must be an array of at " if not params.length
    joinedParams = ""
    joinedParams = params.join " " if params
    combined = "#{command} #{joinedParams}\n"
    minecraft.process.stdin.write combined, "UTF8", callback
  
  
  obj
