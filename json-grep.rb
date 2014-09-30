#!/usr/bin/env ruby 

# grep for the value of a json path

require 'json'
require 'colorize' 
require 'logger' 
require_relative './filter_contents.rb'

$log = Logger.new $stderr
$log.level = Logger::WARN

if ARGV.include? '-v'
  $log.debug "Verbosity enabled"
  $log.level = Logger::INFO
  ARGV.delete '-v'
end
if ARGV.include? '-D'
  $log.level = Logger::DEBUG
  $log.debug "Debugging enabled"
  ARGV.delete '-D'
end

path = []
ARGV.each do |arg| 
    path << arg
end
$log.debug "Initialized path: #{path.inspect}"
c=nil
begin
  c = filter_contents JSON.parse( $stdin.read ), path
rescue JSON::ParserError =>e 
  fail e.class, "Failed to read valid JSON from stdin"
  exit  -2
end
unless c
  $log.info "No such location"
  exit -1
end
begin
  puts JSON.pretty_generate( c )
rescue JSON::ParserError =>e 
  fail e.class, "Returned invalid json from filter: \n#{c.inspect}"
  exit -3
end
