#!/bin/bash
UNDO="$XDG_DATA_HOME/uzbl/undolist"
UZBL=uzbl-browser
if [ -e $UNDO ]; then
    URL=`tail -n 1 $UNDO`
    LINECOUNT=`cat $UNDO | wc -l`
    if [[ $LINECOUNT == 1 ]]; then
        $UZBL -u "$URL" &
        rm $UNDO
    else
        $UZBL -u "$URL" &
        sed -i '$d' $UNDO
    fi
fi
