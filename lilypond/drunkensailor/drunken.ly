\version "2.18.2"
%{
Arranged on 2021/05/01 the Drunken Sailor using the LilyPond editor
"Frescobaldi" on Debian 10. Good stuff. Like it!
The arrangement is easy and contains, as a twist, my very first
self-employed sus4-chord!

Markus-Hermann Koch, mhk@markuskoch.eu, 2021/01/07.

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
  page_count = 1
  top-margin = 25
}

% Lilypond allows to chain sequences written into vars. Vars should not
% contain numbers, sadly. Nevertheless, this code will exploit this
% mechanic to allow two voices broken into several lines.

%> Part 1: Elementary picking part. -----------------------------------
% \<number> forces a specific string in the tab. Highest is 1, lowest is 6.
% \break gives a new line.
melA = {
  <a e''>4 e''8 e e4 e8 e
  e4 a, c e
  <g,, d''>4 d''8 d d4 d8 d8 d4
  g,4 b d \break
  <a, e''>4 e''8 e e4 e8 e
  e4 fis g a
  <c,, g''> e' <g,, d''> b'
  <a, a'>4 <e' a>8 r8 \break
}
%< -------------------------------------------------------------------

%> Part 2: Basic Picking. --------------------------------------------
%melB = {
%  <a, e''>4 e''8. e16
%  e4 a, c e
%  <g,, d''>4 d''8. d16
%  d4 g,4 b d
%  <a, e''>4 e''8. e16
%  e4 fis g a
%  <c,, g''> e' <g,, d''> b'
%  <a, a'>4 <e' a>8 r8
%}
%< -------------------------------------------------------------------


%> Part 2: Introducing beaten chords. --------------------------------
melB = {
  <a, e' a c e>4 <a e' a c e>8. <a e' a c e>16
  <a e' a c e>4 a' c e
  <g,, b d g d'>4 <g b d g d'>8. <g b d g d'>16
  <g b d g d'>4 g'4 b d \break
  <a, e' a c e>4 <a e' a c e>8. <a e' a c e>16
  <a e' a c e>4 fis'' g a
  <c,, e g c g'> e'
  <g,, b d g d'> <e b' e a b>
  <a e' a>4 <a e' a>8 r8
}
%< -------------------------------------------------------------------

mel = {\melA \bar "||" \melB \bar "|." }

primerosNames = \chordmode
{
  a1:m a:m g g
  a:m a:m c2 g a:m
  
  a1:m a2:m g1 g2
  a1:m a2:m c2 g4 e:sus4 a:m
} % Idea: Last 3 strums: C Esus4 a:m

\book
{

\header
{
  %dedication = "Dedication"
  title = "Drunken Sailor"
  %subtitle = "Death from Flats"
  
  % instrument = \markup \with-color #green "Instrument"
  % poet = "Poet"
  %composer = "Anonymous, possibly some guy named Floh"
  % The following fields are placed at opposite ends of the same line
  % meter = "Standard Tuning"
  arranger = "Arr.: M-H. Koch"
  % The following fields are centered at the bottom
  %tagline = "tagline goes at the bottom of the last page"
  copyright = "MHK"
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
    \tempo 4 = 120
    \time 2/4
    \key a \minor
    \relative c'
    <<
      \new Voice = "one" { \voiceOne \hide StringNumber \mel }
    >>
  }

  \new TabStaff \with { stringTunings = #guitar-tuning }
  {
    \set Staff.stringTunings = \stringTuning <e a d' g' b' e''>
    \relative c'
    <<
      { \mel }
    >>
  }
>>
} % end of score.
} % end of book.

