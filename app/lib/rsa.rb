require "base64"

class Rsa
  PRIVATE_KEY = OpenSSL::PKey::RSA.new 2048

  def self.public_key_str
    PRIVATE_KEY.public_key.to_s.gsub(/\n+|-+| |BEGIN|END|PUBLIC|KEY/, '')
  end

  def self.decode_msg(msg)
    str = Base64.decode64(msg)
    PRIVATE_KEY.private_decrypt(str)
  end

  def self.encode_msg(msg)
    Base64.encode64(PRIVATE_KEY.public_encrypt(msg))
  end
end