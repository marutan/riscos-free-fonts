#!/bin/bash

# This script should be executed in from within the Tools directory

# Prerequisite packages
# git
# fontforge
# fontforge-extras
# fontforge-nox


cd ..

mkdir -p Fonts
mkdir -p tmp
cd tmp

# Fetch the fonts module from the RISC OS repositories
git clone https://gitlab.riscosopen.org/RiscOS/Sources/Video/Render/Fonts/ROMFonts.git
git clone https://gitlab.riscosopen.org/RiscOS/Sources/SystemRes/Fonts.git

# Remove any RISC OS filetype extensions that will confuse acorn2sfd
# e.g. rename Outlines,ff6 to Outlines
find -type f -name '*,ff6' -print0 | while read -d $'\0' f; do mv "$f" "${f%,ff6}"; done

# Add the font encodings file to the directories that are missing them
cd ROMFonts/Fonts
cp Encodings/_Base0 Corpus/Bold/Base0
cp Encodings/_Base0 Corpus/Bold/Oblique/Base0
cp Encodings/_Base0 Corpus/Medium/Base0
cp Encodings/_Base0 Corpus/Medium/Oblique/Base0
cp Encodings/_Base0 Homerton/Bold/Base0
cp Encodings/_Base0 Homerton/Bold/Oblique/Base0
cp Encodings/_Base0 Homerton/Medium/Base0
cp Encodings/_Base0 Homerton/Medium/Oblique/Base0
cp Encodings/_Base0 Trinity/Bold/Base0
cp Encodings/_Base0 Trinity/Bold/Italic/Base0
cp Encodings/_Base0 Trinity/Medium/Base0
cp Encodings/_Base0 Trinity/Medium/Italic/Base0
cd ../..

#cp ROMFonts/Fonts/Encodings/_Base0 Fonts/Sassoon/Primary/Base0
#cp ROMFonts/Fonts/Encodings/_Base0 Fonts/Sassoon/Primary/Bold/Base0



# Covert fonts to sfd format
cd ../Fonts

acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Bold/
#acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Bold/Oblique/ Generates Error!
acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Medium/
#acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Medium/Oblique/ Generates Error!
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Bold/
#acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Bold/Oblique/ Generates Error!
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Medium/
#acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Medium/Oblique/ Generates Error!
acorn2sfd ../tmp/ROMFonts/Fonts/Selwyn/
acorn2sfd ../tmp/ROMFonts/Fonts/Sidney/
acorn2sfd ../tmp/ROMFonts/Fonts/Trinity/Bold/
acorn2sfd ../tmp/ROMFonts/Fonts/Trinity/Bold/Italic/
acorn2sfd ../tmp/ROMFonts/Fonts/Trinity/Medium/
acorn2sfd ../tmp/ROMFonts/Fonts/Trinity/Medium/Italic/

acorn2sfd ../tmp/Fonts/NewHall/Bold
acorn2sfd ../tmp/Fonts/NewHall/Bold/Italic
acorn2sfd ../tmp/Fonts/NewHall/Medium
acorn2sfd ../tmp/Fonts/NewHall/Medium/Italic
acorn2sfd ../tmp/Fonts/Sassoon/Primary
acorn2sfd ../tmp/Fonts/Sassoon/Primary/Bold
acorn2sfd ../tmp/Fonts/System/Fixed
acorn2sfd ../tmp/Fonts/System/Medium


# remove git repositories, no longer needed
rm -rf ../tmp


# Update fonts to correct their drawing direction and save out .otf versions of all fonts
../Tools/fontmunge.pe Corpus.Bold.sfd
../Tools/fontmunge.pe Corpus.Medium.sfd
../Tools/fontmunge.pe Homerton.Bold.sfd
../Tools/fontmunge.pe Homerton.Medium.sfd
../Tools/fontmunge.pe Selwyn.sfd
../Tools/fontmunge.pe Sidney.sfd
../Tools/fontmunge.pe Trinity.Bold.Italic.sfd
../Tools/fontmunge.pe Trinity.Bold.sfd
../Tools/fontmunge.pe Trinity.Medium.Italic.sfd
../Tools/fontmunge.pe Trinity.Medium.sfd

../Tools/fontmunge.pe NewHall.Bold.sfd
../Tools/fontmunge.pe NewHall.Bold.Italic.sfd
../Tools/fontmunge.pe NewHall.Medium.sfd
../Tools/fontmunge.pe NewHall.Medium.Italic.sfd
../Tools/fontmunge.pe Sassoon.Primary.sfd
../Tools/fontmunge.pe Sassoon.Primary.Bold.sfd
../Tools/fontmunge.pe System.Fixed.sfd
../Tools/fontmunge.pe System.Medium.sfd



# Create preview images of the fonts
fontimage Corpus.Bold.sfd
fontimage Corpus.Medium.sfd
fontimage Homerton.Bold.sfd
fontimage Homerton.Medium.sfd
fontimage Selwyn.sfd
fontimage Sidney.sfd
fontimage Trinity.Bold.Italic.sfd
fontimage Trinity.Bold.sfd
fontimage Trinity.Medium.Italic.sfd
fontimage Trinity.Medium.sfd

fontimage NewHall.Bold.sfd
fontimage NewHall.Bold.Italic.sfd
fontimage NewHall.Medium.sfd
fontimage NewHall.Medium.Italic.sfd
fontimage Sassoon.Primary.sfd
fontimage Sassoon.Primary.Bold.sfd
fontimage System.Fixed.sfd
fontimage System.Medium.sfd



