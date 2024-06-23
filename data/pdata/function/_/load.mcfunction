#>pdata:_/load
#--------------------
# @PRE_LOAD
#--------------------

# load
scoreboard players set *pdata load-status 1

# settings
execute unless data storage pdata:settings {PERSIST:true} run function pdata:settings

#declare storage pdata:var
#declare storage pdata:in
#declare storage pdata:out
#declare storage pdata:const
#declare storage pdata:dirty
#declare storage pdata:data
#declare storage pdata:hook

# scoreboards
scoreboard objectives add -pdata dummy
scoreboard objectives add --pdata dummy
scoreboard objectives add pdata-index dummy
scoreboard objectives add _pdata-leave minecraft.custom:leave_game

# tick
schedule clear pdata:_/tick
function pdata:_/tick