--- Functions within LDH that your plugin will call, generally relating to registration.
-- Some only apply to Dependents, some only apply to Libraries.
-- However, one plugin can be both a Dependent and a Library, so choose functions to use accordingly.

--- Register your plugin as a Dependent.
--@param a_plugin Plugin name (string)
--@param ... as many library plugin names as you want (string)
--@return true if successful
--@return false and error message if failure.
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


--- Unregister your plugin as a Dependent.
--@param a_plugin Plugin name (string)
--@return true if successful
--@return false and error message if failure.
function UnregisterDependent(a_plugin)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  if not g_Dependents[a_plugin] then return false, "Dependent Already Unregistered" end
  
  
  
  g_Dependents[a_plugin] = nil
  
  return true
end

--- Add required Libraries to your list (Dependent only).
--@param a_plugin Plugin name (string)
--@param ... as many library plugin names as you want (string)
--@return true if successful
--@return false and error message if failure.
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

--- Remove required Libraries to your list (Dependent Only).
--@param a_plugin Plugin name (string)
--@param ... as many library plugin names as you want (string)
--@return true if successful
--@return false and error message if failure.
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




--- Register your plugin as a Library.
--@param a_plugin Plugin name (string)
--@return true if successful
--@return false and error message if failure.
function RegisterLibrary(a_plugin)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  
  if g_Libs[a_plugin] then 
    
    if g_Libs[a_plugin].registered then
      return false, "Library Already Registered" 
    else
      
      g_Libs[a_plugin].registered = true
      cRoot:Get():GetDefaultWorld():ScheduleTask(1,function() g_Libs[a_plugin]:notifyAllOn() end)
      return true
      
    end
  end
  
  g_Libs[a_plugin] = cLibrary:new(a_plugin,true)
  return true
end

--- Register your plugin as a Library.
--@param a_plugin Plugin name (string)
--@return true if successful
--@return false and error message if failure.
function UnregisterLibrary(a_plugin)
  if type(a_plugin) ~= "string" then return false, "Invalid Plugin Name Data Type" end
  if not verify(a_plugin) then return false, "Invalid Plugin Name" end
  if not g_Libs[a_plugin] then return false, "Library Already Unregistered" end
  
  if next(g_Libs[a_plugin].children) == nil then
    g_Libs[a_plugin] = nil
  else
    g_Libs[a_plugin]:notifyAllOff()
    g_Libs[a_plugin].registered = false
  end
  return true
end