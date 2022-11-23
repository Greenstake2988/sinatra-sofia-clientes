 class Cartera < Sinatra::Base 
  # Ruta raiz
  get '/' do
    redirect '/clientes'
  end

  # Ruta para mostrar TODOS los clientes
  get '/clientes' do
    @clientes = Cliente.all.order(:nombre)
    erb :clientes
  end

  # Ruta para mostrar TODOS los clientes DEUDORES
  get '/clientes_saldo' do
    # Cambiar cuando se pueda filtramos todos los que tienen
    # en la suma de sus transacciones mayores a 0
    sql = "SELECT clientes.nombre FROM transacciones INNER JOIN clientes ON clientes.nombre=transacciones.nombre_cliente GROUP BY clientes.nombre HAVING SUM(monto)>0"
    @clientes = ActiveRecord::Base.connection.execute(sql)
    erb :clientes_saldo
  end


  # Ruta para AGREGAR un cliente
  post '/clientes' do
    # todas las palabras en minusculas y le quitamos los espacios de atras ya adelante
    n = params[:nombre].downcase.strip
    # checamos que el nombre n exista y que no este vacio
    if not (Cliente.exists?(n) or n.empty?)
      Cliente.create(nombre: n)
      redirect '/clientes/' + n
    end
      redirect '/' 
  end

  # Ruta para MOSTRAR un cliente
  get '/clientes/:nombre' do |n|
    # Buscamos las transacciones que pertenecen al cliente
    #t = DB[:transacciones].where(nombre_cliente: n).all
    @transacciones = Transaccione.where("nombre_cliente = ?", n).order(:fecha)
    #erb :cliente, :locals => {:nombre => n, :transacciones => t}
    erb :cliente, :locals => {:nombre => n}
  end

  # Ruta para BORRAR un cliente
  delete '/clientes/:nombre' do |n|
    # Hay que borrar primero los childs luego borramos al padre
    Transaccione.where(nombre_cliente: n).destroy_all
    Cliente.where(nombre: n).destroy_all
    redirect '/'
  end


  # Ruta para agregar UNA transaccion al cliente
  post '/clientes/:nombre' do |n|
    # Evitando guardar mayusculas en la base de datos y nombres en blanco
    if (Cliente.exists?(n.downcase) or n.empty?)
      Transaccione.create(monto: params[:monto] ,fecha: params[:fecha], nombre_cliente: n)
    end
      redirect '/clientes/' + n
  end

  # Ruta para BORRAR una TRANSACCION de un CLIENTE
  delete '/clientes/:nombre/:id' do |n, id|
    Transaccione.find(id.to_s).destroy
    redirect '/clientes/' + n
  end
end
