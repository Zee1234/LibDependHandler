local cDependent = {}
cDependent.__index = cDependent




function cDependent:new(a_name,...)
  assert(type(a_name) == "string","cDependent:new() recieved a non-string value for a_name! Value recieved:" .. tostring(a_name))
  local obj = {}
  setmetatable(obj,cDependent)
  
  obj.lib = {}
  obj.lib.n = 0
  obj.name = a_name
  obj.happy = false
  
  for _,v in ipairs({...}) do
    obj:addLib(v)
  end
  
  return obj
end




function cDependent:addLib(a_string)
  if self.libs[a_string] then return false, "Library already registered" end
  self.libs.n = self.libs.n + 1
  self.libs[self.libs.n] = a_string
  self.libs[a_string] = self.libs.n
end




function cDependent:remLib(a_string)
  if not self.libs[a_string] then return false, "Library not registered" end
  local num = self.libs[a_string]
  table.remove(self.libs,num)
  self.lins[a_string] = nil
end




return cDependent
