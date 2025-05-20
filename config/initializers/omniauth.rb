Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {
      hd: 'gsf.com', # Restricts to your domain only
      scope: 'email,profile'
    }
end
