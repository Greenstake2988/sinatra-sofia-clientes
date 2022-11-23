class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes, id: :string, primary_key: :nombre do |t|
    end
  end
end
