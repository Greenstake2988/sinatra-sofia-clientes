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

# Ruta para mostrar TODOS los clientes DEUDORES
get '/clientes_deudores' do
  # Cambiar cuando se pueda filtramos todos los que tienen
  # en la suma de sus transacciones mayores a 0
  c = DB["SELECT clientes.nombre FROM transacciones INNER JOIN clientes ON clientes.nombre=transacciones.nombre_cliente GROUP BY clientes.nombre HAVING SUM(monto)>0"].all
  erb :clientes, :locals => {:clientes => c}
end


# Ruta para AGREGAR un cliente
post '/clientes' do
  # todas las palabras en minusculas y le quitamos los espacios de atras ya adelante
  n = params[:nombre].downcase.strip
  # checamos que el nombre n exista y que no este vacio
  if not (DB[:clientes].include?(nombre: n) or n.empty?)
    DB[:clientes].insert(nombre: n)
    redirect '/clientes/' + n
  end
    redirect '/' 
end

# Ruta para MOSTRAR un cliente
get '/clientes/:nombre' do |n|
  # Buscamos las transacciones que pertenecen al cliente
  t = DB[:transacciones].where(nombre_cliente: n).all
  erb :cliente, :locals => {:nombre => n, :transacciones => t}
end

# Ruta para BORRAR un cliente
delete '/clientes/:nombre' do |n|
  # Hay que borrar primero los childs luego borramos al padre
  DB[:transacciones].where(nombre_cliente: n).delete
  DB[:clientes].where(nombre: n).delete
  redirect '/'
end


# Ruta para agregar UNA transaccion al cliente
post '/clientes/:nombre' do |n|
  # Evitando guardar mayusculas en la base de datos y nombres en blanco
  if (DB[:clientes].include?(nombre: n.downcase) or n.empty?)
    DB[:transacciones].insert(monto: params[:monto] ,fecha: params[:fecha], nombre_cliente: n)
  end
    redirect '/clientes/' + n
end

# Ruta para BORRAR una TRANSACCION de un CLIENTE
delete '/clientes/:nombre/:id' do |n, id|
  DB[:transacciones].where(id: id.to_i).delete
  redirect '/clientes/' + n
end