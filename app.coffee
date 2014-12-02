config = require "./config"



config.resolve (setup, minecraft, minecraftJarUrl, serverDir) ->


  setup (error) ->

    if not error
      minecraft.initServer (error, exit) ->
        console.log error
    else
      console.log error


  # console.log __dirname, serverDir


