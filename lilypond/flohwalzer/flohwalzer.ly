\version "2.18.2"
%{
Begun on 2021/01/07 this is my second self-made arrangement.
The Flohwalzer is a very simple piece on the piano
with the purpose to allow non-pianists to troll pianists.
It is also quite fun on the guitar.

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
  %top-margin = 25
}

% Lilypond allows to chain sequences written into vars. Vars should not
% contain numbers, sadly. Nevertheless, this code will exploit this
% mechanic to allow two voices broken into several lines.

%> Part 1: The low score. --------------------------------------------
% \<number> forces a specific string in the tab. Highest is 1, lowest is 6.
melA = {
  \partial 4 es''8 des''
  ges'4 <bes' ges''>\staccato <bes' ges''>\staccato es''8 des''
  ges'4 <bes' ges''>\staccato <bes' ges''>\staccato es''8 des''
  ges'4 <bes' ges''>\staccato es' <bes' ges''>\staccato
  des' <b'\3 f''\2>\staccato <b'\3 f''\2>\staccato es''8 des''\3 \break
  des'4 <b'\3 f''\2>\staccato <b'\3 f''\2>\staccato es''8 des''\3
  des'4 <b'\3 f''\2>\staccato <b'\3 f''\2>\staccato es''8 des''\3
  des'4 <b'\3 f''\2>\staccato es'\5 <b'\3 f''\2>\staccato
  ges' <bes'\4 ges''\2>\staccato <bes'\4 ges''\2>\staccato es''8\3 des''\3 \break
}
%< -------------------------------------------------------------------

%> Part 2: The high score. -------------------------------------------
melB = {
  bes''4 <bes'\4 ges''\2>\staccato <bes'\4 ges''\2>\staccato es''8\3 des''\3
  bes''4 <bes'\4 ges''\2>\staccato <bes'\4 ges''\2>\staccato es''8\3 des''\3
  bes''4 <bes'\4 ges''\2>\staccato des''' <bes'\4 ges''\2>\staccato
  es''' <b'\4 f''\3>\staccato <b'\4 f''\3>\staccato es''8\3 des''\4
  es'''4 <b'\4 f''\3>\staccato <b'\4 f''\3>\staccato es''8\3 des''\4
  es'''4 <b'\4 f''\3>\staccato <b'\4 f''\3>\staccato es''8\3 des''\4
  es'''4 <b'\4 f''\3>\staccato des''' <b'\4 f''\3>\staccato
  bes'' <bes'\4 ges''\2>\staccato <bes'\4 ges''\2>\staccato r4
}
%< -------------------------------------------------------------------

mel = {\melA \bar "||" \melB \bar "|." }

primerosNames = \chordmode
{
  ges4 ges1 ges ges des
  des des des des4 es2.:m
  es1:m es:m es:m f:5-
  f:5- f:5- f:5- es:m
}

\book
{

\header
{
  %dedication = "Dedication"
  title = "Flohwalzer"
  subtitle = "Death from Flats"
  
  % instrument = \markup \with-color #green "Instrument"
  % poet = "Poet"
  composer = "Anonymous, possibly some guy named Floh"
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
% \midi{}
<<
  \new ChordNames {
    \set chordChanges = ##t
    \primerosNames
  }

  \new Staff
  {
    \tempo 4 = 120
    \time 4/4
    \key ges \major
    <<
      \new Voice = "one" { \voiceOne \hide StringNumber \mel } % \relative c'
    >>
  }

  \new TabStaff \with { stringTunings = #guitar-tuning }
  {
    \set Staff.stringTunings = \stringTuning <e a d' g' b' e''>
    <<
      { \mel }
    >>
  }
>>
} % end of score.
} % end of book.

