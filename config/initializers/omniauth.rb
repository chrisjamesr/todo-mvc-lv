
Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :github, 'e45e650804715464f0e0', '7a3572dcd7c96912eb9bbf5d454b8e3a0670c669'
end