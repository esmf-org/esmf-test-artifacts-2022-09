#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_g_develop/build.bat_%j.o
#SBATCH -e /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_g_develop/build.bat_%j.e
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
export ESMF_DIR=/discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_g_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_g_develop/module-build.log
cd /discover/nobackup/projects/sbu/mpotts/esmf-test/intel_19.1.3_intelmpi_g_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 28 2>&1| tee ../build.log
