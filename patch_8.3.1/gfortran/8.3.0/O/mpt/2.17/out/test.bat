#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_mpt_O_patch_8.3.1/test.bat_%j.o
#SBATCH -e /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_mpt_O_patch_8.3.1/test.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load comp/gcc/8.3.0 mpi/sgi-mpt/2.17

set -x
export ESMF_DIR=/discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_mpt_O_patch_8.3.1/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpt
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_mpt_O_patch_8.3.1/module-test.log
cd /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_mpt_O_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
