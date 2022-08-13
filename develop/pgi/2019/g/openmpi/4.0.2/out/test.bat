#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o /work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_g_develop/test.bat_%j.o
#SBATCH -e /work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_g_develop/test.bat_%j.e
#SBATCH --time=4:00:00
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
export ESMF_MPIRUN=mpirun.srun
module load pgi/2019 openmpi/4.0.2
module load netcdf/4.7.4

set -x
export ESMF_F90COMPILER=mpif90
export ESMF_CXXCOMPILER=mpicxx
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_g_develop/esmf
export ESMF_COMPILER=pgi
export ESMF_COMM=openmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_g_develop/module-test.log
cd /work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_g_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
