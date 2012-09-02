##
#+--------------------------------------------------------------------+
#| not-php.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2012
#+--------------------------------------------------------------------+
#|                                                                    
#| This file is a part of not-php,
#|                                                                    
#| Not-php is free software; you can copy, modify, and distribute 
#| it under the terms of the GNU General Public License Version 3     
#|                                                                    
#+--------------------------------------------------------------------+
##
#
#	not-php - A PHP Compatability Layer for Node
#
#
php = require('phpjs')

##
# This module defines some usefull globals similar to PHP
#
module.exports = true # This is definitely Not PHP!
$fs = require('fs')
$path = require('path')
$required = {}
##
# define — Defines a named constant
#
#	@param	string	The name of the constant
# @param	mixed		The value of the constant
# @param	object	The scope of the constant
# @returns boolean TRUE on success or FALSE on failure
#
global.define = (name, value, scope = global) ->

	if name isnt name.toUpperCase() 
		return false # constants must be UPPER_CASED
		
	if scope[name]?
		return false # already defined
		
	Object.defineProperty scope, name, 
		'value':			value
		'enumerable': true
		'writable':		false

	return true # success


define 'FALSE', false
define 'TRUE', true
define 'PHP_VERSION', '5.3.0'
##
# defined — Checks whether a given named constant exists
#
#	@param	string	The constant name
# @param	object	The constant scope
# @returns boolean TRUE on success or FALSE on failure
#
global.defined = (name, scope = global) ->

	return scope[name]?
	
##
# constant — Returns the value of a constant
#
#	@param	string	The constant name
# @param	object	The constant scope
# @returns the value of the constant, or NULL if the constant is not defined.
#
global.constant = (name, scope = global) ->

	if scope[name]? 
		return scope[name]
	else
		return null
		
##
# realpath — Returns canonicalized absolute pathname
#
#	@param	string	The path being checked
# @returns the canonicalized absolute pathname 
#
global.realpath = (path) ->
	
	return $fs.realpathSync(path)
	
##
# file_exists — check file system
#
#	@param	string	The path being checked
# @returns true or false 
#
global.file_exists = (path) ->
	
	return $fs.existsSync(path)
	
##
# is_dir — check if path is a folder
#
#	@param	string	The path being checked
# @returns true or false 
#
global.is_dir = (path) ->

	try 
		stats = $fs.lstatSync(path)
		b = stats.isDirectory()
	catch ex
		b = false
	finally
		return b

define 'PATHINFO_ALL', 15
define 'PATHINFO_DIRNAME', 1
define 'PATHINFO_BASENAME', 2
define 'PATHINFO_EXTENSION', 4
define 'PATHINFO_FILENAME', 8


##
# pathinfo — return file system info
#
#	@param	string	The path being checked
# @returns true or false 
#
global.pathinfo = (path, options=PATHINFO_ALL) ->

	res = []
	if (options & PATHINFO_DIRNAME) 
		res.push $path.dirname(path)
		
	if (options & PATHINFO_BASENAME) 
		res.push $path.basename(path)
		
	if (options & PATHINFO_EXTENSION) 
		res.push $path.extname(path)
		
	if (options & PATHINFO_FILENAME) 
		res.push $path.basename(path, $path.extname(path))

	if res.length is 1 then res = res[0]
	
	return res

##
# require_all — PHP require
#
#	@param	string	The path to the file
#	@param	string	suffix to append, typically .coffee or .eco
# @returns file content, to be eval'd in calling scope
#
global.require_all = (path, suffix = '.js') ->
	path = path+suffix
	return $fs.readFileSync(path, 'utf8')
	
##
# require_once — PHP require_once
#
#	@param	string	The path to the file
#	@param	string	suffix to append, typically .coffee or .eco
# @returns file content, to be eval'd in calling scope
#
global.require_once = (path, suffix = '.js') ->
	path = path+suffix
	if $required[path]?
		return ''
	else
		$required[path] = true
		return $fs.readFileSync(path, 'utf8')
	
##
# include_all — PHP include
#
#	@param	string	The path to the file
#	@param	string	suffix to append, typically .coffee or .eco
# @returns file content, to be eval'd in calling scope
#
global.include_all = (path, suffix = '.js') ->
	path = path+suffix
	return $fs.readFileSync(path, 'utf8')
	
##
# include_once — PHP include_once
#
#	@param	string	The path to the file
#	@param	string	suffix to append, typically .coffee or .eco
# @returns file content, to be eval'd in calling scope
#
global.include_once = (path, suffix = '.js') ->
	path = path+suffix
	if $required[path]?
		return ''
	else
		$required[path] = true
		return $fs.readFileSync(path, 'utf8')
	
##
# chdir — PHP chdir
#
#	@param	string	The path to the file
#
global.chdir = (path) ->
	process.chdir path
	
##
# dirname — PHP dirname
#
#	@param	string	The path to the file
#
global.dirname = (path) ->
	return $path.dirname(path)
	
##
# die/exit — PHP dir or exit
#
#	@param	string	optional message to display
#
global.die = global.exit = (msg = '') ->
	if msg isnt ''
		console.log msg
		process.exit 1
	process.exit 0
	
##
# header — PHP header
#
#	@param	string	text to output
#	@param	boolean	true to replace current buffer content
#	@param	int			http responce code
#
global.header = (text, replace=true, response_code=200) ->
	
	
global.function_exists = (function_name) ->
	return if typeof global[function_name] is 'function' then true else false


global.set_error_handler = (exception_handler) ->

#
#	import remaining api from phpjs 
#
#
window = global
for api of php
	if not global[api]?
		global[api] = php[api]
