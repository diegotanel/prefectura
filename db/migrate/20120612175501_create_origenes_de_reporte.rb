class CreateOrigenesDeReporte < ActiveRecord::Migration
  def change
    create_table :origenes_de_reporte do |t|
      t.string :codigo
      t.string :etiqueta

      t.timestamps
    end
  end
end
