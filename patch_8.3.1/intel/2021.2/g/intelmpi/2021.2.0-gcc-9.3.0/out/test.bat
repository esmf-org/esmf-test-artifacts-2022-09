#!/bin/bash -l
export JOBID=NO_BATCH
module load intel-oneapi-compilers/2021.2.0-gcc-9.3.0 intel-oneapi-mpi/2021.2.0-gcc-9.3.0
module load netcdf-c/4.8.0-intel-2021.2.0
module load netcdf-fortran/4.5.3-intel-2021.2.0 

set -x
export ESMF_DIR=/home/mpotts/esmf-tests/intel_2021.2_intelmpi_g_patch_8.3.1/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /home/mpotts/esmf-tests/intel_2021.2_intelmpi_g_patch_8.3.1/module-test.log
cd /home/mpotts/esmf-tests/intel_2021.2_intelmpi_g_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
