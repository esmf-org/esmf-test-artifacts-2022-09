#!/bin/bash -l
export JOBID=NO_BATCH
module load gcc/9.3.0-gcc-7.5.0 openmpi/4.0.5-gcc-9.3.0
module load netcdf-c/4.8.0-gcc-9.3.0-openmpi
module load hdf5/1.10.7-gcc-9.3.0-openmpi
module load netcdf-fortran/4.5.3-gcc-9.3.0-openmpi

set -x
export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export ESMF_DIR=/home/mpotts/esmf-tests/gfortran_9.3.0_openmpi_g_patch_8.3.1/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /home/mpotts/esmf-tests/gfortran_9.3.0_openmpi_g_patch_8.3.1/module-build.log
cd /home/mpotts/esmf-tests/gfortran_9.3.0_openmpi_g_patch_8.3.1/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 8 2>&1| tee ../build.log
