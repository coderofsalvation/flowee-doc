fetch        = require 'node-fetch'

module.exports = (method,resource,data,cb) ->
  console.log method+" "+resource+" "+JSON.stringify( data,null,2 ) if process.env.DEBUG
  options = 
    method: method 
  options.body = JSON.stringify data if data
  fetch 'http://localhost:1337'+resource, options
  .then (res,err) -> 
    res.text().then cb
