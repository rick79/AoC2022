#=
--- Day 12: Hill Climbing Algorithm ---

You try contacting the Elves using your handheld device, but the river you're following must be too low to get a decent signal.

You ask the device for a heightmap of the surrounding area (your puzzle input). The heightmap shows the local area from above broken into a grid; the elevation of each square of the grid is given by a single lowercase letter, where a is the lowest elevation, b is the next-lowest, and so on up to the highest elevation, z.

Also included on the heightmap are marks for your current position (S) and the location that should get the best signal (E). Your current position (S) has elevation a, and the location that should get the best signal (E) has elevation z.

You'd like to reach E, but to save energy, you should do it in as few steps as possible. During each step, you can move exactly one square up, down, left, or right. To avoid needing to get out your climbing gear, the elevation of the destination square can be at most one higher than the elevation of your current square; that is, if your current elevation is m, you could step to elevation n, but not to elevation o. (This also means that the elevation of the destination square can be much lower than the elevation of your current square.)

For example:

Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
Here, you start in the top-left corner; your goal is near the middle. You could start by moving down or right, but eventually you'll need to head toward the e at the bottom. From there, you can spiral around to the goal:

v..v<<<<
>v.vv<<^
.>vv>E^^
..v>>>^^
..>>>>>^
In the above diagram, the symbols indicate whether the path exits each square moving up (^), down (v), left (<), or right (>). The location that should get the best signal is still E, and . marks unvisited squares.

This path reaches the goal in 31 steps, the fewest possible.

What is the fewest steps required to move from your current position to the location that should get the best signal?

Your puzzle answer was 462.

--- Part Two ---

As you walk up the hill, you suspect that the Elves will want to turn this into a hiking trail. The beginning isn't very scenic, though; perhaps you can find a better starting point.

To maximize exercise while hiking, the trail should start as low as possible: elevation a. The goal is still the square marked E. However, the trail should still be direct, taking the fewest steps to reach its goal. So, you'll need to find the shortest path from any square at elevation a to the square marked E.

Again consider the example from above:

Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
Now, there are six choices for starting position (five marked a, plus the square marked S that counts as being at elevation a). If you start at the bottom-left square, you can reach the goal most quickly:

...v<<<<
...vv<<^
...v>E^^
.>v>>>^^
>^>>>>>^
This path reaches the goal in only 29 steps, the fewest possible.

What is the fewest steps required to move starting from any square with elevation a to the location that should get the best signal?

Your puzzle answer was 451.
=#

test = """Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi"""

data = """abcccccccccccccccccaaaaaaaaccccccacccaaccccccccccccccccccaaaaaaaaaacccccccccccccccccccccccccccccccaaaaaaccccccccccccccccccccccccccccccccccaaaaa
abccccccccccccccccccaaaaacccccccaaaaaaacccccccccccaaccaaaaaaaaaaaaaccccccccccccccccccccccccccccccccaaaaacccccccccccccccccccccccccccccccccaaaaaa
abccccccccccccaaccccaaaaaacccccccaaaaaaaaccccccacaaaccaaaaaaaaaaaaaaaccccccccccccccccccaaacccccccaaaaaaaccccccccccccccccaaaccccccccccccccaaaaaa
abccccccccacccaaccccaaaaaacccccccaaaaaaaaaccccaaaaaaaaacaaaaaaaaaaaaacccccccccccccccccccaacccccccaaaaaaaacccccccccccccccaaaccccccccccccccaccaaa
abaacccccaaaaaaaccccaaaccacccccccaaaaaaaaaccccaaaaaaaaccccaaaaaaaaaaaccccccccccccccccaacaaaaaccccaaaaaaaacccccccccccccccaaacccccccccccccccccaaa
abaaccccccaaaaaaaacccccccccccccccaaaaaaaaccccccaaaaaacccccaaaacaaaaccccccccccccccccccaaaaaaaaccccccaaacaccccccccccccccccaaakccaaaccccccccccccaa
abaaacccccaaaaaaaaaccccccccccccccaaaaaaacccccccaaaaaccccccaaaccaaaaccccccccccccaacacccaaaaaccccccccaaacccccccccccccacacckkkkkkkaacccccccccccccc
abaaacccccaaaaaaaaaccccccccccccccaccaaaaaccccccaaaaaacccccaaacaaaccccccccccccccaaaaccccaaaaacccccccccccccccccccccccaaaakkkkkkkkkacccaaaccaccccc
abacacccccaaaaaaaccccccccccccccccccccaaaaaaaccccccaaccccccaaaaaaaaccccccccccccaaaaacccaaacaacccccccccccccccccccccccaajkkkkppkkkkccccaaaaaaccccc
abacccccccaaaaaaacccccccccccccccccccaaaaaaaaccccccccccccccccaaaaaaccccccccccccaaaaaacccaacccccccccccccccccccccccccccjjkkooppppkllccccaaaaaccccc
abccccccccaccaaaccccccccccccccccccccaaaaaaaacccccccccccccccccaaaaaccccccccccccacaaaacccccccccccccccccccccccccccccjjjjjjoooppppklllcacaaaaaccccc
abcccaacccccccaaacccccccccccccccccccaaaaaaacccccccccccccccccaaaaacccccccccccccccaacaccccccccccccccccccccccccccjjjjjjjjoooopuppplllcccccaaaacccc
abcccaacccccccccccccccccaaacccccccccccaaaaaaccccccaaaaacccccaaaaaccccccccccccaaacaaacccccaaaccccccccccccccccijjjjjjjjooouuuuuppllllcccccaaacccc
abaaaaaaaaccccccccccccccaaaaccccccccccaacaaaccccccaaaaaccccccccccccccccccccccaaaaaaacccccaaacacccccccccccccciijjoooooooouuuuuppplllllccccaccccc
abaaaaaaaaccccccccccccccaaaaccccccccccaacccccccccaaaaaacccccccccccccccccccccccaaaaaacccaaaaaaaacccccccccccciiiqqooooooouuuxuuuppplllllccccccccc
abccaaaaccccccccccccccccaaaccccccccccccccccccccccaaaaaacccccccccccccccccccccccaaaaaaaccaaaaaaaacccccccccccciiiqqqqtttuuuuxxxuupppqqllllmccccccc
abcaaaaacccaaaccccccccccccccccccccccccaccccccccccaaaaaacccccccccccccccccccccaaaaaaaaaaccaaaaaaccccccccccccciiiqqqtttttuuuxxxuuvpqqqqmmmmccccccc
abcaacaaaccaaacaaccccccccccccccccccccaaaacaaaccccccaacccaaaaacccccccccccccccaaaaaaaaaacccaaaaacccaaaccccccciiiqqttttxxxxxxxyuvvvvqqqqmmmmcccccc
abcacccaaccaaaaaaccccccccccccccccccccaaaaaaaacccccccccccaaaaacccccccccccccccaaacaaacccccaaaaaaccaaaacccccaaiiiqqtttxxxxxxxxyyvvvvvvqqqmmmdddccc
abcccccccaaaaaaaccccccccccccccccccccccaaaaaaaaacccccccccaaaaaaccccccccccccccccccaaaccccccaacccccaaaacccaaaaiiiqqqttxxxxxxxyyyyyyvvvqqqmmmdddccc
SbccccccccaaaaaccccccccaacaaccccccccaaaaaaaaaaccccccccccaaaaaaccccccccccccaaacccaaccccccccccccccaaaacccaaaaaiiiqqtttxxxxEzzyyyyvvvvqqqmmmdddccc
abaccccccccaaaaacccccccaaaaacccccccaaaaaaaaaaaccccccccccaaaaaaccccccccccaaaaaacccccccccccccccccccccccccaaaaaiiiqqqtttxxxyyyyyyvvvvqqqmmmdddcccc
abaacccccccaacaaaccccccaaaaaacccccccaaaaaaaaaaccccccccccccaaacccccccccccaaaaaaccccccccccccccccccccccccccaaaahhhqqqqttxxyyyyyyvvvvqqqmmmddddcccc
abaccccccccaaccccccccccaaaaaacccaacaaccaaaaaaaaaccccccccccccccccccccccccaaaaaaccccccccccccccccccccccccccaaaachhhqqtttxwyyyyyywvrqqqmmmmdddccccc
abaaaccccccccccccccccccaaaaaacccaaaaaccaaaaacaaaccccccccccccccccccccccccaaaaaccccaaaaccccaaaccccccccccccccccchhhppttwwwywwyyywwrrrnmmmdddcccccc
abaaaccccccccccccccccccccaaaccccaaaaaacaaaaaaaaaccccccccaaacccccccccccccaaaaaccccaaaaccccaaaccccccccccccccccchhpppsswwwwwwwwywwrrrnnndddccccccc
abaaacccccccccccccccccccccccccccaaaaaacccaaaaaacccccccccaaaaacccccaacccccccccccccaaaacaaaaaaaaccccccccccccccchhpppsswwwwsswwwwwrrrnneeddccccccc
abaccccccccaaaacccccccccccccccccaaaaaaccccaaaaaaaacccccaaaaaaccaacaaacccccccccccccaaccaaaaaaaaccccccccccccccchhpppssssssssrwwwwrrrnneeecaaccccc
abaccccccccaaaacccccccccccccccccccaaaccccaaaaaaaaacccccaaaaaaccaaaaaccccccccccccccccccccaaaaacccccccccccccccchhpppssssssssrrrwrrrnnneeeaaaccccc
abcccccccccaaaacccccccccccccccccccccccccaaaaaaaaaaccccccaaaaacccaaaaaacccccccccccccccccaaaaaacccccccccccccccchhpppppsssooorrrrrrrnnneeeaaaccccc
abcccccccccaaaccccccccccccccccccccccccccaaacaaacccccccccaacaacaaaaaaaacccccccccccccccccaaaaaacaaccccccccccccchhhppppppoooooorrrrnnneeeaaaaacccc
abccccccccccccccccccccccccccccccccccccccccccaaaccaaaacccccccccaaaaacaaccccaacccccccccacaaaaaacaaccccccccccccchhhgpppppoooooooonnnnneeeaaaaacccc
abcccccccaacccccccccccccccccccccccccccccccccaaacaaaaaccccccccccacaaaccccccaacccccccccaacaaaaaaaaaaacccccaaccccgggggggggggfooooonnneeeeaaaaacccc
abcccccccaaacaaccccccccccccaacccccccccccccccccccaaaaaaccccaacccccaaacccaaaaaaaaccccccaaaaacaaaaaaaaccccaaacccccggggggggggfffooonneeeecaaacccccc
abcccccccaaaaaaccccaacccccaaacccccccccccccccccccaaaaaaccccaaaccccccccccaaaaaaaacccccccaaaaaccaaaaccccaaaaaaaacccggggggggfffffffffeeeecaaccccccc
abcccccaaaaaaaccaaaaacaaaaaaacccccccccccccccccccaaaaacccccaaaacccaaccccccaaaacccccccaaaaaaaacaaaaacccaaaaaaaaccccccccccaaaffffffffecccccccccccc
abcaaacaaaaaaacccaaaaaaaaaaaaaaaccccccccccccccccccaaacccccaaaacaaaacaacccaaaaaccccccaaaaaaaaaaaaaaccccaaaaaacccccccccccaaacaafffffccccccccccaaa
abaaaacccaaaaaaccaaaaacaaaaaaaaaccccccccccccaaacccccccccccaaaaaaaaacaaccaaacaacccccccccaacccaaccaaccccaaaaaaccccccccccaaaaccaaacccccccccccccaaa
abaaaacccaacaaacaaaaacccaaaaaaacccccccccccccaaaacccccccccaaaaaaaaaaaaaccaacccacccccccccaacccccccccccccaaaaaaccccccccccaaacccccccccccccccccccaaa
abcaaacccaacccccccaaaccaaaaaacccccccccccccccaaaaccccccaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccaaccaaccccccccccaaaccccccccccccccccaaaaaa
abcccccccccccccccccccccaaaaaaaccccccccccccccaaacccccccaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa"""

function print_hightmap(heightmap::Array{Char, 2})
    for y ∈ axes(heightmap, 1)
        for x ∈ axes(heightmap, 2)
            print(heightmap[y, x])
        end
        println()
    end
    return nothing
end

function get_location(heightmap::Array{Char, 2}, target::Char)
    for y ∈ axes(heightmap, 1)
        for x ∈ axes(heightmap, 2)
            if heightmap[y, x] == target
                return (y, x)
            end
        end
    end
    return nothing
end

function get_heightmap(input::String)
    lines = split(input, "\n")
    heightmap = fill('a', length(lines), length(lines[1]))
    for y ∈ axes(heightmap, 1)
        for x ∈ axes(heightmap, 2)
            heightmap[y, x] = lines[y][x]
        end
    end
    return heightmap
end

function solve(heightmap::Array{Char, 2}, start::Tuple{Int64, Int64}, stop::Tuple{Int64, Int64})
    ly = last(axes(heightmap, 1))
    lx = last(axes(heightmap, 2))
    que = Array{Tuple{Int64, Int64, Int64}, 1}()
    visited = Array{Tuple{Int64, Int64}, 1}()
    push!(que, (start[1], start[2], 0))
    while length(que) > 0
        (y, x, d) = popfirst!(que)
        ((y, x) == stop) && return d
        for (Δy, Δx)  ∈ [(-1, 0), (0, -1), (0, 1), (1, 0)]
            ((y + Δy)  < 1 || (y + Δy) > ly || (x + Δx) < 1 || (x + Δx) > lx) && continue
            (heightmap[y + Δy, x + Δx] > (heightmap[y, x]  + 1)) && continue
            ((y + Δy, x + Δx) ∈ visited) && continue
            push!(visited, (y + Δy, x + Δx))
            push!(que, (y + Δy, x + Δx, d + 1))
        end
    end
end

hmap = get_heightmap(data)
start = get_location(hmap, 'S')
stop = get_location(hmap, 'E')
hmap[start[1], start[2]] = 'a'
hmap[stop[1], stop[2]] = 'z'

function part_one(hmap::Array{Char, 2}, start::Tuple{Int64, Int64}, stop::Tuple{Int64, Int64})
    println("Part One: ", solve(hmap, start, stop))
end

part_one(hmap, start, stop)

function part_two(hmap::Array{Char, 2}, stop::Tuple{Int64, Int64})
    println(string("Part Two: ", minimum(filter(f -> !isnothing(f), map(x -> solve(hmap, (x[1], x[2]), stop), findall(x -> x == 'a', hmap))))))
end

part_two(hmap, stop)
