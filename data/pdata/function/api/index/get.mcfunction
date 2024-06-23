#> pdata:api > index/get
#--------------------
# -> index: $indexer
#--------------------
# <- result: PlayerEntry
#--------------------
#> gets the player entry at <index>.
#--------------------
#- literal shorthand for `data get storage pdata:data players[$(<index>)]`
#- a player's 'pdata-index' score indicates their entry's index.
#--------------------
# 0.. - result of `data get storage pdata:data players[$(<index>)]`
#--------------------

execute store result score *get.return --pdata run function pdata:_/impl/index/get/do with storage pdata:in get

data remove storage pdata:in get

return run scoreboard players get *get.return --pdata