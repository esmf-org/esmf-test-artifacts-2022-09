#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o /work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/build.bat_%j.o
#SBATCH -e /work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/build.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
module load gcc/8.3.0 
module load netcdf/4.7.4

set -x
export LD_PRELOAD=/apps/gcc-8/gcc-8.3.0/lib64/libstdc++.so
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/module-build.log
cd /work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 40 2>&1| tee ../build.log
