#!/bin/sh -l
#PBS -N build.bat
#PBS -l walltime=1:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module load nvhpc/22.2 mpt/2.25
module load netcdf/4.8.1

set -x
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_patch_8.3.1/esmf
export ESMF_COMPILER=nvhpc
export ESMF_COMM=mpt
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_patch_8.3.1/module-build.log
cd /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_patch_8.3.1/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 36 2>&1| tee ../build.log
