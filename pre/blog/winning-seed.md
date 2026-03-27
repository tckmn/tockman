2026-02-27 01:05 -0500 // draft, games, video games, slay the spire

# An extremely unloseable Slay the Spire seed, and how to find more

If you're a Slay the Spire enthusiast,
you might have seen [OohBleh's blog post about a provably unwinnable seed](https://oohbleh.github.io/losing-seed/).
But what about a provably unloseable seed?
[EXCERPT]

.spire
.toc
.style {{
summary { user-select: none; cursor: pointer; background-color: #383838; padding: 5px 20px; }
details > div { background-color: #282828; padding: 10px 20px; }
details pre { font-size: 10pt; }
p.line { margin-top: -0.2em; margin-bottom: -0.8em; color: #888; font-size: 11pt; }
table.pathing { border-collapse: collapse; }
table.pathing td { padding: 0 0.5rem; line-height: 1.3; }
table.pathing tr.inflection td { border-bottom: 1px dotted #fff; }
span.space { padding: 0 1rem; }
}}

Okay,
obviously no seed is literally unloseable,
because you can walk into floor 1 and press end turn 20 times and die.
So instead,
I will frame the question slightly differently:

**What is the lowest floor where you can prove that you will win the game (on A20H), if playing optimally?**

I want to talk about a few things before answering this question,
but for the sake of not burying the lede --
here .

<table>
<thead>
<tr><td></td><th>Ironclad</th><th>Silent</th><th>Defect</th><th>Watcher</th></tr>
</thead>
<tbody>
<tr><th>part 1 (fake game)</th><td>2</td><td>0</td><td>-</td><td>2</td></tr>
<tr><th>part 2 (real game)</th><td>99</td><td>4</td><td>4</td><td>3</td></tr>
<tr><th>part 3 (REAL game)</th><td>0</td><td>0</td><td>0</td><td>0</td></tr>
</tbody>
</table>

And just for kicks, here's the most troublesome enemy for each of these scenarios:

<table>
<thead>
<tr><td></td><th>Ironclad</th><th>Silent</th><th>Defect</th><th>Watcher</th></tr>
</thead>
<tbody>
<tr><th>part 1</th><td>Time Eater</td><td>Time Eater</td><td>-</td><td>Spiker</td></tr>
<tr><th>part 2</th><td></td><td>Transient</td><td></td><td>The Heart</td></tr>
<tr><th>part 3</th><td></td><td></td><td>Donu and Deca</td><td></td></tr>
</tbody>
</table>

## part 1: the fake game, "slay" the "spire"

My first instinct was to boss swap into [[Pandora's Box]],
and receive a ready-made infinite.
This is simple enough,
but the details can get messy --
you need to solve all of the following problems:

* The infinite must be guaranteed on turn 1,
  because otherwise [Chosen](https://slaythespire.wiki.gg/wiki/Chosen) will hex you and destroy your infinite
  (assuming it plays skills,
  which it hopefully does because otherwise the [Spikers](https://slaythespire.wiki.gg/wiki/Spiker) will destroy your hitpoints).

* The infinite has to come online "relatively quickly".
  Specifically,
  since we are trying to prove a guaranteed win,
  we can assume there is an adversary picking the worst possible RNG at every point in the game.
  So,
  for example,
  you will always topdeck [[Ascender's Bane]] and your class basics until you remove them,
  and the enemies will always choose the worst possible attack patterns.
  This means you will probably lose HP in every hallway
  until you get the necessary removes/upgrades to complete your combo.

  One detail of note is that you can basically think of this as
  "you get to play with the best possible luck until floor *n*,
  at which point you hand off RNG control to the adversary and get the worst possible luck".
  Importantly,
  this means you get to determine the Act 1 map,
  so you can put shops and fires wherever you want.

* Your deck must be [Falling](https://slaythespire.wiki.gg/wiki/Falling)-proof --
  again, you have pessimal RNG,
  so you need to pick a card that you can guarantee will be available for this event.
  You can achieve this either by e.g. adding a dead Power if you have no other powers,
  or e.g. adding a second copy of every necessary Attack so you can always safely pick one.

* The Time Eater fight has to be provably won.

* You have to solve the standard three problems against the Heart:

    * blocking through Beat of Death
    * ensuring the infinite is repeatable
    * dealing with drawing 5 statuses into being hit for 67 on turn 2

This looks like a lot of problems,
but they are not insurmountable,
as you will see!

There are also two caveats to all of these solutions.
The first is a minor detail that I will mention in the Silent section.
The second is much more problematic:
there are two events that can force curses into your deck with no counterplay.
These are [Wheel of Change](https://slaythespire.wiki.gg/wiki/Wheel_of_Change) and [Match and Keep](https://slaythespire.wiki.gg/wiki/Match_and_Keep).
Spinning the wheel and getting one curse isn't that bad,
but the real problem is that the adversary can forcibly add two curses and three useless cards at Match and Keep,
and then immediately throw you into a Nemesis swinging for 45 or adding 5 [[Burn]]s (whichever's worse)
with all five of those cards topdecked,
and then if you somehow live, give you another curse and do that again with Reptomancer and turn 2 [[Normality]].

Naturally,
if this is allowed,
it is much, much harder to prove a win earlier than the first floor of Act 3,
when you get to generate the map.
But then the question is totally uninteresting
because you get two full acts of perfect luck to build your deck.
So in the fake game "Slay" the "Spire",
those two events are just banned by fiat.
(A single curse doesn't seem that bad
until you realize the curse can be a perma-topdecked [[Normality]] with no shop until the end of the act,
ruining your turn 1 infinite.)

Ok,
enough preliminaries!
Let's go from small to large,
because smaller is cooler.

### silent

The Silent can win the entire game on floor 0!
Here is an ideal Pandora's Box (with necessary upgrades shown):

[[[Acrobatics+]]][[[Tactician+]]][[[Backflip+]]][[[GrandFinale+]]][[[WraithForm+]]][[[Adrenaline]]][[[Adrenaline]]][[[Adrenaline]]][[[Adrenaline]]][[[Adrenaline]]]

The first four cards are for the infinite,
the Wraith is for Falling (and act 1 hallways),
and the Adrenalines are just there to take up space.

The Act 1 map is a fight,
then a shop (for [[Neutralize]] remove),
then a bunch of elites and combats to get enough gold,
then another shop (for [[Survivor]] remove).
You also need four fires anywhere on your path
(the deck needs 5 upgrades, a recall, and a rest;
but there are 3 guaranteed fires).

Once [[Survivor]] and [[Neutralize]] are removed,
you are guaranteed to draw your whole deck turn 1:
the only cards that don't draw are Tactician, Finale, Wraith, and Ascender's Bane;
so your fifth card always draws.

Once [[Tactician]] is upgraded,
the deck is infinite:
[[Acrobatics]] on [[Tactician+]],
then [[Backflip]],
then [[Grand Finale]] is energy neutral.
<!-- (This probably doesn't even matter until the heart, -->
<!-- since [[Grand Finale]] plus however much energy from the [[Adrenaline]]s probably kills everything else, -->
<!-- but whatever.) -->

The [[Backflip]] upgrade is for the heart:
with Frail,
it will block for 6,
and you can generate infinite block through 2 Beat of Death
by looping [[Acrobatics]]-[[Tactician+]]
and [[Backflip+]]
(without the Finale).

The [[Acrobatics]] upgrade is for turn 2 of the heart:
suppose you have run the infinite for a while on turn 1,
your discard has [[Backflip+]],
and your hand has everything else.
First play [[Acrobatics+]] on [[Tactician+]],
drawing [[Backflip+]].
Then play [[Grand Finale]].
Then play the [[Backflip+]].
You will draw all but one card.
If you draw [[Acrobatics+]],
repeat this process.
Otherwise,
[[Acrobatics+]] is the only card in your draw pile.
The game is hardcoded to prevent statuses shuffling into your draw pile
from replacing the top card,
so you will always draw [[Acrobatics+]] on turn 2
in order to restart your infinite.
But it needs to be upgraded
(otherwise you can draw the fifth status, Finale, and Tactician+).
This requires having removed the [[Wraith Form]],
but you can just do that in Act 4 if you didn't see Falling.

Note:
this is the first caveat mentioned above.
If the adversary truly has unlimited control of RNG,
they could theoretically make you lose the 1-in-3 chance
to put [[Acrobatics+]] on top infinitely many times,
and you will be stuck forever.
But this is a probability 0 event,
so whatever,
I'm fine saying that you're allowed use lines
that work with probability 1 (without an adversary)
as part of your proof.

Finally,
the [[Grand Finale]] and [[Wraith Form]] upgrades are for Time Eater.
This proof is kind of obnoxious,
so I'll hide it away in a dropdown;
click it if you're curious.

<details>
<summary>silent time eater proof</summary>
<div>

<!-- It doesn't matter what the boss is doing; -->
<!-- it's fine to do the same thing regardless. -->
<!-- You have taken 7 damage in Act 1 (see below) -->
<!-- and 0 damage everywhere else, -->
<!-- so you are at 65/66 HP, -->
<!-- and can just tank the first hit. -->

<!-- The basic idea is to play 5 [[Grand Finale+]]s on turns 1 and 3, -->
<!-- which deals 300 damage, enough to split on turn 1 and kill on turn 3. -->
<!-- You are never Weak on turn 3, -->
<!-- because the Weak debuff only lasts 1 turn, -->
<!-- and if you split turn 1 then the boss will heal on turn 2. -->

It is always possible to split on turn 1.
Look at your turn 1 draw:
* If you have [[Adrenaline]], the following line always works:

  [[Adrenaline]] [[Adrenaline]] [[Adrenaline]] [[Grand Finale+]] [[Backflip+]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Backflip+]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]]
* Otherwise, if you have [[Backflip+]], play basically the same line:

  [[Backflip+]] [[Adrenaline]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Backflip+]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]]
* Otherwise, your hand must be exactly [[Grand Finale+]] [[Acrobatics+]] [[Tactician+]] [[Wraith Form+]] [[Ascender's Bane]], so play:

  <!-- [[Acrobatics+]] [[Adrenaline]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Backflip+]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] -->
  [[Acrobatics+]] [[Adrenaline]] [[Grand Finale+]] [[Backflip+]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]] [[Adrenaline]] [[Grand Finale+]]

<!-- At this point, you have successfully exhausted down to 5 cards -->
<!-- (or 4 if you found Falling). -->
This blocks for as little as 8,
but the first hit is at most 34,
which you can tank.

On turn 2, Time Eater is always healing.
If the first move was not Head Slam (draw down and 2 [[Slimed]]),
the above lines work great --
since you have exhausted down to 5 cards (or 4 if you found Falling),
you can pass turn 2 (Time Eater is always healing) and play the following on turn 3 to win:

<p class='line'>[line A]</p>

[[Grand Finale+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Grand Finale+]]

So suppose the first move was Head Slam.
In this case,
we analyze the Falling case (where [[Wraith Form+]] is gone)
and the Wraith Form case separately.

Suppose you saw Falling.
If you play the same lines as above,
blocking for 16
(since the third one can only happen with [[Wraith Form+]] in the deck)
and therefore taking 18 damage,
you exhaust down to 4 cards at the end of your turn.
So you have 6 cards at the start of turn 2.
You only draw 4 of them, but you are not Weak.
If you draw either [[Acrobatics+]] or [[Backflip+]],
you can kill this turn with

<p class='line'>[line B1]</p>

([[Backflip+]]) [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Grand Finale+]]

Otherwise, your hand is exactly [[Slimed]] [[Slimed]] [[Grand Finale+]] [[Tactician+]].
Pass the turn, and next turn play

<p class='line'>[line B2]</p>

[[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Slimed]] [[Slimed]]

You are blocking 32 and the boss has 4 Strength,
dealing at most 36.
So you have now taken at most 20.
The boss is at 92 HP.
Even if the last move was Ripple (weak+block),
you draw your whole deck and play 5 Finales (line A),
still dealing 225 and winning handily.

The only problem is if the last move was Head Slam again.
In this case we repeat the same process of either killing now or passing the turn
(line B),
but this time passing the turn takes up to 36 damage.
So we end the fight having taken up to 56.
Fortunately,
the only Act 3 event that can force HP or max HP loss is Winding Halls
(-3 max TODO),
so if you Rest at the final campfire,
you will always enter the fight with at least 63 HP.

The final case is if you still have [[Wraith Form+]] and the first move is Head Slam.
In this case,
you might have only blocked for 8
and took 26 damage,
and you have 7 cards at the start of turn 2 instead of 6.
If you draw [[Acrobatics+]],
line B1 still works,
so suppose you do not.
Then you must have drawn at least one of [[Slimed]] or [[Wraith Form+]],
so play one of them and pass.
On turn 3, play a modified line of 11 cards:

<p class='line'>[line B2']</p>

[[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Acrobatics+]] [[Backflip+]] [[Grand Finale+]] [[Slimed]] ([[Wraith Form+]] or [[Slimed]])

You full block thanks to Intangible,
so have still only taken 26,
and the boss is at 92 HP.
You have also exhausted both [[Slimed]] and the [[Wraith Form+]],
so the situation is now identical to the Falling case
except you are Intangible turn 4.
So you will take at most 3 more damage,
for a total of 29.

</div>
</details>

The only details I haven't mentioned
are regarding how you beat your pre-turn-1-infinite Act 1 fights
(before you have enough gold for the second remove).
The only way you can fail to draw the whole deck turn 1
is by topdecking exactly [[Survivor]] [[Tactician]] [[Grand Finale]] [[Wraith Form]] [[Ascender's Bane]],
so of course you will do this every fight.
So play [[Survivor]] on [[Tactician]] and then play [[Wraith Form]] to take 0 damage.
Now you win on turn 2.

The only fight this doesn't work in is Sentries,
since you will gain 6 [[Dazed]]s.
But this is fine,
since you are now drawing into all the [[Adrenaline]]s,
which you can use to fill your hand (your deck now has 11 cards),
then play either [[Backflip]] or [[Acrobatics]],
then play [[Grand Finale]].

Finally,
for the floor 1 fight,
you will still have both Survivor and Neutralize,
so your worst draw is [[Survivor]] [[Tactician]] [[Grand Finale]] [[Neutralize]] [[Ascender's Bane]].
There's nothing to do but play [[Survivor]] and [[Neutralize]].
Unfortunately,
you are facing a Acid Slime (M) + Spike Slime (S) which are both attacking,
and you take 7 damage.
Unlucky.

<!-- ### TODO seed search -->

<!-- <img class='card' src='/img/sts/EscapePlan.png'> -->

### ironclad

Next up is Ironclad,
who wins on floor 2.
Here are the Pandora's (including necessary upgrades), relics, and potions:

[[[Sundial]]]<span class='space'></span>[[[Liquid Memories]]]

[[[Rage+]]][[[PommelStrike+]]][[[PommelStrike+]]][[[PommelStrike+]]][[[Warcry+]]][[[Warcry+]]][[[Warcry]]][[[Warcry]]][[[Offering]]]

This is the bog standard [[Sundial]] infinite,
with an extra [[Pommel Strike+]] for Falling
and a few [[Warcry+]] to fill up space.
(The unupgraded cards and [[Bash]] will be removed.)
The [[Liquid Memories]] solves turn 2 of the Heart.

Since this requires a relic,
the earliest possible floor is floor 2,
which can be a relic in a number of ways --
for example,
a question mark room can have a big chest
with an uncommon/rare relic and 82 gold.
However,
the most convenient source of relics
will typically be the [We Meet Again!](https://slaythespire.wiki.gg/wiki/We_Meet_Again!) event,
which gives you both a remove and a relic.
Here is the path:

<table class='pathing'>
<tr><td>f1</td><td>fight</td><td>119g, +memories</td></tr>
<tr class='inflection'><td>f2</td><td>ranwid</td><td>remove, +sundial</td></tr>
<tr><td>f3</td><td>fire</td></tr>
<tr><td>f4</td><td>shop</td><td>44g</td></tr>
<tr><td>f5</td><td>fire</td></tr>
<tr><td>f6</td><td>elite</td><td>69g</td></tr>
<tr><td>f7</td><td>fire</td></tr>
<tr><td>f8</td><td>elite</td><td>94g</td></tr>
<tr><td>f9</td><td>chest</td></tr>
<tr><td>f10</td><td>elite</td><td>119g</td></tr>
<tr><td>f11</td><td>fire</tr>
<tr><td>f12</td><td>shop</td><td>19g</td></tr>
<tr><td>f13</td><td>fire</tr>
<tr><td>f14</td><td>elite</td><td>44g</td></tr>
<tr><td>f15</td><td>fire</td></tr>
<tr><td>f16</td><td>boss</td><td>115g → 125g act 2</td></tr>
</table>

By the floor 6 elite,
the deck has removed [[Bash]] and a [[Warcry]],
and upgraded two [[Pommel Strike]]s.
This is always infinite turn 1 by playing [[Offering]].
We fight 2 elites under these conditions, losing 12 HP.
By floor 10,
two [[Warcry]]s are upgraded,
and the deck is infinite turn 1 without needing to play [[Offering]].
At the end of the act,
we have all 6 necessary upgrades
and 3 out of 4 removes
(with enough gold in act 2 to buy the last remove,
which is not relevant until Time Eater).

Again, Time Eater is complicated,
but only gets 13 damage through before dying.

<details>
<summary>ironclad time eater proof</summary>
<div>

I can't be bothered to format this one nicely,
so you get my raw notes.
(This is actually a proof that it's possible with 3 [[Warcry+]]s,
because my earlier strategy got fewer removes --
obviously it's even easier with just 2.)

    deck: bane cry+ cry+ cry+ pommel+ pommel+ (pommel+) rage+

    ripple
        cry+ cry+ pommel+x10 is 100 damage

        -> head slam
            rage+ pommel+x11 is 55 block into 54 damage, 100 + 77-20 = 57 = 157

            -> reverberate [deck: cry+ slime slime rage+ pommel+ pommel+ (pommel+)]
                (pommel+ cry+ rage+) pommel+x8 slime, 35 block into 42 damage, 247 splits
                ** 7 damage, 1 slime

            -> ripple
                (cry+ pommel+) pommel+x8 slime slime, 247 is a split, tim is stupid, this will never happen

        -> reverberate -> head slam
                rage+ pommel+x9, 45 block into 36 damage, 247 splits, 2 card plays next turn to guarantee exhausting 1 [slime]
                ** 0 damage, 1 slime, 1 cry+, draw down

    head slam
        cry+ cry+ rage+ pommel+x9 is 90 damage fullblock

        -> reverberate
            (pommel+ cry+ rage+) pommel+x7 slime slime, 35 block into 36 damage, 90+80 = 170

            -> head slam
                rage+ pommel+x8, 40 block into 36 damage, 250 splits, 3 card plays next turn to guarantee exhausting 2 [slime cry]
                ** 1 damage, 1 slime, draw down

            -> ripple
                pommel+ x12, 290 huge split, tim is stupid, this will never happen

        -> ripple
            (cry+ pommel+) pommel+x9 slime, 90+100 = 190

            -> head slam
                (pommel+ rage+) pommel+ x10, 190 + 57 = 247 splits, blocks 50 into 57 damage
                ** 7 damage, 3 slimes, draw down

            -> reverberate
                (pommel+ rage+) pommel+ x10, 190 + 57 = 247 splits, blocks 50 into 63 damage
                ** 13 damage, 1 slime

    post split, boss always has 6 str
    worst case is either (-7, 3 slimes, draw down) or (-13, 1 slime)
    consider former: pommel+ pommel+ pommel+ rage+ slime slime slime
    on heal turn you draw pommel+ pommel+ pommel+ rage+, spend 3 cards to go pommel slime slime
    next turn: 9 card plays, you draw pommel+ pommel+ pommel+ slime, draw pile rage+

    ripple
        pommel x9, deals 90

        -> head slam (63 dmg)
            pommel rage pommel rage pommelx7 slime, 75 block, deals 43 (-133)
            kill next turn (pommelx12 is 120)

        -> reverberate (81 dmg)
            pommel rage pommel rage pommelx8, 85 block, deals 36 (-126)
            kill next turn (pommelx12 is 120)

    head slam (40 dmg)
        pommel rage pommel rage pommelx4 slime, 45 block, deals 60 (-60)

        -> ripple
            pommelx12, deals 120 (-180)
            kill next turn (pommelx12 is 64)

        -> reverberate (54 dmg)
            pommel rage pommel rage pommelx6 slime slime, 65 block, deals 80 (-140)
            kill next turn (pommelx12 is 120)

    reverberate (48 dmg)
        pommel rage pommel rage pommelx4 slime, 45 block (take 3 in the -7 universe), deals 60 (-60)

        -> ripple
            pommelx12, deals 120 (-180)
            kill next turn (pommelx12 is 64)

        -> head slam (42 dmg) or reverberate (54 dmg)
            rage pommelx11, 55 block, deals 110 (-170)
            kill next turn (pommelx12 is 120)

</div>
</details>

### watcher

Watcher also wins on floor 2.
You would think that the [[Rushdown]] monkey
would win by playing the Rushdown infinite,
but actually...

[[[Sundial]]]<span class='space'></span>[[[Liquid Memories]]]

[[[Sanctity+]]][[[Empty Mind+]]][[[Empty Mind+]]][[[Vault+]]][[[Pressure Points+]]][[[Rushdown]]][[[Wish]]][[[Wish]]]

Don't be fooled by the [[Rushdown]] --
that can be literally any power for Falling
(but I thought this one was funniest).
It's just the Ironclad again,
with [[Pressure Points]] as the damage source to deal with Time Eater.

The reason [[Rushdown]] + [[Mental Fortress+]] doesn't work isn't just Time Eater, though;
it's that it's possible to see 16 Spikers in the same run,
and basically the only combination that works against those is [[Eruption+]] + [[Inner Peace]],
which is too slow for Time Eater.

<table class='pathing'>
<tr><td>f1</td><td>fight</td><td>169g, +memories</td></tr>
<tr class='inflection'><td>f2</td><td>ranwid</td><td>remove, +sundial</td></tr>
<tr><td>f3</td><td>fire</td></tr>
<tr><td>f4</td><td>shop</td><td>94g</td></tr>
<tr><td>f5</td><td>fire</td></tr>
<tr><td>f6</td><td>fight</td><td>154g</td></tr>
<tr><td>f7</td><td>shop</td><td>54g</td></tr>
<tr><td>f8</td><td>fire</td></tr>
</table>

You will take some damage on floor 6 trying to double [[Wish]]
(although note that there's enough spare gold that you don't need to play either of them),
but after removing [[Eruption]] [[Vigilance]] [[Wish]] and upgrading both [[Empty Mind]]s
(which happens by floor 7),
the deck is turn 1 infinite with [[Sundial]] setup.
The setup is always trivial because the main loop of the infinite --
alternating any of the three draw cards to accumulate energy --
doesn't deal damage.

For style points, the second [[Wish]] can played every fight of Act 2
and removed in the guaranteed Act 3 shop.
This accomplishes nothing,
but now you are rich.

This time,
Time Eater is actually quite easy,
because apparently [[Pressure Points+]] is an overpowered card.
If you draw [[Empty Mind+]], play (energy and [[Sundial]] numbers shown):

> mind[2/2] sanctity[3/1] pp[2/1] mind[3/0] sanctity[2/2] mind[3/1] sanctity[4/0] pp[3/0] mind[2/2] sanctity[3/1] pp[2/1] vault[0/1]

Otherwise, play:

> pp[2/2] sanctity[1/2] mind[2/1] sanctity[3/0] mind[2/2] sanctity[3/1] pp[2/1] mind[3/0] sanctity[2/2] mind[3/1] pp[2/1] vault[0/1]

After [[Vault+]],
play a similar turn again,
at which point you have played [[Pressure Points+]] 6&nbsp;times
dealing 231&nbsp;damage.
You tank one hit and kill on your next turn.

### defect

I originally had a solution here.

## part 2: the real game, slay the spire

### silent

[[[Potion Belt]]][[[Tungsten Rod]]][[[Bag of Preparation]]][[[Ninja Scroll]]][[[Gambling Chip]]][[[Omamori]]]

[[[Gambler's Brew]]][[[Gambler's Brew]]][[[Ghost in a Jar]]][[[Smoke Bomb]]]

[[[Nightmare]]][[[Nightmare]]][[[Wraith Form]]][[[Setup]]][[[Setup]]][[[Well-Laid Plans]]][[[Alchemize]]][[[Grand Finale]]]

### defect

This is to let you play 4 cards of your choice on turn 1:

[[[Bottled Lightning]]]

[[[Seek+]]][[[Seek+]]][[[Seek+]]]

This is to ensure your opening hand contains no [[Pain]] or [[Normality]]:

[[[Boot Sequence]]][[[Chill+]]][[[Chill+]]][[[Chill+]]]

This is the main infinite loop for most fights (second [[All for One]] is for Falling):

[[[Madness]]][[[Madness]]][[[Hologram+]]][[[All for One]]][[[All for One]]]

This is the Time Eater specific section of the deck
(play the first four cards and the three [[Chill+]] on turn 1 to block forever,
then play the last two whenever they come around):

[[[Blue Candle]]]

[[[Panacea+]]][[[Biased Cognition+]]][[[Biased Cognition+]]][[[Loop+]]][[[Capacitor]]][[[Zap]]]

Finally,
this is the Heart specific section of the deck
(duplicate a [[Seek+]] to get the cards turn 1,
and duplicate a [[Madness]] onto the [[Equilibrium]] to play the infinite repeatably,
which is barely block positive through Beat+Frail with 2 Dexterity):

[[[Duplication Potion]]][[[Duplication Potion]]]

[[[Equilibrium]]][[[Reprogram+]]]

### watcher

[[[Bottled Lightning]]]<span class='space'></span>[[[Ancient Potion]]][[[Weak Potion]]]

[[[Omniscience+]]][[[Omniscience]]][[[Omniscience]]][[[Omniscience]]][[[Omniscience]]][[[Omniscience]]][[[Omniscience]]][[[Alpha]]][[[Wish+]]][[[Dramatic Entrance]]][[[Dramatic Entrance]]][[[Dramatic Entrance]]][[[Dramatic Entrance]]][[[Vigilance+]]][[[Rushdown]]]

### ironclad

## part 3: the "real" game, "slay the spire"

### defect

### watcher

### silent

### ironclad

## summary
