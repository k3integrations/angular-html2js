# Angular-html2js

Angular-html2js is based off the [karma-ng-html2js-preprocessor](https://github.com/karma-runner/karma-ng-html2js-preprocessor) project
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

This gem adds support for AngularJS templates. Those familiar with the Karma
test runner will be able to use the familiar `beforeEach(module('myTemplateModule'))`
or `beforeEach(module('/your/template/file'))`. Additionally, you can now leverage
sprockets to help you. Since Sprockets is the one doing the work, you can also
use this outside of the test environment.

### Using Sprocket directives with templates included in global module (Recommended)

1.  Configure a top level shared module

    ```ruby
    # In Rails
    MyApp::Application.configure do
      config.angular_html2js.module_name = 'MyApp'
    end

    # or Any
    Angular::Html2js.configure do |config|
      config.angular_html2js.module_name = 'MyApp'
    end
    ```
2.  Now just require the template above the code needing it (perhaps a directive)

    ```javascript
    //= require my_template

    angular.module('myApp').directive('myDirective', function($injectable){
      { restrict: 'A'
        templateUrl: 'myTemplate'
        // Etc...
      }}
    });
    ```

### Using Sprocket directives with auto-generated modules (No configuration needed)

    ```javascript
    //= require my_template

    angular.module('myApp', ['/full/path/to/myTemplate.html']).directive('myDirective', function($injectable){
      { restrict: 'A'
        templateUrl: '/full/path/to/myTemplate'
        // Etc...
      }}
    });
    ```

### Using Sprocket directives with custom secondary module

1.  Configure a top level shared module

    ```ruby
    # In Rails
    MyApp::Application.configure do
    config.angular_html2js.module_name = 'MyTemplates'
    end
    ```

2.  Depend on that module

    ```javascript
    //= require my_template

    angular.module('myApp', ['MyTemplates']).directive('myDirective', function($injectable){
      { restrict: 'A'
        templateUrl: '/full/path/to/myTemplate'
        // Etc...
      }}
    });
    ```

### Using Sprocket directives with custom secondary module

1.  Configure a top level shared module and custom cache id

    ```ruby
    # In Rails
    MyApp::Application.configure do
      config.angular_html2js.module_name = 'MyTemplates'

      # `file` is the full file path
      # `scope` is the Sprockets scope. This has handy things like scope.logical_path
      #
      config.angular_html2js.cache_id {|file_path, scope|
        "myTemplates-#{scope.logical_path}"
      }
    end
    ```

2.  Depend on that module
    ```javascript
    //= require my_template

    angular.module('myApp', ['MyTemplates']).directive('myDirective', function($injectable){
      { restrict: 'A'
        templateUrl: 'myTemplates-templates/myTpl'
        // Etc...
      }}
    });
    ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
