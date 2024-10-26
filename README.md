
# PlayerData | pdata
> Dead-simple framework for registering players and storing custom player data.

## Dependencies
- [load](https://github.com/sixslime/load)
- [six](https://github.com/sixslime/six)
- [varchunk](https://github.com/sixslime/varchunk)
- [loggr](https://github.com/sixslime/loggr) (optional)

# Overview
PlayerData provides the 'Player Array'.

Every time a new unique player joins the world:
- A new element is created in the Player Array containing:
    - The player's UUID.
    - The player's username.
    - The player's hex-UUID as a string.
    - A location for arbitrary data.
- The player is "assigned" the index of the new element.

Reading/writing custom player data is then as simple as reading/writing from the Player Array, given a player's index/information. \
*PlayerData provides shorthand API functions to make this even easier.*

PlayerData's integrity is unnaffected by player name changes and will automatically update the Player Array to reflect a player's new username.
# Usage
NBT storage paths will be referred to in this format: `foo:bar -> baz`. \
*Such that the command to get this data would be `/data get storage foo:bar baz`.*

The Player Array refers to `pdata:data -> players`.

## Player Registration

When a player that has never joined before joins the world, an element is added to the Player Array with the following keys:
| NBT path | Type | Contains |
|--|--|--|
| `index` | int | The numerical index of this element in the Player Array. |
| `UUID` | UUID | The player's UUID. |
| `guuid` | string (hex-UUID) | the player's hex-UUID. |
| `username` | string | The player's username. |
| `storage` | object | The player's "custom" data (Initialized as `{}`). |

The player's `pdata-index` score is also set to their element's index in the Player Array. \
*Such that `players[<pdata-index>]` is their designated element in the Player Array.*

`username` keys and players' `pdata-index` score will *always* be accurate, even through name changes.

## Interfacing with The Player Array

Data that your datapack defines/attaches to a player must be stored in `pdata:data -> players[<player's index>].storage.<namespace>`, where `<namespace>` is your datapack's namespace. 

Other than that, there are a few simple but very important rules when interfacing with PlayerData:
- A player's `pdata-index` score must not be changed.
- All keys except for `storage` must not be changed (for all elements of the Player Array).
- The order of elements in the Player Array must not be changed.

Whether or not a particular value in `storage.<some namespace>` should be read/changed is to be defined by `some namespace`'s datapack.

## Shorthands
PlayerData provides shorthand functions to make interactions with the Player Array more convenient. \
*These shorthands are not essential for proper usage.*

### Get/Set by Index
**Get Data**: `pdata:api/index/get` takes a single input: `pdata:in -> get.index` and is effectively shorthand for:
```mcfunction
data modify storage pdata:out get.result set from storage pdata:data players[<get.index>]
```
**Set Data**: `pdata:api/index/set` takes 2 inputs: `pdata:in -> set.index` and `pdata:in -> set.storage`, and is effectively shorthand for:
```mcfunction
data modify storage pdata:data players[<get.index>].storage set from storage pdata:in set.storage
```

While setting the `index` input to a numerical index is by far the most performant, any array indexer (such as `{UUID:<a player's UUID>}`) works.

### Get/Set by @s Context
You can call `pdata:api/self/get` and `pdata:api/self/set` as shorthand for calling the `pdata:api/index/...` counterpart with the executing player's `pdata-index` score as the `index` input.

### NOTICE:
'Set' shorthands do not merge, they **overwrite the entirety** of `storage` with `pdata:in -> set.storage`.

This is to support the following workflow:
1) Call a 'get' shorthand (retrieving a player's entire `storage`).
2) Modify the result.
3) Call a 'set' shorthand with the modified result as input.

# Examples

Standard usage with 'self' shorthands:
```mcfunction
# get this player's data:
function pdata:api/self/get
# it's best practice to move output data out of it's 'out' variable before changing it.
data modify storage mypack:var player_entry set from storage pdata:out get.result

# sets this player's 'mypack.foo' value to "bar":
data modify storage mypack:var player_entry.storage.mypack.foo set value "bar"

# write the updated 'storage' back to the Player Array:
data modify storage pdata:in set.storage set from storage mypack:var player_entry.storage
function pdata:api/self/set
```

The same procedure as above, but via 'index' shorthands with the player's UUID:
```mcfunction
# assume the target player's UUID is stored in 'mypack:var -> target_UUID'
# get the target player's data:
data modify storage pdata:in get.index.UUID set from storage mypack:var target_UUID
function pdata:api/index/get

data modify storage mypack:var player_entry set from storage pdata:out get.result

# sets this player's 'mypack.foo' value to "bar":
data modify storage mypack:var player_entry.storage.mypack.foo set value "bar"

# write the updated 'storage' back to the Player Array:
# because we have the player's entry, we can use their index instead of UUID for optimal performance.
data modify storage pdata:in set.index set from storage mypack:var player_entry.index
data modify storage pdata:in set.storage set from storage mypack:var player_entry.storage
function pdata:api/index/set
```

Direct array access use case:
```mcfunction
# change all players' 'mypack.foo' value to "BAZ" if it is already equal to "bar":
# it would be cumbersome to try and use shorthands for this one-line operation.
data get storage pdata:data players[{storage:{mypack:{foo:"bar"}}}].storage.mypack.foo set value "BAZ"
```
___

<p align="center">
  <img src="https://sixslime.github.io/info/logos/temporary_documentation.svg" width="75%" alt="Temporary Documentation Tag"/>
</p>
