#>pdata:_/join
#--------------------
# ./tick
#--------------------

data modify storage pdata:var join.UUID set from entity @s UUID

data modify storage pdata:in get.index.UUID set from storage pdata:var join.UUID
execute store result score *join.exists -pdata run function pdata:api/index/get

execute if score *join.exists -pdata matches 1.. run data modify storage pdata:var join.entry set from storage pdata:out get.result
execute unless score *join.exists -pdata matches 1.. run function pdata:_/register

execute store result score *join.helmet -pdata run data modify storage pdata:var join.helmet set from entity @s Inventory[{Slot:103b}]
loot replace entity @s armor.head loot pdata:_/player_head
execute if score *join.helmet -pdata matches 1.. unless data storage pdata:var join.helmet.components run data modify storage pdata:var join.helmet.components set value {}

data modify storage pdata:var join.entry.username set from entity @s Inventory[{Slot:103b}].components."minecraft:profile".name
execute if score *join.helmet -pdata matches 1.. run function pdata:_/join.1 with storage pdata:var join
execute unless score *join.helmet -pdata matches 1.. run item replace entity @s armor.head with air
execute store result score @s pdata-index run data get storage pdata:var join.entry.index

function pdata:_/join.2 with storage pdata:var join.entry
scoreboard players set @s _pdata-leave -1

execute unless score *join.exists -pdata matches 1.. run function pdata:_/register_hook

data remove storage pdata:var join
scoreboard players reset *join.exists -pdata