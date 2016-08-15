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
