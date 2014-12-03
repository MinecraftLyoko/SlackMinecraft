request = require "request"
child = require "child_process"

module.exports = (rootDir, serverDir, minecraftVer, slack) ->
  obj = {
    process: null
    started: false
  }
  obj.initServer = (errorCallback) ->
    cd serverDir
    console.log "Starting Minecraft Server version #{minecraftVer}"
    obj.process = child.spawn "java", ["-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.jar", "nogui"], {cwd: serverDir, stdio: "pipe"}
    obj.started = true
    

    obj.process.stdio[1].on "data", (response) ->
      # response = response.split("/INFO]: ")[1]
      console.log response.toString()
      options = 
        url: slack.serverAdminUrl
        method: "POST"
        json: true
        headers: 
          "Content-Type": "application/json"
        body: 
          text: response

      # request options, (error, response, body) ->
      #   console.log error, body if error
  obj
  # {
  #   initServer
  #   process
  # }