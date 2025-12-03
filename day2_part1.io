File with("inputs/day2") do(
    openForReading
) readToEnd split(",") map(split("-")) map(
    range,
    r := list()
    for(i, range at(0) asNumber, range at(1) asNumber,
        r push(i)
    )
    r
) flatten select(
    num,
    n := num asString
    if(n size isOdd,
        false,
        halfNSize := (n size)/2
        n exSlice(0, halfNSize) == (n exSlice(halfNSize, n size))
    )
) map(asNumber)