class AddCodigoUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :origenes_de_reporte, :codigo, :unique => true
  end

  def down
    remove_index :origenes_de_reporte, :codigo
  end
end
