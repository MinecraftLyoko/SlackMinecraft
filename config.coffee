{container} = require "dependable"
shell = require "shelljs/global"
shell.silent = true

_ = require "underscore"

rootDir = pwd()
minecraftVer = "1.8.8"

deps = new container()
deps.register "rootDir", rootDir
deps.register "serverDir", "#{rootDir}/server"
deps.register "minecraftVer", minecraftVer
deps.register "minecraftJarUrl", "https://s3.amazonaws.com/Minecraft.Download/versions/#{minecraftVer}/minecraft_server.#{minecraftVer}.jar"

deps.register "slack", require './slackConfig'

deps.register "PORT", 25566

deps.load "#{__dirname}/minecraft"


module.exports = deps
