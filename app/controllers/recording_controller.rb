class RecordingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def record
    @audio = Recording.new(recording_params)

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
