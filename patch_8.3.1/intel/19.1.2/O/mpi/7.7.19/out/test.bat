#!/bin/sh -l
#SBATCH --account=e3sm
#SBATCH -o /global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.1.2_mpi_O_patch_8.3.1/test.bat_%j.o
#SBATCH -e /global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.1.2_mpi_O_patch_8.3.1/test.bat_%j.e
#SBATCH --time=3:00:00
#SBATCH -C haswell
#SBATCH --qos=regular
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module unload darshan
module load intel/19.1.2.254 cray-mpich/7.7.19
module load cray-netcdf/4.6.3.2

set -x
export ESMF_NETCDF_LIBS="-lnetcdf"
export ESMF_NETCDFF_LIBS="-lnetcdff"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/cray/pe/hdf5/1.10.5.2/INTEL/19.0/lib/pkgconfig
export ESMF_DIR=/global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.1.2_mpi_O_patch_8.3.1/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.1.2_mpi_O_patch_8.3.1/module-test.log
cd /global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.1.2_mpi_O_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
