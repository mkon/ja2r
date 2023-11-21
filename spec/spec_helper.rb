ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'
Bundler.require :default, 'development', 'test'

require 'simplecov'
SimpleCov.start
