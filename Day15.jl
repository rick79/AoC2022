
test = """
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3"""

data="""Sensor at x=13820, y=3995710: closest beacon is at x=1532002, y=3577287
Sensor at x=3286002, y=2959504: closest beacon is at x=3931431, y=2926694
Sensor at x=3654160, y=2649422: closest beacon is at x=3702627, y=2598480
Sensor at x=3702414, y=2602790: closest beacon is at x=3702627, y=2598480
Sensor at x=375280, y=2377181: closest beacon is at x=2120140, y=2591883
Sensor at x=3875726, y=2708666: closest beacon is at x=3931431, y=2926694
Sensor at x=3786107, y=2547075: closest beacon is at x=3702627, y=2598480
Sensor at x=2334266, y=3754737: closest beacon is at x=2707879, y=3424224
Sensor at x=1613400, y=1057722: closest beacon is at x=1686376, y=-104303
Sensor at x=3305964, y=2380628: closest beacon is at x=3702627, y=2598480
Sensor at x=1744420, y=3927424: closest beacon is at x=1532002, y=3577287
Sensor at x=3696849, y=2604845: closest beacon is at x=3702627, y=2598480
Sensor at x=2357787, y=401688: closest beacon is at x=1686376, y=-104303
Sensor at x=2127900, y=1984887: closest beacon is at x=2332340, y=2000000
Sensor at x=3705551, y=2604421: closest beacon is at x=3702627, y=2598480
Sensor at x=1783014, y=2978242: closest beacon is at x=2120140, y=2591883
Sensor at x=2536648, y=2910642: closest beacon is at x=2707879, y=3424224
Sensor at x=3999189, y=2989409: closest beacon is at x=3931431, y=2926694
Sensor at x=3939169, y=2382534: closest beacon is at x=3702627, y=2598480
Sensor at x=2792378, y=2002602: closest beacon is at x=2332340, y=2000000
Sensor at x=3520934, y=3617637: closest beacon is at x=2707879, y=3424224
Sensor at x=2614525, y=1628105: closest beacon is at x=2332340, y=2000000
Sensor at x=2828931, y=3996545: closest beacon is at x=2707879, y=3424224
Sensor at x=2184699, y=2161391: closest beacon is at x=2332340, y=2000000
Sensor at x=2272873, y=1816621: closest beacon is at x=2332340, y=2000000
Sensor at x=1630899, y=3675405: closest beacon is at x=1532002, y=3577287
Sensor at x=3683190, y=2619409: closest beacon is at x=3702627, y=2598480
Sensor at x=180960, y=185390: closest beacon is at x=187063, y=-1440697
Sensor at x=1528472, y=3321640: closest beacon is at x=1532002, y=3577287
Sensor at x=3993470, y=2905566: closest beacon is at x=3931431, y=2926694
Sensor at x=1684313, y=20931: closest beacon is at x=1686376, y=-104303
Sensor at x=2547761, y=2464195: closest beacon is at x=2120140, y=2591883
Sensor at x=3711518, y=845968: closest beacon is at x=3702627, y=2598480
Sensor at x=3925049, y=2897039: closest beacon is at x=3931431, y=2926694
Sensor at x=1590740, y=3586256: closest beacon is at x=1532002, y=3577287
Sensor at x=1033496, y=3762565: closest beacon is at x=1532002, y=3577287"""

#=
        id = parse(Int64, match(r"((?<=Monkey )(.*)(?=:))", input)[1])
        iftrue = parse(Int64, match(r"((?<=If true: throw to monkey )(.*))", input)[1])
        iffalse = parse(Int64, match(r"((?<=If false: throw to monkey )(.*))", input)[1])
        starting_items = map(x -> parse(Int64, x), split(match(r"(?<=Starting items: )(.*)", input)[1], ", "))
        ops = split(match(r"(?<=Operation: new = old )(.*)", input)[1], " ")
        divtest = parse(Int64, match(r"((?<=Test: divisible by )(.*))", input)[1])
=#

function bs_distance(y1::Int64, x1::Int64, y2::Int64, x2::Int64)
    return abs(y2 - y1) + abs(x2 - x1)
end

function read_data(data::String)
    list = Vector{NamedTuple{(:y, :x, :by, :bx, :d), Tuple{Int64, Int64, Int64, Int64, Int64}}}()
    ymin = typemax(Int64)
    ymax = -typemax(Int64)
    xmin = typemax(Int64)
    xmax = -typemax(Int64)
    for input ∈ eachsplit(data, "\n", keepempty = false)
        matches = match(r"(?<=Sensor at x=)(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)", input)
        sy = parse(Int64, matches[2])
        sx = parse(Int64, matches[1])
        by = parse(Int64, matches[4])
        bx = parse(Int64, matches[3])
        d = bs_distance(sy, sx, by, bx)
        push!(list, (y=sy, x=sx, by=by, bx=bx, d=d))
        ymin = minimum([sy-d, by-d, ymin])
        ymax = maximum([sy+d, by+d, ymax])
        xmin = minimum([sx-d, bx-d, xmin])
        xmax = maximum([sx+d, bx+d, xmax])
    end
    return (list, ymin, xmin, ymax, xmax)
end



function part_one(data::Vector{NamedTuple{(:y, :x, :by, :bx, :d), Tuple{Int64, Int64, Int64, Int64, Int64}}}, xmin::Int64, xmax::Int64, y::Int64)
    counter = 0
    for x in xmin:xmax
        xinr = false
        for sensor in data
            (sensor.bx == x && sensor.by == y) && continue
            d = bs_distance(sensor.y, sensor.x, y, x)
            if d <= sensor.d
                xinr = true
            end
        end
        if xinr
            counter += 1
        end
    end    
    println("Part One: $counter")
end

function part_two2(data::Vector{NamedTuple{(:y, :x, :by, :bx, :d), Tuple{Int64, Int64, Int64, Int64, Int64}}}, ymin::Int64, xmin::Int64, ymax::Int64, xmax::Int64)
    points = Vector{Tuple{Int64, Int64}}()
    tf = 0
    for sensor in data
        for i in 0:(sensor.d+1)
            push!(points, (sensor.y-i, sensor.x-sensor.d-1+i))
            push!(points, (sensor.y+i, sensor.x-sensor.d-1+i))
            push!(points, (sensor.y-i, sensor.x+sensor.d+1-i))
            push!(points, (sensor.y+i, sensor.x+sensor.d+1-i))
        end
    end
    for (y, x) in points
        if y < ymin || y > ymax || x < xmin || x > xmax
            continue
        end
        inr = false
        for sensor in data
            if sensor.bx == x && sensor.by == y
                inr = true
                continue
            end
            d = bs_distance(sensor.y, sensor.x, y, x)
            if d <= sensor.d
                inr = true
            end
        end
        if !inr
            tf = 4000000 * x + y
            #println("y=$y, x=$x, tf=$tf")
        end
    end
    println("Part Twp: $tf")
end

(data, ymin, xmin, ymax, xmax) = read_data(data)
part_one(data, xmin, xmax, 2000000)
part_two2(data, 0, 0, 4000000, 4000000)
