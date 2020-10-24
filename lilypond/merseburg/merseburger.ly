\version "2.18.2"
%{
Begun on 2017/04/14 this is my second take on a LilyPond file.
It aims at finally having a full arrangement for the First
Merseburger spell. Including both the main theme as well as the
higher second voice from (to my best knowledge) the Ougenweide.
Both parts may be played as a Canon.

Markus-Hermann Koch, mhk@markuskoch.eu, 2020/04/04.

Useful sources for engraving guitar scores:
http://lilypond.org/doc/v2.19/Documentation/notation/common-notation-for-fretted-strings
http://lilypondcookbook.com/post/75545613870/fretted-strings-1-guitar-basics
https://timmurphy.org/2012/06/22/writing-guitar-tabs-with-lilypond/

Useful to play MIDI files: apt-get install wildmidi
If you ever have repeats and want them unfolded for MIDI:
Prefix "\unfoldRepeats" to your score.
%}

\paper
{
  %ragged-last-bottom = true
  page_count = 2
  %min-systems-per-page = 5
}

% Lilypond allows to chain sequences written into vars. Vars should not
% contain numbers, sadly. Nevertheless, this code will exploit this
% mechanic to allow two voices broken into several lines.

%> Part 1: Classic Ougenweide Score. --------------------------------- 
% The \f introduces a 'forte' symbol.
melAa = { <a' c e>4\f e'8 e8 e4 d8 c <g d'>2. c8 d }
basAa = { a2 a g2. \skip 4 }
lyrAa = \lyricmode { Eiris sazun Idisi, sazun }

melAb = { e4 d8 c b a g4 <a e>1 }
basAb = { a2 g2 a1 }
lyrAb = \lyricmode { hera douder. }

melAc = { <a c e>4. e'8 e4 d8 c <g d'>2. c8 d }
basAc = { a2 a g2. \skip 4 }
lyrAc = \lyricmode { Suma hapt heptidun, suma }

melAd = { e4 d8 c b4 b32(c b16) g8 <a e>2. a8 b }
basAd = { e2 g a2. \skip 4 }
lyrAd = \lyricmode { heri lezidun. Suma }

melAe = { <e, a c>4. b'8 <e, a>4 b'8 c d e d c b4 c8 d }
basAe = { a2 a4 \skip 4 g2 e4 \skip 4 }
lyrAe = \lyricmode { clubudun, umbi couioidi, in- }

melAf = { <a c e>4. <c e a>8 a'4 g8 e8 d2. e8 g }
basAf = { a2 a4 \skip 4 g2. \skip 4 }
lyrAf = \lyricmode { sprinc haptebandun! In- }

melAg = { <c, e a>4. a'8 q4 g8 e d e d c b4 c8 b }
basAg = { a2 a g e4 \skip 4 }
lyrAg = \lyricmode { var vigandun! In- }

melAh = { a4 d8 c b a g4 a1  }
basAh = { a2 e2 a1 }
lyrAh = \lyricmode { var vigandun! }
%< -------------------------------------------------------------------

%> Part 2: The high score. -------------------------------------------
% \<number> forces a specific string in the tab. Highest is 1, lowest is 6.
melBa = { <c e a>4\f a'8 a q4 g8\2 e\2 <g,\3 g'\2>2. e'8\2 g\2 }
basBa = { a'2\4 a\4 c,2.\6 \skip 4 }
lyrBa = \lyricmode { Eiris sazun Idisi, sazun }

melBb = { <c, e a>4 a' g\2 e8\2 d\3 e1\2 }
basBb = { a'2\4 g2\4 a1\4 }
lyrBb = \lyricmode { hera douder. }

melBc = { <c e a>4. a'8 q4 g8\2 e\2 <g,\3 g'\2>2. e'8\2 g\2 }
basBc = { a2\4 a\4 c,2.\6 \skip 4 }
lyrBc = \lyricmode { Suma hapt heptidun, suma }

melBd = { <c, e a>4 a' g\2 e8\2 d\3 e2.\2 e8\2 g\2 }
basBd = { a'2\4 g\4 a2.\4 \skip 4 }
lyrBd = \lyricmode { heri lezidun. Suma }

melBe = { a4. a8 a4 g8\2 a <e b'> c' b a g4\2 e8\2 g\2 }
basBe = { a2\4 a4\4 \skip 4 g2\4 e4\5 \skip 4 }
lyrBe = \lyricmode { clubudun, umbi couioidi. In- }

melBf = { <e a>4. c'8 c4 b8 a\1 g2.\2 e8\2 g\2 }
basBf = { a2\4 g2\4 g2.\4 \skip 4 }
lyrBf = \lyricmode { sprinc haptebandun! In- }

melBg = { <c, e a>4. c'8 c4 b8 a b c b a g4\2 e8\2 g\2 }
basBg = { a2\4 a4\4 \skip 4 e2\5 e\5 }
lyrBg = \lyricmode { var vigandun! In- }

melBh = { <c, e a>4 a' g\2 e8\3 d\3 e1\3 }
basBh = { a2\4 b\4 a1\4 }
lyrBh = \lyricmode { var vigandun! }
%< -------------------------------------------------------------------

mel = {\melAa \melAb \melAc \melAd \melAe \melAf \melAg \melAh \bar "||" \melBa \melBb \melBc \melBd \melBe \melBf \melBg \melBh \bar "|." }
bas = {\basAa \basAb \basAc \basAd \basAe \basAf \basAg \basAh \bar "||" \basBa \basBb \basBc \basBd \basBe \basBf \basBg \basBh \bar "|." }
lyr = {\lyrAa \lyrAb \lyrAc \lyrAd \lyrAe \lyrAf \lyrAg \lyrAh           \lyrBa \lyrBb \lyrBc \lyrBd \lyrBe \lyrBf \lyrBg \lyrBh }

primerosNames = \chordmode
{
  % Part 1.
  a1:m g a2:m g \powerChords a1:1.5 a:m g e2:m g a1:m a:m
  g a:m g a:m g a:m a:m
  % Part 2.
  a:m c:1.5 a2:m g a1:1.5 a:m c:1.5 a2:m g a1:1.5 a:m
  g2:6 e:m a:m g g1 a:m e:m a2:m b:m a:1.5
}

\book
{

\header
{
  %dedication = "Dedication"
  title = "Der erste Merseburger Zauberspruch"
  subtitle = "Vermutlich 10. Jahrhundert"
  subsubtitle = "Das \"Hello World\" der Musik"
  
  %instrument = \markup \with-color #green "Instrument"
  %poet = "Poet"
  % composer = \markup \with-color #blue "www.handschriftencensus.de/6099"
  % The following fields are placed at opposite ends of the same line
  % meter = "Standard Tuning"
  arranger = "MHK"
  % The following fields are centered at the bottom
  %tagline = "tagline goes at the bottom of the last page"
  %copyright = "copyright goes at the bottom of the first page"
  %print_page_number = true
}

\score
{
% Uncomment the next line if you want to compile into a .midi file.
%\midi{}
<<
  \new ChordNames {
    \set chordChanges = ##t
    \primerosNames
  }

  \new Staff
  {
    \tempo 4 = 90
    \time 4/4
    <<
      \new Voice = "one" { \voiceOne \hide StringNumber \relative c' \mel }
      \new Voice = "two" { \voiceTwo \hide StringNumber \relative c' \bas }
      %\new Lyrics \lyricsto "one" { \lyr }
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

