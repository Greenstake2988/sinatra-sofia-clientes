require 'sinatra'
require "sequel"

# Conexion base de datos
DB = Sequel.connect('sqlite://cartera.db')

# Routes
get '/' do
  redirect '/clientes'
end

get '/clientes' do
  c = DB[:clientes].all
  erb :clientes, :locals => {:clientes => c}
end


get '/clientes/:nombre' do |n|
  t = DB[:transacciones].where(nombre_cliente: n).all
  erb :cliente, :locals => {:nombre => n, :transacciones => t}
end

post '/clientes' do
  DB[:clientes].insert(nombre: params[:nombre])
  redirect '/'
end

delete '/clientes/:name' do |n|
  DB[:clientes].where(nombre: n).delete
  redirect '/'
end