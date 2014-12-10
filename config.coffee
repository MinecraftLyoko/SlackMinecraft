{container} = require "dependable"
shell = require "shelljs/global"
shell.silent = true

_ = require "underscore"

rootDir = pwd()
minecraftVer = "1.8.1"

deps = new container() 
deps.register "rootDir", rootDir
deps.register "serverDir", "#{rootDir}/server"
deps.register "minecraftVer", minecraftVer
deps.register "minecraftJarUrl", "https://s3.amazonaws.com/Minecraft.Download/versions/#{minecraftVer}/minecraft_server.#{minecraftVer}.jar"

slack = {
  serverAdminUrl: "https://hooks.slack.com/services/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"
}

deps.register "slack", slack

deps.register "PORT", 25566
deps.register "ServerLog", require "./ServerLog"
deps.register "setup", require "./setup"  
deps.register "minecraft", require "./minecraft"
deps.register "Command", require "./Command"


module.exports = deps