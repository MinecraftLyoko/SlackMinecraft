request = require "request"
child = require "child_process"

module.exports = (rootDir, serverDir, minecraftVer, slack, ServerLog) ->
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
      log = new ServerLog(response.toString())
      

      options = 
        url: slack.serverAdminUrl
        method: "POST"
        json: true
        headers: 
          "Content-Type": "application/json"
        body: 
          text: log.toString()

      request options, (error, response, body) ->
        console.log error, body if error
  obj
