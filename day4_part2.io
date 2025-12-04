Empty := Object clone
Roll := Object clone

Board := Object clone do(
    cells ::= list()
)

Board outOfBounds := method(x, y,
    cells size == 0 or x < 0 or x >= cells size or y < 0 or y >= cells size
)

Board cellAt := method(x, y,
    if(outOfBounds(x, y),
        return Empty,
        if(cells at(y) at(x) asCharacter == "@", Roll, Empty)
    )
)

Board neighbors := method(x, y,
    list(cellAt(x - 1, y - 1), cellAt(x, y - 1), cellAt(x + 1, y - 1),
         cellAt(x - 1, y), cellAt(x + 1, y),
         cellAt(x - 1, y + 1), cellAt(x, y + 1), cellAt(x + 1, y + 1))
)

Board isAccessible := method(x, y,
    cellAt(x, y) == Roll and neighbors(x, y) select(== Roll) size < 4
)

Board accessible := method(
    if(getSlot("cachedAccessible"), cachedAccessible)

    positions := list()

    cells foreach(y, row,
        row foreach(x, cell,
            if(isAccessible(x, y), positions push(list(x, y)))
        )
    )

    setSlot("cachedAccessible", positions)
)

Board withAccessibleRemoved := method(
    modifiedCells := cells map(asMutable)

    accessible foreach(pos,
        modifiedCells at(pos at(1)) atPut(pos at(0), 46) # 46 = '.' character
    )

    Board fromInput(modifiedCells)
)

Board fromInput := method(input,
    b := Board clone
    b cells = input
    b
)

b := Board fromInput(
    File with("inputs/day4") do(
        openForReading
    ) readLines
)


prevSize := b accessible size
currentBoard := b
total := prevSize
loop(
    nextBoard := currentBoard withAccessibleRemoved
    nextSize := nextBoard accessible size
    if(currentBoard cells == nextBoard cells,  break)

    total = total + nextSize
    prevSize = nextSize
    currentBoard = nextBoard
)

total println
