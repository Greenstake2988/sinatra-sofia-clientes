require 'rubygems'
require 'bundler'
Bundler.require

require './server'

# Models
require './models/cliente'

run Sinatra::Application