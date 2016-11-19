class CreateRecordings < ActiveRecord::Migration[5.0]
  def change
    create_table :recordings do |t|
      t.attachment :audio
      t.time :run_time

      t.timestamps
    end
  end
end
