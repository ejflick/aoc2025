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

"Part 1: " print
contents slice(blankLine + 1) select (id,
    freshIdRanges containsId(id asNumber)
) size println

Range := Object clone do(
    start := 0
    end := 0
)

Range overlaps := method(other,
    (end >= other start and end <= other end) or (
        other end >= start and other end <= end
    )
)

Range asString := method(
    "[#{start}, #{end}]" interpolate
)

Range combine := method(other,
    start min(other start) toInclusive(end max(other end))
)

Number toInclusive := method(end,
    r := Range clone
    r start := self
    r end := end
    r
)

ranges := freshIdRanges map(r, r at(0) toInclusive(r at(1)))
ranges sortInPlaceBy(block(a, b, a start < b start))

combined := list()
curr := ranges first
idx := 1
loop(
    if(idx == ranges size,
        combined push(curr)
        break)

    if(curr overlaps(ranges at(idx)),
        curr = curr combine(ranges at(idx)),
        combined push(curr)
        curr = ranges at(idx)
    )
    idx = idx + 1
)

combined map(r, r end - (r start) + 1) sum negate asString exSlice(1) println