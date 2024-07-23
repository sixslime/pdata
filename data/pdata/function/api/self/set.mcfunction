#> pdata:api > self/set
#--------------------
# [AS] player
# -> storage: obj
#--------------------
# <- result: PlayerEntry
#--------------------
#> sets [player]'s player entry storage to <storage>.
#--------------------
#- literal shorthand for calling pdata:api/index/set with [player]'s 'pdata-index' as <index>.
#- intended to work nicely with `pdata:api/self/get`
#--------------------
# 1 - success
# 0 - <storage> already matches this player's entry's storage.
#--------------------

execute store result storage pdata:in set.index int 1 run scoreboard players get @s pdata-index
return run function pdata:api/index/set