class RecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def record
    @audio = Recording.new(recording_params)

    filename = "upload#{Time.now.to_s.gsub(/\D+/, '')}"
    saved_file = Rails.root.join("tmp", filename)
    File.open(saved_file, "wb") { |f|
      f.write(params[:recording][:audio].read)
    }

    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
    })
    directory = connection.directories.get(ENV['S3_BUCKET_NAME'])
    file = directory.files.create(
      :key    => filename,
      :body   => File.open(saved_file),
      :public => true
    )
    file.save
    @audio.audio_url = file.url

    if @audio.save!
      logger.info "Success: #{@audio.inspect}"
      redirect_to @audio, notice: 'Audio was successfully created.'
    else
      logger.info "Error: #{@audio.inspect}"
    end
  end

  private

  def recording_params
    params.require(:recording).permit(:audio, :run_time)
  end
end
