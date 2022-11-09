require 'sinatra'
require "sequel"

# Conexion base de datos
DB = Sequel.connect('sqlite://cartera.db')

# Ruta raiz
get '/' do
  redirect '/clientes'
end

# Ruta para mostrar TODOS los clientes
get '/clientes' do
  c = DB[:clientes].all
  erb :clientes, :locals => {:clientes => c}
end

# Ruta para AGREGAR un cliente
post '/clientes' do
  # Evitando guardar mayusculas en la base de datos
  unless DB[:clientes].include?(nombre: params[:nombre].downcase)
    DB[:clientes].insert(nombre: params[:nombre].downcase)
  end
    redirect '/'
end

# Ruta para BORRAR el cliente
delete '/clientes/:name' do |n|
  # Hay que borrar primero los childs luego
  # borramos al padre
  DB[:transacciones].where(nombre_cliente: n).delete
  DB[:clientes].where(nombre: n).delete
  redirect '/'
end

# Ruta para mostrar UN cliente
get '/clientes/:nombre' do |n|
  # Buscamos las transacciones que pertenecen al cliente
  t = DB[:transacciones].where(nombre_cliente: n).all
  erb :cliente, :locals => {:nombre => n, :transacciones => t}
end