require "sequel"

DB = Sequel.connect('sqlite://cartera.db')


#DB.create_table :clientes do
#    primary_key :id 
#    String :nombre, unique: true, null: false
#end 

#DB.create_table :transacciones do
#    primary_key :id
#    Float :monto, null: false
#    Date  :fecha, null: false
#end




#clientes = DB[:clientes]
#transacciones = DB[:transacciones]

#clientes.insert(nombre: 'oscar')
#clientes.insert(nombre: 'sofia')
#clientes.insert(nombre: 'ernesto')
#clientes.insert(nombre: 'rony')

#transacciones.insert(monto: -1000, fecha: '22-10-18')

[   {:monto => 10, :fecha => "10-10-22"},                                                                  
    {:monto => 20, :fecha => "12-10-22"},                                                                  
    {:monto => 30, :fecha => "14-10-22"},
    {:monto => 100, :fecha => "20-10-22"},
    {:monto => -1000, :fecha => "30-10-22"},
]  