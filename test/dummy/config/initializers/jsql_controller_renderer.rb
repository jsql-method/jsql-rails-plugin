# Be sure to restart your server when you modify this file.

ActiveSupport::Reloader.to_prepare do
  JSQLController.renderer.defaults.merge!(
    base: 'example.org',
    https: true
  )
end
