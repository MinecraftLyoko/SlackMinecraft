config = require "./config"
express = require "express"
app = express()
stdin = process.openStdin()


config.resolve (setup, minecraft, Command, minecraftJarUrl, serverDir, PORT) ->


  app.get "/test", (req, res, next) ->
    Command.achievement "give", "*", "SerenadeX", ->
      res.sendStatus 200

  app.get "/stopServer", (req, res, next) ->
    Command.stop ->
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
        stdin.on 'data', (response) ->
          response = response.toString()  
          if response is "stop\n"
            Command.stop ->
              process.exit 0
      else
        console.log "error", error

  startme()


