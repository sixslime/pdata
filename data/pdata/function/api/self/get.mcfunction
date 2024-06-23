#> pdata:api > self/get
#--------------------
# [AS] player
#--------------------
# <- result: PlayerEntry
#--------------------
#> gets [player]'s player entry.
#--------------------
#- literal shorthand for calling pdata:api/index/get with [player]'s 'pdata-index' as <index>
#--------------------
# 1 - success
#--------------------

execute store result storage pdata:in get.index int 1 run scoreboard players get @s pdata-index
return run function pdata:api/index/get