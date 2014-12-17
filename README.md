# SlackMinecraft

## A NodeJS wrapper for a Minecraft server with support for chat in Slack


- http://www.minecraft.net
- http://www.nodejs.org
- http://www.slack.com

This is a wrapper for minecraft.  I intend to make this like [bukkit](http://www.bukkit.org) in that plugins as node modules will be able to be installed.  This is just the default settings.  

#### Installation

To install clone this repo and run
```shell
npm install
```
to install all dependencies.

To start server run
```shell
coffee app.coffee
```

If you don't have coffee installed you can install it like this
```shell
npm install -g coffee-script
```

#### Configuration

This should download the minecraft_server.jar on first run but make sure you have java installed before you run it.  After that you should configure the slackConfig.coffee file in the root of the directory so that it has the URLs that tie to your Slack integrations.

The config.coffee file has the default port for the minecraft server (25565) and the web server (25566).  

If you have any suggestions or ideas go ahead and fork and make a pull request.  I'll be putting in my own changes too.  