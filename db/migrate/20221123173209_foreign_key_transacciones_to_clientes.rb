class ForeignKeyTransaccionesToClientes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :transacciones, :clientes, column: :nombre_cliente, primary_key: :nombre
  end
end
