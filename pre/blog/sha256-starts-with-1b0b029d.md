2025-04-29 00:53 -0400 // programming

# The SHA256 of this title starts with 1b0b029d

Here is a true sentence:

> My name is Andy Tockman, and the SHA256 of this sentence starts with 10823817b8.

[EXCERPT]

You can check that it's true yourself:

    tckmn@alpaca:~$ echo -n 'My name is Andy Tockman, and the SHA256 of this sentence starts with 10823817b8.' | sha256sum
    10823817b8e9c37ed42a4fe239d607d6128fe2f3f53ead2248b8667946d6cf08  -

I, uh, "made" this sentence
when [this tweet by @LaurieWired](https://x.com/lauriewired/status/1700982575291142594)
was making the rounds on the internet:

> The SHA256 for this sentence begins with: one, eight, two, a, seven, c and nine.

(Is "made" the right verb? Wrote? Discovered? Anyway...)
I was further inspired by my friend
making a 6-digit version with their name in it,
and decided to try going further by writing the bruteforce in C.
[Here's the code](https://gist.github.com/tckmn/7f775104cf3c32acd3dd59210540a8dd),
which uses [this random SHA256 implementation off the internet](https://github.com/wangkui0508/sha256).

In case you're not familiar with [cryptographic hash functions](https://en.wikipedia.org/wiki/Cryptographic_hash_function),
of which [SHA256](https://en.wikipedia.org/wiki/SHA-2) is one,
the oversimplified description is that you stick in any string
and it's supposed to spit out a number in some fixed range
that "looks random" --
i.e. you always get the same number for the same string,
but it has no visible relation to the contents of the string.
So in theory,
it's intended to be impossible to find two strings that hash to the same thing,
or find a string that results in some given hash,
except by brute force.
Similarly,
if the hash function is cryptographically secure,
the only way to find sentences like this is by trying a lot of them until they work.

How likely is it that you find one?
Let's say you're trying to find one with 4 hex digits.
The first 4 digits of your hash
will effectively be randomly chosen from the 2<sup>16</sup> possible 4-digit hex strings.
so the chances that a random one works is 1 in 2<sup>16</sup>.
But since there are also 2<sup>16</sup> possible sentences to try,
the expected number of matches you find if you try all of them is exactly one!
This goes for any number of digits:
if you brute force all possibilities,
you will find 1 working one in expectation.

When I ran my code for 8 digits, I found all of these:

> My name is Andy Tockman and the SHA256 of this sentence starts with cfdf9b1e.  
> My name is Andy Tockman, and the SHA256 of this sentence starts with d93f0e7a.  
> My name is Andy Tockman, and the SHA256 of this sentence starts with e767eb5a  
> My name is Andy Tockman, and the SHA256 of this sentence starts with f00d7099

Four of them!
My favorite is the last one because it starts with "food".
Do I just have an extremely lucky name?
No --
as you can see from the differences in the above sentences,
you can cheat a little by varying the punctuation.
There are 4 versions here if you try both comma / no comma and period / no period,
and so the expected number is indeed exactly 4.
So if you have a very unlucky name,
not all hope is lost.

The amount of time it takes to try all of them
increases exponentially with the number of digits;
I think the projected runtime for the 10-digit version with my code
was around 24 core-hours.
But I got lucky and found one in around 2 --
in fact,
you can tell exactly how lucky I got because my code tries all the numbers in order,
and the number that worked was `10823817b8`.

Anyway,
there's not much more I have to say about this.
It's kind of funny that this process is basically the exact same thing as mining bitcoin,
except instead of dollars you get sentences.
But they are such great, personalized sentences!
Clearly a much more valuable commodity.

On an entirely unrelated note,
I learned while writing this
that apparently different web browsers will put different text in your clipboard
if you copy/paste from a page with formatting??
So you can <a id='copyclip' href='#'>click here to copy the text of this blog post to your clipboard</a>
in a standardized way.
And if you check,
you will discover that [its SHA256](https://emn178.github.io/online-tools/sha256.html) starts with `8c0735`.

<!--nowd-->
.script {{
window.addEventListener('load', () => { document.getElementById('copyclip').addEventListener('click', e => { e.preventDefault(); navigator.clipboard.writeText("Here is a true sentence:\n\n    My name is Andy Tockman, and the SHA256 of this sentence starts with 10823817b8.\n\nYou can check that it's true yourself:\n\ntckmn@alpaca:~$ echo -n 'My name is Andy Tockman, and the SHA256 of this sentence starts with 10823817b8.' | sha256sum\n10823817b8e9c37ed42a4fe239d607d6128fe2f3f53ead2248b8667946d6cf08  -\n\nI, uh, \"made\" this sentence when this tweet by @LaurieWired was making the rounds on the internet:\n\n    The SHA256 for this sentence begins with: one, eight, two, a, seven, c and nine.\n\n(Is \"made\" the right verb? Wrote? Discovered? Anyway...) I was further inspired by my friend making a 6-digit version with their name in it, and decided to try going further by writing the bruteforce in C. Here's the code, which uses this random SHA256 implementation off the internet.\n\nIn case you're not familiar with cryptographic hash functions, of which SHA256 is one, the oversimplified description is that you stick in any string and it's supposed to spit out a number in some fixed range that \"looks random\" -- i.e. you always get the same number for the same string, but it has no visible relation to the contents of the string. So in theory, it's intended to be impossible to find two strings that hash to the same thing, or find a string that results in some given hash, except by brute force. Similarly, if the hash function is cryptographically secure, the only way to find sentences like this is by trying a lot of them until they work.\n\nHow likely is it that you find one? Let's say you're trying to find one with 4 hex digits. The first 4 digits of your hash will effectively be randomly chosen from the 216 possible 4-digit hex strings. so the chances that a random one works is 1 in 216. But since there are also 216 possible sentences to try, the expected number of matches you find if you try all of them is exactly one! This goes for any number of digits: if you brute force all possibilities, you will find 1 working one in expectation.\n\nWhen I ran my code for 8 digits, I found all of these:\n\n    My name is Andy Tockman and the SHA256 of this sentence starts with cfdf9b1e.\n    My name is Andy Tockman, and the SHA256 of this sentence starts with d93f0e7a.\n    My name is Andy Tockman, and the SHA256 of this sentence starts with e767eb5a\n    My name is Andy Tockman, and the SHA256 of this sentence starts with f00d7099\n\nFour of them! My favorite is the last one because it starts with \"food\". Do I just have an extremely lucky name? No -- as you can see from the differences in the above sentences, you can cheat a little by varying the punctuation. There are 4 versions here if you try both comma / no comma and period / no period, and so the expected number is indeed exactly 4. So if you have a very unlucky name, not all hope is lost.\n\nThe amount of time it takes to try all of them increases exponentially with the number of digits; I think the projected runtime for the 10-digit version with my code was around 24 core-hours. But I got lucky and found one in around 2 -- in fact, you can tell exactly how lucky I got because my code tries all the numbers in order, and the number that worked was 10823817b8.\n\nAnyway, there's not much more I have to say about this. It's kind of funny that this process is basically the exact same thing as mining bitcoin, except instead of dollars you get sentences. But they are such great, personalized sentences! Clearly a much more valuable commodity.\n\nOn an entirely unrelated note, I learned while writing this that apparently different web browsers will put different text in your clipboard if you copy/paste from a page with formatting?? So you can click here to copy the text of this blog post to your clipboard in a standardized way. And if you check, you will discover that its SHA256 starts with 8c0735."); }); });
}}
