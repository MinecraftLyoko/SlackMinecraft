config = require "./config"
express = require "express"
bodyParser = require "body-parser"
app = express()
stdin = process.openStdin()


config.resolve (setup, minecraft, Command, minecraftJarUrl, serverDir, PORT, slack) ->

  app.use bodyParser()

  app.get "/test", (req, res, next) ->
    Command.achievement "give", "*", "SerenadeX", ->
      res.sendStatus 200

  app.get "/stopServer", (req, res, next) ->
    Command.stop ->
      res.sendStatus 200

  app.get "/startServer", (req, res, next) ->
    startme()
    res.sendStatus 200
  

  app.post "/inchat", (req, res, next) ->
    return res.sendStatus 200 if req.body.user_name is "slackbot"
    if req.body.token isnt slack.inChatPostToken
      return res.sendStatus 403
    
    Command.tellraw "@a", {text: "<#{req.body.user_name}> #{req.body.text}"}, ->
      res.sendStatus 200

  startme = ->
    setup (error) ->
      if not error
        minecraft.initServer (error, exit) ->
          console.log error
        app.listen PORT, ->
          console.log "listening on #{PORT}"
        stdin.on 'data', (response) ->
          response = response.toString()  
          if response is "stop\n"
            Command.stop ->
              process.exit 0
      else
        console.log "error", error

  startme()


