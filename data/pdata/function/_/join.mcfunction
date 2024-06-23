#>pdata:_/join
#--------------------
# ./tick
#--------------------

data modify storage pdata:var join.UUID set from entity @s UUID

data modify storage pdata:in get.index.UUID set from storage pdata:var join.UUID
execute store result score *join.exists -pdata run function pdata:api/index/get

data modify storage pdata:var join.entry set from storage pdata:out get.result

execute unless score *join.exists -pdata matches 1.. run function pdata:_/register

summon item_display ~ ~ ~ {Tags:["_pdata-head"]}
loot replace entity @n[type=item_display,tag=_pdata-head] container.0 loot pdata:_/player_head
execute as @n[type=item_display,tag=_pdata-head] run function pdata:_/join.1

execute store result score @s pdata-index run data get storage pdata:var join.entry.index

function pdata:_/join.2 with storage pdata:var join.entry
scoreboard players set @s _pdata-leave -1

execute unless score *join.exists -pdata matches 1.. run function pdata:_/register_hook

data remove storage pdata:var join
scoreboard players reset *join.exists -pdata