/* First version: */

runningTotal := 50
timesHitZero := 0

File with("inputs/day1") do(openForReading) readLines map(
    /* Convert to mutable so we can replace L/R with +/- */
    asMutable replaceSeq("L", "-") replaceSeq("R", "") asNumber
) foreach (
    num,
    if((runningTotal = (runningTotal + num) % 100) == 0, timesHitZero = timesHitZero + 1)
)

timesHitZero println

/* Second version: */
runningTotal := 0
File with("inputs/day1") do(openForReading) readLines map(
    asMutable replaceSeq("L", "-") replaceSeq("R", "") asNumber
) atInsert(0, 50) map(num,
    runningTotal = (runningTotal + num) % 100
) select(== 0) size println

/* Third version: */
