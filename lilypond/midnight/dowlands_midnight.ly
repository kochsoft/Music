\version "2.18.2"
%{
Begun on 2020/10/01 this is my third take on a LilyPond file.
Upon falling in love with Roland Keuning's decacorde rendition
of Dowland's Midnight I researched several scores on the web.
All nice for some points and lacking for some others.

At least consistent in most notes. However, I decided to write
a proper Lilypond Score for this piece.

Markus-Hermann Koch, mhk@markuskoch.eu.

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
  page_count = 1
  %min-systems-per-page = 4
}

% Lilypond allows to chain sequences written into vars. Vars should not
% contain numbers, sadly. Nevertheless, this code will exploit this
% mechanic to allow two voices broken into several lines.

%> Part 1. -----------------------------------------------------------
% The \f introduces a 'forte' symbol.
melAa = {
\textSpannerUp
\override TextSpanner.bound-details.left.text = #"II "
b'4.\3\startTextSpan cis8 d4 b\3\stopTextSpan  <fis d'> e'  <fis,-2 \tweak color #blue ais-3 cis-4>2 }
basAa = { <b fis'>1           b2. ais4-1 }

melAb = { b4.\3\startTextSpan cis8 d4 cis-1\stopTextSpan  d e <ais, cis fis>2  \break }
basAb = { <b fis'>2. a4      <g g'>2 fis          \break }

melAc = { b4.\3 cis8 d4 b\3  <fis d'> e' <fis, \tweak color #blue ais cis>2 }
basAc = { <b fis'>4 b2.      b2. ais4 }

melAd = { b4.\3 cis8 d4 cis  b8 cis d e <ais, cis fis>2  \break }
basAd = { <b fis'>4 b2 a4    g2-2 fis2                   \break }
%< -------------------------------------------------------------------

%> Part 2. -----------------------------------------------------------
% \<number> forces a specific string in the tab. Highest is 1, lowest is 6.
melBa = { \bar ".|:" cis4 a' e fis  g-1 fis8-2 e <b d>4 <cis-1 e>4 }
basBa = { \bar ".|:" fis'2 <a cis>  <e b'>2-3 g-4\4 }

% TODO: Add \glissando: http://lilypond.org/doc/v2.19/Documentation/source/Documentation/notation/expressive-marks-as-lines.en.html
melBb = { fis4 e8 fis <cis e>4-2^"gliss"  <b-3 d-2>  cis cis <b b\3> fis'8 g     \break }
basBb = { <d d'>2 e-1             <fis, fis'> <b fis'>  \break }

melBc = { a4-4 g8-2 fis-1 e d-3 e fis  g4-3 fis8-2 e d-3 cis d e }
basBc = { fis'2-3 a-1                  <e b'>-1 g,-2 }

melBd = { fis4 e8 fis g fis e d  <fis, cis'> b\3 cis4 <b b\3>2  \bar ":|." }
basBd = { <d' d'>2 e,              fis <b fis'>           \bar ":|." }
%< -------------------------------------------------------------------

mel = { \melAa \melAb \melAc \melAd \melBa \melBb \melBc \melBd }
bas = { \basAa \basAb \basAc \basAd \basBa \basBb \basBc \basBd }

primerosNames = \chordmode
{
  % Part 1.
  b1:m b2:m ais:m b1:m g2 fis b1:m b2:m ais:m b1:m g2 fis

  % Part 2.
  fis2:m a2 e2:m g:6 d e:m \powerChords fis:1.5 b:m fis2:m a e:m g d e:m fis:1.5 b:1.5
}

\book
{

\header
{
  %dedication = "Dedication"
  title = "Mr. Dowland's Midnight"
  subtitle = "Late 16th century"
  subsubtitle = "Lute gone guitar"
  
  %instrument = \markup \with-color #green "Instrument"
  %poet = "Poet"
  % composer = \markup \with-color #blue "www.handschriftencensus.de/6099"
  % The following fields are placed at opposite ends of the same line
  % meter = "Standard Tuning"
  arranger = "John Dowland"
  % The following fields are centered at the bottom
  %tagline = "tagline goes at the bottom of the last page"
  copyright = "Set in Lilypond by MHK. Blue notes are optionals added by me."
  %print_page_number = true
}

\score
{
% Uncomment the next line if you want to compile into a .midi file.
% \midi{}
<<
  \new ChordNames {
    \set chordChanges = ##t
    \primerosNames
  }

  \new Staff
  {
    \tempo 4 = 65
    \time 4/4
    <<
      \key b \minor
      \new Voice = "one" { \voiceOne \hide StringNumber \relative c' \mel }
      \new Voice = "two" { \voiceTwo \hide StringNumber \relative c' \bas }
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

