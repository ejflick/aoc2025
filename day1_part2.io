# This doesn't compute the correct answer.

Number sign := method(
    if(self < 0, -1, 1)
)

dial := 50
File with("inputs/day1_test_2") do(openForReading) readLines map(
    asMutable replaceSeq("L", "-") replaceSeq("R", "") asNumber
) reduce(
    passedZero, turns,
    dial = dial + turns
    if(dial < 0 or dial > 99) then(
        correction := (dial sign) * 100
        while(dial < 0 or dial > 99,
            dial = dial - correction
            passedZero = passedZero + 1
        )
    )
    passedZero
    , 0
) println
