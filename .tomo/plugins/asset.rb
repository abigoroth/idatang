def assets_precompile
  remote.rake("assets:precompile", silent: true, raise_on_error: false)
end