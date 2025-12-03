File with("inputs/day3") do(
    openForReading
) readLines map(line,
    bank := line asList map(asNumber)
    max := bank at(0)
    maxIdx := 0
    for(i, 1, (bank size) - 2,
        battery := bank at(i)
        if(battery > max,
            max = battery
            maxIdx = i)
    )

    maxAfterMax := bank at(maxIdx + 1)
    for(i, maxIdx + 2, (bank size) - 1,
        battery := bank at(i)
        if(battery > maxAfterMax, maxAfterMax = battery)
    )

    (max * 10) + maxAfterMax
) sum println
