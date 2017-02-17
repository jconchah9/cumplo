class CreateSettingSbifs < ActiveRecord::Migration[5.0]
  def change
    create_table :setting_sbifs do |t|
      t.string :date
      t.float :uf
      t.float :dolar
      t.timestamps
    end
  end
end
