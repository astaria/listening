class Recording < ApplicationRecord
  has_attached_file :audio
    #:storage => :s3,
    #:bucket => ENV['S3_BUCKET_NAME'],
    #:region => ENV['AWS_REGION'],
    #:s3_credentials => "#{Rails.root}/config/aws.yml",
    #:path => "resources/:id/:style/:basename.:extension"

  validates_attachment_content_type :audio, :content_type => /\Aaudio|video\/.*\Z/
end
