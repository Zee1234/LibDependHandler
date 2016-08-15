local cLibrary = {}
cLibrary.__index = cLibrary

function cLibrary:new(a_name,a_fromLib)
  assert(type(a_name) == "string","cLibrary:new() recieved a non-string value for a_name! Value recieved:" .. tostring(a_name))
  local obj = {}
  setmetatable(obj,{["__index"] = cLibrary})
  
  obj.registered = a_fromLib and true or false
  
  obj.children = {}
  obj.n = 0
  obj.name = a_name
  
  return obj
end

function cLibrary:addChild(a_child)
  if self.children[a_child] then return false, "Child Already Registered" end
  
  self.n = self.n + 1
  self.children[a_child] = self.n
  self.children[self.n] = a_child
  
  if self.registered then self:notifyOneOn(a_child) end
  return true
end

function cLibrary:remChild(a_child)
  if not self.children[a_child] then return false, "Child Already Unregistered" end
  
  self.children[a_child] = nil
  self.children[self.n] = nil
  self.n = self.n - 1
  return true
end

function cLibrary:notifyAllOn()
  if next(self.children) == nil then return false, "No Children" end
  
  for i = 1, self.n do
    cPluginManager:CallPlugin(self.children[i],"LDHLibOn",self.name)
  end
  return true
end

function cLibrary:notifyOneOn(a_child)
  if not self.children[a_child] then return false, "Not a Child" end
  
  cPluginManager:CallPlugin(self.children[a_child],"LDHLibOn",self.name)
end

function cLibrary:notifyAllOff()
  if next(self.children) == nil then return false, "No Children" end
  
  for i = 1, self.n do
    cPluginManager:CallPlugin(self.children[i],"LDHLibOff",self.name)
  end
  return true
end

function cLibrary:hasChild(a_child)
  if self.children[a_child] then return true else return false end
end


return cLibrary
