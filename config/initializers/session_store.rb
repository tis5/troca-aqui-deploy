if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_auth_app", domain: "https://troca-aqui-api-e7p5jefkcq-uc.a.run.app/"
else
  Rails.application.config.session_store :cookie_store, key: "_auth_app"
end
