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
  # Evitando guardar mayusculas en la base de datos
  unless DB[:clientes].include?(nombre: params[:nombre].downcase)
    DB[:clientes].insert(nombre: params[:nombre].downcase)
  end
    redirect '/'
end

delete '/clientes/:name' do |n|
  #Hay que borrar primero los childs luego
  #borramos al padre
  DB[:transacciones].where(nombre_cliente: n).delete
  DB[:clientes].where(nombre: n).delete
  redirect '/'
end