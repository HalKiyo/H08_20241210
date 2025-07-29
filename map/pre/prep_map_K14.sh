#!/bin/sh
############################################################
#to   prepare global canal data by Kitamura et al. (2014)
#by   2016/01/31, hanasaki
############################################################
#settings
############################################################
SUF=.bk5
L=4032
XY="48 84"
L2X=${DIRH08}/map/dat/l2x_l2y_/l2x${SUF}.txt
L2Y=${DIRH08}/map/dat/l2x_l2y_/l2y${SUF}.txt
LONLAT="98 102 13 20"
MAP=.CAMA
ARG="$L $XY $L2X $L2Y $LONLAT"

MAX=1
OPT=within

############################################################
# in
############################################################
DIRCANORG=../../map/out/can_org_   # origin of canal water
DIRCANDES=../../map/out/can_des_   # destination of canal water
#
# ORGIN=../../map/org/K14/in__3___20000000${SUF}.txt
#ORGOUT=../../map/org/K14/out_3___20000000${SUF}.txt
#
BININ=../../map/org/K14/in__3___20000000${SUF}
BINOUT=../../map/org/K14/out_3___20000000${SUF}
#
LCANIMPORG=$DIRCANORG/canorg.l.${OPT}.${MAX}${MAP}${SUF}
LCANIMPDES=$DIRCANDES/candes.l.${OPT}.${MAX}${MAP}${SUF}
#
RIVSEQ=../../map/out/riv_seq_/rivseq${MAP}${SUF}
############################################################
# create
############################################################
htcreate $L 1e20 $BININ
htcreate $L 1e20 $BINOUT
############################################################
# out 
############################################################
# ASCIN=../../map/org/K14/in__3___20000000.txt
#ASCOUT=../../map/org/K14/out_3___20000000.txt
#
LCANEXPORG=$DIRCANORG/canorg.l.canal.NON${SUF}
LCANEXPDES=$DIRCANDES/candes.l.canal.NON${SUF}
#
LCANMRGORG=$DIRCANORG/canorg.l.merged.${MAX}${MAP}${SUF}
LCANMRGDES=$DIRCANDES/candes.l.merged.${MAX}${MAP}${SUF}
#
LOG=temp.log
############################################################
# job
############################################################
#htformat $ARG asciiu binary $ORGIN  $BININ
#htformat $ARG asciiu binary $ORGOUT $BINOUT
############################################################
# job (fix problem: remove 33 of in 37.75,-121.75 and 30 of in -121.25,37.25)
############################################################
#htedit $ARGGL5 lonlat $BININ 1.0E20 -121.75 37.75 >  $LOG
#htedit $ARGGL5 lonlat $BININ 1.0E20 -121.25 37.25 >> $LOG
############################################################
# job (print out non-zero points)
############################################################
#htmask   $ARGGL5 $BININ  $BININ  ne 0 $BININ  all > $ASCIN
#htmask   $ARGGL5 $BINOUT $BINOUT ne 0 $BINOUT all > $ASCOUT
############################################################
# convert
############################################################
if [ !  -d $DIRCANORG ]; then  mkdir -p $DIRCANORG; fi
if [ !  -d $DIRCANDES ]; then  mkdir -p $DIRCANDES; fi
#
prog_map_K14 $BININ $BINOUT $LCANIMPORG $LCANIMPDES $RIVSEQ $LCANEXPORG $LCANEXPDES $LCANMRGORG $LCANMRGDES >> $LOG
echo Log: $LOG
