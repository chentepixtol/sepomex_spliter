class Encryption

    def initialize(private_key_file, public_key_file, password)
        @private_key = OpenSSL::PKey::RSA.new(File.read(private_key_file),password)
        @public_key = OpenSSL::PKey::RSA.new(File.read(public_key_file))
    end

    def encrypt(json)
        Base64.encode64(@public_key.public_encrypt(json))
    end

    def decrypt(text)
        @private_key.private_decrypt(Base64.decode64(text))
    end

end