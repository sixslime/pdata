
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
- The player is 'assigned' the index of the new element.

Reading/writing custom player data is then as simple as reading/writing from the Player Array, given a player's index/information. \
*PlayerData provides shorthand API functions to make this even easier.*

PlayerData's integrity is unnaffected by player name changes and will automatically update the Player Array to reflect a player's new username.
# Preface
NBT storage locations will be referred to in this format: `foo:bar -> baz`. \
*Such that the command to get this data would be `/data get storage foo:bar baz`.*
# Usage

#### Player Array Location:
The Player Array is stored in `pdata:data -> players`.

### Player Registration

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

### Interfacing with The Player Array

Data that your datapack defines/attaches to a player must be stored in `pdata:data -> players[<player's index>].storage.<namespace>`, where `<namespace>` is your datapack's namespace. 

Other than that, there are a few simple but very important rules when interfacing with PlayerData:
- A player's `pdata-index` score must not be changed.
- All keys except for `storage` must not be changed (for all elements of the Player Array).
- The order of elements in the Player Array must not be changed.

Whether or not a particular value in `storage.<some namespace>` should be read/changed is to be defined by `some namespace`'s datapack.

### Provided Shorthands
PlayerData provides a few shorthand functions to make interacting with the Player Array smoother:

#### By Index:

**Getting Data**: `pdata:api/index/get` takes a single input: `pdata:in -> get.index` and is effectively shorthand for:
```mcfunction
data modify storage pdata:out get.result set from storage pdata:data players[<get.index>]
```

**Setting Data**: `pdata:api/index/set` takes 2 inputs: `pdata:in -> set.index` and `pdata:in -> set.storage`, and is effectively shorthand for:
```mcfunction
data modify storage pdata:data players[<get.index>].storage set from storage pdata:in set.storage
```

*It is worth noting: \
while setting the `index` input to a numerical index is by far the most performant, any array indexer (such as `{UUID:<a player's UUID>}`) works, as long as it yields a single result.*

#### By Entity Context:

You can call `pdata:api/self/get` and `pdata:api/self/set` as shorthand for calling their `pdata:api/index/...` counterparts with the executing player's `pdata-index` score as the `index` input.

#### A WORD OF CAUTION:
When using `pdata:api/index/set` or `pdata:api/self/set`, notice that they do not merge, they **overwrite the entirety** of `storage` with `pdata:in -> set.storage`.

This is to support the following workflow:
1) Call a `get` shorthand (retrieving a player's entire `storage`).
2) Change the result in some way.
3) Call a `set` shorthand with the modified result as input.


___

<p align="center">
  <img src="https://sixslime.github.io/info/logos/temporary_documentation.svg" width="75%" alt="Temporary Documentation Tag"/>
</p>
