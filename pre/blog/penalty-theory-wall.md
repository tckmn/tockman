2024-07-27 23:45 -0400 // puzzles, logic puzzles, math

# Penalty theory in wall puzzles

[Nikoli](https://www.nikoli.co.jp/en/)-style pencil-and-paper logic puzzles,
like Sudoku, Yajilin, and many more,
have very simple rules.
But you can often build puzzles
that require thinking in really cool ways,
seemingly totally unrelated to what the rules literally say.

Wait, it feels like [I've written this intro before](https://tck.mn/blog/penalty-theory/)...
[EXCERPT]

.script+spoiler
.style {{
    span.var { font-style: italic; background-color: #333; padding: 0 2px; white-space: nowrap; }
}}

---

On July 27, 2022,
I published a blog post (linked above) about a graph-theoretic argument
often referred to as "penalty theory"
applied to a Nikoli logic puzzle.

Now,
on July 27, 2024,
I am publishing a blog post about a graph-theoretic argument
often referred to as "penalty theory"
applied to a Nikoli logic puzzle.

Obviously,
I have just copied and pasted the entire post and changed the date,
so there's really no point in reading this one.
But in case you still want to anyway,
this post is about the "gridpoint counting argument"
briefly described [here by chaotic_iak](https://chaoticiak.github.io/logic.html#nurikabe-2019-05-19),
which I'll again try to explain as intuitively as possible.

<div style='padding-top:5px'></div>

*Note: This post is long!
But don't worry:
lots of space is taken up by pictures,
and you only need to read about half of the post
to understand basic penalty theory.*

## wall puzzles #wall

This version of "penalty theory"
applies to puzzles with these rules:

 * Shade some cells in the grid.
 * No 2×2 region can be fully shaded.
 * All of the shaded cells must form a single orthogonally connected group.

Puzzle types which include all of these rules
are sometimes called **wall puzzles**.

There are many kinds of wall puzzles,
but the one most conducive to this style of deduction
is **Nurikabe**.
In Nurikabe,
in addition to the rules above,
there are also numbers on the grid.
Every orthogonally connected *unshaded* group
must contain exactly one number,
which must be the number of unshaded cells it has.

*You can click the first image to try the puzzle,
or click the second image to see the solution.*

.heya {{
    7x7
    https://puzz.link/p?nurikabe/7/7/2g4h3o2q2p2i4k5

    NUM 0 0 2
    NUM 2 0 4
    NUM 5 0 3
    NUM 1 2 2
    NUM 6 3 2
    NUM 3 5 2
    NUM 0 6 4
    NUM 6 6 5
}}
.heya {{
    7x7
    SPOILER

    -#--#--
    -##-#-#
    #-#-###
    #-###--
    ###-###
    --#-#--
    --##---

    NUM 0 0 2
    NUM 2 0 4
    NUM 5 0 3
    NUM 1 2 2
    NUM 6 3 2
    NUM 3 5 2
    NUM 0 6 4
    NUM 6 6 5
}}

## use-case

In general,
these kinds of global counting arguments work on puzzles that are "extreme"
in some sense.
If you read [the post about Heyawake penalty theory][heyapen],
for example,
you know it only applies to puzzles which are extreme in a specific direction:
it works when the number of shaded cells required by the clues is really big,
making it hard to fit that many shaded cells while following the rules of Heyawake.

One cool aspect of Nurikabe penalty theory
is that it works in *both* directions.
There's one version that works when the numbers are really big,
and it's hard to fit that many unshaded cells while following the rules,
but there's also another version that works when the numbers are really small,
and it's hard to cover enough area with unshaded cells while following the rules.

I'll call these "minimization" and "maximization" respectively.
The second version is easier to get started with,
so I'll talk about it first.

## part 1: gridpoint maximization #part1

As mentioned,
this version of penalty theory
is about how to **cover as much space as possible**
with a small number of unshaded cells.

Here's an example.
Like all logic puzzles,
there's only one possible solution,
so you probably can't solve it by guessing.
But once you've learned penalty theory,
it will suddenly go from basically impossible to fairly easy!

.heya {{
    13x13
    https://puzz.link/p?nurikabe/13/13/zzj3g5zgbk1ybk7w3i9gdzzj
    NUM 5 3 3
    NUM 7 3 5
    NUM 3 5 11
    NUM 9 5 1
    NUM 3 7 11
    NUM 9 7 7
    NUM 1 9 3
    NUM 5 9 9
    NUM 7 9 13
}}

(This puzzle was created by [@agnomy on Twitter][puztweet].)

## counting gridpoints #counting

Just like in the Heyawake post,
the main thing we'll be thinking about is the **gridpoints** in the grid,
which are all the places the grid lines intersect.

.heya {{
    5x4

    grid
    ............
    ..1o2o3o4o..
    ..5o6o7o8o..
    ..9oaoboco..
    ............
    end
}}

However,
for Nurikabe,
we'll also care about what you get if you extend these
to the edge of the puzzle.

.heya {{
    5x4

    grid
    1o2o3o4o5o6o
    7o8o9oaoboco
    doeofogohoio
    jokolomonooo
    poqorosotouo
    end
}}

I'll call the first kind **internal gridpoints**,
and the ones on the edge **external gridpoints**.

Now you can look at the gridpoints that every **island**
(group of unshaded cells)
touches.
Here,
the island with the "3"
touches the starred gridpoints,
including 6 internal gridpoints
and 2 external gridpoints.

.heya {{
    5x4

    ??###
    ###?#
    ??#??
    #####

    NUM 0 0 2
    NUM 0 2 2
    NUM 4 2 3

    grid
    ............
    ......R*R*..
    ......R*R*R*
    ......R*R*R*
    ............
    end
}}

We're going to need to know the total number of internal gridpoints,
which is easy to count:
just multiply (<span class='var'>width</span>−1) by (<span class='var'>height</span>−1).
For example,
this puzzle is 8 cells wide and 4 cells tall,
so it has 7 × 3 = 21 internal gridpoints.

.heya {{
    8x4
    grid
    ..................
    ..1o2o3o4o5o6o7o..
    ..2o..............
    ..3o..............
    ..................
    end
}}

## touching gridpoints #touching

The reason we care about these gridpoints
is that the rule "*No 2×2 region can be fully shaded*"
can actually be rephrased as
"**Every internal gridpoint must be touched by at least one island**".

.heya {{
    5x4

    ??#?#
    #####
    #??##
    #?##?

    NUM 0 0 2
    NUM 3 0 1
    NUM 1 2 3
    NUM 4 3 1

    grid
    ............
    ............
    ........P3..
    ............
    ............
    end
}}

The solution shown on this puzzle breaks the "no 2×2" rule
because it has a fully shaded 2×2 region on the right.
But another way of seeing this is that no island touches the triangular gridpoint.

These two versions of the rule are the same
because if you shade a 2×2 region,
no island can reach the gridpoint at its center;
and in the other direction,
if you have a gridpoint touched by no islands,
the four cells surrounding it are shaded,
creating a 2×2.

At first,
this version of the rule might seem unnecessarily more complicated.
But notice that most gridpoints can only be touched by one island in the first place.
The only way to touch a gridpoint twice is to have diagonally touching islands,
like with the gridpoint marked with a diamond here.

.heya {{
    5x4

    2?###
    ##1#?
    4###?
    ???#3

    grid
    ............
    ....O4......
    ............
    ............
    ............
    end
}}

Okay,
so now we know we can count the *total* number of gridpoints touched
by just adding up the number each *individual island* touches,
and we'll only be off by however many diagonally-touching islands there are.
We'll come back to that later.
But how many gridpoints does each island touch?

Well,
a 1-size island touches 4 gridpoints,
its four corners.
A 2-size island touches 6 gridpoints,
and a 3-size island touches 8 gridpoints.
So it looks like an island of size <span class='var'>n</span>
touches (2 + 2×<span class='var'>n</span>) gridpoints.
This is mostly true,
because usually when you add a new unshaded cell,
you add 2 more gridpoints being touched.

<p>
.heya {{
    5x4

    #####
    #3###
    #??##
    #####

    grid
    ............
    ..WxWx......
    ..WxWxWx....
    ..WxWxWx....
    ............
    end
}}
<span style='padding:0 1rem'>→</span>
.heya {{
    5x4

    #####
    #4###
    #???#
    #####

    grid
    ............
    ..WxWx......
    ..WxWxWxGx..
    ..WxWxWxGx..
    ............
    end
}}
</p>

But it's possible to add an unshaded cell to an island
and only touch 1 more new gridpoint:

<p>
.heya {{
    5x4

    #####
    #3###
    #??##
    #####

    grid
    ............
    ..WxWx......
    ..WxWxWx....
    ..WxWxWx....
    ............
    end
}}
<span style='padding:0 1rem'>→</span>
.heya {{
    5x4

    #####
    #4?##
    #??##
    #####

    grid
    ............
    ..WxWxGx....
    ..WxWxWx....
    ..WxWxWx....
    ............
    end
}}
</p>

<!--TODO: say something about making two 2x2s and adding 0 gridpoints? lol-->
When does this happen?
It's exactly when adding that cell to the island
creates a new *unshaded* 2×2 region.
Intuitively,
every unshaded 2×2 region represents a gridpoint
(the one at its center)
that the island touches more than it needs to.
So the correct formula for number of gridpoints touched by an island with size <span class='var'>n</span> is:

> 2 × (1+<span class='var'>n</span>) − (<span class='var'># of unshaded 2×2s</span>)

You already know all the island sizes when you look at a puzzle,
since they're given by the clues.
So you can get close to the total number of gridpoints touched by:

1. adding 1 to each clue,
2. adding them up,
3. and doubling the resulting number.

Nice!
This is pretty easy,
and you know it can only be off in two ways:
it counts 1 extra for every pair of diagonally touching islands,
and 1 extra for every unshaded 2×2.

Going way back to the reason we cared about this in the first place,
remember that the rules say that every internal gridpoint must be touched.
We know the number of internal gridpoints.
Is it equal to the number we just calculated,
after adjusting for the 2 things it's off by?
Almost,
but some islands might touch *external* gridpoints,
which the rules don't care about.

Putting it all together,
the number from the three steps above is almost the same as the number of gridpoints,
except there are actually *three* ways it might be off:

* it's 1 extra for every places islands touch
* it's 1 extra for every unshaded 2×2
* it's 1 extra for every touched external gridpoint

## but how do I actually solve a puzzle? #solving

From all that, we get a nice formula:

> (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) = 2×(<span class='var'>sum of (clues+1)</span>) − (<span class='var'># of places islands touch</span>) − (<span class='var'># of unshaded 2×2s</span>) − (<span class='var'># of touched external gridpoints</span>)

At first,
this might not seem very useful for solving puzzles,
because you don't know what any of the three "# of" values will end up being.
But remember that this penalty theory applies to puzzles
where the clue numbers are *very small*.

That means that 2×(<span class='var'>sum of (clues+1)</span>)
is probably not that much bigger than the number of internal gridpoints.
In fact,
it might be exactly equal,
in which case you can deduce that the three "# of" values must all be zero!
In other words,
the arrangement of islands has to be as "efficient" as possible at touching internal gridpoints –
none of them can touch,
they can't have 2×2s,
and they can't touch the edge of the puzzle.

Even if the numbers are not exactly equal,
they still give lots of useful information.
Let's call each "inefficiency" a **penalty**.
This simplifies the formula:

> (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) = 2×(<span class='var'>sum of (clues+1)</span>) − (<span class='var'># penalties</span>)

We can rearrange this to get

> (<span class='var'># penalties</span>) = 2×(<span class='var'>sum of (clues+1)</span>) − (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1)

Now the right-hand side is entirely things you can calculate from the puzzle itself!
If the resulting number of penalties is very small,
you can get lots of useful information about what the solution must look like,
especially if you can locate where the penalties are.

This is easiest to understand by example,
so I'll demonstrate the technique on several puzzles (created by me).

.heya {{
    7x5
    https://puzz.link/p?nurikabe/7/5/u5n5p
    NUM 1 2 5
    NUM 3 3 5
}}

(Click the image to open the puzzle in a new tab if you want to try it yourself or follow along.)

This puzzle is easy to solve without using penalty theory if you're a Nurikabe expert,
but it's still a good example of how the theory can be applied.

If you add 1 to each clue and add them up,
you get 6 + 6 = 12.
Doubling this gives you 24.
How does this compare to the number of internal gridpoints?
The puzzle is 7 by 5, so it has 6×4 = 24 internal gridpoints.
That's exactly the same!
That means the solution has no penalties.

The easiest thing to do first is to shade the entire border,
since every external gridpoint touched is a penalty,
and an island on the border would touch at least one external gridpoint.

.heya {{
    7x5
    #######
    #?????#
    #5????#
    #??5??#
    #######
}}

Also,
every place two islands touch is a penalty.
That means neither of the two cells between the clues can be unshaded,
since that would cause them to touch.

.heya {{
    7x5
    #######
    #?????#
    #5#???#
    #?#5??#
    #######
}}

Now there's only one shape the leftmost 5 can be
(noting that it has to include the cell below it,
due to the no-shaded-2×2 rule),
solving the puzzle!

.heya {{
    7x5
    #######
    #???#?#
    #5###?#
    #?#5??#
    #######
}}

Okay,
that one was pretty easy,
since there weren't any penalties.
But what if there are?

.heya {{
    10x6
    https://puzz.link/p?nurikabe/10/6/g3v5l3l5i3zi
    NUM 1 0 3
    NUM 8 1 5
    NUM 5 2 3
    NUM 2 3 5
    NUM 6 3 3
}}

Here,
we first take 4 + 4 + 4 + 6 + 6 = 24
and double it to get 48.
But the number of internal gridpoints,
since the puzzle is 10 by 6,
is 9×5 = 45.
That means there are 3 penalties available to use anywhere in the solution.

However,
the given arrangement of clues already forces 3 penalties in the solution.
Specifically,
the 3 in the top left is already touching two external gridpoints,
which accounts for 2 penalties.
And the other two 3s are touching diagonally,
accounting for another penalty.
So you can conclude that the solution can't contain any *more* penalties!

.heya {{
    10x6
    #3########
    #.??????5#
    #????3#??#
    #?5??#3??#
    #.??????.#
    ##########
}}

I've marked cells that we know are unshaded
(by the rules of Nurikabe)
with dots.
Since there are no more penalties,
we again know that any cell touching more than one existing island
must be shaded.

.heya {{
    10x6
    #3########
    #.??????5#
    ###??3##?#
    #.5??#3??#
    #.??????.#
    ##########
}}

This completely determines the top left 3 –
but it also determines the leftmost 5.
Since there are no more penalties,
we can't make an unshaded 2×2 region,
so the cell directly below the 5 must be shaded.

.heya {{
    10x6
    #3########
    #..#.???5#
    #####3##?#
    #.5.##3??#
    #.#.#.??.#
    ##########
}}

The rest of the puzzle is easy to solve
by applying the normal Nurikabe rules.

.heya {{
    10x6
    #3########
    #..#..#.5#
    #####3##.#
    #.5.##3#.#
    #.#.#..#.#
    ##########
}}

## part 2: gridpoint minimization #part2

(to be continued...)

[heyapen]: https://tck.mn/blog/penalty-theory/
[puztweet]: https://twitter.com/agnomy/status/1257867454664937472
