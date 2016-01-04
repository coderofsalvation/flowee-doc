jref = require 'json-ref-lite'

module.exports = ( (flowee) ->

  me = @

    
  flowee.use require('ecstatic')({ root: __dirname + '/node_modules/swagger-ui/dist', baseDir: "doc", handleErrors:false })
  flowee.on 'init', (flowee,staticfiles) ->
    flowee.router.get '/doc', (req,res,next) -> 
      res.redirect '/doc/index.html#!/default';
      next()
    
    flowee.router.get '/doc/md', (req,res,next) -> 
      #res.writeHead 200, { 'Content-Type': 'text/plain' }
      model = JSON.parse JSON.stringify flowee.model
      model = jref.resolve model
      result = "## API endpoints\n\n"
      result += "[JSONAPI](http://jsonapi.org/)-compatible endpoints: "+model.info.description+"\n\n"
      result += '* __version__: '+model.info.version+"\n"
      result += '* __contact__: '+model.info.contact.name+"\n"
      result += "* __produces__: "+model.produces.join(", ")+"\n"
      result += "* __consumes__: "+model.consumes.join(", ")+"\n"
      result += "\n"
      for path,methods of model.paths
        for methodname,method of methods
          result += "> [__"+methodname.toUpperCase()+" #{path}__](#user-content-"+methodname+path+")\n\n"
      for path,methods of model.paths
        for methodname,method of methods
          result += "### <a name=\""+methodname+path+"\"/> __"+methodname.toUpperCase()+" #{path}__\n\n"
          result += method.description+"\n\n"
          result += "* public: "+ ( if method.public? and method.public then "yes" else "no" )+"\n"
          result += "* produces: #{method.produces[0]} \n"
          schema = JSON.stringify( method.responses[200].schema,null,2 ).split("\n").map (o) -> "    "+o
          result += "\nschema:\n\n" + schema.join "\n"
          result += "\n\n"
      res.end( result )
      next()

  me

).bind({})
