2026-03-09 13:23 -0400 // math, video games, slay the spire

# The Hellraiser "infinite" in Slay the Spire 2

Slay the Spire 2 was released 4 days ago!
In my opinion it is a very fun game.
This post is about a very unintuitive and mathematically interesting interaction
between two Ironclad cards.
[EXCERPT]

.style {{
table.pad th, table.pad td { padding: 0 10px; }
table.pad td { text-align: right; }
img.half { max-width: 50%; }
video { max-width: 100%; }
span.nobr { white-space: nowrap; }
}}

<img src='hellraiser-small.png' class='half'><img src='pommel-small.png' class='half'>

Imagine you have Hellraiser in play,
your entire deck is 3 copies of Pommel Strike+,
and you end your turn.
On the next turn,
you might expect that they keep playing forever until the enemy dies.

But there are some enemies that can prevent this,
like the one that decreases your attack damage every time you play a card
(so attacks eventually do nothing).
What happens then?
Do they play infinitely many times,
softlocking your game?

No,
it turns out that the loop stops after playing **exactly 35 cards**.
If you have 4 copies of Pommel Strike+ instead of 3,
it instead stops after exactly 75 cards.

What???

There is actually a real reason for these numbers to be what they are,
and figuring it out is maybe an interesting "puzzle"
(albeit one that requires understanding subtle details about card play mechanics).
If you want to try solving it yourself,
stop reading now,
since I will spoil the answer below this clip.

<video controls><source src='threepommel.mp4' type='video/mp4'></video>

## the numbers

When I first heard about this confusing behavior
where people's "infinites" were randomly fizzling,
I collected some data by using the debug console
to set up this scenario with various numbers of Pommel Strike+.

<table class='pad'>
<thead>
<tr><th>pommels</th><th>cards played</th></tr>
</thead>
<tbody>
<tr><td>2</td><td>15</td></tr>
<tr><td>3</td><td>35</td></tr>
<tr><td>4</td><td>75</td></tr>
<tr><td>5</td><td>155</td></tr>
<tr><td>6</td><td>315</td></tr>
</tbody>
</table>

The last row was mostly a sanity check
to verify that the apparent pattern still holds:
to go from one row to the next,
double it and add 5.

Why 5?
Well,
the number 5 happens to be the number of cards you draw at the start of your turn.
So I tried giving myself a status effect
that decreases your start of turn draw by 4,
and discovered this indeed divides all the numbers by 5.

Okay,
that explains some of it --
each start-of-turn draw accounts for the same number of card plays.
But why is this number not infinite,
and instead some function of the number of Pommel Strike+ in the deck?

## card play mechanics

If your entire deck is a single Pommel Strike+ and you play it,
you don't draw it back.
This is because of a detail in how cards are played.

When you play a card,
it moves to an abstract "currently-being-played" zone,
and then it resolves all of the effects on the card,
and then it moves to your discard pile.
So the "draw 2" effect occurs while the Pommel Strike+ is still trapped in the "currently-being-played" zone,
and therefore sees that there are no cards to draw.
(From now on,
I will refer to the "currently-being-played" zone as "limbo",
since it's a bit of a mouthful.)

So what if you have two copies of Pommel Strike+?
Let's say you have Hellraiser in play and you draw one of them.
It moves to limbo,
and then begins to resolve its "draw 2" effect.

<img src='pic1.png'>

The first step of drawing 2 is to draw 1,
which happens to be the second Pommel Strike+.
Now this one also moves to limbo,
and begins to resolve its own "draw 2" effect.

<img src='pic2.png'>

But both cards in your deck are now in limbo,
and there is nothing to draw!
So nothing happens,
and the second Pommel Strike+ gets discarded.

<img src='pic3.png'>

The first Pommel Strike+ is not yet done resolving --
it has only drawn 1 so far,
and still has 1 more to draw.
So the same thing happens again:
the second Pommel Strike+ plays once,
and is then discarded.

<img src='pic4.png'>

<img src='pic5.png'>

Now the first Pommel Strike+ is done with its effect,
and is also discarded.

When all is said and done,
exactly 3 cards have been played.
The number in the table is 15, which agrees with this;
since you draw 5 at the start of your turn,
this entire process happens 5 times,
and 3×5 = 15.

Okay,
so that works,
but it was a bit of a pain to work out by hand.
It's time for some math.

## recurrence relations

The fundamental question we want to answer is:
**If your deck is *n* copies of Pommel Strike+,
how many cards are played when you draw one?**

Let's call this function *f*:
if you have *n* copies of Pommel Strike+,
then drawing one of them results in *f*(*n*) card plays.
We've already worked out
that <span class='nobr'>*f*(1) = 1</span> and <span class='nobr'>*f*(2) = 3</span>.

How do we compute *f*(*n*) without a specific value for *n*?
Well,
imagine you draw a Pommel Strike+.
It immediately moves to limbo,
and then it stays there forever until its entire chain of effects is done resolving.
So for this entire duration,
your deck effectively contains *n*-1 copies of Pommel Strike+.

Now we could go through the whole process of figuring out what happens
as a result of the draw effect that is about to occur.
But as I have just said,
this is the exact same result as drawing a Pommel Strike+ from a deck of *n*-1 copies of Pommel Strike+,
which is just *f*(*n*-1) card plays!
Since the effect is draw 2,
this happens twice,
and adding the card play from the original Pommel Strike+ itself,
we get <span class='nobr'>*f*(*n*) = 2*f*(*n*-1) + 1</span>.

<img src='func.png'>

We have now expressed *f* in terms of itself,
but how do we compute an actual numerical value for a particular *n*?
This is a [recurrence relation](https://en.wikipedia.org/wiki/Recurrence_relation),
which I will not attempt to explain the full theory of here,
but the solution in this case is <span class='nobr'>*f*(*n*) = 2^n - 1</span>.
(You can check that this works:
*f*(*n*) = <span class='nobr'>2*f*(*n*-1) + 1</span> = <span class='nobr'>2(2^(n-1) - 1) + 1</span> = <span class='nobr'>2^n - 2 + 1</span> = <span class='nobr'>2^n - 1</span>.)

Finally,
this gives a closed form for the numbers in the original table!
Each of the 5 start-of-turn draws results in *f*(*n*) card plays,
and so the total number of cards played is <span class='nobr'>**5 × (2^n - 1)**</span>.

## conclusion

This was a surprisingly deep interaction
between two seemingly very straightforward cards!
Admittedly,
most of the complexity comes from the somewhat unintuitive card play mechanics
(thanks to @redstonerodent for figuring out where this 2^n was coming from!),
but I still think it's very fun that these cards that absolutely do not say the number 315 on them
can somehow produce the number 315 in actual gameplay
(a claim I heard before investigating this was that 6 copies of Pommel Strike+ is actually infinite,
which is understandable to believe).

Anyway,
in case you find yourself with 50 copies of Pommel Strike+
against that one enemy who can only take 20 damage per turn
and want to know when you get to play the game again,
rest assured that you only need to wait for 5,629,499,534,213,115 card plays!
