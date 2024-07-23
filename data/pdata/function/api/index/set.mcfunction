#> pdata:api > index/set
#--------------------
# -> index: $indexer
# -> storage: obj
#--------------------
# ...
#--------------------
#> sets the player entry's <storage> at <index>.
#--------------------
#- literal shorthand for: `data modify storage pdata:data players[$(<index>)].storage set from storage pdata:in set.storage`
#- a player's 'pdata-index' score indicates their entry's index.
#- intended to work nicely with `pdata:api/index/get`.
#--------------------
# 0..1 - result of `data modify storage pdata:data players[$(<index>)].storage set from storage pdata:in set.storage`
#--------------------

execute store result score *set.return --pdata run function pdata:_/impl/index/set/do with storage pdata:in set

data remove storage pdata:in set

return run scoreboard players get *set.return --pdata