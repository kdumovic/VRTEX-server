require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/app/*.rb'].each {|file| require file }
