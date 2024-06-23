#>pdata:_/register_hook
#--------------------
# ./join
#--------------------

#-- HOOK : pdata:on_register --
data modify storage pdata:hook on_register append value {}
data modify storage pdata:hook on_register[-1].info.entry set from storage pdata:var join.entry
function #pdata:hook/on_register
data remove storage pdata:hook on_register[-1]
#-- > < --

execute if score *loggr load-status matches 1 run function pdata:_/register_log