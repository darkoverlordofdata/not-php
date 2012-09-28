#+--------------------------------------------------------------------+
#| not-php.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2012
#+--------------------------------------------------------------------+
#|
#| This file is a part of darklite
#|
#| Darklite is free software; you can copy, modify, and distribute
#| it under the terms of the GNU General Public License Version 3
#|
#+--------------------------------------------------------------------+
#
#	not-php - PHP Library Clone
#
#
#
# This is definitely Not PHP!
$fs = require('fs')
##
# define — Defines a named constant
#
#	@param	string	The name of the constant
# @param	mixed		The value of the constant
# @param	object	The scope of the constant
# @returns boolean TRUE on success or FALSE on failure
#
exports.define = (name, value, scope = global) ->

  if scope[name]?
    return false # already defined

  Object.defineProperty scope, name,
    'value':			value
    'enumerable': true
    'writable':		false

  return true # success


##
# defined — Checks whether a given named constant exists
#
#	@param	string	The constant name
# @param	object	The constant scope
# @returns boolean TRUE on success or FALSE on failure
#
exports.defined = (name, scope = global) ->

  return scope[name]?

##
# constant — Returns the value of a constant
#
#	@param	string	The constant name
# @param	object	The constant scope
# @returns the value of the constant, or NULL if the constant is not defined.
#
exports.constant = (name, scope = global) ->

  if scope[name]?
    return scope[name]
  else
    return null

##
# is_dir — check if path is a folder
#
#	@param	string	The path being checked
# @returns true or false
#
exports.is_dir = (path) ->

  try
    stats = $fs.lstatSync(path)
    b = stats.isDirectory()
  catch ex
    b = false
  finally
    return b

##
# realpath — Returns canonicalized absolute pathname
#
#	@param	string	The path being checked
# @returns the canonicalized absolute pathname
#
exports.realpath = (path) ->

  if $fs.existsSync(path)
    return $fs.realpathSync(path)
  else
    return false

##
# file_exists — check file system
#
#	@param	string	The path being checked
# @returns true or false
#
exports.file_exists = (path) ->

  return $fs.existsSync(path)

##
# die/exit — PHP die or exit
#
#	@param	string	optional message to display
#
exports.die = exports.exit = (msg = '') ->
  if msg isnt ''
    console.log msg
    process.exit 1
  process.exit 0
