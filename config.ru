require 'rubygems'
require 'bundler'
Bundler.require

require './app'

# Models
require './models/cliente'
require './models/transaccione'

run Sinatra::Application