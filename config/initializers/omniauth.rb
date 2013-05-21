Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, Figaro.env.dropbox_app_key, Figaro.env.dropbox_app_secret
end