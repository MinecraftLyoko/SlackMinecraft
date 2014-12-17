_ = require 'underscore'

module.exports = (minecraft) ->
  obj = {}


  obj.sendCommand = (command, params, callback) ->
    return callback "Minecraft not running" if not minecraft.started
    # return callback "Params must be an array of at " if not params.length
    joinedParams = ""
    joinedParams = params.join " " if params
    combined = "#{command} #{joinedParams}\n"
    console.log "Running command: #{combined}"
    minecraft.process.stdin.write combined, "UTF8", callback
  
  
  obj.achievement = (giveTake, statName, player, callback) ->
    giveTake = giveTake.toLowerCase()
    return callback "Error: invalid param – giveTake" if giveTake isnt "give" and giveTake isnt "take"
    return callback "Error: invalid param – statName" if not statName
    return callback "Error: invalid param – player" if not player

    args = []
    args.push giveTake
    args.push statName
    args.push player

    obj.sendCommand "achievement", args, callback
     
  obj.ban = (playerOrIp, reason, callback) ->
    return callback "Error: all params required" if not player and not reason

    args = [player, reason]
    obj.sendCommand "ban-ip", args, callback

  obj.banlist = (callback) ->
    obj.sendCommand "banlist", args, callback

  obj.blockdata = (coords, datatag, callback) ->
    return callback "Error: coords not valid" if not coords
    return callback "Error: invalid datatag" if not datatag

    obj.sendCommand "blockdata", [coords.x, coords.y coords.z, datatag], callback

  obj.clear = (player, item, data, maxCount, datatag, callback) ->
    return callback "Error: Must specify player" if not player
    args = [player]
    args.push item if item
    args.push data if data
    args.push maxCount if maxCount
    args.push datatag if datatag

    obj.sendCommand "clear", args, callback

  obj.list = (callback) ->
    return if not callback
    obj.sendCommand "list", [], callback


  obj.stop = (callback) ->
    console.log "Shutting down server"
    obj.sendCommand "stop", [], callback


  obj.tellraw = (player, jsonMessage, callback) ->
    return callback "Error: missing params" if not player or not jsonMessage
    args = []
    args.push player
    args.push JSON.stringify jsonMessage

    obj.sendCommand "tellraw", args, callback


  obj
