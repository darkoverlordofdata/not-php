#!/usr/bin/env php
<?php
/*
+--------------------------------------------------------------------+
| php2coffee.php
+--------------------------------------------------------------------+
| Copyright DarkOverlordOfData (c) 2012
+--------------------------------------------------------------------+
|                                                                    
| This file is a part of NodeLiter
|                                                                    
| NodeLiter is free software; you can copy, modify, and distribute 
| it under the terms of the GNU General Public License Version 3     
|                                                                    
+--------------------------------------------------------------------+
*/
/**
 * 
 * @package     NodeLiter
 * @subpackage  php2coffee
 * @category    tools
 * @copyright   DarkOverlordOfData (c) 2012
 * @author      BruceDavidson@darkoverlordofdata.com
 * 
 *
 *	php2coffee
 */
$man = <<<DOC

Usage: php2coffee [OPTIONS] PATH [DESTINATION]
 
  -c, --config        config files (declares module globals)
  -h, --help          display this help
  -j. --javascript    compiles resulting .coffee file
  -r, --recursive     recurse source path
  -t, --trace         trace output
  
 
DOC;

include_once 'lib/Parser.php';
include_once 'lib/constants.php';
include_once 'lib/file_helper.php';
error_reporting(E_ALL);

$config       = false;    // config files (declares module globals)
$javascript   = false;    // compiles resulting .coffee file
$recursive    = false;    // recurse source path
$trace        = false;    // trace output
$paths        = array();  // path arguments
$src          = '';       // arg0 = source folder
$dst          = '';       // arg1 = optional destination folder

unset($argv[0]);          // scriptname: php2coffee.php

foreach ($argv as $arg)   // decode the command line
  switch ($arg) {
  
    case '-c':
    case '--config':
      $config = true;  
      break;
    
    case '-h':
    case '--help':
      echo $man;
      exit;
    
    case '-j':
    case '--javascript':
      $javascript = true;  
      break;
    
    case '-r':  
    case '--recursive':  
      $recursive = true;  
      break;
    
    case '-t':  
    case '--trace':  
      $trace = true;  
      break;
    
    default:    
      $paths[] = $arg;
  }
  
// unpack path args
switch (count($paths)) {
  case 0:
    throw new Exception("Source path not specified");
    
  case 1:
    $src = $dst = realpath($paths[0]);
    break;
  
  default:
    $src = realpath($paths[0]);
    $dst = realpath($paths[1]);
    
    
}

// global flags
define('CONFIG',    $config);
define('TRACE',     $trace);

// process each source file
$i = 0;
$dir = get_filenames($src, TRUE, $recursive);
foreach ($dir as $f) {
  if (fnmatch('*.php', $f)) {
    $f2 = copyto_filename($f, $src, $dst).'.coffee';
    echo "$f -> ";
    $parser = new Parser();
    write_file($f2, $parser->convert($f));
    if ($javascript) {
      system("coffee -c -b $f2");
    }
    echo "$f2\n";
    $i++;
  }
}
$s = ($i == 1) ? '':'s';
echo "\n$i file$s converted.\n";

/**
 * copyto_filename
 *
 * @param string $filename
 * @param string $source
 * @param string $destination
 * @return string
 */
function copyto_filename($filename, $source, $destination) {
  
  if ($source == $destination) return $filename;
  $n = substr($filename, strlen($source)-1);
  return $destination.$n;
}
/* End of file php2coffee.php */
/* Location: ./tools/php2coffee.php */
