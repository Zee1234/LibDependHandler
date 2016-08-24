function Initialize(a_Plugin)
  a_Plugin:SetName("LibDependHandler")
  a_Plugin:SetVersion(1.0)
	
  
  cPluginManager:AddHook(cPluginManager.HOOK_PLUGINS_LOADED, LDHBroadcast)
  cRoot:Get():GetDefaultWorld():ScheduleTask(1,LDHBroadcast)
  
  
  g_Plugin = a_Plugin
  LOG("Initialized LibDependHandler v." .. a_Plugin:GetVersion())
  return true
end

function OnDisable()
  
  for _,v in pairs(g_Libs) do
    cPluginManager:CallPlugin(v.name,"LDHDisable")
  end
  
  for _,v in pairs(g_Dependents) do
    cPluginManager:CallPlugin(v.name,"LDHDisable")
  end
  
  
  LOG("LibDependHandler is disabled")
end

function verify(a_name)
  return not cPluginManager:ForEachPlugin(function(a_plugin) if a_plugin:GetName() == a_name then return true end end) and cPluginManager:CallPlugin(a_name,"LDHVerify")
end

function LDHBroadcast()
  if LDHSent then return; end
  LOG("Errors of this format:")
  LOG("Error in plugin ________: Could not find function LDHSetup()")
  LOG("Function 'LDHSetup' not found")
  LOG("are intended.")
  LOG("Do not report them to the plugin dev, you will be laughed at.")
  LOG("You have been warned.")
  cPluginManager:ForEachPlugin(function(a_plugin) if a_plugin:GetName() == "LibDependHandler" then return; end cPluginManager:CallPlugin(a_plugin:GetName(),"LDHSetup") end)
  LDHSent = true
  LOG("Any errors of that format after this point may be and likely are actual errors!")
end
