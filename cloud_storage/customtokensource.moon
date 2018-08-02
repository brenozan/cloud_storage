class CustomTokenSource

  new: (@tkrefresh,@auth_type) =>

  get_access_token: =>
    if not @access_token or os.time! >= @expires_at
      @refresh_access_token!

    @access_token

  refresh_access_token: =>
    @expires_at, @access_token = @tkrefresh!
    @access_token

  sign_string: =>
      error "unsported action from custom token source"

{ :CustomTokenSource }

