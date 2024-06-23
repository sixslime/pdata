#>pdata:_/register_log
#--------------------
# ./register_hook
#--------------------

data modify storage loggr:in log set value {source:"pdata", level:3, message:{}}
data modify storage loggr:in log.message.player_registered set from storage pdata:var join.entry
function loggr:api/log

