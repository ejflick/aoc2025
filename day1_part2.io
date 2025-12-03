turns := File with("inputs/day1") do(
    openForReading
) readLines map(
    asMutable replaceSeq("L", "-") replaceSeq("R", "") asNumber
) atInsert(0, 50)

dial := 0
passedZero := 0
turns foreach(turn,
    sign := if(turn > 0, 1, -1)
    for(click, sign, turn, sign,
        if((dial = (dial + sign) % 100) == 0, passedZero = passedZero + 1)
    )
)

passedZero println