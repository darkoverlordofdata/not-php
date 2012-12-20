# this is your php on node (not-php)

Extracted from my Exspresso project

## Installation

    $ npm install ./not-php.tar.gz

    $ npm install git://github.com/darkoverlordofdata/not-php.git

## Quick Start

  Port the php code to coffee-script. <br />
  This will create the output file CodeIgniter.php.coffee: <br />

    $ php2coffee CodeIgniter.php


## Next Steps

  Tweak the resulting code. Not-php helper functions are declared globaly, <br />
  and so will act as a drop in replacement for many php api functions. You <br />
  will have to update arguments for node style async calls, where appropriate.

so code like this:

    forgotten_password_check : ($code) ->
      $profile = @where('forgotten_password_code', $code).users().row()# pass the code to profile

is changed to:

    @where('forgotten_password_code', $code).users ($err, $users) =>

      if $err then return $next $err
      $profile = $users.row()# pass the code to profile


## Known Issues

  At this point, about 98% of php code is correctly converted. <br />
  But some things must be manually corrected. <br />

  <strong>Node</strong> does not fully support arguments by reference. <br >
  This mainly affects preg_match:

  example:

    if preg_match($pattern, $subject, $matches) ...

  must be changed to

    $matches = preg_match($pattern, $subject)
    if $matches? ...

  <strong>Some</strong> nested literal object constructs are mis-tranlsated, <br />
  and will need to be manually corrected. <br />

  example:

			$this->data['identity'] = array('name' => 'identity',
				'id' => 'identity',
				'type' => 'text',
				'value' => $this->form_validation->set_value('identity'),
			);

  is incorrectly tranlated as

      @data['identity'] = 'name':'identity',
        'id':'identity',
        'type':'text',
        'value':@form_validation.set_value('identity',
      )

  So, you will correct it thusly:

      @data['identity'] =
        'name':'identity',
        'id':'identity',
        'type':'text',
        'value':@form_validation.set_value('identity')

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
