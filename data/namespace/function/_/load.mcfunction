#>namespace:_/load
#--------------------
# @LOAD
#--------------------

# load
scoreboard players set *namespace load-status 1

# settings
execute unless data storage namespace:settings {PERSIST:true} run function namespace:settings

#declare storage namespace:var
#declare storage namespace:in
#declare storage namespace:out
#declare storage namespace:const
#declare storage namespace:dirty
#declare storage namespace:data
#declare storage namespace:hook

# scoreboards
scoreboard objectives add -namespace dummy
#(dirty)
scoreboard objectives add --namespace dummy
#scoreboard objectives add namespace-scoreboard dummy