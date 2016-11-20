class AddAudioToRecordings < ActiveRecord::Migration[5.0]
  def change
    add_column :recordings, :audio, :string
  end
end
