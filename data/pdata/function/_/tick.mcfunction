#>pdata:_/tick
#--------------------
# @PRE_TICK
#--------------------

execute as @a unless score @s _pdata-leave matches -1 run function pdata:_/join

schedule function pdata:_/tick 1t