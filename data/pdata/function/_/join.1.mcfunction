#>pdata:_/join.1

setblock ~ ~ ~ barrel{Items:[]}
loot replace block ~ ~ ~ container.0 loot pdata:_/player_head
data modify storage pdata:var join.entry.username set from block ~ ~ ~ Items[0].components."minecraft:profile".name