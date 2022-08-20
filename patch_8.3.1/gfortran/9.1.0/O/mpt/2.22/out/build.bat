#!/bin/sh -l
#PBS -N build.bat
#PBS -l walltime=1:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module load gnu/9.1.0 mpt/2.22
module load netcdf/4.7.3

set -x
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/gfortran_9.1.0_mpt_O_patch_8.3.1/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpt
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /glade/scratch/dunlap/esmf-testing/gfortran_9.1.0_mpt_O_patch_8.3.1/module-build.log
cd /glade/scratch/dunlap/esmf-testing/gfortran_9.1.0_mpt_O_patch_8.3.1/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 36 2>&1| tee ../build.log
