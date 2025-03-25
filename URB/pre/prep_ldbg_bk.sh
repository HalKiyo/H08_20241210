#!/bin/sh

L=50
LMAX=4000

while [ $L -le $LMAX ]; do
    BK5=$(htpoint $ARGBK5 l ../../map/dat/lnd_msk_/lndmsk.CAMA.bk5 $L)
    SUM=$(echo $BK5 | awk '{printf("%d", $1)}')

    if [ $SUM -ge 1 ]; then
        echo $L $SUM $BK5
    fi

    L=$((L + 50))
done

