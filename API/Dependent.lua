function RegisterDependent(a_plugin,...)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  if g_Dependents[a_plugin] then return false, "Dependent Already Registered" end
  
  g_Dependents[a_plugin] = cDependent:new(a_plugin)
  
  for _,v in ipairs({...}) do
    if not g_Libs[v] then
      g_Libs[v] = cLibrary:new(v,false)
      g_Libs[v]:addChild(a_plugin)
    else
      g_libs[v]:addChild(a_plugin)
    end
  end
  
  return true
end

function UnregisterDependent(a_plugin)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  if not g_Dependents[a_plugin] then return false, "Dependent Already Unregistered" end
  
  
  
  g_Dependents[a_plugin] = nil
  
  return true
end

function AddLibs(a_plugin,...)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  
  for _,v in ipairs({...}) do
    g_Dependents[a_plugin]:addLib(v)
    if not g_Libs[v] then
      g_Libs[v] = cLibrary:new(v,false):addChild(a_plugin)
    else
      g_libs[v]:addChild(a_plugin)
    end
  end
end

function RemLibs(a_plugin,...)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  
  for _,v in ipairs({...}) do
    repeat
      if not g_Libs[v] then break end
      g_Dependents[a_plugin]:remLib(v)
      if g_Libs[v][a_plugin] then g_Libs[v]:remChild(a_child) end
    until true
  end
end

