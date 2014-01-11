#!/bin/sh

if [ -z "$1" ] ; then
	echo "Please enter the desired medium: P(räsentation)/H(andout)"
	read TARGET
else
	TARGET=$1
fi

if [ -z "$2" ]; then
	PROCEDURE="normal"
else
	PROCEDURE=$2
fi

TARGET=$(echo $TARGET | tr '[:upper:]' '[:lower:]')
PROCEDURE=$(echo $PROCEDURE| tr '[:upper:]' '[:lower:]')

TARGET=$(echo $TARGET | sed 's/-//'g)
PROCEDURE=$(echo $PROCEDURE | sed 's/-//g')

if [ "$TARGET" = "präsentation" ]; then
	TARGET="p"
fi

if [ "$TARGET" = "handout" ]; then
	TARGET="h"
fi

if [ "$PROCEDURE" = "normal" ]; then
	PROCEDURE="n"
fi

if [ "$PROCEDURE" = "clean" ]; then
	PROCEDURE="c"
fi

if [[ "$TARGET" != "p" && "$TARGET" != "h" ]]; then
	echo "no matching TARGET"
	exit 1
fi

if [[ "$PROCEDURE" != "n" && "$PROCEDURE" != "c" ]]; then
	echo "no matching PROCEDURE"
	exit 1
fi

if [ "$TARGET" = "h" ]; then
	if [ "$PROCEDURE" = "c" ]; then
		rm -f Handout.aux Handout.dvi Handout.log Handout.pdf Handout.ps
	fi
	NAME="Handout"
else
	if [ "$PROCEDURE" = "c" ]; then
		rm -f Präsentation.aux Präsentation.dvi Präsentation.log Präsentation.nav Präsentation.out Präsentation.pdf Präsentation.ps Präsentation.snm Präsentation.toc
	fi
	NAME="Präsentation"
fi

latex $NAME.tex
latex $NAME.tex
dvips -Ppdf -G0 $NAME.dvi
ps2pdf $NAME.ps

echo "Done."
