class AngularModule
  constructor: (@name, @deps) ->
    templates = @templates = {}

  run: (injectable) ->
    if injectable instanceof Array
      [injected..., block] = injectable
    else
      block = injectable
    block
      put: (id, content) =>
        @templates[id] = content

# Evaluates generated js code fot the template cache
# processedContent - The String to be evaluated
# Returns an object with the following fields
#   moduleName - generated module name `angular.module('myApp')...`
#   templateId - generated template id `$templateCache.put('id', ...)`
#   templateContent - template content `$templateCache.put(..., <div>cache me!</div>')`
@evaluateTemplate = (processedContent) ->
  modules = {}

  angular =
    module: (name, deps) ->
      if deps? then return modules[name] = new AngularModule name, deps
      if modules[name] then return modules[name]
      throw new Error "Module #{name} does not exists!"

  eval processedContent

  modules
