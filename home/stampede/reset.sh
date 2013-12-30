#!/bin/bash


export PATH=$HOME/local/cfour.gnu.mkl/bin/:$PATH
module swap intel gcc
export LD_LIBRARY_PATH=/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/intel64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/apps/intel/13/composer_xe_2013.2.146/mkl/lib/intel64:$LD_LIBRARY_PATH

xwipeout

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
        STATEFILE=allbutecc_$CALCLEVEL-$BASIS.tar.gz
	CALCLEVEL=`echo $PWD | cut -f $calclevellocation -d /`
fi


FILELIST="basinfo.data den.dat FILES fort.83 GAMLAM \
          I* J* M* N* OLDMOS"

echo "extracting $STATEFILE ... "
tar -xvf $STORAGE/$STATEFILE $FILELIST 
