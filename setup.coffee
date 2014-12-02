fs = require "fs"
https = require "https"

module.exports = (rootDir, serverDir, minecraftVer, minecraftJarUrl) ->

  downloadFile = (url, callback) ->

    serverFile = "#{serverDir}/minecraft_server.jar"
    files = ls serverFile
    return callback() if files.length
    
    file = fs.createWriteStream serverFile
    console.log "Downloading #{url} ..."
    https.get url, (response) ->

      response.pipe file
      file.on "error", ->
        file.close()
        callback("error happened")
      file.on "finish", ->
        file.close()
        console.log "Download Complete"
        callback()

  writeEULA = (callback) ->
    eula = "#{serverDir}/eula.txt"
    fs.writeFile eula, "eula=true", (error) ->
      callback error

  setupServer = (createDir, callback) ->
    cd rootDir
    
    if createDir
      mkdir serverDir

    cd serverDir
    callback()




  checkJava = (callback) ->
    exec "java -showversion", {silent: true}, (code, output) ->
      callback code isnt 0

  checkMinecraft = (callback) ->
    files = ls rootDir
    # setupServer if _.indexOf files, "server" is -1
  
  (callback) ->
    #checkJava (error) ->
     # return callback "javacheck-error:#{error}" if error
    setupServer true, ->
      downloadFile minecraftJarUrl, (error) ->
        return callback "downloadFile-error: #{error}" if error
        writeEULA (error) ->
          return callback "eulaFile-error: #{error}" if error
          callback()
