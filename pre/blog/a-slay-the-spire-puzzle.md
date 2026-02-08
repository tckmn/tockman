2024-02-21 23:56 -0500 // games, video games, slay the spire, puzzles, math

# A Slay the Spire puzzle

You are peacefully going about your day
when you are suddenly thrust into the following position
in a game of Slay the Spire.
What do you do?
[EXCERPT]

.spire
.style {{
    main li { margin: 0; span.desc { color: #888; font-size: 12pt; } }
    main details ul { margin: 0; }
}}

(This puzzle is probably not particularly accessible
to readers who haven't played Slay the Spire,
but if you want to try it anyway,
[here's an excessively detailed explanation of all the mechanics at play](mechanics).)

[![](puz1.png)](puz1.png)

[![](puz2.png)](puz2.png)

Obviously,
the rest of this blog post contains spoilers for the puzzle,
so stop reading if you want to solve it yourself.

## how did we get here?

On my path to unlocking all the Watcher ascensions,
I found myself on floor 48
(the floor before the final act 3 campfire)
with a deck that absolutely would not beat Awakened One.
It had literally no scaling,
and my plan for pretty much all of act 3
was "I have two [[Scrawl]]s and if I find [[Rushdown]] I go infinite".
I don't have screenshots from before the boss fight,
but the deck was:

<img class='card' src='/img/sts/Scrawl+.png'><img class='card' src='/img/sts/Scrawl+.png'><img class='card' src='/img/sts/EmptyMind+.png'><img class='card' src='/img/sts/InnerPeace.png'><img class='card' src='/img/sts/CutThroughFate.png'><img class='card' src='/img/sts/EmptyFist+.png'><img class='card' src='/img/sts/DefendP.png'><img class='card' src='/img/sts/Eruption+.png'><img class='card' src='/img/sts/StrikeP.png'><img class='card' src='/img/sts/StrikeP.png'><img class='card' src='/img/sts/StrikeP.png'><img class='card' src='/img/sts/Vigilance+.png'><img class='card' src='/img/sts/Violence.png'><img class='card' src='/img/sts/AscendersBane.png'>

Floor 48 was a shop,
which I had pathed to in order to find literally anything to save me --
maybe a potion,
but realistically probably an infinite enabler.
(Which in practice means,
yes,
I was basically just thinking "hello please give me [[Rushdown]]".)

I opened the shop,
and I did not find a [[Rushdown]].
Instead,
I stared at the shop,
thought for a long time,
and decided there was exactly one thing I could do in that shop
to maximize my chances of survival:
remove a [[cpa|Strike]],
buy a [[Blessing of the Forge]],
and buy both colorless cards on offer:

<img class='card' src='/img/sts/Purity.png'><img class='card' src='/img/sts/Chrysalis.png'>

Certainly unconventional,
but the justification was that my only hope was pulling an infinite out of the [[Chrysalis]].
And as you might guess,
that's what the puzzle is about.

(I am about to reveal the answer,
so now is your last chance to stop reading if you want to try finding it!)

## the provable infinite

It is possible to guarantee infinite damage/energy/block
on both phases of Awakened One,
and therefore provably win the game,
from the pictured state.
As a reminder if you don't want to scroll up,
the hand is
* [[Scrawl+]] <span class='desc'>(0 cost draw to full hand)</span>
* [[Empty Mind+]] <span class='desc'>(1 cost draw 3, exit stance)</span>
* [[Inner Peace]] <span class='desc'>(1 cost draw 3 if in calm, enter calm otherwise)</span>
* [[cpa|Strike]]

and the draw pile is
* [[cps|Defend]]
* [[Eruption+]]
* [[cpa|Strike]]
* [[Vigilance+]]
* [[Cut Through Fate]] <span class='desc'>(1 cost 7 damage, scry 2, draw 1)</span>
* [[Empty Fist+]] <span class='desc'>(1 cost 14 damage, exit stance)</span>
* [[Pressure Points]] at 0 cost <span class='desc'>(8 mark, all enemies lose mark hp)</span>
* [[Collect]] <span class='desc'>(X cost get a [[Miracle+]] the next X turns)</span>
* [[Purity]] <span class='desc'>(0 cost exhaust 3)</span>
* [[Worship]] at 0 cost <span class='desc'>(5 mantra)</span>

The infinite, assuming all cards in hand, goes like this:
1. [[Cut Through Fate]] drawing [[Empty Mind+]]
2. [[Worship]] for +5 mantra
3. [[Inner Peace]] to enter calm
4. [[Empty Mind+]] for +2 energy drawing [[Cut Through Fate]], [[Worship]], [[Inner Peace]]

Since [[Worship]] is free from [[Chrysalis]],
each cycle costs 3 energy.
But you get 2 back from leaving calm,
so each cycle costs net 1 energy.
And every other cycle you enter divinity and gain 3 energy,
for an overall gain of 1 energy every two cycles.
In the meantime, [[Cut Through Fate]] has been doing infinite damage
(and you can replace [[Worship]] with [[Pressure Points]] after accumulating enough energy
to speed things up greatly).

How do you guarantee it?
Exhausting down to 6 cards is definitely enough,
since if your initial draw has [[Cut Through Fate]] you just start the cycle,
and if not you play [[Empty Mind]] first.
This amounts to playing [[Purity+]] for 5,
and also playing [[Collect]] for anything.
[[Scrawl]] draws all but 3,
and then [[Inner Peace]] followed by [[Empty Mind]] just leaves 1.
If it's [[Purity]] or [[Collect]],
you have [[Cut Through Fate]],
so play it.
Finally,
drink the [[Blessing of the Forge]],
play [[Collect]],
and play [[Purity]] on 5 garbage cards
(there are only 4 cards in the infinite,
2 of which are in discard,
and there are 8 other cards in your hand,
so at least 8 - 2 = 6 of them are garbage).

Of course,
you might not have to do any of this --
I [[Scrawl]]ed into [[Purity]] [[Collect]] and was able to immediately start the infinite.
It's probably possible to guarantee actually executing the infinite this turn,
especially with [[Duplication Potion]] and [[Distilled Chaos]],
but I didn't bother figuring it out since you can tank the current hit anyway.

Cool! So that's it for this post, right?

## that's it for this post, right?

... well.

That was a pretty lucky [[Chrysalis]].
The entire strategy hinged on the free [[Worship]] that it generated.
So just how lucky did I have to get to win this game?

For the sake of simplicity,
let's say I win if I go infinite
and I lose if I don't.
This isn't really true,
because I'm sure there are plenty of ways 3 free skills can be good enough without being infinite,
but it's obviously impractical to analyze them all,
so this will at least give a lower bound.

It's still impractical to compute the probability of an infinite, right?
Well let's do it anyway.
Here's a categorization of all the Watcher skills
based on what they would do for my deck:

* **Whiffs**:
  These will never do anything to directly create an infinite,
  so they are essentially curses.
  (But they still might be useful for energy and damage neutral infinites
  that need some other card to play for its effect.)

  [[Alpha]]
  [[Conjure Blade]]
  [[Deceive Reality]]
  [[Empty Body]]
  [[Halt]]
  [[Indignation]]
  [[Judgment]]
  [[Meditate]]
  [[Pressure Points]]
  [[Prostrate]]
  [[Spirit Shield]]
  [[Third Eye]]
  [[Wave of the Hand]]
  [[Wreath of Flame]]

* **Exhaust/Retain**:
  These cards will get out of the way of an infinite
  by not eating up draws,
  but they won't produce an infinite themselves.

  [[Blasphemy]]
  [[Collect]]
  [[Crescendo]]
  [[Deus Ex Machina]]
  [[Omniscience]]
  [[Perseverance]]
  [[Protect]]
  [[Scrawl]]
  [[Simmering Fury]]
  [[Tranquility]]
  [[Vault]]

  Blasphemy requires an upgrade,
  but I'm assuming you can manage that with the Blessing of the Forge.
  Simmering Fury doesn't exhaust or retain,
  but I'm putting it in here because it adds 2 to your draw.

* **Infinites**:
  These cards win the game,
  so long as the deck can be exhausted down enough.

    * [[Worship]]:
      [Cut Through Fate, Worship, Inner Peace, Empty Mind+] is energy positive and does infinite damage,
      as we saw.

    * [[Swivel]]:
      [Cut Through Fate, Swivel, Inner Peace, Empty Mind+] is energy neutral and does infinite damage.
      (This one is pretty funny. I've never thought of this card as an infinite enabler before!)

    * [[Inner Peace]] or [[Empty Mind]]:
      [Cut Through Fate, Inner Peace, Empty Mind] is energy neutral if one of them is free
      and does infinite damage.
      (There's room to fit a 0 cost card in there if you get one that can help accelerate.)

    * [[Pray]]:
      [Insight, Pray, Inner Peace, Empty Mind+] is energy positive,
      and after accumulating enough you can swap out Insight+Pray for Cut Through Fate
      to do infinite damage.

    * [[Evaluate]]:
      [Insight, Evaluate, Inner Peace, Empty Mind+] is energy neutral and makes infinite block.
      But does no damage.
      Oops, that'll be a long fight.
      And you need to handle the Voids from Awakened One.
      Though if you get something 0 cost that's useful (e.g. Pressure Points or Prostrate),
      you can stick it on the end.

    * [[Sanctity]]:
      [Sanctity, Inner Peace, Empty Mind+] is energy neutral and makes infinite block.
      Again, no damage,
      but any other free skill can be appended.

* **Illegal**:
  Chrysalis can't generate this card,
  because forcing the player to stall won fights
  to see whether RNG spits out metascaling is no fun.

  [[Wish]]

Great!
Let's run the numbers.
Barring garbage turn 1s like Strike Strike Defend Eruption Empty Fist,
it's reasonably safe to assume that by the end of turn 2,
we can achieve the following:
* Draw [[Ascender's Bane]] on turn 1 so it exhausts.
* Play [[Chrysalis]].
* Exhaust [[Scrawl+]] [[Scrawl+]] [[Violence]] (they're all free), likely in service of the below.
* Draw [[Purity]] together with at least 5 garbage cards (i.e. not used in the infinite), and exhaust them.
* Draw and retain an [[Insight]] if using one of those infinites.
* Block for at least 22 (there will be 22+8×4+6+6 = 66 incoming damage, and I came in with 45hp). Killing a bird counts for 6. Alternatively, don't block and go infinite on turn 2.

After all of that,
the deck will have 7 cards left:
9 non-exhausting cards originally,
plus 3 from [[Chrysalis]],
minus 5 from [[Purity+]].
Is that enough to get the infinite up consistently?
If you can manage to end turn 2 in calm,
the answer is yes:
you draw at least one of [[Cut Through Fate]], [[Inner Peace]], or [[Empty Mind+]] on turn 3.
If not...
the answer is still probably yes,
because even if you bottom deck both [[Cut Through Fate]] and [[Empty Mind+]],
there are ways to save yourself
(e.g. either potion, if you didn't use them both during setup).

... unless your infinite is [[Evaluate]] or [[Sanctity]],
which only block,
because then it needs to work for probably hundreds of turns
as you slowly chip away at Awakened One's HP (which is regenerating).
Ouch.
For [[Sanctity]],
once you get your infinite once,
you can choose to end the cycle when you're in calm,
so 7 cards is fine.
Awakened One is sometimes giving you [[Void]]s,
but you will still draw at least one of [[Sanctity]] [[Cut Through Fate]] [[Inner Peace]] [[Empty Mind+]],
and the infinite only has a startup cost of 2.

It's worse for [[Evaluate]].
You definitely need the [[Insight]] to be retained at the end of each turn
(otherwise you have 9 cards including [[Insight]] and [[Void]],
and only 4 of them say draw,
so in one of the hundreds of turns you will almost definitely miss all 3).
But that means you can't end your turns in calm,
so you still lose, because even with only 8 cards,
now [[Inner Peace]] stops saying draw.
So you need at least one of your [[Chrysalis]] cards
to come from the **Exhaust/Retain** category above.
That lets you end all your turns in calm,
and then you have 8 cards and can't miss all of [[Insight]] [[Cut Through Fate]] [[Inner Peace]] [[Empty Mind+]].

<hr>

Ok! So after all of that... what you need out of [[Chrysalis]] is *either*:
* any of [[Worship]] [[Swivel]] [[Inner Peace]] [[Empty Mind]] [[Pray]] [[Sanctity]]
* OR [[Evaluate]] plus any of the following:
  * [[Pressure Points]] (makes the infinite damage positive)
  * [[Prostrate]] (makes the infinite energy positive)
  * [[Wreath of Flame]] (then you only need to run the infinite twice)
  * another [[Evaluate]] (then you can retain multiple [[Insight]]s)
  * any of the 11 cards in the **Exhaust/Retain** category

Let's take care of the first case first:
there are 32 legal Watcher skills,
and 6 of them are hits,
so the probability that you get any of them is 1 - (1 - 6/32)³ = 46.36%.
Okay, that's not bad.

Now for the Evaluate case.
Let's count the ways to draw a good Evaluate infinite
by splitting on how many you get.
There's 1 way to draw three Evaluates.
There's 3\*25 ways to draw two Evaluates plus a non-infinite non-Evaluate card.
And there's 3\*(14\*25 + 25\*14 - 14\*14) ways to draw exactly one Evaluate
and two non-infinite non-Evaluate cards,
at least one of which is in the set of 14.
So the chance you don't get any of the easy infinites but you do get an Evaluate infinite
is 1588/32768 = 4.85%.

Adding those together,
it comes out to a 51.21% chance of [[Chrysalis]] giving you what you need.
So just over half!
Given that I think almost any other decision at the shop
would have given me a &lt;10% chance of survival
(this relies on all 4 purchases of [[Chrysalis]], [[Purity]], [[Blessing of the Forge]], card remove),
I feel vindicated in my decisions.

... er, hang on a second.

I just counted the Watcher skills again,
and there's actually 34 of them, not 33.
Did I forget one?

<img style='width:350px;max-width:70%' src='/img/sts/ForeignInfluence.png'>

... oh no.

## oh no

I saved this one for last
because it adds,
uh,
a bit more complexity,
shall we say.
(The probability that it matters is many times lower
than the effect of various other assumptions I made,
so I could just ignore it,
but that would be *lame*.)

The upgrade says "it costs 0 this turn",
but unfortunately that actually means "it costs 0 until leaving your hand",
so it's basically useless.
Also,
you're allowed to skip the card,
so at worst [[Foreign Influence]] goes under "Exhaust/Retain"
(and therefore enables [[Evaluate]] all the same).
So we only need to consider cards that actually go infinite themselves.

Let's start with all the whiffs.
Fundamentally,
the problem with the deck as is is that the infinite cycle
[[Cut Through Fate]] [[Inner Peace]] [[Empty Mind+]] is net -1 energy.
So you need something that either generates energy
or draws for cheaper.
None of these cards can help with that:

[[Anger]] [[Bash]] [[Blood for Blood]] [[Bludgeon]] [[Body Slam]] [[Carnage]] [[Clash]] [[Cleave]] [[Clothesline]] [[Fiend Fire]] [[Headbutt]] [[Heavy Blade]] [[Hemokinesis]] [[Immolate]] [[Iron Wave]] [[Perfected Strike]] [[Pummel]] [[Rampage]] [[Reckless Charge]] [[Searing Blow]] [[Sever Soul]] [[Sword Boomerang]] [[Thunderclap]] [[Twin Strike]] [[Uppercut]] [[Whirlwind]] [[Wild Strike]] [[All-Out Attack]] [[Backstab]] [[Bane]] [[Choke]] [[Dagger Spray]] [[Dash]] [[Die Die Die]] [[Endless Agony]] [[Eviscerate]] [[Finisher]] [[Flechettes]] [[Flying Knee]] [[Glass Knife]] [[Grand Finale]] [[Masterful Stab]] [[Poisoned Stab]] [[Predator]] [[Riddle with Holes]] [[Skewer]] [[Slice]] [[Sneaky Strike]] [[Sucker Punch]] [[Unload]] [[All for One]] [[Ball Lightning]] [[Barrage]] [[Beam Cell]] [[Blizzard]] [[Bullseye]] [[Claw]] [[Cold Snap]] [[Compile Driver]] [[Core Surge]] [[Doom and Gloom]] [[FTL]] [[Go for the Eyes]] [[Hyperbeam]] [[Melter]] [[Rebound]] [[Rip and Tear]] [[Streamline]] [[Sunder]] [[Thunder Strike]] [[Bowling Bash]] [[Brilliance]] [[Carve Reality]] [[Conclude]] [[Consecrate]] [[Crush Joints]] [[Empty Fist]] [[Fear No Evil]] [[Flurry of Blows]] [[Flying Sleeves]] [[Follow-Up]] [[Just Lucky]] [[Ragnarok]] [[Reach Heaven]] [[Sands of Time]] [[Sash Whip]] [[Signature Move]] [[Talk to the Hand]] [[Tantrum]] [[Wallop]] [[Weave]] [[Windmill Strike]] [[Dramatic Entrance]] [[Hand of Greed]] [[Mind Blast]] [[Swift Strike]]

Of the remaining ones:

* All of [[Cut Through Fate]] [[Dagger Throw]] [[Pommel Strike]] [[Quick Slash]] [[Scrape]] [[Sweeping Beam]] [[Wheel Kick]] say "draw" on them, but cost 1 or more, so they don't help. (If the upgrade made the card free for rest of combat, they would all work except for Scrape.)

* [[Flash of Steel]] just wins.

* [[Dropkick]] and [[Heel Hook]] do the trick as long as you can apply vulnerable or weak respectively.

* Honorable mention to [[Meteor Strike]], which is playable with upgraded Foreign Influence and would make the infinite energy positive if we had an orb slot. (BaseMod gives you an orb slot when you attempt to channel an orb as non-Defect, but I want the analysis to be for vanilla.)

So that's just 3 out of 107 cards that might work,
and two of them have pretty strong caveats
given that the deck has no source of vulnerable/weak.
How can we get those?

* Vulnerable can come from [[Indignation]],
  or another [[Foreign Influence]] into any of [[Bash]], [[Thunderclap]], [[Uppercut]], [[Beam Cell]], or [[Crush Joints]].

* Weak can come from [[Wave of the Hand]],
  or another [[Foreign Influence]] into any of [[Clothesline]], [[Uppercut]], [[Sucker Punch]], [[Go for the Eyes]], or [[Sash Whip]].

Unsurprisingly,
these probabilities are extremely obnoxious to compute.
I've hidden the details for your sake,
but you can still see them if you really want to.

<details><summary>show/hide details</summary><div>

Alright,
so let's count how many ways there are to draw something good
by casework again,
at the same scale for sanity
(so that e.g. the number of ways to draw a [[Foreign Influence]] as your first [[Chrysalis]] card
which gives [[Dropkick]] as the first choice is 1/107).
There are 33 legal Watcher skills to come out of [[Chrysalis]];
we're assuming we didn't get any of the 7 infinite enablers,
so we're actually working with a pool of 26.

For futher sanity,
we can define *f*(*n*) = 1-((107-*n*)/107)((106-*n*)/106)((105-*n*)/105)
to be the probability that you find any of *n* cards in a [[Foreign Influence]] roll.
Also,
*f*(*n*,*m*) = (1-*f*(*m*))(1-((107-*n*-*m*)/(107-*m*))((106-*n*-*m*)/(106-*m*))((105-*n*-*m*)/(105-*m*)))
is the probability you failed to find any of *m* cards
but did find any of *n* cards.

With multiple [[Foreign Influence]]s,
you need to specify a strategy --
fortunately,
there's a clearly best one,
which is to pick the card resulting in the largest increase
in number of possible cards
to complete an infinite.

* One [[Foreign Influence]]: 3 possible slots for it, times...
    * 2*f*(3) ways to get a hit with both [[Indignation]] and [[Wave of the Hand]]
    * 2(2\*24-1)*f*(2) ways to get a hit with only one of [[Indignation]]/[[Wave of the Hand]]
    * 23\*23*f*(1) ways to get a hit with neither [[Indignation]]/[[Wave of the Hand]]
* Two [[Foreign Influence]]s: 3 possible slots for the other card, times...
    * 2 ways for the other card to be [[Indignation]]/[[Wave of the Hand]], times...
        * *f*(2) ways for the first [[Foreign Influence]] to hit
        * *f*(5,2)*f*(3) ways for the first to give the *other* status and the second to hit
        * (1-*f*(7))*f*(2) ways to whiff first and hit second
    * 23 ways for the other card to be useless, times...
        * *f*(1) ways for the first [[Foreign Influence]] to hit
        * *f*(2,1)*f*(6) ways for the first to give [[Dropkick]]/[[Heel Hook]] and the second to hit
        * *f*(1,3)*f*(3) ways for the first to give [[Uppercut]] and the second to hit
        * *f*(8,4)*f*(2) ways for the first to give only one status and the second to hit
        * (1-*f*(12))*f*(1) ways to whiff first and hit second
* Three [[Foreign Influence]]s:
    * *f*(1) ways for the first [[Foreign Influence]] to hit
    * *f*(2,1) ways to get [[Dropkick]]/[[Heel Hook]] first, times...
        * *f*(6): immediate hit
        * *f*(1,6)*f*(10): the other of [[Dropkick]]/[[Heel Hook]]
        * *f*(4,7)*f*(7): the wrong status
        * (1-*f*(11))*f*(6): something useless
    * *f*(1,3) ways to get [[Uppercut]] first, times...
        * *f*(3): immediate hit
        * (1-*f*(3))*f*(3): something useless
    * *f*(8,4) ways to get a single status first, times...
        * *f*(2): immediate hit
        * *f*(1,2)*f*(7): the wrong one of [[Dropkick]]/[[Heel Hook]]
        * *f*(5,3)*f*(3): the other status
        * (1-*f*(8))*f*(2): something useless
    * 1-*f*(12) ways to whiff first, times the value above ("for the other card to be useless")

Here's some Ruby code to add everything up:

    def g n, t; 1-((t-n)/(t-0))*((t-1-n)/(t-1))*((t-2-n)/(t-2)); end
    def f n, m=0; (1-g(m, 107.to_r))*g(n, 107.to_r-m); end
    def out x; puts x; puts x.to_f; end

    one = 3 * (2*f(3) + 2*(2*24-1)*f(2) + 23*23*f(1))
    twofi = f(1) + f(2,1)*f(6) + f(1,3)*f(3) + f(8,4)*f(2) + (1-f(12))*f(1)
    two = 3 * (2*(f(2) + f(5,2)*f(3) + (1-f(7))*f(2)) + 23*twofi)
    three = f(1) + f(2,1)*(f(6) + f(1,6)*f(10) + f(4,7)*f(7) + (1-f(11))*f(6)) +
        f(1,3)*(f(3) + (1-f(3))*f(3)) +
        f(8,4)*(f(2) + f(1,2)*f(7) + f(5,3)*f(3) + (1-f(8))*f(2)) +
        (1-f(12))*twofi

    total = 33**3

    out one/total
    out two/total
    out three/total
    out (one+two+three)/total

Which gives the output:

    4012997/2377651815
    0.001687798429813408
    71552617889/471928220500275
    0.00015161758670237925
    103503659463493/31223557615332361125
    3.3149220450352337e-06
    57536615629709323/31223557615332361125
    0.0018427309385608227

</div></details>

When all is said and done,
it turns out the probability that you don't get an immediate infinite,
but [[Foreign Influence]] saves you,
is... 0.184%.

Redoing the numbers from before,
we get a 1 - (1 - 6/33)³ = 45.23% chance of a 1-card infinite,
and a 1744/35937 = 4.85% chance of an Evaluate infinite.
Adding everything up,
the chance of any infinite is 50.266%,
which is lower than if [[Foreign Influence]] didn't exist (obviously)
but still just above half!

## but why?

idk math is fun
