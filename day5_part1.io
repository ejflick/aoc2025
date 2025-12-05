/* First attempt at this was too slow :(. Was creating a list of all ids
   that are fresh. I didn't look at the input beforehand and thus didn't
   notice the huge ranges. */

contents := File with("inputs/day5") do(openForReading) readLines
blankLine := contents indexOf("")
freshIdRanges := contents slice(0, blankLine) map(
    split("-") map(asNumber)
) sort(a, b, a at(0) < b at(0))

freshIdRanges containsId := method(id,
    foreach(range, if(id between(range at(0), range at(1) + 1), return true))

    false
)

contents slice(blankLine + 1) select (id,
    freshIdRanges containsId(id asNumber)
) size println