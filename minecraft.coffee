request = require "request"

module.exports = (rootDir, serverDir, minecraftVer, slack) ->

  initServer = (errorCallback) ->
    cd serverDir
    console.log "Starting Minecraft Server version #{minecraftVer}"
    process = exec "java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui", {async: true, silent: true}
    process.stdout.on "data", (response) ->
      response = response.split("/INFO]: ")[1]
      options = 
        url: slack.serverAdminUrl
        method: "POST"
        json: true
        headers: 
          "Content-Type": "application/json"
        body: 
          text: response

      request options, (error, response, body) ->
        console.log error, body if error
    
  {
    initServer
  }