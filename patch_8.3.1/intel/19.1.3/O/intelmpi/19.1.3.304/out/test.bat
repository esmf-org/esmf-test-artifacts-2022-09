#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_O_patch_8.3.1/test.bat_%j.o
#SBATCH -e /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_O_patch_8.3.1/test.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load comp/intel/19.1.3.304 mpi/impi/19.1.3.304
module load netcdf4/4.7.4
module load hdf5/1.13.0

set -x
export ESMF_NETCDF_LIBS="-lhdf5_hl -lhdf5"
export ESMF_DIR=/discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_O_patch_8.3.1/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_O_patch_8.3.1/module-test.log
cd /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_O_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
