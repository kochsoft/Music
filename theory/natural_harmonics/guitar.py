#!/usr/bin/python3

"""
Having been mystified by the fact that the guitar can be tuned to
standard tuning EADGBE via natural harmonics by comparing

a) 6th string fret 5 harmonic vs 5th string fret 7 harmonic (matching E)
b) 5th 5 vs 4th 7 (A)
c) 4th 5 vs 3rd 7 (D)
d) 6th 7 vs 2nd open (B)
e) 5th 7 vs 1st open (E),

watching M. Krupkina's video on overtones,

https://www.youtube.com/watch?v=IFLXtH4cZUQ

and remembering long-lost physics classes on the workings of flutes
and even temperament computation using powers of 12th-roots of 2 led
to following thoughts:

Consider the guitar course to be of length 2 (simpler to work with than 1,
when thinking in powers of 2). Therein let the bridge be at 0 and the saddle
at 2. Fret 12, marking the first octave in the middle, is at 1.

By the rules of even temperament, below function f2g ("fret to guitar site")
will compute the position of any fret in this measure of (0,2] by the numbers
given them in usual tabulature.

g2f ("guitar site to fret") is the inverse of f2g, allowing to associate
any site on the guitar in (0,2] with a fret number. This function, too,
returns a real number.

frets_ot will compute both fret numbers and heights on the course for each
node in the nth overtone. For the overtone numbers 1, 2, 3, 4, 5
the script's output is included as a comment below the code.

That answers the question, that the 4th overtone is between frets 3 and
4, close to the 4, and between frets 8 and 9, close to the 9. It should
measure approximately 2 octaves and 1 large third:

  (2**(28/12)) == (2**((2*12+4)/12)) == 5.04,

matching the 5 waves of the 4th overtone.

Meaning, on, e.g., the 6th string this creates something close to a gis.
[As experimentation confirms. Easier to get cleanly on fret 8.84]
"""


from math import log

def f2g(fret):
    """:param fret: Lives in 0 (saddle) over 12 (middle) to infinity (bridge)"""
    return 2**((12-fret)/12)

def g2f(x):
    """:param x: Lives in 0 (bridge) over 1 (middle) to 2 (saddle)."""
    return 12*(1 - (log(x) / log(2)))

def frets_ot(n:int=1):
  for j in range(1, n+2):
    x = 2 * j / (n+1)
    fret = g2f(x)
    print(f"Overtone #{n} at height {x:1.4} is at fret {fret:1.4}.")
  print("")

frets_ot(1)
frets_ot(2)
frets_ot(3)
frets_ot(4)
frets_ot(5)

"""
This will yield the output:

>>> frets_ot(1)
Overtone #1 at height 1.0 is at fret 12.0.
Overtone #1 at height 2.0 is at fret 0.0.

>>> frets_ot(2)
Overtone #2 at height 0.6667 is at fret 19.02.
Overtone #2 at height 1.333 is at fret 7.02.
Overtone #2 at height 2.0 is at fret 0.0.

>>> frets_ot(3)
Overtone #3 at height 0.5 is at fret 24.0.
Overtone #3 at height 1.0 is at fret 12.0.
Overtone #3 at height 1.5 is at fret 4.98.
Overtone #3 at height 2.0 is at fret 0.0.

>>> frets_ot(4)
Overtone #4 at height 0.4 is at fret 27.86.
Overtone #4 at height 0.8 is at fret 15.86.
Overtone #4 at height 1.2 is at fret 8.844.
Overtone #4 at height 1.6 is at fret 3.863.
Overtone #4 at height 2.0 is at fret 0.0.

>>> frets_ot(5)
Overtone #5 at height 0.3333 is at fret 31.02.
Overtone #5 at height 0.6667 is at fret 19.02.
Overtone #5 at height 1.0 is at fret 12.0.
Overtone #5 at height 1.333 is at fret 7.02.
Overtone #5 at height 1.667 is at fret 3.156.
Overtone #5 at height 2.0 is at fret 0.0.
"""

