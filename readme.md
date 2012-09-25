# this is your php on node (not-php)

This is from an experimental project to port CodeIgniter
to coffeescript, running on a node.js server.


## Installation

    $ npm install ./not-php.tar.gz

    $ npm install git://github.com/darkoverlordofdata/not-php.git

## Quick Start

  Port the php code to coffee-script.
  This will create the output file CodeIgniter.php.coffee:

    $ php2coffee CodeIgniter.php

  Tweak the resulting code to declare the appropriate helper functions:

    {define, defined} = require('not-php')

    define 'TRUE', true
    if ! defined('TRUE') then throw 'TRUE not defined'

## Helpers

<table>
    <thead>
        <tr>
            <th>Keywords</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th><code>constant</code></th>
            <td>Return the value of the constant indicated by name.</td>
        </tr>
        <tr>
            <th><code>define</code></th>
            <td>Defines a named constant at runtime.</td>
        </tr>
        <tr>
            <th><code>defined</code></th>
            <td>Checks whether the given constant exists and is defined.</td>
        </tr>
        <tr>
            <th><code>file_exists</code></th>
            <td>Checks whether a file or directory exists.  </td>
        </tr>
        <tr>
            <th><code>is_dir</code></th>
            <td>Tells whether the given filename is a directory. </td>
        </tr>
        <tr>
            <th><code>realpath</code></th>
            <td>Return the canonicalized absolute pathname.  </td>
        </tr>
    </tbody>
</table>


## Options

    Usage: php2coffee [OPTIONS] PATH [DESTINATION]

    -c, --config        config files (declares module globals)
    -h, --help          display this help
    -j. --javascript    compiles resulting .coffee file
    -r, --recursive     recurse source path
    -t, --trace         trace output








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
