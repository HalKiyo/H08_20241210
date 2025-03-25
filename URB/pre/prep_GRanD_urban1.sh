#!/bin/sh
############################################################
#to   make GRanD_tk5_noedit
#
#
#
############################################################
# Methods
#
# Job 1: Show the dams in the domain
#
# Mannually list up the dams to inclue, and set $NAMES
#
# Job 2: Extract the data from GRanD and 
#
############################################################
#
# Setting
#
#LONMIN=138; LONMAX=141; LATMIN=34; LATMAX=38; SUF=.tk5
LONMIN=98; LONMAX=102; LATMIN=13; LATMAX=20; SUF=.bk5
#
# In
#
LSTFULL=../../map/org/GRanD/GRanD_M.txt  # original
#
# Out
#
LSTOUT=../org/GRanD/GRanD${SUF}.raw.txt  # Extracted the reservoirs in $NAMES
############################################################
#
############################################################
NAMES="Sirikit Bhumibol Pasak_Chonlasit Srinagrind Tha_Tung_Na
       Mae_Ngat  Me-Kuang      Kiwlom  Mae_Chang 
       Chulabhorn  Huai_Kum     Bueng_Boraphet    Tabsalao
       Lamtakhong   Krasoew
       Khao_Laem   Lamphraphloeng  Huai_Sam_Nak_Mai_Teng
       Beng_phra"
############################################################
# Job 1 Dams in the area
############################################################
awk '($1>'$LONMIN'&&$1<'$LONMAX'&&$2>'$LATMIN'&&$2<'$LATMAX'){print}' $LSTFULL
############################################################
# Job 2 Extract data
############################################################
#
# initialize
#
if [ -f $LSTOUT ]; then
  rm $LSTOUT
fi

for NAME in $NAMES; do
  awk '($5=="'$NAME'"){print}' $LSTFULL >> $LSTOUT
done

