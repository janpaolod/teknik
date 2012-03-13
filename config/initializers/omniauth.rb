Rails.application.config.middleware.use OmniAuth::Builder do 
provider :facebook, '324093857626424', '454f0a9b193915523da9a5ab6a004a2f', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}, :scope => 'publish_stream,email'} 
end 
