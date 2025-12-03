maxVoltage := method(bank, maxAmount,
    if(maxAmount == 0 or (bank size) == 0, return 0)

    max := bank at(0)
    maxIdx := 0

    for(i, maxIdx + 1, (bank size) - maxAmount,
        battery := bank at(i)
        if(battery > max,
            max = battery
            maxIdx = i
        )
    )

    (max * (10 pow(maxAmount - 1))) + maxVoltage(bank slice(maxIdx + 1), maxAmount - 1)
)

part2 := File with("inputs/day3") do(
    openForReading
) readLines map(
    asList map(asNumber)
) map(bank, maxVoltage(bank, 12)) sum

part2 println
