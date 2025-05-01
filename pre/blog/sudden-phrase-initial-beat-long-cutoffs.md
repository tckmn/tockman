2025-01-02 16:58 -0500 // music

# Sudden phrase-initial beat-long cutoffs

I have literally no idea how to describe this in words,
but here's a short list of a bunch of songs
that do a cool musical thing.
[EXCERPT]

.style {{ main ul li { margin: 2em 0; } }}

- **A Cruel Angel's Thesis** (theme song of *Neon Genesis Evangelion*)

  First listen to this pre-chorus bit
  (this is *not* the cool musical thing),
  and in particular listen for the electronic brassy thing at about the midpoint,
  on the first syllable of "moshimo":

  <p><audio controls>
    <source src='angel1.ogg' type='audio/ogg'>
    <source src='angel1.mp3' type='audio/mpeg'>
  </audio></p>

  Now keep that little sound effect in mind,
  and listen for it at the beginning of the chorus
  (around 0:04):

  <p><audio controls>
    <source src='angel2.ogg' type='audio/ogg'>
    <source src='angel2.mp3' type='audio/mpeg'>
  </audio></p>

  That's the cool thing!
  The electronic brassy thing doesn't happen on beat 1,
  like expected;
  it stops abruptly and comes in on beat 2 instead.
  The surprise effect is further amplified
  by the three notes on the same instrument
  strongly leading up to beat 1,
  which makes you *really* anticipate hearing:

  .ly {{
    \new Staff \relative {
      \key c \minor
      \time 4/4
      | r2 g'8. a b8 | c4->\bendAfter #-4 r r2 |
    }
  }}

  Compare this to the second time that musical phrase happens in the chorus,
  at around 0:10-0:11.
  There,
  the same instrument has a similar run
  that actually lands on beat 1 this time.
  This makes sense,
  since it'd feel overdone / cheesy / lose its impact
  if it happened every time.
  (There is still a small remnant of the beat 2 landing,
  in the form of a cymbal crash.)

  This is the song that originally inspired me to make this list,
  which is interesting,
  because it sort of leaves out the "cutoff" part of the title of this post.
  So the next example is the most dramatic one in that regard.

- **Flowers** (unreasonably catchy song by Miley Cyrus)

  This song does the thing into each chorus,
  and it sounds a little different each time:

  <p><audio controls>
    <source src='flowers1.ogg' type='audio/ogg'>
    <source src='flowers1.mp3' type='audio/mpeg'>
  </audio></p>

  <p><audio controls>
    <source src='flowers2.ogg' type='audio/ogg'>
    <source src='flowers2.mp3' type='audio/mpeg'>
  </audio></p>

  <p><audio controls>
    <source src='flowers3.ogg' type='audio/ogg'>
    <source src='flowers3.mp3' type='audio/mpeg'>
  </audio></p>

  Hopefully this one is striking enough that I don't need to say anything more!
  I like how each time gets progressively more dramatic --
  the first has an audible breath on beat 1,
  but the second and third are completely silent,
  and the third changes up the rhythm of the drums leading into it.

- **The Middle** (the only song by Jimmy Eat World that anyone's ever heard)

  This song has a cool variation
  where instead of *everything* cutting out,
  all the instrumentals cut out,
  leaving just the solo vocals on beat 1.
  It's a really neat effect:

  <p><audio controls>
    <source src='themiddle.ogg' type='audio/ogg'>
    <source src='themiddle.mp3' type='audio/mpeg'>
  </audio></p>

  Kind of like the Evangelion song,
  this one accentuates the same beat 2 in every other measure
  with a cymbal crash
  (and the same sixteenths on the drums leading up to the preceding 1).

- **Believer** (by Imagine Dragons, of *Murder on the Orient Express*-movie-trailer fame)

  This one is quite in-your-face about it.

  <p><audio controls>
    <source src='believer.ogg' type='audio/ogg'>
    <source src='believer.mp3' type='audio/mpeg'>
  </audio></p>

  Like the last one,
  it's not "complete silence on&nbsp;1"
  but rather "all parts except one drop out on&nbsp;1";
  in this case,
  it's the low bass rumble.
  It's also maybe two beats,
  I dunno,
  you could count this song in 4 or 2 or 12,
  but it's the same idea.

Can you think of any other songs that do this?
I would be interested to know!

<!--nowd-->
<!-- .ly {{
  \version "2.24.3"
  \score {
    \new Staff \relative {
      \key f \major
      \numericTimeSignature
      \time 4/4
      | r2 f'8 g a4 |
      \time 2/4
      | <<
        { \voiceOne \hideNotes a4 \unHideNotes
          \tweak color #grey
          \tweak Stem.color #grey
          c4
        }
        \new Voice { \voiceTwo
          \tweak color #grey
          \tweak Stem.color #grey
          c2
        }
      >> \oneVoice |
      \time 4/4
      | c2. f,4 | e4 r d'4. d8( | c2) r |
    }
    \addlyrics {
      Yu -- me de (ta) (ta) ta -- ka -- ku ton -- da __
    }
  }
}} -->
