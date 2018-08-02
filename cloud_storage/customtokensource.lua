local CustomTokenSource
do
  local _class_0
  local _base_0 = {
    get_access_token = function(self)
      if not self.access_token or os.time() >= self.expires_at then
        self:refresh_access_token()
      end
      return self.access_token
    end,
    refresh_access_token = function(self)
      self.expires_at, self.access_token = self:tkrefresh()
      return self.access_token
    end,
    sign_string = function(self)
      return error("unsported action from custom token source")
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, tkrefresh, auth_type)
      self.tkrefresh, self.auth_type = tkrefresh, auth_type
    end,
    __base = _base_0,
    __name = "CustomTokenSource"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  CustomTokenSource = _class_0
end
return {
  CustomTokenSource = CustomTokenSource
}
