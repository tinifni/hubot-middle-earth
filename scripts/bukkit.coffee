# Description:
#   Return a random image from bukk.it
#
# Dependencies:
#   htmlparser 1.7.6
#   soupselect 0.2.0
#
# Configuration:
#
# Commands:
#   hubot bukkit me - returns a random image from http://bukk.it
#
# Notes:
#
# Author:
#   Adam Anderson (scudco)
#   Taken from https://github.com/sauliusg/hubot/blob/master/scripts/bukkit.coffee

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->
  robot.respond /(bukkit)( me)?$/i, (msg) ->
    msg.http("http://bukk.it")
      .get() (err, res, body) ->
        handler = new HtmlParser.DefaultHandler()
        parser  = new HtmlParser.Parser handler

        parser.parseComplete body

        results = ("http://bukk.it/#{link.attribs.href}" for link in Select handler.dom, "td a")
        msg.send msg.random results
