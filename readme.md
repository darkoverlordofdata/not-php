# this is your php on node

### porting php code to node.js

This is an experimental project to port CodeIgniter 
to javascript, running on a node.js server.

Start by running the php2coffee command line tool. 
This program will port php code to coffee-script, and 
then attempt to compile the result to js. You can then 
edit the cofee-script to tweak and re-compile to js. 
This is still in bump-n-dev mode as I work my way through
porting the CodeIgniter framework.

The resulting files will have the extensions *.php.coffee, and 
*.php.js, so the front end controller index.php will be named 
index.php.js.


### run using the not-php library


Boot the server application by running thee front end controller,
like this:
	
	require('coffee-script');
	require('./not-php');
	require('./index.php.js');

Note: at this time, not-php defines it's php compatability to be
globally scoped. This is to make the port easier for proof of concept.
A more sophisticated port would use an intermediary AST to drive the
conversion, and invoke a namespaced version of not-php.

