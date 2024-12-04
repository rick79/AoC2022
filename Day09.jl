#=
--- Day 9: Rope Bridge ---

This rope bridge creaks as you walk along it. You aren't sure how old it is, or whether 
it can even support your weight.

It seems to support the Elves just fine, though. The bridge spans a gorge which was 
carved out by the massive river far below you.

You step carefully; as you do, the ropes stretch and twist. You decide to distract 
yourself by modeling rope physics; maybe you can even figure out where not to step.

Consider a rope with a knot at each end; these knots mark the head and the tail of the 
rope. If the head moves far enough away from the tail, the tail is pulled toward the head.

Due to nebulous reasoning involving Planck lengths, you should be able to model the 
positions of the knots on a two-dimensional grid. Then, by following a hypothetical 
series of motions (your puzzle input) for the head, you can determine how the tail will 
    move.

Due to the aforementioned Planck lengths, the rope must be quite short; in fact, the 
head (H) and tail (T) must always be touching (diagonally adjacent and even overlapping 
both count as touching):

    ....
    .TH.
    ....

    ....
    .H..
    ..T.
    ....

    ...
    .H. (H covers T)
    ...

If the head is ever two steps directly up, down, left, or right from the tail, the tail 
must also move one step in that direction so it remains close enough:

    .....    .....    .....
    .TH.. -> .T.H. -> ..TH.
    .....    .....    .....

    ...    ...    ...
    .T.    .T.    ...
    .H. -> ... -> .T.
    ...    .H.    .H.
    ...    ...    ...

Otherwise, if the head and tail aren't touching and aren't in the same row or column, 
the tail always moves one step diagonally to keep up:

    .....    .....    .....
    .....    ..H..    ..H..
    ..H.. -> ..... -> ..T..
    .T...    .T...    .....
    .....    .....    .....

    .....    .....    .....
    .....    .....    .....
    ..H.. -> ...H. -> ..TH.
    .T...    .T...    .....
    .....    .....    .....

You just need to work out where the tail goes as the head follows a series of motions. 
Assume the head and the tail both start at the same position, overlapping.

For example:

    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2

This series of motions moves the head right four steps, then up four steps, then left 
three steps, then down one step, and so on. After each step, you'll need to update the 
position of the tail if the step means the head is no longer adjacent to the tail. 
Visually, these motions occur as follows (s marks the starting position as a reference 
point):

    == Initial State ==

    ......
    ......
    ......
    ......
    H.....  (H covers T, s)

    == R 4 ==

    ......
    ......
    ......
    ......
    TH....  (T covers s)

    ......
    ......
    ......
    ......
    sTH...

    ......
    ......
    ......
    ......
    s.TH..

    ......
    ......
    ......
    ......
    s..TH.

    == U 4 ==

    ......
    ......
    ......
    ....H.
    s..T..

    ......
    ......
    ....H.
    ....T.
    s.....

    ......
    ....H.
    ....T.
    ......
    s.....

    ....H.
    ....T.
    ......
    ......
    s.....

    == L 3 ==

    ...H..
    ....T.
    ......
    ......
    s.....

    ..HT..
    ......
    ......
    ......
    s.....

    .HT...
    ......
    ......
    ......
    s.....

    == D 1 ==

    ..T...
    .H....
    ......
    ......
    s.....

    == R 4 ==

    ..T...
    ..H...
    ......
    ......
    s.....

    ..T...
    ...H..
    ......
    ......
    s.....

    ......
    ...TH.
    ......
    ......
    s.....

    ......
    ....TH
    ......
    ......
    s.....

    == D 1 ==

    ......
    ....T.
    .....H
    ......
    s.....

    == L 5 ==

    ......
    ....T.
    ....H.
    ......
    s.....

    ......
    ....T.
    ...H..
    ......
    s.....

    ......
    ......
    ..HT..
    ......
    s.....

    ......
    ......
    .HT...
    ......
    s.....

    ......
    ......
    HT....
    ......
    s.....

    == R 2 ==

    ......
    ......
    .H....  (H covers T)
    ......
    s.....

    ......
    ......
    .TH...
    ......
    s.....

After simulating the rope, you can count up all of the positions the tail visited at 
least once. In this diagram, s again marks the starting position (which the tail also 
visited) and # marks other positions the tail visited:

    ..##..
    ...##.
    .####.
    ....#.
    s###..

So, there are 13 positions the tail visited at least once.

Simulate your complete hypothetical series of motions. How many positions does the tail 
of the rope visit at least once?

Your puzzle answer was 6269.

--- Part Two ---

A rope snaps! Suddenly, the river is getting a lot closer than you remember. The bridge is still there, but some of the ropes that broke are now whipping toward you as you fall through the air!

The ropes are moving too quickly to grab; you only have a few seconds to choose how to arch your body to avoid being hit. Fortunately, your simulation can be extended to support longer ropes.

Rather than two knots, you now must simulate a rope consisting of ten knots. One knot is still the head of the rope and moves according to the series of motions. Each knot further down the rope follows the knot in front of it using the same rules as before.

Using the same series of motions as the above example, but with the knots marked H, 1, 2, ..., 9, the motions now occur as follows:

== Initial State ==

......
......
......
......
H.....  (H covers 1, 2, 3, 4, 5, 6, 7, 8, 9, s)

== R 4 ==

......
......
......
......
1H....  (1 covers 2, 3, 4, 5, 6, 7, 8, 9, s)

......
......
......
......
21H...  (2 covers 3, 4, 5, 6, 7, 8, 9, s)

......
......
......
......
321H..  (3 covers 4, 5, 6, 7, 8, 9, s)

......
......
......
......
4321H.  (4 covers 5, 6, 7, 8, 9, s)

== U 4 ==

......
......
......
....H.
4321..  (4 covers 5, 6, 7, 8, 9, s)

......
......
....H.
.4321.
5.....  (5 covers 6, 7, 8, 9, s)

......
....H.
....1.
.432..
5.....  (5 covers 6, 7, 8, 9, s)

....H.
....1.
..432.
.5....
6.....  (6 covers 7, 8, 9, s)

== L 3 ==

...H..
....1.
..432.
.5....
6.....  (6 covers 7, 8, 9, s)

..H1..
...2..
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

.H1...
...2..
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

== D 1 ==

..1...
.H.2..
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

== R 4 ==

..1...
..H2..
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

..1...
...H..  (H covers 2)
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

......
...1H.  (1 covers 2)
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

......
...21H
..43..
.5....
6.....  (6 covers 7, 8, 9, s)

== D 1 ==

......
...21.
..43.H
.5....
6.....  (6 covers 7, 8, 9, s)

== L 5 ==

......
...21.
..43H.
.5....
6.....  (6 covers 7, 8, 9, s)

......
...21.
..4H..  (H covers 3)
.5....
6.....  (6 covers 7, 8, 9, s)

......
...2..
..H1..  (H covers 4; 1 covers 3)
.5....
6.....  (6 covers 7, 8, 9, s)

......
...2..
.H13..  (1 covers 4)
.5....
6.....  (6 covers 7, 8, 9, s)

......
......
H123..  (2 covers 4)
.5....
6.....  (6 covers 7, 8, 9, s)

== R 2 ==

......
......
.H23..  (H covers 1; 2 covers 4)
.5....
6.....  (6 covers 7, 8, 9, s)

......
......
.1H3..  (H covers 2, 4)
.5....
6.....  (6 covers 7, 8, 9, s)
Now, you need to keep track of the positions the new tail, 9, visits. In this example, the tail never moves, and so it only visits 1 position. However, be careful: more types of motion are possible than before, so you might want to visually compare your simulated rope to the one above.

Here's a larger example:

R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
These motions occur as follows (individual steps are not shown):

== Initial State ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
...........H..............  (H covers 1, 2, 3, 4, 5, 6, 7, 8, 9, s)
..........................
..........................
..........................
..........................
..........................

== R 5 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
...........54321H.........  (5 covers 6, 7, 8, 9, s)
..........................
..........................
..........................
..........................
..........................

== U 8 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
................H.........
................1.........
................2.........
................3.........
...............54.........
..............6...........
.............7............
............8.............
...........9..............  (9 covers s)
..........................
..........................
..........................
..........................
..........................

== L 8 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
........H1234.............
............5.............
............6.............
............7.............
............8.............
............9.............
..........................
..........................
...........s..............
..........................
..........................
..........................
..........................
..........................

== D 3 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
.........2345.............
........1...6.............
........H...7.............
............8.............
............9.............
..........................
..........................
...........s..............
..........................
..........................
..........................
..........................
..........................

== R 17 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
................987654321H
..........................
..........................
..........................
..........................
...........s..............
..........................
..........................
..........................
..........................
..........................

== D 10 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
...........s.........98765
.........................4
.........................3
.........................2
.........................1
.........................H

== L 25 ==

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
...........s..............
..........................
..........................
..........................
..........................
H123456789................

== U 20 ==

H.........................
1.........................
2.........................
3.........................
4.........................
5.........................
6.........................
7.........................
8.........................
9.........................
..........................
..........................
..........................
..........................
..........................
...........s..............
..........................
..........................
..........................
..........................
..........................

Now, the tail (9) visits 36 positions (including s) at least once:

..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
..........................
#.........................
#.............###.........
#............#...#........
.#..........#.....#.......
..#..........#.....#......
...#........#.......#.....
....#......s.........#....
.....#..............#.....
......#............#......
.......#..........#.......
........#........#........
.........########.........
Simulate your complete series of motions on a larger rope with ten knots. How many positions does the tail of the rope visit at least once?

Your puzzle answer was 2557.

=#


test = """R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2"""

test2 = """R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20"""

test3 = """R 9
R 9
"""

data = """L 1
R 1
D 1
R 2
D 2
L 1
D 1
L 2
R 1
L 1
U 1
D 2
R 1
D 2
R 1
L 2
D 1
U 1
L 2
U 1
D 1
U 1
D 2
L 2
D 2
L 1
D 2
R 2
L 1
D 2
R 2
D 2
R 1
L 2
U 1
R 2
U 2
D 1
R 2
U 1
R 2
L 2
U 1
L 2
D 2
L 1
U 1
R 2
U 1
R 2
U 1
R 2
U 2
L 1
U 2
L 2
R 2
L 2
R 2
L 1
D 1
L 1
U 1
R 2
L 1
R 2
L 1
R 1
L 2
R 2
D 1
L 2
R 1
L 2
R 1
D 2
U 2
D 1
R 2
L 2
D 2
U 1
R 2
U 2
D 2
R 2
D 1
R 2
D 2
R 1
D 2
R 1
D 2
U 1
R 2
U 2
R 2
L 1
U 2
L 1
R 1
U 1
R 1
L 1
U 1
D 2
L 1
D 2
U 1
R 1
D 2
U 1
D 3
R 1
L 3
U 3
L 2
U 3
D 2
U 2
D 2
U 2
D 1
L 1
D 1
U 1
D 2
U 2
R 3
D 1
L 1
D 1
R 1
U 2
R 2
D 2
R 2
U 2
R 2
L 3
R 2
D 1
R 3
U 1
L 3
U 3
L 2
R 3
D 2
L 3
D 1
L 2
U 3
L 2
U 3
D 2
L 3
R 3
U 3
D 2
U 3
D 3
U 2
D 2
U 2
D 3
L 1
R 2
U 1
L 1
R 1
U 1
D 2
R 2
U 3
L 1
D 2
R 3
D 1
U 2
R 1
L 2
R 2
U 2
R 2
D 1
L 3
U 3
L 2
D 1
U 3
R 3
D 1
U 3
L 1
D 2
U 1
D 1
L 3
R 1
L 1
U 3
L 2
U 1
R 1
U 3
L 2
U 1
L 2
D 2
L 2
U 3
D 2
L 1
U 3
L 2
U 2
D 3
L 3
U 1
D 2
R 2
D 1
U 3
R 4
U 2
D 2
L 2
U 2
L 1
R 2
D 2
U 1
D 2
R 1
U 4
R 1
U 2
D 2
U 2
D 1
L 1
R 2
D 3
U 1
D 3
R 2
L 4
U 4
L 4
U 3
D 1
R 2
L 3
D 4
U 3
D 3
U 2
D 2
U 2
D 1
U 3
D 1
L 4
U 2
L 2
U 1
R 1
L 3
R 4
L 1
U 1
L 1
D 1
L 2
U 4
R 1
D 3
U 3
L 1
U 1
D 4
L 1
D 3
U 2
L 4
U 2
R 2
U 1
R 1
L 3
R 1
D 4
U 3
L 1
U 2
L 1
D 3
R 3
U 4
R 4
D 4
L 3
U 4
L 3
D 2
R 2
D 3
U 1
D 1
R 2
D 2
L 2
R 2
D 4
U 4
L 2
D 3
L 4
R 2
U 1
D 4
L 2
D 1
U 3
L 2
R 4
U 1
R 2
U 3
L 3
D 4
R 2
L 2
D 4
U 1
R 3
U 3
D 5
L 4
D 3
U 4
R 5
L 3
R 1
D 1
R 4
L 1
D 5
L 4
R 2
U 1
D 2
R 4
U 5
R 4
D 2
R 4
D 4
R 2
L 4
R 4
U 2
D 1
L 4
R 4
U 3
D 2
L 5
R 4
L 2
R 2
D 3
U 3
D 3
L 4
D 2
U 2
L 4
R 1
D 2
L 4
U 2
L 4
U 2
D 2
L 2
R 4
D 4
U 3
L 1
R 4
L 4
R 5
D 2
R 2
U 1
D 4
L 2
U 3
R 1
L 3
R 4
L 2
R 3
U 1
R 5
U 2
L 4
R 2
D 4
U 3
R 2
L 4
D 4
U 4
D 2
U 5
L 5
U 1
D 5
L 1
R 1
L 2
D 2
U 1
R 3
U 3
L 3
D 1
R 5
D 5
L 3
R 3
D 2
L 1
D 2
L 3
U 1
R 5
U 2
R 3
L 2
U 1
D 4
L 1
D 2
U 4
D 3
U 6
L 3
D 4
R 6
U 4
L 3
D 2
L 1
U 1
D 6
R 4
L 1
D 4
L 3
U 2
L 2
R 2
L 1
D 2
U 2
L 5
U 6
L 1
D 3
U 1
L 1
U 6
D 4
R 6
D 2
R 3
L 2
D 3
U 1
D 4
U 1
D 4
R 3
L 3
R 2
L 1
R 6
L 5
R 3
D 2
L 6
R 4
D 1
R 4
L 6
R 1
U 5
D 2
U 4
R 6
D 5
U 5
R 6
L 5
D 4
U 3
L 6
U 3
R 5
U 1
L 6
D 1
U 6
L 1
R 4
L 3
R 6
D 2
L 1
U 4
D 4
L 1
U 6
L 6
U 5
L 6
R 5
L 5
R 2
U 6
R 1
U 2
D 6
U 3
D 4
U 4
L 6
U 6
R 4
D 5
L 2
D 5
R 1
L 2
D 6
U 6
L 6
U 1
R 4
L 5
D 6
L 6
U 7
D 4
L 4
R 2
U 5
L 7
R 3
D 6
R 1
L 2
R 2
U 5
R 5
D 3
L 4
U 2
L 6
R 2
U 3
D 2
R 7
L 3
D 6
L 4
R 1
D 7
R 4
U 3
L 4
D 5
L 4
D 2
L 5
U 4
R 6
D 2
L 4
U 4
L 3
R 7
L 6
U 1
D 5
L 6
D 3
L 7
D 5
L 1
R 1
D 7
U 6
L 4
D 6
U 7
L 7
D 6
L 4
R 4
U 5
D 4
U 2
R 4
U 4
L 2
D 6
U 6
L 5
R 7
L 4
R 7
L 4
U 5
D 3
L 6
R 1
D 2
U 4
L 3
D 1
R 2
U 2
D 4
L 6
U 7
D 1
R 1
L 4
R 1
D 6
U 6
R 2
D 7
R 2
D 2
U 3
L 5
U 5
L 4
D 2
R 2
U 5
R 1
D 7
L 6
D 1
R 1
L 2
D 3
R 7
L 2
U 2
D 4
R 6
U 2
R 4
U 2
R 1
L 3
R 7
U 2
R 7
L 4
U 4
R 4
L 4
D 3
U 1
L 5
D 8
L 7
R 7
D 2
U 1
L 5
R 5
L 2
D 1
U 6
R 3
U 2
R 7
L 7
U 7
D 3
R 6
U 2
L 7
U 7
R 4
D 6
R 4
U 4
D 4
R 1
U 4
R 1
U 2
D 6
L 2
D 1
L 6
D 2
U 3
D 4
U 8
R 5
U 8
R 1
D 7
L 5
U 4
D 2
U 6
D 4
L 8
D 5
R 1
U 6
L 8
R 7
D 1
U 5
D 8
R 3
U 3
D 2
L 3
U 3
R 4
D 7
U 2
D 2
L 4
R 6
L 6
D 2
R 5
D 4
U 7
D 6
U 3
L 8
D 3
R 7
U 3
R 5
D 1
U 6
D 8
L 7
D 5
L 6
R 5
L 4
R 7
L 8
D 5
U 5
R 8
L 6
D 7
R 9
U 7
L 8
D 6
U 2
D 2
R 9
D 2
L 5
R 3
U 6
R 6
L 7
R 5
D 3
R 7
D 1
L 1
U 5
D 2
R 6
D 4
R 2
U 1
L 9
D 8
R 2
U 3
D 6
L 3
D 3
R 5
L 1
U 5
L 6
R 4
L 4
U 3
L 6
D 5
L 9
D 7
R 9
U 1
R 7
U 2
D 8
L 6
U 1
L 2
U 3
D 1
L 3
U 7
L 3
R 3
D 2
L 4
U 3
R 6
L 5
R 3
U 5
R 6
L 7
D 8
L 8
D 6
U 4
R 5
U 2
D 9
L 1
R 1
D 9
U 2
L 8
U 1
L 3
D 2
L 6
U 7
D 7
U 9
R 1
D 1
U 4
L 1
U 5
L 7
U 2
D 4
U 3
R 6
D 3
L 9
D 5
U 3
D 1
L 4
U 2
R 6
L 1
R 6
D 1
L 3
U 8
R 2
U 9
D 3
L 8
R 5
U 6
R 8
L 2
D 5
L 1
U 7
R 1
L 7
D 2
R 8
U 5
D 5
L 9
D 6
R 10
D 3
R 2
D 6
L 7
D 8
R 1
D 4
R 9
L 5
D 7
U 2
R 3
L 4
D 7
U 5
D 5
L 9
U 6
D 7
U 5
D 8
R 3
U 3
D 3
R 10
D 2
U 7
D 2
U 2
R 2
U 8
L 9
U 5
D 1
U 5
D 8
R 4
D 2
R 1
U 9
L 2
D 9
R 5
L 10
R 1
U 2
L 3
D 8
U 8
L 3
U 4
R 2
L 6
R 10
D 5
U 6
L 10
D 3
U 2
L 2
R 9
U 5
R 2
L 3
R 4
L 1
D 4
L 8
R 3
D 4
U 5
R 8
D 3
L 5
D 1
U 8
R 4
U 4
L 9
R 3
L 10
D 1
L 10
D 7
L 3
R 8
L 7
R 8
D 4
R 5
U 2
D 6
U 4
D 4
U 9
L 6
D 3
R 9
U 2
R 9
U 10
R 1
D 5
L 9
R 1
U 5
R 3
D 7
U 5
D 7
L 7
D 9
R 11
D 2
R 5
U 1
D 5
U 4
R 6
L 10
D 2
R 2
U 4
L 2
R 7
U 11
R 5
D 9
L 4
D 11
U 8
L 8
D 10
R 4
L 5
D 5
L 1
D 3
L 6
U 9
D 11
R 10
D 6
R 10
U 4
L 1
U 1
R 7
D 6
R 6
D 5
U 11
R 8
D 7
U 10
L 4
U 8
R 11
L 4
R 9
D 3
L 10
U 9
L 8
U 3
D 3
R 1
L 11
U 1
D 7
L 7
D 8
L 11
D 6
L 7
U 6
D 11
R 9
U 11
L 9
U 2
D 1
L 1
D 2
L 6
R 4
D 7
U 8
R 11
D 9
L 8
D 7
U 3
R 7
D 11
L 3
U 5
L 3
D 6
U 2
L 1
R 2
D 7
R 10
L 1
U 1
R 8
D 5
R 3
L 3
D 7
R 10
U 1
R 8
L 7
U 5
R 2
U 10
L 6
R 8
D 1
U 12
R 3
L 6
D 2
R 12
L 5
R 8
D 12
R 8
D 4
R 3
U 10
D 8
R 7
U 3
D 8
U 5
L 12
U 10
D 6
R 5
L 3
R 8
U 2
R 5
L 3
U 7
R 2
L 4
U 12
R 6
L 1
U 3
L 4
U 6
R 7
U 12
L 5
R 8
D 1
U 5
L 10
D 8
R 5
L 10
D 1
R 5
D 8
U 2
L 8
D 11
R 4
U 11
D 10
U 9
D 8
R 9
U 10
D 12
L 3
D 1
U 11
R 10
L 6
R 4
U 3
R 4
L 1
U 12
D 10
L 1
R 9
L 3
D 10
L 12
U 4
D 6
R 5
U 11
D 5
L 8
R 9
L 4
R 11
D 6
L 1
U 10
R 7
U 4
D 2
L 3
R 12
U 7
D 7
U 2
L 11
R 8
U 4
R 1
U 13
L 8
R 2
D 6
U 2
R 2
U 2
L 6
U 7
D 6
R 7
D 7
L 3
R 5
L 1
U 9
R 7
U 4
L 7
D 9
L 10
R 13
L 11
D 8
R 10
L 12
U 12
R 5
U 3
L 1
R 10
D 13
L 1
R 9
L 3
U 11
L 1
D 4
L 1
R 7
D 12
R 11
U 5
D 12
L 5
D 7
R 7
L 12
U 8
D 7
U 5
R 13
L 10
R 7
D 4
U 8
L 10
R 8
L 6
R 5
D 13
L 7
U 8
D 12
R 10
L 4
D 7
U 4
L 11
R 3
L 6
R 6
D 3
R 11
L 10
R 8
U 5
R 4
U 5
R 10
L 4
D 3
U 8
R 11
D 12
R 9
L 11
R 9
L 9
R 5
U 13
R 2
U 4
D 12
R 9
L 10
D 4
L 2
D 13
L 3
D 11
U 10
D 10
U 13
L 2
U 1
L 9
U 10
L 12
U 14
R 8
U 10
D 6
R 13
D 10
L 6
U 3
R 8
L 1
R 2
D 14
U 11
L 4
D 11
R 14
U 7
R 1
D 5
U 12
R 8
D 11
R 14
U 3
R 8
U 5
L 13
D 5
L 8
R 1
L 12
D 5
R 8
L 4
D 1
R 6
L 14
R 1
U 11
R 4
D 12
L 10
R 7
D 4
U 1
L 3
U 13
R 1
D 13
U 2
R 9
D 1
L 5
R 8
U 2
D 9
L 5
D 4
L 3
D 11
L 3
R 14
D 9
R 2
U 3
D 10
L 4
D 14
L 12
R 5
D 14
L 3
U 1
D 13
U 6
R 3
L 9
R 7
U 8
R 9
D 9
U 8
D 3
R 4
D 5
U 14
L 5
D 12
L 1
R 3
D 6
R 10
U 5
R 4
D 3
L 12
D 13
L 13
D 8
L 3
D 13
L 1
R 9
D 2
L 5
U 13
R 3
D 14
R 8
L 3
U 10
L 6
R 2
L 1
U 15
R 2
D 11
R 3
L 11
D 13
L 5
D 2
U 11
L 5
D 6
U 3
R 7
U 14
R 9
D 5
R 2
L 15
U 13
D 14
L 14
U 8
L 14
D 15
R 7
U 6
D 3
U 7
D 10
L 4
R 8
L 13
U 10
D 2
U 7
D 14
R 2
L 6
R 13
L 6
D 10
U 9
D 14
U 5
D 6
R 4
L 3
R 1
L 3
D 9
U 14
R 2
D 15
L 3
D 11
L 4
U 13
D 14
U 12
D 8
R 11
U 14
R 15
D 8
L 3
D 10
L 10
U 14
D 13
L 7
D 8
U 12
L 3
D 6
L 8
R 1
L 5
R 15
L 1
D 5
U 4
R 11
L 14
D 7
L 9
U 5
R 7
D 4
R 13
L 15
U 5
L 3
R 6
D 13
L 11
U 9
R 6
D 2
R 5
D 11
R 2
U 11
R 14
L 11
U 3
L 4
R 14
D 7
R 10
U 6
R 14
D 8
R 15
D 3
U 9
L 14
R 7
L 14
R 7
U 13
L 12
U 7
R 9
D 7
L 2
D 13
U 8
D 14
U 4
R 7
L 3
R 7
U 7
R 15
D 13
U 4
L 15
D 12
U 11
L 16
D 16
L 12
U 4
D 3
R 11
U 2
L 4
U 6
R 3
D 4
R 1
D 16
U 6
D 7
L 9
U 5
R 3
L 5
R 2
U 3
L 8
R 13
U 10
D 1
L 15
D 1
R 7
L 16
D 5
U 8
R 13
D 11
L 9
D 8
U 6
R 7
D 14
U 9
L 4
R 10
D 14
R 13
U 15
D 9
R 2
D 5
L 10
U 11
D 7
U 11
D 4
U 8
R 13
U 15
L 15
U 12
L 10
D 10
R 16
D 14
U 10
R 16
D 3
R 16
L 13
D 5
R 9
L 9
R 10
D 8
R 11
D 12
L 10
R 15
L 5
U 12
L 3
U 1
R 1
L 6
R 7
L 5
D 4
L 10
U 15
L 10
U 7
L 5
D 3
L 11
U 12
R 16
L 17
U 8
D 2
L 13
U 10
L 2
R 4
D 4
L 14
D 6
U 5
D 14
U 17
D 7
R 3
D 10
L 11
D 15
L 4
D 5
L 7
D 3
R 15
U 10
R 12
L 7
U 13
R 6
L 6
R 4
L 6
D 3
U 9
D 17
R 6
D 1
R 5
L 3
R 6
L 17
D 1
L 6
U 9
L 15
U 10
R 7
U 7
R 15
U 8
R 16
D 16
L 3
U 17
L 16
D 8
L 6
R 1
D 10
L 13
D 17
U 10
D 15
U 12
D 1
L 10
R 8
D 13
L 16
R 1
U 1
D 5
U 1
L 12
R 9
U 7
L 7
D 7
U 15
R 6
L 10
R 17
D 6
R 10
U 10
D 16
L 16
U 14
R 13
U 15
L 7
U 11
L 16
U 9
L 5
D 16
R 8
U 17
D 6
R 18
D 17
L 14
D 13
R 2
U 2
R 5
U 10
L 17
U 4
L 7
U 1
D 14
R 11
L 6
D 5
U 12
D 16
U 5
D 3
R 18
D 12
R 3
U 5
L 1
U 1
D 14
L 8
R 15
U 9
L 10
D 3
L 5
U 11
D 7
R 17
U 7
D 1
U 16
D 15
L 11
U 8
L 5
R 5
D 15
L 5
U 1
R 3
L 7
U 11
D 12
L 12
D 14
U 13
D 14
R 14
D 5
R 12
D 7
L 17
U 18
D 13
L 2
D 3
R 6
U 9
L 1
R 3
U 17
L 7
D 5
U 9
L 2
D 8
U 16
L 3
U 10
D 4
U 6
D 11
L 18
U 11
L 18
R 18
U 3
R 11
L 18
U 14
D 7
L 16
D 2
L 8
D 8
L 9
R 5
U 14
R 15
D 5
U 18
D 5
L 5
R 7
D 4
R 8
L 13
D 15
R 10
U 5
L 1
D 8
L 1
U 6
L 7
D 4
U 12
R 4
D 11
R 5
L 6
R 3
L 1
D 14
L 18
D 5
U 2
R 8
D 18
R 11
U 10
R 4
U 14
D 15
U 17
R 16
D 15
R 8
U 14
R 18
L 2
R 3
L 10
R 9
U 17
R 2
U 19
L 7
D 19
L 8
R 12
U 1
L 18
R 7
L 18
D 19
U 9
L 5
D 5
L 14
U 2
R 8
D 19
R 17
U 6
D 4
R 7
U 6
R 14
U 3
D 17
U 14
R 19
U 1
R 17
L 11
U 18
L 13
R 16
D 9
L 3
U 9
D 5
L 2
D 5
L 10
U 10
R 10
U 6
D 4
R 3
U 1
L 18
U 15
R 2
L 2
U 9
R 2
U 8
R 18
D 16
R 3
D 6
R 14
L 15
D 18
L 12
R 7
L 18
D 15
R 13
D 8
L 8
R 9
L 4
U 11
R 12
L 13
U 12
D 5
L 4
D 19
R 10
L 9
U 18"""

function print_view(visited::Dict{Tuple{Int64, Int64}, Bool})
    for y in -20:20
        for x in -20:20
            if get(visited, (y,x), false)
                print("#")
            else
                print(".")
            end
        end
        println()
    end
end

function isadjecent(y1::Int64, x1::Int64, y2::Int64, x2::Int64)
    return ((y2 - y1)^2 + (x2 - x1)^2) <= 2
end

function get_Δv(cmd::SubString)
    Δx = 0
    Δy = 0
    if cmd == "L"
        Δx = -1
    elseif cmd == "R"
        Δx = 1
    elseif cmd == "U"
        Δy = -1
    elseif cmd == "D"
        Δy = 1
    end
    return(Δy, Δx)
end


function part_one(input::String)
    visited = Dict{Tuple{Int64, Int64}, Bool}()
    hx = 0
    hy = 0
    tx = 0
    ty = 0
    visited[(ty, tx)] = true
    for line ∈ eachsplit(input, "\n", keepempty = false)
        cmd = split(line, " ")
        steps = parse(Int64, cmd[2])
        (Δy, Δx) = get_Δv(cmd[1])
        for s ∈ 1:steps
            hx = hx + Δx
            hy = hy + Δy
            if !isadjecent(hy, hx, ty, tx)
                tx = hx - Δx
                ty = hy - Δy
                visited[(ty, tx)] = true
            end
        end
    end
    println(string("Part One: ", length(keys(visited))))
end

part_one(data)



mutable struct RopeNode
    y::Int64
    x::Int64
    isfirst::Bool
    next::Union{Nothing, RopeNode}
end

function follow(rope::RopeNode, visited::Dict{Tuple{Int64, Int64}, Bool})
    if rope.next === nothing 
        visited[(rope.y, rope.x)] = true
        return nothing
    end
    if !isadjecent(rope.y, rope.x, rope.next.y, rope.next.x)
        Δy = 0
        Δx = 0
        if rope.y < rope.next.y 
            Δy = -1
        elseif rope.y > rope.next.y
            Δy = 1
        end
        if rope.x < rope.next.x
            Δx = -1
        elseif rope.x > rope.next.x
            Δx = 1
        end
        rope.next.y = rope.next.y + Δy
        rope.next.x = rope.next.x + Δx
    end
    return(follow(rope.next, visited))
end

function create_rope()
    rope = RopeNode(0, 0, true, nothing)
    current = rope
    for i ∈ 1:9
        current.next = RopeNode(0, 0, false, nothing)
        current = current.next
    end
    return rope
end

function part_two(input)
    rope = create_rope()
    visited = Dict{Tuple{Int64, Int64}, Bool}()
    visited[(rope.y, rope.x)] = true
    for line ∈ eachsplit(input, "\n", keepempty = false)
        cmd = split(line, " ")
        steps = parse(Int64, cmd[2])
        (Δy, Δx) = get_Δv(cmd[1])
        for s ∈ 1:steps
            rope.x = rope.x + Δx
            rope.y = rope.y + Δy
            follow(rope, visited)
        end
    end
    println(string("Part Two: ", length(keys(visited))))
end

part_two(data)


