class CreateTransacciones < ActiveRecord::Migration[7.0]
  def change
    create_table :transacciones do |t|
      t.float :monto, null: false
      t.date  :fecha, null: false
      t.string :nombre_cliente
    end
  end
end
