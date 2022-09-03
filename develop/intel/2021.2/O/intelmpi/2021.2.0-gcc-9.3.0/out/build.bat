#!/bin/bash -l
export JOBID=NO_BATCH
module load intel-oneapi-compilers/2021.2.0-gcc-9.3.0 intel-oneapi-mpi/2021.2.0-gcc-9.3.0
module load netcdf-c/4.8.0-intel-2021.2.0
module load netcdf-fortran/4.5.3-intel-2021.2.0

set -x
export ESMF_DIR=/home/mpotts/esmf-tests/intel_2021.2_intelmpi_O_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /home/mpotts/esmf-tests/intel_2021.2_intelmpi_O_develop/module-build.log
cd /home/mpotts/esmf-tests/intel_2021.2_intelmpi_O_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 8 2>&1| tee ../build.log
