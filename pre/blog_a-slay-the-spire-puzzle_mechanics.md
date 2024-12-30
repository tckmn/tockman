.title Mechanics - a Slay the Spire puzzle
.desc hi
.subpage
.spire

Here's the screenshots again:

[![](../puz1.png)](../puz1.png)

[![](../puz2.png)](../puz2.png)

Unfortunately,
I'm going to have to give you a bunch of irrelevant information,
because if I only told you the relevant information
that would give away part of the puzzle.
So get ready for a lot of words.

## the basics

*(If you've played Slay the Spire before,
you can skip this section.)*

Slay the Spire is a turn-based card battling game.
I am playing as the Watcher, on the left.
It is currently my turn,
and I am fighting two enemies, on the right:
a Cultist
and the Awakened One.
We all have **health** bars,
shown below us.
Whenever anyone's health reaches 0,
they die.
If all the enemies die, I win,
and if I die, I lose.

The primary two mechanics in fights are dealing **damage** and gaining **block**.
When anyone deals damage to anyone else,
the amount of damage is first subtracted from their current block,
if they have any.
If the amount of damage exceeds the amount of block,
the unblocked damage is subtracted from their health.
Any remaining block is removed at the start of one's turn.
Currently, nobody has any block.

How do I and my opponents damage or block?
Let's start with the opponents.
All enemies have preset attack patterns,
and their current **intent** is shown above their head.
When I end my turn,
each enemy will perform the depicted action.
In this case,
the Cultist will deal 6 damage,
and the Awakened One will deal 8 damage 4 times.

On the other hand,
the way I do things is by playing **cards**.
All of the cards in my deck start in the **draw pile** at the beginning of the fight,
ordered randomly.
At the start of each turn,
I draw 5 cards into my **hand**.
Each card has an **energy** cost,
depicted in the top left.
My current energy is shown to the left of my hand:
I have 2 energy left out of the 4 that I start with every turn.
My energy is set to 4 at the beginning of every turn;
any unused energy from the previous turn is wasted.
To **play** a card from my hand,
I first have to pay its energy cost.
Then its effect occurs.
Finally,
after its effect has been processed,
it goes into the **discard pile**.

If at any point I attempt to draw a card
but my draw pile is empty,
all the cards in my discard pile get shuffled
and then moved back to the draw pile.
Also,
there is a hand size limit of 10,
so I can never have more than 10 cards in my hand at once.

## the cards

If a card has a + after its name,
that means it's been **upgraded**,
which improves it in some way.
If you hover over a card name,
you will see its in-game text --
the text in parentheses indicates what the upgrade does.

My discard pile is empty.
I have the following cards in my hand:

* [[Scrawl+]].
    For 0 energy,
    this draws cards until my hand has 10 cards in it.
    It then **Exhausts**,
    which means that instead of going into my discard pile,
    it disappears for the rest of this fight.

* [[Empty Mind+]].
    For 1 energy,
    this exits my **stance** and draws 3 cards.
    Stances are a mechanic unique to the Watcher,
    the character I am playing as.
    They are simply a state that persists between turns.
    I am always in one of four stances:

    * **Wrath**. When in Wrath, all of my attacks deal double damage, but all enemy attacks also deal double damage.
    * **Calm**. Being in Calm has no effect, but upon exiting Calm, I immediately gain 2 Energy.
    * **Divinity**. When in Divinity, all of my attacks deal triple damage. Also, I immediately gain 3 Energy upon entering Divinity.
    * No stance. I start the fight in no stance, and e.g. playing [[Empty Mind+]] will leave me in no stance again.

* [[Inner Peace]].
    For 1 energy,
    this either enters Calm (if I am not currently in Calm)
    or draws 3 cards (if I am currently in Calm).

* [[cpa|Strike]].
    For 1 energy,
    this deals 6 damage.
    This card **targets** an enemy,
    meaning I choose which one to deal the 6 damage to.

As for the cards in my draw pile:

* [[cps|Defend]]. For 1 energy, this gains 6 block.

* [[Eruption+]]. For 1 energy, this deals 9 damage, then enters Wrath.

* [[Vigilance+]]. For 2 energy, this gains 12 block, then enters Calm.

* [[Cut Through Fate+]]. For 1 energy, this deals 7 damage, **scries** 2, and then draws 1 card.
    Scry is another mechanic unique to the Watcher.
    Whenever I "scry 2",
    I get to see the next 2 cards I will draw in order.
    I can additionally choose to discard either or both of them.
    If my draw pile only has 0 or 1 cards in it,
    I only get to see those cards --
    the discard pile is not reshuffled.

* [[Empty Fist+]]. For 1 energy, this deals 14 damage, then exits my current stance.

* [[Pressure Points]]. For 0 energy, this adds 8 **Mark** to the target, then deals damage to all enemies equal to their current Mark.
    Mark is a mechanic only used by this specific card.
    It starts at 0 and carries over between turns.
    Also note that this card does not normally cost 0,
    but it does for the current battle because of previous actions.

* [[Collect]]. This consumes all of my energy,
    and will then add a [[Miracle+]] to my hand at the beginning of my next X turns,
    where X is the amount of energy that was consumed.
    It then Exhausts.
    Note that X can be 0,
    in which case I still play the card but for no effect
    (other than Exhausting).

    * [[Miracle+]], which can be generated from [[Collect]],
       simply gains 2 energy for free, then Exhausts.
       It also **retains**,
       which means I do not discard it at the end of my turn
       (but I still draw 5 cards at the beginning of the next turn as usual,
       which would leave me with 6 in my hand total).

* [[Purity]]. For 0 energy, this lets me choose anywhere from 0 to 3 cards in my hand to Exhaust, and then Exhausts itself.

* [[Worship]]. For 0 energy, this gains 5 **Mantra**.
   Mantra is another Watcher-specific mechanic.
   It is a value that persists between turns,
   and if at any point I ever have 10 or more Mantra,
   I lose 10 Mantra and enter the Divinity stance.
   Again,
   this card does not normally cost 0,
   but it does for the current battle.

## enemies, buffs, and debuffs

I will continue describing the first screenshot from bottom to top;
if I skip something,
that means it's not important.

Below each combatant,
you can see several icons.
These are **buffs** and **debuffs**,
static effects that persist between turns.
They are applied by various player or enemy actions.
From left to right,
my character has:

* 1 **Strength**, which means all damage numbers on my cards are increased by 1. This means a [[cpa|Strike]] actually does 7 damage.
* 1 **Dexterity**, which means all block numbers on my cards are increased by 1. This means a [[cps|Defend]] actually blocks for 6.
* 3 **Mantra**, described above (for the card [[Worship]]).
* 6 **Thorns**, which means every time an enemy hits me, they take 6 damage. (Since the Awakened One intends to hit me 4 times, it will take 24 damage.)

The Cultist has:

* 4 **Ritual**, which means at the end of all of its turns, it will gain 4 Strength. The Cultist's attack pattern is to simply attack for 6 repeatedly, but due to the Strength gain, its damage will actually be 6, then 10, then 14, and so on.

The Awakened One has:

* 10 **Regen**, which means it heals 10 HP at the start of its turn.
* 1 **Curiosity**, which is not important.
* 1 **Unawakened**. This enemy has a unique mechanic where when it dies for the first time,
    it does not actually die.
    Instead,
    it immediately enters a "waking up" state,
    in which it can no longer be targeted by cards.
    At the beginning of its next turn,
    it will then replenish all of its HP
    and enter a second phase,
    where its attack pattern becomes significantly deadlier.
* 2 **Strength**.

Before waking up,
the Awakened One's attack pattern
is approximately random between attacking for 20 and 6x4.
(Since it has 2 Strength, these will actually be 22 and 8x4.)
On the turn that it wakes up,
its intent is a 40 (42 with Strength) damage attack.
For all future turns,
it is then approximately random between attacking for 10x3 (12x3),
and simultaneously attacking for 18 (20) and adding a [[Void]] into my draw pile.
[[Void]] is an unplayable card that immediately reduces my energy by 1 when I draw it (unless I have no energy),
but it is **Ethereal**, which means it Exhausts itself if it is in my hand at the end of my turn.

## relics and potions

The row of 17 icons above my character
is my collection of **relics**.
These are items that I have collected throughout the current game
which give various benefits in every fight.
I will only explain the ones that could possibly be relevant.

* [[Damaru]]: At the start of my turn, I gain 1 Mantra.
* [[Centennial Puzzle]]: The first time I take damage this battle, I draw 3 cards. (I have not yet taken damage.)
* [[Ornamental Fan]]: Every time I play 3 Attack cards in the same turn, I gain 4 block. (The type of each card is visible in the screenshots.)
* [[Sacred Bark]]: Effects of most **potions** are doubled.

What is a potion, you ask?
Those are what can occupy the four slots above my relic bar.
Potions are one-time use items,
and I can use them at any time during my turn.
I currently have 3 potions:

* [[Duplication Potion]]: After using this potion, the next 2 cards I play are played twice.
* [[Distilled Chaos]]: Immediately play the next 6 cards in my draw pile in sequence. If there are less than 6, do not reshuffle, just play all of them.
* [[Blessing of the Forge]]: Upgrade all cards in my hand for the rest of this battle. You can see the effects of each upgrade by hovering over the card names in the "cards" section above.

<p style='margin-top:3em'><a href='..'>« return to post</a></p>
