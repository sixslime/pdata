#>pdata:_/join.1

item modify entity @s container.0 pdata:_/player_head
data modify storage pdata:var join.entry.username set from entity @s Item.components."minecraft:profile".name

kill @s