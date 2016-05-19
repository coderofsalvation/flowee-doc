request      = require './util/requester.coffee'
t            = require './util/tester.coffee'
  
flowee   = require 'flowee'
flowee.verbosity = 2
require('./../index.coffee')(flowee)
model    = require('flowee/test/model.coffee')

t.test 'starting server', (next) ->

  app = flowee.init {model: model, store:true }

  flowee.start (server) ->
    port = process.env.PORT || 1337
    console.log "starting flowee at port %s",port
    server.listen port
    next()

t.test 'testing html output', (next) ->
  request 'GET', "/doc/", false, (result) ->
    for str in ["Api docs"]
      t.error "string '"+str+"' not found :/" if not result.match( new RegExp(str,"g") )
    next()

t.test 'testing markdown output', (next) ->
  request 'GET', "/doc/md", false, (result) ->
    for str in ["API endpoints","foo"]
      t.error "string '"+str+"' not found :/" if not result.match( new RegExp(str,"g") )
    next()

t.done()

t.run()
