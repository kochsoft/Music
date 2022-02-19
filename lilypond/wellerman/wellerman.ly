\version "2.18.2"
%{
Begun on 2022/02/14 found a nice chord progression for the infamous Wellerman:
https://tabs.ultimate-guitar.com/tab/the-longest-johns/wellerman-chords-3182162

Lends itself beautifully for a mixed chord melody style (stanza), beat-me-
down cowboy chord camp fire chorus.

Not sure if this really qualifies as music. But it sure is fun!

Markus-Hermann Koch, mhk@markuskoch.eu.

Useful sources for engraving guitar scores:
http://lilypond.org/doc/v2.19/Documentation/notation/common-notation-for-fretted-strings
http://lilypondcookbook.com/post/75545613870/fretted-strings-1-guitar-basics
https://timmurphy.org/2012/06/22/writing-guitar-tabs-with-lilypond/

Useful to play MIDI files: apt-get install wildmidi
Or timidity: http://ccrma.stanford.edu/planetccrma/man/man1/timidity.1.html
If you ever have repeats and want them unfolded for MIDI:
Prefix "\unfoldRepeats" to your score.
%}

\paper
{
  %ragged-last-bottom = true
  page_count = 1
  %min-systems-per-page = 4
}

% Lilypond allows to chain sequences written into vars. Vars should not
% contain numbers, sadly. Nevertheless, this code will exploit this
% mechanic to allow two voices broken into several lines.

%> Part 1. -----------------------------------------------------------
% a:m
melAa = { \partial 2 e'2 | <e, a>4 <e a>8 <e a>8 <e a>4 c' e e e4. e8 }
basAa = { \partial 2 r2 | a1 a1 }

% d:m
melAb = { <a, d f>4 <a d>8 <a d>8 <a d>4 f'8 f }
basAb = { d1 }

% a:m, \<number> forces a specific string. 1 is the highest and 6 is the lowest.
melAc = { <c e a>8 <c e a> <c\3 e\2>4 <c\3 e\2>4. e8 }
basAc = { a1 }

% a:m
melAd = { <e, a>4 <e a>4 <e a>4 <e a>8 c' e4 e e4. e8 }
basAd = { a1 a1 }

% e1 a1
melAe = { <gis, e'>4 <gis c>4 <gis d'>8 <gis d'>8 <gis b>4 <e a>1 \break }
basAe = { e1 a1 \break }
%< -------------------------------------------------------------------

%> Part 2. -----------------------------------------------------------
% f, c  Soon may the Wellerman come
melBa = { <c f a c f>2 <c f a c f>4. <c f a c f>8 <e g c e>8 <e g c e>8 <e g c e>4 <e g c e>4. e'8 }
basBa = {f2 f4. f8 c'8 c8 c4 c2}

% d:m
melBb = {<a, d f>4 <a d>4 <a d>8 <a d>8 <a d f>4 }
basBb = {d4 d4 d8 d8 d4}

% a:m
melBc = {<e a c e a>4 <e\5 a\4 c\3 e\2> <e\5 a\4 c\3 e\2>2}
basBc = {a4\6 a\6 a2\6}

% f, c  One day, when the
melBd = { <c f a c f>2 <c f a c f>4 <c f a c f>8 <c f a c f>8 <e g c e>8 <e g c e>8 <e g c e>4 <e g c e>4. <e g c e>8 }
basBd = {f2 f4 f8 f8 c'8 c8 c4 c4. c8 }

melBe = { <b e gis b e>4 <b e gis c>4 <b e gis d'>4 <b e gis b>4 <e a>1 }
basBe = { e,4 e e e a1 }
%< -------------------------------------------------------------------

text = \lyricmode { There once was a ship that put to sea, the name of the ship was the
"\"Bi" -- lly o' "Tea\"." The wind blew up, and her bow dipped down. Oh, blow, me bul -- ly boys, blow!
Soon may the We ller man come, to bring us su gar and tea and rum.
One day, when the toun gin' is done,
We'll take our leave and go!
}

mel = { \melAa \melAb \melAc \melAd \melAe \bar "||" \melBa \melBb \melBc \melBd \melBe }
bas = { \basAa \basAb \basAc \basAd \basAe \bar "||" \basBa \basBb \basBc \basBd \basBe }

primerosNames = \chordmode
{
  % Part 1.
  \partial 2
  a2:m
  a1:m a:m d:m a:m
  a:m a:m e a:m

  % Part 2.
  f c d:m a:m
  f c e a:m
}

\book
{

\header
{
  %dedication = "Dedication"
  title = "The Wellerman"
  subtitle = "19th Century, New Zealand"
  subsubtitle = "Chord Melody / Campfire Version"
  
  %instrument = \markup \with-color #green "Instrument"
  %poet = "Poet"
  composer = "Anonymous"
  % The following fields are placed at opposite ends of the same line
  % meter = "Standard Tuning"
  arranger = "MHK"
  % The following fields are centered at the bottom
  %tagline = "tagline goes at the bottom of the last page"
  copyright = "Set in Lilypond by Markus-H. Koch"
  %print_page_number = true
}

\score
{
% Uncomment the next line if you want to compile into a .midi file.
% Making a 6MB .wav from the tiny midi: timidity -T 115 wellerman.midi -Ow
% \midi{}
<<
  \new ChordNames {
    % Display chords only at line start and when they change.
    \set chordChanges = ##t
    \primerosNames
  }

  \new Staff
  {
    \tempo 4 = 95
    \time 4/4
    <<
      \key a \minor
      \new Voice = "one" { \voiceOne \hide StringNumber \relative c' \mel }
      \new Voice = "two" { \voiceTwo \hide StringNumber \relative c' \bas }
      \new Lyrics \lyricsto "one" { \text }
    >>
  }

  \new TabStaff \with { stringTunings = #guitar-tuning }
  {
    \set Staff.stringTunings = \stringTuning <e a d' g' b' e''>
    <<
      { \relative c' \mel }
      { \relative c' \bas }
    >>
  }
>>
} % end of score.
} % end of book.

