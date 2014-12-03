config = require "./config"
express = require "express"
app = express()


config.resolve (setup, minecraft, Command, minecraftJarUrl, serverDir, PORT) ->


  app.get "/test", (req, res, next) ->
    Command.sendCommand "tellraw", ["@a", "{'text':'hello again'}"], ->
      res.sendStatus 200

  app.get "/stopServer", (req, res, next) ->
    Command.sendCommand "stop", [], ->
      res.sendStatus 200

  app.get "/startServer", (req, res, next) ->
    startme()
    res.sendStatus 200
  


  startme = ->
    setup (error) ->
      if not error
        minecraft.initServer (error, exit) ->
          console.log error
        app.listen PORT, ->
          console.log "listening on #{PORT}"
      else
        console.log "error", error

  startme()


