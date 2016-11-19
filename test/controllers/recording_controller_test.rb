require 'test_helper'

class RecordingControllerTest < ActionDispatch::IntegrationTest
  test "should get record" do
    get recording_record_url
    assert_response :success
  end

end
