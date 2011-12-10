HTTParty::Request.class_eval do
  alias :orig_setup_digest_auth :setup_digest_auth
  def setup_digest_auth
    options.delete(:headers)
    orig_setup_digest_auth
  end
end
