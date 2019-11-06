################# busco_ZC04.2.sh ######################

##-----------------------------------------------------
## DESCRIPTION: Completness assesment base on universal
##              homologs with BUSCO for ZC07 using 
##		arthopoda data base
##-----------------------------------------------------

#!/bin/bash
#$ -S /bin/sh
. /etc/profile
#$ -o out_busco
#$ -cwd
#$ -pe threads 20

##-----------------------
## Set environment
##-----------------------

export AUGUSTUS_CONFIG_PATH=/home/lfern/software/augustus/config/
export PATH=/opt/augustus-3.2.3/bin:$PATH
export PATH=/opt/augustus-3.2.3/scripts:$PATH

WORK_DIR=/home/lfern/projects/ZC07
DATA_DIR=/home/lfern/projects/ZC07
SOFT_DIR=/home/lfern/software/busco-master

## ----------------------
## Run busco
## ----------------------

cd $WORK_DIR

python $SOFT_DIR/scripts/run_BUSCO.py --in C.ZC04.fasta\
                              	      --out ZC07_re-trimmed_endopterigota\
                                      --lineage $SOFT_DIR/endopterygota_odb9\
                                      --mode geno \
                                      --cpu 20

