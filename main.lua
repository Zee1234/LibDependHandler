g_Plugin = nil --I know this does nothing, it's a note.


function Initialize(a_Plugin)
  a_Plugin:SetName("LibDependHandler")
  a_Plugin:SetVersion(1.0)
	
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
