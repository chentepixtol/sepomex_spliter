require 'redis'
require 'json'

class FileController < ApplicationController
  def index

  end

  def upload
    encrypter = Encryption.new(
      Rails.application.secrets.encryption_private_key,
      Rails.application.secrets.encryption_public_key,
      Rails.application.secrets.encryption_password
    )

    redis = Redis.new
    file_data = params[:file]

    csv_reader = CsvReader.new(file_data.path)
    csv_reader.read { |row|
      redis.publish "csv-channel", encrypter.encrypt(row.to_json)
    }
  end

end
