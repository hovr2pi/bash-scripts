#!/bin/bash

STORAGE=/work/00416/csim/public/tarballs/
counter=`echo $PWD | awk -F'/' '{print NF; exit}'`

BASIS=`echo $PWD | cut -f $counter -d /`

if [ $BASIS = ecc_only ]; then
	echo "defaulting to pvdz basis"
	calclevellocation=`expr $counter - 1` 
	CALCLEVEL=`echo $PWD | cut -f $calclevellocation -d /`
        STATEFILE=allbutecc_$CALCLEVEL.tar.gz
else
	echo "basis is $BASIS"
	calclevellocation=`expr $counter - 2` 
	CALCLEVEL=`echo $PWD | cut -f $calclevellocation -d /`
        STATEFILE=allbutecc_$CALCLEVEL-$BASIS.tar.gz
fi


FILELIST="basinfo.data den.dat FILES fort.83 GAMLAM \
          I* J* M* N* OLDMOS"

echo "archiving previous solutions ..."
mv $STORAGE/$STATEFILE $STORAGE/.$STATEFILE.old
echo "creating $STATEFILE ... "
tar -czvf $STORAGE/$STATEFILE $FILELIST 
