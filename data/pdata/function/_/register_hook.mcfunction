#>pdata:_/register_hook
#--------------------
# ./join
#--------------------

#-- HOOK : pdata:on_register --
function #pdata:hook/on_register

execute if score *loggr load-status matches 1 run function pdata:_/register_log