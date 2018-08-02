ltn12 = require "ltn12"
json = require "cjson"
import concat from table

http = require"socket.http"


class InstanceAuth
  account_token_url: "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token"
  auth_type: "Bearer"

  new: () =>

  get_access_token: =>
    if not @access_token or os.time! >= @expires_at
      @refresh_access_token!

    @access_token

  refresh_access_token: =>

    time = os.time!
    out = {}
    status,code,respheaders = http.request {
        url: @account_token_url
        sink: ltn12.sink.table out
        method: "GET"
        headers: {
            "Metadata-Flavor": "Google"
        }
    }
    
    res = assert concat out
    res = json.decode res

    @expires_at = time + res.expires_in
    @access_token = res.access_token
    @access_token
  sign_string: =>
      error "unsported action from instance token"

{ :InstanceAuth }

