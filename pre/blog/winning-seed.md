2025-11-27 01:05 -0500 // draft, games, video games, slay the spire

# An extremely unloseable Slay the Spire seed, and how to find more

If you're a Slay the Spire enthusiast,
you might have seen [OohBleh's blog post about a provably unwinnable seed](https://oohbleh.github.io/losing-seed/).
But what about a provably unloseable seed?
[EXCERPT]

.spire
.style {{
summary { user-select: none; cursor: pointer; background-color: #383838; padding: 5px 20px; }
details > div { background-color: #282828; padding: 10px 20px; }
details pre { font-size: 10pt; }
p.line { margin-top: -0.2em; margin-bottom: -0.8em; color: #888; font-size: 11pt; }
}}

Okay,
obviously no seed is literally unloseable,
because you can walk into floor 1 and press end turn 20 times and die.
So instead,
I will frame the question slightly differently:

**What is the lowest floor where you can prove that you will win the game (on A20H), if playing optimally?**

I want to talk about a few things before answering this question,
but for the sake of not burying the lede,
here are the best numbers I could come up with:
Ironclad can win the game on floor TODO,
Silent can win on floor 0 (!),
Defect can win on floor TODO, and
Watcher can win on floor TODO.

## part 1: the fake game, "slay" the "spire"

You might be able to guess
that the basic idea looks pretty much the same for all the characters:
boss swap into [[Pandora's Box]],
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
  as above,
  you can assume pessimal RNG,
  so you need to pick a card that you can guarantee will be available for this event.
  You can achieve this either by e.g. adding a dead Power if you have no other powers,
  or e.g. adding a second copy of every necessary Attack so you always have the option to pick one.

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
Here is the ideal Pandora's Box (with necessary upgrades shown):

<img class='card' src='/img/sts/Acrobatics+.png'><img class='card' src='/img/sts/Tactician+.png'><img class='card' src='/img/sts/Backflip+.png'><img class='card' src='/img/sts/GrandFinale+.png'><img class='card' src='/img/sts/WraithForm+.png'><img class='card' src='/img/sts/Adrenaline.png'><img class='card' src='/img/sts/Adrenaline.png'><img class='card' src='/img/sts/Adrenaline.png'><img class='card' src='/img/sts/Adrenaline.png'><img class='card' src='/img/sts/Adrenaline.png'>

The first four cards are for the infinite,
the Wraith is for Falling (and act 1 hallways),
and the Adrenalines are just there to take up space.

The ideal Act 1 map is a fight,
then a shop (for [[Neutralize]] remove),
then a bunch of elites and combats to get enough gold,
then another shop (for [[Survivor]] remove).
You also need four fires anywhere on your path
(the deck needs 5 upgrades, a recall, and a rest;
but there are 3 guaranteed fires).

Once [[Survivor]] and [[Neutralize]] are removed,
you are guaranteed to draw your whole deck turn 1:
the only cards that don't draw are Tactician, Finale, Finale, and Ascender's Bane;
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
by looping [[Acrobatics]] on [[Tactician+]]
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
Here is the deck, including necessary upgrades, relics, and potions:

[[Sundial]] [[Liquid Memories]]

<img class='card' src='/img/sts/Rage+.png'><img class='card' src='/img/sts/PommelStrike+.png'><img class='card' src='/img/sts/PommelStrike+.png'><img class='card' src='/img/sts/PommelStrike+.png'><img class='card' src='/img/sts/Warcry+.png'><img class='card' src='/img/sts/Warcry+.png'><img class='card' src='/img/sts/Warcry+.png'><img class='card' src='/img/sts/Warcry.png'><img class='card' src='/img/sts/Warcry.png'>

<details>
<summary>ironclad time eater proof</summary>
<div>

I can't be bothered to format this one nicely,
so you get my raw notes.

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

### defect

I originally had a solution here.

## part 2: the real game, slay the spire

### defect

### watcher

### silent

### ironclad

## part 3: the "real" game, "slay the spire"

### defect

### watcher

### silent

### ironclad

## summary
