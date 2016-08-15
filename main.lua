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
  cPluginManager:ForEachPlugin(function(a_plugin) cPluginManager:CallPlugin(a_plugin:GetName(),"LDHSetup") end)
  LDHSent = true
end
