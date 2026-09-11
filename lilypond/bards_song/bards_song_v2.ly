\version "2.26.0"
%{
On 2017/04/14 this was my first take ever on a Lilypond-based guitar tab.
In the past ten years the resulting sheet became one of my favorites.
It is a simple, arpeggio-heavy single guitar take on Blind Guardian's
famous Bard's Song.

Today, 2026/09/06, I am no longer satisfied with the lack of melody the
old sheet presented over a large section of the piece and want to improve
on it.

Markus-Hermann Koch, mhk@markuskoch.eu, September 6th, 2026.

Notes:
======
In the original version I kept a ton of potentially helpful commented-out
lines of code. This version will only keep the most sensible ones.

Literature:
===========
The AI chat over the afternoon I put the core file together:
[1] https://share.google/aimode/7pftCl4TeVJ8fWWhU

Useful sources for engraving guitar scores:
[11] http://lilypond.org/doc/v2.19/Documentation/notation/common-notation-for-fretted-strings
[12] http://lilypondcookbook.com/post/75545613870/fretted-strings-1-guitar-basics
%}

% > Macros. ----------------------------------------------------------
% Define the macro shortcut
playThrice =
{
  \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
  \mark \markup \small "3x"
}

% Set minimum fret for a given chord/note.
% @param fretNumber: Minimum fret to be used for the target music.
% @param music: Target music the fret setting should apply to.
% Usage: \withMin Fret 3 { fis cis' }. Enforces second and first string.
withMinFret =
#(define-music-function (fretNumber music) (number? ly:music?)
   #{
     \set TabStaff.restrainOpenStrings = ##t
     \set TabStaff.minimumFret = #fretNumber
     #music
     \unset TabStaff.minimumFret
     \unset TabStaff.restrainOpenStrings
   #})
% < ------------------------------------------------------------------

% > Header. ----------------------------------------------------------
\paper
{
    markup-system-spacing =
    #'((basic-distance . 35)       % The ideal target distance
       (minimum-distance . 30)     % The closest they are allowed to get
       (padding . 5)               % Absolute clear space between them
       (stretchability . 25))      % Allows it to stretch further if needed
  
  % Forces this specific tune to fit perfectly on 2 pages
  %page-count = #3
  
  %ragged-bottom = ##f  % << ##t means true. Consequently, ##f stands for false.
  %ragged-last-bottom = ##f
  
  % Forces the last line on the last page to stop naturally instead of stretching to the paper's right edge.
  ragged-last = ##f
  bottom-margin = 18\mm
  last-bottom-spacing.basic-distance = #8

  % Drops the indentation of the first line in a "paragraph" that is reserved for instrument name.
  indent = #0
}

\header {
  title = \markup { \small {\transparent "(kinda)"} "The Bard‘s Song" \italic \small "(kinda)" }
  subtitle = "In the Forest"
  subsubtitle = "Synthesis for single guitar. A fantasy on a fantasy song really (v2.0)"
  composer = "Orig. Words & Music by H. Kürsch and A. Olbrich"
  meter = \markup {\small "(I.e., guitar should be tuned down 1/2 step)" }
  arranger = "MHK"
  poet = "Flat Standard Tuning"
}
% < -----------------------------------------------------------------

% > INTRO. ==========================================================
layout_instructions_INTRO =
{
  \tempo 4 = 160
  \time 3/4
  
  % "Intro A" grid.
  \repeat volta 2
  {
    s2. * 3  % << "s2." means a invisible blank space. Three times.
    \alternative
    {
      { s2. } % 1st ending lasts 1 measure
      { s2. } % 2nd ending lasts 1 measure
    }
  }
  
  \break  % << Newline.

  % "Intro B" grid.
  \repeat volta 2
  {
    s2. * 2  % << "s2." means a invisible blank space. Three times.
    \alternative
    {
      { s2. * 2 } % 1st ending lasts 1 measure
      { s2. * 4 } % 2nd ending lasts 1 measure
    }
  }
  
  \bar "||"
  
  
}

melody_INTRO = \relative c
{
  % VoiceOne ensures that note stems point up and pauses are placed topside.
  \voiceOne
  
  % Intro A, repeated part.
  <e a c e>4\arpeggio\f d'8 c b4
  <g b> c8 b g4
  b a g
  % Intro A, alternative ending 1.
  <e a c>4 d'8( c b c)  %<< The parantheses open and close a slur.
  % Intro A, alternative ending 2.
  <e, a>2.
  
  % Intro B, repeated part.
  <e a c>4\arpeggio\f d'8 c b4
  b a g
  % Intro B, alternate ending 1.
  g a8 b c4
  b c d
  % Intro B, alternate ending 2.
  g, a8 b( c b)
  
  % Intro Epilogue.
  e4 d c
  b2.
  b4 c b
} %\bar":|."

base_INTRO = \relative c
{
  % VoiceOne ensures that note stems point down and pauses are placed bottomside.
  \voiceTwo

  % Intro A, repeated part.
  a2.
  g
  e
  % Intro A, alternative ending 1.
  a
  % Intro A, alternative ending 2.
  a
  
  % Intro B, repeated part.
  a2.
  g
  % Intro B, alternative ending 1.
  e
  a
  % Intro A, alternative ending 2.
  e
  
  % Intro Epilogue
  a
  g ^\markup { \italic "vib." } % << Vibrato for this exceptionally important note.
  e
}
% < End of INTRO. ====================================================

% > STROPHE_A. =======================================================
layout_instructions_STROPHE_A =
{
  \tempo 4 = 158
  \time 4/4

  s1 * 12 \bar "||" s1 * 4 \bar "||"
}

melody_STROPHE_A = \relative c
{
  \voiceOne
  
  e'8 a, s d a s c e,
  d'4 g,8 d s d g d
  b' e, s a e s g s
  a4 e8 a, e' a c a
  e' a, s <d f> a s <d g>4
  
  d4 g,8 d s d g d
  d'8 e, s e' e, s f' e,
  e'4 e,8 a, e' a c e
  e a, s d a s c s

  d4 g,8 d s d g d
  b'8 e, s c' e, s d' e,
  <a d f>\arpeggio e' d2 d4
  
  % Chord progression and bridge to Refrain
  <c, e g c e>2 <b d g d'>
  <a e' a c> <g d' g b>
  c'8 g e c' b g d b'
  a e s e b' g d4
}

base_STROPHE_A = \relative c
{
  \voiceTwo
  
  a4 a4. a4.
  g2 g
  e4 e4. e4 e8
  a4 s2.
  a4 a4. a4.

  g2 g
  e4 e4. e4.
  a4 s2.
  a4 a4. a4.

  g2 g
  e4 e4. e4.
  d'1

  % Chord progression and bridge to Refrain
  s1
  s1
  c2 b2
  a4 a4 g2
}
% < End of STROPHE. ==================================================

% > REFRAIN. =========================================================
layout_instructions_REFRAIN =
{
  \tempo 4 = 150
  \time 3/4

  s2.
  \repeat volta 3
  {
    s2. * 2
        
    % Add the "3x" text right here, pushing it over the final barline
    \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
    \mark \markup \small "3x"
  }
  
  s2. * 7
  
  \repeat volta 3
  {
    s2. * 2
    \playThrice
  }

  \time 4/4
  s1 * 4
  
  \bar ".|:-||"  %<< Next section will start with a repeated phrase.
}

melody_REFRAIN = \relative c
{
  \voiceOne
  
  d'4 a d
  % Thrice repeated.
  <a c e>4.\arpeggio c8 a4
  <a d f>4.\arpeggio e'8 d4
  
  a'2 a8 a8
  \withMinFret 3 { b2 b4 }
  d,4 a d
  f d8 a d4
  a'2 a8 a8
  \withMinFret 3 { b2 b4 }

  d,4 a d
  % Thrice repeated.
  <a c e>4.\arpeggio c8 a4
  <a d f>4.\arpeggio e'8 d4
 
  f,4 a c f,
  a1
  
  <a c e>4\arpeggio d c d b1
}

base_REFRAIN = \relative c
{
  \voiceTwo
  
  d2.
  % Thrice repeated.
  a2.
  d2.
  
  f2.
  g2.
  d2.
  d2.
  f2.
  g2.

  d2.
  % Thrice repeated.
  a2.
  d2.
  
  f,1( f)
  a1 e
}
% < ==================================================================

% > INTERMEZZO. ======================================================
layout_instructions_INTERMEZZO = \relative c
{
  \tempo 4 = 160
  \time 4/4

  \repeat volta 2
  {
    s1 * 3
  }
  
  s1 * 8
  \bar ".|:-||"
}

melody_INTERMEZZO = \relative c
{
  \voiceOne
  
  <e a>4 a8 a c16( d c b) a4
  <e a>4 a8 a c16( d c b) a4
  d8 \withMinFret 3 { e f g } a2
  
  % High-pitched arpeggio intermezzo.
  c,8  a e b' a e c' a
  e' b g c g d b' g
  f' d a e' d a f' d
  g d g, g' d g, g' d
  f d a e' d a f' d
  g d g, e' d g, g' d
  <a d f>2.\arpeggio s4
  g'1
}

base_INTERMEZZO = \relative c
{
  \voiceTwo
  
  a2 a2
  a2 a2
  d2 a2

  % High-pitched arpeggio intermezzo.
  a1
  g
  d'
  g,
  d'
  g,
  d'2. \withMinFret 5 { a4 }
  g1
}
% < ==================================================================

% > STROPHE_B. =======================================================
% Also added the final refrain right away ...
layout_instructions_STROPHE_B = \relative c
{
  \repeat volta 3
  {
    s1 * 3
    \alternative
    {
      \volta 1,2 { s1 }
      \volta 3 { s1 }
    }
  }
  
  s1 * 4
  %\bar ".|:-||"
  
  \tempo 4 = 150
  \time 3/4
  
  \repeat volta 2
  {
    s2. * 13
  }
}

melody_STROPHE_B = \relative c
{
  \voiceOne
  
  e'8 c a b a e c' a
  b g d c' g d d' g,
  b a e a e b g'4
  c8 a e b' a e c' a
  
  % First bridge from the old arrangement. (There measures 20-24)
  f' d a2 e'4
  a, e d' g,
  c8 a e c' d4 g,
  c8 a e c' b g d b'
  a4 e b' e,
  
  % Refrain
  d'4 a d
  <a c e>4.\arpeggio c8 a4
  <a d f>4.\arpeggio e'8 d4
  e c a
  <a d f>4.\arpeggio e'8 d4
  e c a
  <a d f>4.\arpeggio e'8 d4
  a'4. a8 a4
  b2 b4
  d,4 a d
  f d8 a d4
  a'4. a8 a4
  b2 b4
}

base_STROPHE_B = \relative c
{
  \voiceTwo
  
  a1
  g
  e
  a

  % First bridge from the old arrangement. (There measures 20-24)
  d
  a2 g
  e g
  e g
  a1
  
  % Refrain
  d2.
  a
  d
  a
  d
  a
  d
  f2 f4
  \withMinFret 3 { g2. }
  d
  d
  f2
  f4
  \withMinFret 3 { g2. }
}
% < ==================================================================

% > OUTRO. ===========================================================
layout_instructions_OUTRO = \relative c
{
  \tempo 4 = 150
  \time 4/4
  s1
  \time 3/4
  s2.*2
  
  \time 4/4
  s1
  
  \time 3/4
  s2. * 12
  
  \bar "||"
  s2.*2
}

melody_OUTRO = \relative c
{
  \voiceOne

  a'8 b c4 g c4
  d g, d'
  e c a
  c a e a4
  c4 g c4
  
  d4 g, d'
  c8( b) a4 e
  a2 e'4
  
  e4 c e
  d g, d'
  c8( b) a4 e
  a2 e'4

  e c e
  g g, g'
  e2.(
  
  e4) a,4 b
  c2. d2.
  
 { 
   \pitchedTrill b4\startTrillSpan c 
   b2\stopTrillSpan \fermata
 }
  % Optional: a g e
  % g2., conclude with a:m in V.
}

base_OUTRO = \relative c
{
  \voiceTwo
  s4 c2.
  g
  a
  s2.
  s4 c2.
  b
  a(
  a2) s4
  
  c2.
  b
  a(
  a2) s4
  
  c2.
  g
  a
  
  s2.
  c2.
  b2.
  <e, b' e g>\arpeggio %(
  % <e b' e g>)
}
% < ==================================================================

primerosNames = \chordmode
{
  % Intro A, repeated.
  a2.:m g2. a2.:m
  % Intro A, alternative 1.
  a2.:m 
  % Intro A, alternative 2.
  a2.:m
  
  % Intro B, repeated.
  a2. g2.
  % Intro B, alternative 1.
  e2.:m a2.:m
  % Intro B, alternative 2.
  e2.:m a2.:m g2. e2.:m

  % Melodic Strophe. Thinking mostly of what is actually fretted here.
  a1:m g a:m/e a:m d:m/a
  g a:m/e a:m a:m g a:m/e d:m
  c2 b:m a:m g c b:m a:m g d2.:m
  a:m d:m  %<< Thrice repeated.
  f g d:m d:m f g d:m
  a:m d:m  %<< Thrice repeated.
  f1 f a e:5
  
  % Intermezzo
  a:m a:m d2:m a2:m
  a1:m g d:m g d:m g d:m g
  
  % Arpeggioated Strophe. This is a fantasy of a fantasy song ...
  a:m g e:m a:m d:m
  
  % Complicated arpeggioated bridge that in the old arrangement was earlier.
  a2:m g a:m g a:m g a1:m
  
  % Second Refrain
  d2.:m a:m d:m a:m d:m a:m d:m f g d:m d:m f g
  
  % Outro
  s4 c2. g a:m a:m s4 c2. g/b a:m a:m
  c2. g/b a:m a:m c g a:m a:m
  c g e:m
}

% --- DOCUMENT LAYOUT ---
% Music content in a variable for feeding both \layout{} for pdf
% generation and \midi{} for creation of a timidity-able preview.
my_music =
{
  << \layout_instructions_INTRO
    \new Voice { \melody_INTRO } \new Voice { \base_INTRO } >>
  
  << \layout_instructions_STROPHE_A
    \new Voice { \melody_STROPHE_A } \new Voice { \base_STROPHE_A } >>
  
  << \layout_instructions_REFRAIN
    \new Voice { \melody_REFRAIN } \new Voice { \base_REFRAIN } >>

  << \layout_instructions_INTERMEZZO
    \new Voice { \melody_INTERMEZZO } \new Voice { \base_INTERMEZZO } >>

  << \layout_instructions_STROPHE_B
    \new Voice { \melody_STROPHE_B } \new Voice { \base_STROPHE_B } >>

  << \layout_instructions_OUTRO
    \new Voice { \melody_OUTRO } \new Voice { \base_OUTRO } >>
}

\book
{

\score
{
  <<
    \new ChordNames
    {
      \set chordChanges = ##t
      \primerosNames
    }
    
    \new Staff \with { \omit StringNumber \numericTimeSignature }
    {
      \clef "treble_8"
      \my_music
    }

    \new TabStaff \with { \omit TimeSignature }
    {
      << \layout_instructions_INTRO
        \new TabVoice { \melody_INTRO } \new TabVoice { \base_INTRO } >>

      << \layout_instructions_STROPHE_A
        \new TabVoice { \melody_STROPHE_A } \new TabVoice { \base_STROPHE_A } >>

      << \layout_instructions_REFRAIN
        \new TabVoice { \melody_REFRAIN } \new TabVoice { \base_REFRAIN } >>

       << \layout_instructions_INTERMEZZO
        \new TabVoice { \melody_INTERMEZZO } \new TabVoice { \base_INTERMEZZO } >>

      << \layout_instructions_STROPHE_B
        \new TabVoice { \melody_STROPHE_B } \new TabVoice { \base_STROPHE_B } >>

      << \layout_instructions_OUTRO
        \new TabVoice { \melody_OUTRO } \new TabVoice { \base_OUTRO } >>
    }
  >>
  \layout { }
} % end of pdf printer score.

\score
{
  % Wrap your entire music variable inside \unfoldrepeats
  % \unfoldRepeats
  { \new Staff {\my_music } }
  %% { \new Staff { << \melody_OUTRO \base_OUTRO >> } } % << timidity -T 260 bards_song_v2.midi 
  \midi {}
}

} % end of book.
