# Angular-html2js

Angular-html2js is based off the [karma-ng-html2js-preprocessor](www.google.com) project
that many Angular folks use. It makes your templates available through the asset-pipeline
while still acting like Karam's ng-html2js, so it should feel familiar to those already
using ng-html2js and should be less confusing for those following instructions in online
tutorials.

Look in the usage section below for examples.

## Installation

Add this line to your application's Gemfile:

    gem 'angular-html2js'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install angular-html2js

## Usage

There are two ways that the Karma test runner (through karma-ng-html2js-preprocessor) enables
you to use templates in a test.

1. You configure a default module to attach all templates to and load that module. Say you configured
it to use the module name 'myTemplateModule':

    ```javascript
    beforeEach(module('myTemplateModule'))
    ```

2. Or you let it make each template in a new module, named after the name of the file.

    ```javascript
    beforeEach(module('/your/template/file.html'))
    ```


The gem supports an additional method. You can use the sprockets built in directives to actually inline
the template for you.

```javascript
//= require myTemplate.html

angular.module('myApp').directive('myDirective', function($injectable){
  { restrict: 'A'
    templateUrl: 'myTemplate.html'
    // Etc...
  }}
});
```

This is awesome for two reasons:

1. You don't have to have a `beforeEach(module('your/template.html'))` anymore
2. This will work in production. Now your directive file will already have it's template when
the file is initially loaded!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
