var jref;

jref = require('json-ref-lite');

module.exports = (function(flowee) {
  var me;
  me = this;
  flowee.use(require('ecstatic')({
    root: __dirname + '/../node_modules/swagger-ui/dist',
    baseDir: "doc",
    handleErrors: false
  }));
  flowee.on('init', function(flowee, staticfiles) {
    flowee.router.get('/doc', function(req, res, next) {
      res.redirect('/doc/index.html#!/default');
      return next();
    });
    return flowee.router.get('/doc/md', function(req, res, next) {
      var method, methodname, methods, model, path, ref, ref1, result, schema;
      model = JSON.parse(JSON.stringify(flowee.model));
      model = jref.resolve(model);
      result = "## API endpoints\n\n";
      result += "[JSONAPI](http://jsonapi.org/)-compatible endpoints: " + model.info.description + "\n\n";
      result += '* __version__: ' + model.info.version + "\n";
      result += '* __contact__: ' + model.info.contact.name + "\n";
      result += "* __produces__: " + model.produces.join(", ") + "\n";
      result += "* __consumes__: " + model.consumes.join(", ") + "\n";
      result += "\n";
      ref = model.paths;
      for (path in ref) {
        methods = ref[path];
        for (methodname in methods) {
          method = methods[methodname];
          result += "> [__" + methodname.toUpperCase() + (" " + path + "__](#user-content-") + methodname + path + ")\n\n";
        }
      }
      ref1 = model.paths;
      for (path in ref1) {
        methods = ref1[path];
        for (methodname in methods) {
          method = methods[methodname];
          result += "### <a name=\"" + methodname + path + "\"/> __" + methodname.toUpperCase() + (" " + path + "__\n\n");
          result += method.description + "\n\n";
          result += "* public: " + ((method["public"] != null) && method["public"] ? "yes" : "no") + "\n";
          result += "* produces: " + method.produces[0] + " \n";
          schema = JSON.stringify(method.responses[200].schema, null, 2).split("\n").map(function(o) {
            return "    " + o;
          });
          result += "\nschema:\n\n" + schema.join("\n");
          result += "\n\n";
        }
      }
      res.end(result);
      return next();
    });
  });
  return me;
}).bind({});
