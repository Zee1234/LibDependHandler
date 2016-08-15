g_Dependents = {}
g_Libs = {}
g_LibState = {
  ["requested"] = false,
  ["registered"] = 0,
  ["utilized"] = 1,
  [false] = "requested",
  [0] = "registered",
  [1] = "utilized"
}
g_Plugin = {}
g_LDHSent = {}


cDependent = dofile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/class/cDependent.lua")
cLibrary = dofile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/class/cLibrary.lua")


dofile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/API/Dependent.lua")
dofile(cPluginManager:GetCurrentPlugin():GetLocalFolder() .. "/API/Library.lua")
