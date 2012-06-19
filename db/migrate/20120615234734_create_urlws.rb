class CreateUrlws < ActiveRecord::Migration
  def change
    create_table :urlws do |t|
      t.string :url

      t.timestamps
    end
  end
end
