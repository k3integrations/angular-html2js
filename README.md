# Angular-html2js

Angular-html2js is based off the [karma-ng-html2js-preprocessor](www.google.com) project
that many Angular folks use. It makes your templates available through the asset-pipeline.

This can be particularly useful for including your templates inline with the related
directives or using your templates in tests when using ng-mock. You should be able to use
the ng-mock helpers like `module` just the way you would have with a test runner like Karma.

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

    beforeEach(module('myTemplateModule'))

2. Or you let it make each template in a new module, named after the name of the file.

    beforeEach(module('/your/template/file.html'))

The gem supports and additional method. You can use the sprockets built in directives to actually inline
the template for you.

    //= require myTemplate.html

    angular.module('myApp').directive('myDirective', function($injectable){
      { restrict: 'A'
        templateUrl: 'myTemplate.html'
        // Etc...
      }}
    });

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
