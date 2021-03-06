# this is your php on node

Port your PHP code to Coffee-Script

## Status

v0.3.14 stable and in use by [Exspresso] (https://github.com/darkoverlordofdata/exspresso)

## Installation

```bash
$ npm install not-php
```

You also need to have php installed. Php2coffee is written in php to leverage the Zend lexer.

## Quick Start

  This will create the output file 'CodeIgniter.php.coffee'

```bash
$ php2coffee CodeIgniter.php
```


## Next Steps

  Use the not-php module as a drop in replacement for many php api functions.


```CoffeeScript
class Driver

  eval "#{$name} = #{$body}" for $name, $body of require('not-php')

  ...
  someMethod: ->

    y = md5('bruce')

```




  Tweak the resulting code. You will have to update arguments for node style async calls,
  where appropriate, so this:

```CoffeeScript
  $profile = @where('forgotten_password_code', $code).users().row()# pass the code to profile
```

  Becomes this:

```CoffeeScript
  @where('forgotten_password_code', $code).users ($err, $users) =>

    if $err then return $next $err
    $profile = $users.row()# pass the code to profile
```


## Known Issues
### preg_match

  Node does not fully support arguments by reference.


  Example:

```CoffeeScript
  if preg_match($pattern, $subject, $matches) ...
```

  Use this pattern:

```CoffeeScript
  if ($matches = preg_match($pattern, $subject))
```

### arrays

  Some nested literal object constructs are mis-tranlsated, and will need to be manually corrected.


  Example:

```CoffeeScript
  @data['identity'] = 'name':'identity',
    'id':'identity',
    'type':'text',
    'value':@form_validation.set_value('identity',
  )
```

  Correction:

```CoffeeScript
  @data['identity'] =
    'name':'identity',
    'id':'identity',
    'type':'text',
    'value':@form_validation.set_value('identity')
```

### .eco templates

  Eco syntax require a this (@) operator for helpers and variables


  Example:

```eco
  <td><%- anchor("auth/edit_user/" + $user.id, 'Edit') %></td>
```

  Correction:

```eco
  <td><%- @anchor("auth/edit_user/" + @user.id, 'Edit') %></td>
```

  Note that the open coffee tag defaults to <%-, which matches the php default behaviour.
  Change to <%= as appropriate to escape output.

## To Do

  * Complete the test suite
  * Complete Eco templates - address the this (@) operator issue.
    * prepend all external variables
    * prepend all external functions not in the compatability layer.

## Options

```bash
Usage: php2coffee [OPTIONS] PATH [DESTINATION]

-h, --help          display this help
-j, --javascript    compiles resulting .coffee file
-m, --markup        compiles into .eco markup template
-r, --recursive     recurse source path
-t, --trace         trace output
-T, --tabs          use tab character in output (default is spaces)
-d, --dump          dump of tokens
```

## License

(The MIT License)

Copyright (c) 2012 Bruce Davidson &lt;darkoverlordofdata@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
