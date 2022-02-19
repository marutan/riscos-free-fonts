#!/bin/bash

# This script should be executed in from within the Tools directory

# Prerequisite packages
# git
# fontforge
# fontforge-extras
# fontforge-nox


dofontimage() {
	sfdname="$1"
	pngname=`basename "$sfdname" .sfd`.png

	fontimage -o "$pngname" "$sfdname"
}

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

cp -f ../tmp/ROMFonts/Fonts/Corpus/Bold/Outlines0 ../tmp/ROMFonts/Fonts/Corpus/Bold/Oblique
acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Bold/Oblique/
sed "s/Corpus.Bold/Corpus.Bold.Oblique/" Corpus.Bold.sfd > Corpus.Bold.Oblique.sfd
acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Bold/
cp -f ../tmp/ROMFonts/Fonts/Corpus/Medium/Outlines0 ../tmp/ROMFonts/Fonts/Corpus/Medium/Oblique
acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Medium/Oblique/
sed "s/Corpus.Medium/Corpus.Medium.Oblique/" Corpus.Medium.sfd > Corpus.Medium.Oblique.sfd
acorn2sfd ../tmp/ROMFonts/Fonts/Corpus/Medium/
cp -f ../tmp/ROMFonts/Fonts/Homerton/Bold/Outlines0 ../tmp/ROMFonts/Fonts/Homerton/Bold/Oblique
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Bold/Oblique/
sed "s/Homerton.Bold/Homerton.Bold.Oblique/" Homerton.Bold.sfd > Homerton.Bold.Oblique.sfd
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Bold/
cp -f ../tmp/ROMFonts/Fonts/Homerton/Medium/Outlines0 ../tmp/ROMFonts/Fonts/Homerton/Medium/Oblique
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Medium/Oblique/
sed "s/Homerton.Medium/Homerton.Medium.Oblique/" Homerton.Medium.sfd > Homerton.Medium.Oblique.sfd
acorn2sfd ../tmp/ROMFonts/Fonts/Homerton/Medium/
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
../Tools/fontmunge.pe Corpus.Bold.Oblique.sfd
../Tools/fontmunge.pe Corpus.Medium.sfd
../Tools/fontmunge.pe Corpus.Medium.Oblique.sfd
../Tools/fontmunge.pe Homerton.Bold.sfd
../Tools/fontmunge.pe Homerton.Bold.Oblique.sfd
../Tools/fontmunge.pe Homerton.Medium.sfd
../Tools/fontmunge.pe Homerton.Medium.Oblique.sfd
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
dofontimage Corpus.Bold.sfd
dofontimage Corpus.Medium.sfd
dofontimage Homerton.Bold.sfd
dofontimage Homerton.Medium.sfd
dofontimage Selwyn.sfd
dofontimage Sidney.sfd
dofontimage Trinity.Bold.Italic.sfd
dofontimage Trinity.Bold.sfd
dofontimage Trinity.Medium.Italic.sfd
dofontimage Trinity.Medium.sfd

dofontimage NewHall.Bold.sfd
dofontimage NewHall.Bold.Italic.sfd
dofontimage NewHall.Medium.sfd
dofontimage NewHall.Medium.Italic.sfd
dofontimage Sassoon.Primary.sfd
dofontimage Sassoon.Primary.Bold.sfd
dofontimage System.Fixed.sfd
dofontimage System.Medium.sfd



