##-----------------------------------------------------
## DESCRIPTION: Masks repetitive elements in lepiddopt 
##		eran genomes using RepeatMasker
##-----------------------------------------------------

#!/bin/bash
#$ -S /bin/sh
. /etc/profile
#$ -o out_A1
#$ -cwd
#$ -pe threads 30

##-----------------
## environment
##-----------------

WORK_DIR=/home/lfern/projects/ZC2019/RepeatMasker
GENO_DIR=/scratch4/lfern/data/ZC2019/lep_genomes/selection
LIBR_DIR=/home/lfern/databases/RepeatMasker
REPM_DIR=/opt/ogma/latest/RepeatMasker

## --------------------------------------
## Loop through the genomes and mask each
## --------------------------------------

cd $GENO_DIR

for genome in $(ls); do

	# Create environment .................
	name=$(echo $genome | cut -f1 -d'.')
	size=$(grep -v '>' $genome | wc -c)
	mkdir $WORK_DIR/$name

	# Run RepeatMasker ...........................................

	$REPM_DIR/RepeatMasker \
	     -lib $LIBR_DIR/hex_plus_butterfly_corrected_Aug_2017.fas \
             -pa 30 \
	     -q \
	     -a \
             -dir $WORK_DIR/$name \
             $genome

	# Calculate Kimura distance ....................
	cd $WORK_DIR/$name
	perl $REPM_DIR/util/calcDivergenceFromAlign.pl \
	     -s $genome.summary \
	     -a $genome.distance \
	     $genome.align

	# Create html graph ............................
	perl $REPM_DIR/util/createRepeatLandscape.pl \
	     -div $genome.summary > $name.html \
	     -g $size

	# Go back to original directory .....
	cd $GENO_DIR

done
