require 'rails/all'

class EncryptionTest < ActiveSupport::TestCase
    test "text should be encrypted" do
        encrypter = Encryption.new(
            "config/certificates/private.pem",
            "config/certificates/public.pem",
            "chentux"
        )
        assert encrypter.encrypt("Encrypt this!").bytesize() > 0
    end

    test "text should be encrypted and then decrypted" do
        encrypter = Encryption.new(
            "config/certificates/private.pem",
            "config/certificates/public.pem",
            "chentux"
        )
        encrypted = encrypter.encrypt("Encrypt this!")
        assert_equal "Encrypt this!", encrypter.decrypt(encrypted)
    end
end