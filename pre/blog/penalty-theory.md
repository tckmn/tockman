2022-07-27 04:44 -0400 // puzzles, logic puzzles, math

# Penalty theory in dynasty puzzles

[Nikoli](https://www.nikoli.co.jp/en/)-style pencil-and-paper logic puzzles,
like Sudoku, Yajilin, and many more,
have very simple rules.
But you can often build puzzles
that require thinking in really cool ways,
seemingly totally unrelated to what the rules literally say.
[EXCERPT]

    \raw .script+spoiler
    .style {{
        span.var { font-style: italic; background-color: #333; padding: 0 2px; white-space: nowrap; }
    }}

One example is commonly called **penalty theory**,
which has been written about before in e.g.
[this Twitter thread by agnomy][agnomy] (Japanese),
[this blog post by chaotic_iak][iak] (English),
or [this blog post by redstonerodent][rr] (English).
However,
the way penalty theory is usually explained
still seems to leave some people confused.

So here's a different description of penalty theory,
which I personally find to be the most intuitive.

    \raw <div style='padding-top:5px'></div>

*Note: This post is long!
But don't worry:
lots of space is taken up by pictures,
and you only need to read about half of the post
to understand basic penalty theory.*

## dynasty puzzles #dynasty

The standard "penalty theory"
applies to puzzles with these rules:

 * Shade some cells in the grid.
 * No two *shaded* cells can touch orthogonally (horizontally or vertically).
 * All of the *unshaded* cells must form a single orthogonally connected group.

Puzzle types which include all of these rules
are sometimes called **dynasty puzzles**.

There are many kinds of dynasty puzzles,
but the one most conducive to penalty deductions
is **Heyawake**.
In Heyawake,
in addition to the rules above,
there are also "rooms" with numbers in them,
which are required to contain that many shaded cells.

*You can click the first image to try the puzzle,
or click the second image to see the solution.*

    \rawp .heya {{
        7x7
        https://puzz.link/p?heyawake/7/7/8ki94ilag7u003jsc022g3321111g

        0 0 2x2 2
        2 0 4x1 2
        2 1 3x3 3
        5 1 2x6 3
        0 2 2x3 2
        2 4 3x1 1
        0 5 1x2 1
        1 5 2x1 1
        3 5 2x2 1
    }}

    .heya {{
        7x7
        SPOILER

        #--#-#-
        -#-----
        --#-#-#
        #--#---
        -#--#-#
        --#----
        #---#-#

        0 0 2x2 2
        2 0 4x1 2
        2 1 3x3 3
        5 1 2x6 3
        0 2 2x3 2
        2 4 3x1 1
        0 5 1x2 1
        1 5 2x1 1
        3 5 2x2 1
    }}

Heyawake also has one more rule,
which we won't worry about for the purposes of this post.
(But if you want to solve other Heyawake puzzles,
**make sure you learn the full rules!**)

## use-case #usecase

Penalty theory is about how to **fit as many shaded cells as you can**
into a given space.

You may notice that both of the dynasty rules
are *restrictions* on how the shaded cells can be placed.
So penalty theory can only apply
when there is some other constraint,
like the rooms in Heyawake,
that forces you to shade a large number of cells.

Here's an example.
Like all logic puzzles,
there's only one possible solution,
so you probably can't solve it by guessing.
But once you've learned penalty theory,
it will suddenly go from basically impossible to fairly easy!

    \rawp .heya {{
        10x10
        https://puzz.link/p?heyawake/10/10/04080g000000001428000003000000003g00-1d03
        0 0 10x10 29
        8 0 2x3 0
        3 8 3x2 3
    }}

(This puzzle was created by [@agnomy on Twitter][puztweet].)

## counting pools #counting

To talk about penalty theory,
I'm going to introduce the concept of a **pool**.

Consider all of the <strong>gridpoints</strong> in the grid.
These are all the places the grid lines intersect.

    \rawp .heya {{
        5x4

        grid
        ............
        ..1o2o3o4o..
        ..5o6o7o8o..
        ..9oaoboco..
        ............
        end
    }}

You can think of shaded cells
as connecting all the gridpoints they touch together.
In the example below,
the starred gridpoints are connected.

    \rawp .heya {{
        6x5

        ??????
        ??#???
        ?#?#??
        ??????
        ??????

        grid
        ..............
        ....R*R*......
        ..R*R*R*R*....
        ..R*R*R*R*....
        ..............
        ..............
        end
    }}

Also,
some shaded cells connect gridpoints to the edge of the grid,
like the triangular gridpoints in the example below.

    \rawp .heya {{
        6x5

        ??????
        ???#??
        ????#?
        ?????#
        ??????

        grid
        ..............
        ......P3P3....
        ......P3P3P3..
        ........P3P3..
        ..........P3..
        ..............
        end
    }}

A "pool" is just a group of connected gridpoints
which does not connect to the edge.
In the example below,
there are 8 pools,
all marked with their own shape.

    \rawp .heya {{
        7x6

        ?#?????
        ??#??#?
        ????#??
        ?#???#?
        ???#???
        ?????#?

        grid
        ................
        ........A3W6W6..
        ..G4....W6W6W6..
        ..O5O5MoW6W6W6..
        ..O5O5P*P*W6W6..
        ..YxR+P*P*......
        ................
        end
    }}

To continue the metaphor,
you could think of the edge of the grid
and everything connected to it
as "the <b>ocean</b>".

    \rawp .heya {{
        7x6

        ?#?????
        ??#??#?
        ????#??
        ?#???#?
        ???#???
        ?????#?

        grid
        B~B~B~B~B~B~B~B~
        B~B~B~B~......B~
        B~..B~B~......B~
        B~............B~
        B~............B~
        B~........B~B~B~
        B~B~B~B~B~B~B~B~
        end
    }}

It's easy to count the number of pools
when there are no shaded cells:
just multiply (<span class='var'>width</span>−1) by (<span class='var'>height</span>−1).
For example,
this puzzle is 8 cells wide and 4 cells tall,
so it starts with 7 × 3 = 21 pools.

    \rawp .heya {{
        8x4
        grid
        ..................
        ..1o2o3o4o5o6o7o..
        ..2o..............
        ..3o..............
        ..................
        end
    }}

## consuming pools #consuming

The reason we care about these pools
is that shading a cell
changes the number of pools
in a completely predictable way.

In particular,
when you shade a cell,
the pools corresponding to its four corners
are combined to become a single pool.
Some of them might be the ocean,
like if you shade a corner:

<!-- Suppose you don't know anything about the current state of the grid -->
<!-- except for the number of pools. -->
<!-- How does the number of pools change -->
<!-- when you shade a cell in the corner? -->

    \rawp .heya {{
        3x3 !T !R
        ???
        ???
        ???
        grid
        ........
        ........
        B~R*....
        B~B~....
        end
    }}

    →

    .heya {{
        3x3 !T !R
        ???
        ???
        #??
        grid
        ........
        ........
        B~B~....
        B~B~....
        end
    }}

Or an edge:

    \rawp .heya {{
        3x3 !T !R !B
        ???
        ???
        ???
        grid
        ........
        B~R*....
        B~P3....
        ........
        end
    }}

    →

    .heya {{
        3x3 !T !R !B
        ???
        #??
        ???
        grid
        ........
        B~B~....
        B~B~....
        ........
        end
    }}

Or they might all be different:

    \rawp .heya {{
        3x3 !T !R !B !L
        ???
        ???
        ???
        grid
        ........
        ..R*P3..
        ..G4Mo..
        ........
        end
    }}

    →

    .heya {{
        3x3 !T !R !B !L
        ???
        ?#?
        ???
        grid
        ........
        ..R*R*..
        ..R*R*..
        ........
        end
    }}

In the corner example,
whichever pool the starred gridpoint belongs to
becomes part of the ocean.
So the number of pools decreases by 1.

In the edge example,
both the star and triangle pools
become connected to the ocean.
So the number of pools decreases by 2.

In the interior example,
the four pools on each of the four corners
are all joined into a single pool.
So the number of pools decreases by 3.

You might be suspicious
that I'm assuming different symbols belong to different pools –
and rightfully so!
But remember that the dynasty rules say
that the unshaded cells must form a single connected group.
If any of the different symbols drawn were actually the same,
then you could draw a line of shaded cells through whatever connected them.
This would "rope off" an area of unshaded cells,
disconnecting it from the rest of the puzzle.

    \rawp .heya {{
        5x5 !T !R !B !L
        CURVE 2 3 2 2* 3 2* 3 3
        -----
        --#--
        -#-#-
        --?--
        -----
        grid
        ............
        ....R*R*....
        ..R*R*R*R*..
        ..R*R*R*R*..
        ....G4Mo....
        ............
        end
    }}

    →

    .heya {{
        5x5 !T !R !B !L
        -----
        --#--
        -#!#-
        --~--
        -----
        grid
        ............
        ....R*R*....
        ..R*R*R*R*..
        ..R*R*R*R*..
        ....R*R*....
        ............
        end
    }}

<!---->

    \rawp .heya {{
        4x6 !T !R
        CURVE 0 2 1 2* 2 3 2 4 2 5*
        ----
        #---
        -#--
        --#-
        -#--
        --?-
        grid
        ..........
        B~B~......
        B~B~B~....
        ..B~B~B~..
        ..B~B~B~..
        ..B~B~P3..
        ....B~B~..
        end
    }}

    →

    .heya {{
        4x6 !T !R
        ----
        #---
        !#--
        !!#-
        !#--
        !!~-
        grid
        ..........
        B~B~......
        B~B~B~....
        ..B~B~B~..
        ..B~B~B~..
        ..B~B~B~..
        ....B~B~..
        end
    }}

<!-- If you shaded the gray cell, -->
<!-- then whichever pool the starred gridpoint belongs to -->
<!-- would become connected to the ocean. -->
<!-- That means it's no longer a pool. -->
<!-- So placing a corner cell -->
<!-- always just decreases the number of pools by 1. -->

<!-- You might worry: -->
<!-- what if the starred gridpoint was *already* connected -->
<!-- to the ocean? -->
<!-- In that case, -->
<!-- shading the corner cell would break the rule -->
<!-- about unshaded cells being connected, -->
<!-- so we're not allowed to shade it. -->

<!--     \rawp .heya {{ -->
<!--         6x4 !T !R -->
<!--         ?????? -->
<!--         ??#??? -->
<!--         ?#?#?? -->
<!--         ~???#? -->
<!--     }} -->

To summarize,

 * **Corner cells** decrease the number of pools by 1.
 * **Edge cells** decrease the number of pools by 2.
 * **Interior cells** decrease the number of pools by 3.

But there's another way of thinking about this,
which I personally like more.

 * Placing a shaded cell **costs** 3 pools.
 * Every edge of a shaded cell
   touching the border of the puzzle
   gives a **discount** of 1 pool.

(There's actually a good reason this works:
every edge of a shaded cell touching the border of the puzzle
corresponds to allowing two of the pools it joins to be the same.)

I'll give explanations with both styles of counting;
you can use whichever one you like better.

## but how do I actually solve a puzzle? #solving

From all that, we get a nice formula:

> <span class='var'>remaining pools</span> = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) − (<span class='var'># corners</span>) − 2×(<span class='var'># edges</span>) − 3×(<span class='var'># interior</span>)

or, with the other counting method,

> <span class='var'>remaining pools</span> = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) − 3×(<span class='var'># shaded</span>)  
> &nbsp; + <span class='var'># shaded on top edge</span>  
> &nbsp; + <span class='var'># shaded on bottom edge</span>  
> &nbsp; + <span class='var'># shaded on left edge</span>  
> &nbsp; + <span class='var'># shaded on right edge</span>

At first,
this might not seem very useful for solving puzzles,
because you don't know how many corner and edge cells you're going to end up shading.
But remember that penalty theory applies to puzzles
where you're trying to shade *as many cells as possible*.

You have a limited supply of pools.
So since corners and edges consume fewer pools,
you had better shade as many of them as possible
to avoid running out of pools.

This is confusing without an example.
I'll demonstrate the technique on this puzzle (created by me).

    \rawp .heya {{
        10x8
        https://puzz.link/p?heyawake/10/8/04081024480k98g000700o0071s00-132222
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

(Click the image to open the puzzle in a new tab
if you want to try it yourself
or follow along.)

How do I start?
Well,
here are all the facts I know:

* There are 9 × 7 = **63 pools** to start with.

* I have to place 19 + 2 + 2 + 2 + 2 = **27 shaded cells**.

* Using the first counting method:

    * If I'm trying to spend as few pools as possible,
      I should shade as many corners as possible,
      since they're the cheapest.
      There are **4** of those.

    * If all the corners are shaded,
      I can only fit **10** more shaded cells on the edges:
      three on the top, three on the bottom, two on the left, and two on the right.
      (Remember, shaded cells can't touch.)

    * If I shade as many corners and edges as possible,
      the remaining 27 − 4 − 10 = **13** shaded cells
      must be interior.

    * Shading 4 corners, 10 edges, and 13 interior cells
      costs 4 + 2×10 + 3×13 = **63 pools**.

* Alternatively, using the second counting method:

    * Shading 27 cells costs 3×27 = **81** pools without any discounts.

    * The biggest discount I can get is 5 from the top edge,
      5 from the bottom edge,
      4 from the left edge,
      and 4 from the right edge.

    * Therefore,
      shading 27 cells on this grid
      costs at least 81 − 5 − 5 − 4 − 4 = **63 pools**.

So there are 63 pools available,
and shading 27 cells on this grid
costs at least 63 pools!
That means I *must* shade as many corners and edges as possible,
*and there will be no pools left over*
(in other words,
every gridpoint will be part of the ocean).

Great!
Concretely,
I can now start by shading all the corners.

    \rawp .heya {{
        10x8
        #-??????-#
        -????????-
        ??????????
        ??????????
        ??????????
        ??????????
        -????????-
        #-??????-#
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

I need to shade 2 cells in the top right room,
and then some more cells will be unshaded
because of the dynasty rules.

    \rawp .heya {{
        10x8
        #-?????--#
        -??????-#-
        ????????--
        ??????????
        ??????????
        ??????????
        -????????-
        #-??????-#
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

Now there's only one way to fit enough shaded cells
on the top and right edges.

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        ????????--
        ????????-#
        ????????--
        ????????-#
        -???????--
        #-??????-#
        grid
        ......................
        ......................
        ......................
        ................R*....
        ................P3....
        ......................
        ......................
        ......................
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

Both the star and the triangle have to connect to the ocean somehow.
But I can only shade one more cell in the 2 room.
So it has to be the middle one,
so that both the star and the triangle can escape.

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        ???????---
        ??????-#-#
        ???????---
        ????????-#
        -???????--
        #-??????-#
        grid
        ......................
        ......................
        ..............O4......
        ......................
        ......................
        ................M5....
        ......................
        ......................
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

Now there are some nearly-trapped pools,
marked above,
which only have one way to escape.
Also,
shading the corresponding cell
will create another nearly-trapped pool next to it,
resulting in a chain of similar deductions.

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        #-#-#-#---
        -?-?-?-#-#
        ???????---
        ??????-#-#
        -??????---
        #-????-#-#
        grid
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

The remaining 2 rooms both already have one shaded cell in them,
and to fit enough shaded cells on the edges,
one of them has to go in each of the 2 rooms.
So I can mark all the non-edge cells in the 2 rooms
as unshaded.

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        #-#-#-#---
        -?-?-?-#-#
        ?-?????---
        ?-????-#-#
        --??------
        #-????-#-#
        grid
        ......................
        ......................
        ......................
        ......................
        ......................
        ..............O4O4....
        ..R*........M5O4O4....
        ............P3........
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

Again,
there are a bunch of marked pools that only have one escape route,
and again they will lead to more of the same:

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        #-#-#-#---
        -#-?---#-#
        --???-#---
        #-??-#-#-#
        --??------
        #-??-#-#-#
        grid
        ......................
        ......................
        ........R*R*O4O4......
        ........R*R*O4O4O4....
        ............O4O4O4....
        ..........O4O4O4O4....
        ..........O4O4O4O4....
        ......................
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

<!---->

    \rawp .heya {{
        10x8
        #-#-#-#--#
        --------#-
        #-#-#-#---
        -#-#---#-#
        ----#-#---
        #-#--#-#-#
        ---#------
        #-#--#-#-#
        grid
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        end
        0 0 10x8 19
        8 0 2x2 2
        7 2 3x3 2
        0 4 2x4 2
        4 6 4x2 2
    }}

Solved!

## optional: deeper down the rabbit pool #deeper

So that's how to apply penalty theory to the whole puzzle.
But what if you only want to use it on a certain part?

    \rawp .heya {{
        10x9
        https://puzz.link/p?heyawake/10/9/0g1k386h020k280g00600001v006080u0eg3ag1
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
    }}

This puzzle has a big number in it,
but if you try to apply penalty theory to the whole thing,
you'll find that there's a lot of wiggle room.
Is it possible to use penalty theory on just the big number?

It turns out it is!
Consider just the 14 room,
and pretend the rest of the puzzle doesn't exist.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        grid
        B~B~B~B~B~B~B~........
        B~1o2o3o4o5o6o........
        B~7o8o9oaoboco........
        B~doeofogohoio........
        B~jokolomonooo........
        B~poqoroso............
        B~touovowo............
        B~xoyo................
        B~zo..................
        ......................
        end
    }}

Let's count:

 * There are **35 pools**.

 * I have to place **14 shaded cells**.

 * The best I can do is 1 corner, 5 edges, and 8 interior.
   This consumes 1 + 2×5 + 3×8 = **35 pools**.

 * Alternatively,
   the base cost is 3×14 = 42 pools,
   and the best discount is 3 pools from the top edge
   and 4 pools from the left edge.
   This consumes at least 42 − 3 − 4 = **35 pools**.

Nice!
Again,
I need as many corners and edges as possible,
and all pools must connect to the ocean.

Some pools
(namely 24, 32, 34, and 35)
are already almost trapped,
so I'll start by placing the shaded cells that let them escape.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        grid
        ......................
        ......................
        ............co........
        ..........hoho........
        ........mohoho........
        ......roro............
        ......roro............
        ......................
        ......................
        ......................
        end
        ??????????
        ??????????
        ?????-????
        ????-#-???
        ???-?-????
        ---#-?????
        -#--??????
        #-????????
        --????????
    }}

Now some more pools
(marked on the grid)
are almost trapped,
and I can also fill in the left edge.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        grid
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        ......................
        end
        #-???-????
        --??-#-???
        #-?-#--???
        ---#-#-???
        #-#---????
        ---#-?????
        -#--??????
        #-????????
        --????????
    }}

The rest is straightforward.

Now it's time to look at the 10.
Notice that some of its gridpoints are already part of the ocean.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        grid
        ......................
        ......................
        ......................
        ......................
        ........B~B~B~1o2o3oB~
        ........B~4o5o6o7o8oB~
        ........B~9oaobocodoB~
        ........eofogohoiojoB~
        ........kolomonooopoB~
        ........B~B~B~B~B~B~B~
        end
        #-#-#--???
        -----#-???
        #-#-#--???
        ---#-#-???
        #-#---????
        ---#-?????
        -#--??????
        #-????????
        --????????
    }}

Counting again:

 * There are **25 pools**.

 * I have to place **10 shaded cells**.

 * The best I can do is 1 corner, 4 edges, and 5 interior.
   This consumes 1 + 2×4 + 3×5 = **24 pools**.

 * Alternatively,
   the base cost is 3×10 = 30 pools,
   and the best discount is 3 pools from the bottom edge
   and 3 pools from the right edge.
   This consumes at least 30 − 3 − 3 = **24 pools**.

Hmm,
there's one extra pool left over.
That could mean one of two things:
either I won't be able to shade as many corners and edges as I thought,
or there'll be a pool that doesn't connect to the ocean.

In this case,
the answer is a little tricky.
Because of the 3 room,
there will be another shaded cell
touching the top of the 10 room.
This shaded cell will touch either pools 1 and 2 or pools 2 and 3.

Hypothetically,
let's say it touches 2 and 3.
Then,
pools 2 and 3 will be connected *from the outside*.
But remember,
I'm only looking at this subregion of the puzzle,
and I'm pretending the rest of the puzzle doesn't exist.
So from the perspective of the penalty computation,
2 and 3 aren't actually connected yet,
and connecting them from inside the subregion would be illegal!
(That would create a closed-off area of unshaded cells,
for the same reason as described in the [counting pools](#counting) section.)

Therefore,
pools 2 and 3 will remain separate pools within this region.
And since I know there's only room for one pool left over,
that means everything else has to connect to either 2 or 3,
one of which will end up connecting to the ocean.

Now all the pools are accounted for,
so I know that all pools must connect to the ocean *or the remaining pool*,
and corners and edges are maximal.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        #-#-#--???
        -----#-???
        #-#-#--???
        ---#-#-??-
        #-#---??-#
        ---#-#-?--
        -#--?-??-#
        #-??????--
        --??????-#
        grid
        ......................
        ......................
        ......................
        ......................
        ......................
        ................A*....
        ......................
        ........A*..A*..A*....
        ......................
        ..........A*..A*......
        end
    }}

<!-- At this point, -->
<!-- unfortunately I can't find an elegant argument for the next step, -->
<!-- but it's not too hard to show -->
<!-- that the sixth cell in the last row can't be shaded by trial and error. -->
<!-- Therefore the fifth one must be shaded -->
<!-- (to fit enough edges). -->

The next step is a bit tricky,
and you might find it easiest to just proceed by trial and error.
But here's one reasonable argument:
all of the starred gridpoints have to touch a shaded cell within the 10 room
(either to fit enough edges or to let pools escape),
which accounts for all 6 remaining shaded cells in the 10 room.
So the 7th cell in the 5th row must be unshaded.

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        #-#-#--???
        -----#-???
        #-#-#--???
        ---#-#-??-
        #-#----~-#
        ---#-#-?--
        -#--?-??-#
        #-??????--
        --??????-#
    }}

Now the cell marked in gray must be shaded
to avoid trapping too many pools,
and you should be able to solve the puzzle from there!

    \rawp .heya {{
        10x9
        0 0 0x0 14
        6 0 4x4 -1
        7 1 2x3 3
        4 4 6x5 10
        0 8 4x1 1
        BORDER 2 6 2
        BORDER 2 6 -1
        BORDER 1 7 1
        BORDER 1 7 -1
        #-#-#-----
        -----#--#-
        #-#-#--#--
        ---#-#--#-
        #-#----#-#
        ---#-#----
        -#--#--#-#
        #-----#---
        --#-#--#-#
    }}

As promised,
the original pool 2 does not connect to the ocean
through the 10 region,
showing where the inefficiency of 1 pool comes from.

<!--
    \rawp .heya {{
        8x7
        https://puzz.link/p?heyawake/8/7/cg413830g4vg0104g200g1g3c11
        2 0 1x1 1
        3 3 1x1 1
        6 4 1x1 1
        6 0 2x7 3
        0 1 6x6 12
    }}

x

    \rawp .heya {{
        8x7
        grid
        ..................
        B~1o2o3o4o5o6o....
        B~7o8o9oaoboco....
        B~doeofogohoio....
        B~jokolomonooo....
        B~poqorosotouo....
        B~vowoxoyozo0o....
        B~B~B~B~B~B~B~....
        end
        2 0 1x1 1
        3 3 1x1 1
        6 4 1x1 1
        6 0 2x7 3
        0 1 6x6 12
    }}
-->

## appendix: an alternative counting method #counting2

If you're happy with the strategies described,
you can skip this section.
But there's a further simplification
that can help speed up the counting,
at the cost of requiring a little more math.

Consider the second formula from before.

> <span class='var'>remaining pools</span> = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) − 3×(<span class='var'># shaded</span>)  
> &nbsp; + <span class='var'># shaded on top edge</span>  
> &nbsp; + <span class='var'># shaded on bottom edge</span>  
> &nbsp; + <span class='var'># shaded on left edge</span>  
> &nbsp; + <span class='var'># shaded on right edge</span>

If we're applying penalty theory to the whole puzzle,
we can establish a better baseline.
Usually,
we're shading as many edge cells as possible,
so it makes more sense to count the **deficit** of shaded edge cells.

> <span class='var'>remaining pools</span> = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) − 3×(<span class='var'># shaded</span>)  
> &nbsp; + <span class='var'>max # shaded on top edge</span> − <span class='var'># missing on top edge</span>  
> &nbsp; + <span class='var'>max # shaded on bottom edge</span> − <span class='var'># missing on bottom edge</span>  
> &nbsp; + <span class='var'>max # shaded on left edge</span> − <span class='var'># missing on left edge</span>  
> &nbsp; + <span class='var'>max # shaded on right edge</span> − <span class='var'># missing on right edge</span>

What's the maximum number of cells we can shade on an edge?
Consider the top and bottom edges together.
If <span class='var'>width</span> is even,
we can shade <span class='var'>width</span>÷2 cells on both the top and bottom,
for a total of <span class='var'>width</span> combined.
If <span class='var'>width</span> is odd,
we can shade (<span class='var'>width</span>+1)÷2 cells on both the top and bottom,
for a total of <span class='var'>width</span>+1 combined.
So we get:

> <span class='var'>remaining pools</span> = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) − 3×(<span class='var'># shaded</span>)  
> &nbsp; + <span class='var'>width</span> + <span class='var'>1 if width is odd</span>  
> &nbsp; + <span class='var'>height</span> + <span class='var'>1 if height is odd</span>  
> &nbsp; − <span class='var'># missing on each edge</span>

Doing some simplification
and moving things around so that everything is positive,
we end up with:

> <span class='var'>width</span>×<span class='var'>height</span> + 1 + <span class='var'>1 if width is odd</span> + <span class='var'>1 if height is odd</span>  
> &nbsp; = 3×(<span class='var'># shaded</span>) + <span class='var'>remaining pools</span> + <span class='var'># missing on each edge</span>

The left-hand side of this equation
doesn't depend on the shaded cells at all!
So you can compute it immediately upon seeing the puzzle.
If you think of this as how many **penalties** you have available,
then:

* Each shaded cell costs 3 penalties.
* Each remaining pool (not connected to the ocean) costs 1 penalty.
* Each missing shaded cell on each edge costs 1 penalty.

As a quick demonstration,
for the example puzzle from the previous section,
the left-hand quantity is 10×8 + 1 = **81**,
and just placing all the shaded cells costs 27×3 = **81** penalties.
So this is another way of seeing
that all pools must connect to the ocean,
and that the edges must hold as many shaded cells as possible.

For the mathematically inclined,
we can produce a similar formula for arbitrary rectangles:

> penalties = (<span class='var'>width</span>−1)×(<span class='var'>height</span>−1) + Σ<sub>b</sub> ⌈b/2⌉

where the sum is over lengths of edges touching the border.
For shapes more complicated than rectangles,
I think it's easiest to use the other method.

## appendix: an etymological edification #etym

So anyway, why are these things called "pools"?

The original description of penalty theory
used the **graph of unshaded cells** instead of gridpoints.
This is just the thing you get if you draw a line
between every touching pair of unshaded cells.

    \rawp .heya {{
        5x5
        LOOPS #f00
        ???#?
        ?#???
        ???#?
        ??#??
        ?????
    }}

Then,
instead of pools,
it talked about "fundamental loops".
There are five of them in this example.

    \rawp .heya {{
        5x5
        LOOPS #aaa
        CLOOP #0ff 0 0 3 3
        CLOOP #00f 1 2 3 3 2 1 3 3
        CLOOP #f0f 0 2 2 2
        CLOOP #0f0 0 3 2 2
        CLOOP #80f 3 3 2 2
        ???#?
        ?#???
        ???#?
        ??#??
        ?????
    }}

A loop is a path you can draw along these lines
that starts and ends at the same place.

But why doesn't this one count?

    \rawp .heya {{
        5x5
        LOOPS #aaa
        CLOOP #f00 0 2 2 3 F 0 3 1 3
        ???#?
        ?#???
        ???#?
        ??#??
        ?????
    }}

That's what "fundamental" means:
the red loop is just a combination of the pink loop and the green loop.
More explicitly,
the number of fundamental loops is the biggest number of loops you can choose
so that none of them are combinations of any others.
(There can be many ways to do this;
for example,
you could take the pink loop and the red loop,
but then you couldn't count the green loop.)
There are also a few extra considerations
when applying penalty theory to only part of the puzzle.
This all feels more confusing to me,
which is why my presentation uses pools instead.

But if you like loops more,
you can almost just replace the word "pool" with "loop" on this page
and keep basically everything else intact.
In fact,
pools and loops are almost "the same thing" –
in mathematical jargon,
pools are the **dual** of a particular basis of loops.
That's why I chose the name "pool":
it's "loop" backwards.

## appendix: patterns, pitfalls, and practice #patterns

Here are a few more examples of various levels of trickiness.
Many of them are easy to solve without penalty theory –
the point is to make sure you understand how the penalty calculations work.
You can try working through them yourself first,
for practice.

For all of these,

* **Click the first image** to try the puzzle.
* **Click the second image** to see the solution.
* **Click the gray bars below** to read the explanations.

### puzzle 1

    \rawp .heya {{
        5x5
        https://puzz.link/p?heyawake/5/5/16cge00e05
        0 0 5x5 0
        1 1 3x3 5
    }}

    .heya {{
        5x5
        SPOILER
        -----
        -#-#-
        --#--
        -#-#-
        -----
        0 0 5x5 0
        1 1 3x3 5
    }}

*Region to apply penalty to*: <span class='spoiler'>the 5 room</span>

*Computation*: <span class='spoiler'>16 pools available, costs at least 3×5 = 15 pools</span>

*Explanation*: <span class='spoiler'>This might trip you up at first. It seems like the solution is maximally efficient, but shouldn't we have 16 − 15 = 1 extra pool? In fact, this region doesn't connect to the ocean at all, so there is indeed necessarily at least 1 pool left over.</span>

### puzzle 2

    \rawp .heya {{
        6x6
        https://puzz.link/p?heyawake/6/6/1157110e7k8071211
        0 0 5x6 7
        5 0 1x3 1
        0 2 3x1 2
        3 3 1x1 1
        5 3 1x3 1
    }}

    .heya {{
        6x6
        SPOILER
        #-#--#
        ----#-
        #-#---
        -#-#-#
        ------
        #-#-#-
        0 0 5x6 7
        5 0 1x3 1
        0 2 3x1 2
        3 3 1x1 1
        5 3 1x3 1
    }}

*Region to apply penalty to*: <span class='spoiler'>the whole puzzle</span>

*Computation*: <span class='spoiler'>25 pools available, costs at least 3×12 − 3 − 3 − 3 − 2 = 25 pools</span>

*Explanation*: <span class='spoiler'>If you deduce that two edges next to each other both have the maximum number of shaded cells that can fit, you can safely shade the corner between them. But in this example, the right edge is inefficient – you should be careful to not falsely apply this "deduction" in this case.</span>

<!-- ## appendix: for weirdos #weird -->

<!-- If this is confusing, -->
<!-- you could also imagine -->
<!-- that the subregion you're doing penalty on -->
<!-- is actually one cell bigger, -->
<!-- and it also includes whichever of the two cells is shaded. -->
<!-- This gains two pools -->
<!-- (from the region being bigger) -->
<!-- but loses three pools -->
<!-- (from having to place another shaded cell), -->
<!-- for the same net result. -->


[agnomy]: https://twitter.com/agnomy/status/1246741741777997824
[iak]: https://chaoticiak.github.io/penaltydynasty.html
[rr]: https://www.oneplusome.ga/dynasty-cycle-counting/

[puztweet]: https://twitter.com/agnomy/status/1253652799910371328
