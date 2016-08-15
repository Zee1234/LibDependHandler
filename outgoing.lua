--- These are functions that your plugin may need in order to work with LDH.
-- It is mentioned which functions are required for Libraries, Dependents, and both, so don't worry.

--- Informs your plugin of LDH disabling.
-- Both.
--@return nill
function LDHDisable() end

--- Allows LDH to verify your plugin is registered properly.
-- Both.
--@return true
function LDHVerify() end

--- Notify your plugin of a library plugin "turning on".
-- Dependents only.
--@param plugin_name (string)
--@return nil
function LDHLibOn(plugin_name) end

--- Notify your plugin of a library plugin "turning off".
-- Dependents only.
--@param plugin_name (string)
--@return nil
function LDHLibOff(plugin_name) end

