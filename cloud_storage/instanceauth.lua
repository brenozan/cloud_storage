local ltn12 = require("ltn12")
local json = require("cjson")
local concat
concat = table.concat
local http = require("socket.http")
local InstanceAuth
do
  local _class_0
  local _base_0 = {
    account_token_url = "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token",
    auth_type = "Bearer",
    get_access_token = function(self)
      if not self.access_token or os.time() >= self.expires_at then
        self:refresh_access_token()
      end
      return self.access_token
    end,
    refresh_access_token = function(self)
      local time = os.time()
      local out = { }
      local status, code, respheaders = http.request({
        url = self.account_token_url,
        sink = ltn12.sink.table(out),
        method = "GET",
        headers = {
          ["Metadata-Flavor"] = "Google"
        }
      })
      local res = assert(concat(out))
      res = json.decode(res)
      self.expires_at = time + res.expires_in
      self.access_token = res.access_token
      return self.access_token
    end,
    sign_string = function(self)
      return error("unsported action from instance token")
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "InstanceAuth"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  InstanceAuth = _class_0
end
return {
  InstanceAuth = InstanceAuth
}
