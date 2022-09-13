#!/bin/sh -l
#PBS -N test.bat
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module load nvhpc/22.2 
module load netcdf/4.8.1

set -x
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpiuni_g_patch_8.3.1/esmf
export ESMF_COMPILER=nvhpc
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpiuni_g_patch_8.3.1/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpiuni_g_patch_8.3.1/module-test.log
cd /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpiuni_g_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
