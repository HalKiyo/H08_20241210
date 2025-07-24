#!/bin/sh
YEARMIN=2019
YEARMAX=2019
MONS="00 01 02 03 04 05 06 07 08 09 10 11 12"
#MONS="04 05 06 07 08 09 10 11"
PRJ=W5E5
RUN=____

L=4032
XY="48 84"
SUF=.bk5
L2X=../../map/dat/l2x_l2y_/l2x${SUF}.txt
L2Y=../../map/dat/l2x_l2y_/l2y${SUF}.txt
LONLAT="98 102 13 20"
ARGGL5="$L $XY $L2X $L2Y $LONLAT"

OPT=bak   # to take backup
OPT=rest  # to restore from backup
OPT=rplc  # to replace snowfall less than 0.000005 kg/m2/s to zero.
#
#
#
YEAR=${YEARMIN}
while [ $YEAR -le $YEARMAX ]; do
  for MON in $MONS; do
    DAY=0
    DAYMAX=`htcal $YEAR $MON`
    if [ $MON = "00" ]; then
      DAYMAX=0
    fi
    while [ $DAY -le $DAYMAX ]; do
      DAY=`echo $DAY | awk '{printf("%2.2d",$1)}'`
      SNOWF=../../met/dat/Snowf___/$PRJ$RUN$YEAR$MON$DAY$SUF
      if   [ $OPT = "bak" ]; then 
	cp $SNOWF $SNOWF.bak
      elif [ $OPT = "rest" ]; then 
	cp $SNOWF.bak $SNOWF
	echo cp $SNOWF.bak $SNOWF
      else
	htmaskrplc $ARGGL5 $SNOWF $SNOWF lt 0.000005 0.0 $SNOWF
      fi
      DAY=`expr $DAY + 1`
    done
  done
  YEAR=`expr $YEAR + 1`
done
