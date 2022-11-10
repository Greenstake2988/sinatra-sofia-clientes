require "sequel"

DB = Sequel.connect('sqlite://cartera.db')

#DB.create_table :clientes do
#    String :nombre, unique: true, null: false, primary_key: true
#end 

#DB.create_table :transacciones do
#    primary_key :id
#    Float :monto, null: false
#    Date  :fecha, null: false
#    foreign_key :nombre_cliente, :clientes
#end

#transacciones = DB[:transacciones]
#clientes = DB[:clientes]

#clientes.insert(nombre: 'oscar')
#clientes.insert(nombre: 'sofia')
#clientes.insert(nombre: 'ernesto')
#clientes.insert(nombre: 'rony')

#transacciones.insert(monto: 1000, fecha: '22-10-18', nombre_cliente: "oscar")
#transacciones.insert(monto: 1000, fecha: '22-10-18', nombre_cliente: "oscar")
#transacciones.insert(monto: 1000, fecha: '22-10-18', nombre_cliente: "sofia")
#transacciones.insert(monto: 1000, fecha: '22-10-18', nombre_cliente: "ernesto")
#transacciones.insert(monto: 1000, fecha: '22-10-18', nombre_cliente: "ernesto")