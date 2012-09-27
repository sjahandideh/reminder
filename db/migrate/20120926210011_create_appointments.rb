class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :datetime
      t.text :message
      t.references :staff

      t.timestamps
    end
    add_index :appointments, :staff_id
  end
end
