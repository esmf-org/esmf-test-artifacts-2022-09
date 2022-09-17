#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/build.bat_%j.o
#SBATCH -e /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/build.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
module load pgi/19.10 

set -x
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/esmf
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/module-build.log
cd /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_mpiuni_g_patch_8.3.1/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 40 2>&1| tee ../build.log
