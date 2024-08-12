#>pdata:_/register
#--------------------
# ./join
#--------------------

data modify storage pdata:var join.entry set value {index:0, UUID:[], guuid:"", username:"", storage:{}}
execute store result storage pdata:var join.entry.index int 1 if data storage pdata:data players[]
data modify storage pdata:var join.entry.UUID set from storage pdata:var join.UUID

data modify storage six:in guuid.UUID set from storage pdata:var join.entry.UUID
function six:api/uuid/guuid

data modify storage pdata:var join.entry.guuid set from storage six:out guuid.result
data modify storage pdata:data players append from storage pdata:var join.entry

data remove storage pdata:var register