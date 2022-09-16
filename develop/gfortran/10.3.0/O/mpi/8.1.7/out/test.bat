#!/bin/sh -l
#PBS -N test.bat
#PBS -l walltime=1:00:00
#PBS -q dev
#PBS -A GFS-DEV
#PBS -l select=1:ncpus=128:mpiprocs=128
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

module unload PrgEnv-cray PrgEnv-intel
module load PrgEnv-gnu cray-pals craype cmake
module load gcc/10.3.0 cray-mpich/8.1.7

set -x
export ESMF_MPIRUN=mpirun.unicos
sed -i 's/aprun/mpiexec/' scripts/mpirun.unicos
export ESMF_DIR=/lfs/h1/emc/ptmp/Mark.Potts/gfortran_10.3.0_mpi_O_develop/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /lfs/h1/emc/ptmp/Mark.Potts/gfortran_10.3.0_mpi_O_develop/module-test.log
cd /lfs/h1/emc/ptmp/Mark.Potts/gfortran_10.3.0_mpi_O_develop/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
