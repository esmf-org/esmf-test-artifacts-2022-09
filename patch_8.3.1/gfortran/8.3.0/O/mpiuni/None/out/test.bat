#!/bin/sh -l
#SBATCH --account=nggps_emc
#SBATCH -o /lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/test.bat_%j.o
#SBATCH -e /lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/test.bat_%j.e
#SBATCH --time=3:00:00
#SBATCH --cluster=c4
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module unload PrgEnv-intel
module load PrgEnv-gnu git/2.26.0
module load gcc/8.3.0 
module load cray-netcdf/4.6.3.2

set -x
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf"
export ESMF_DIR=/lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
export ESMF_MPIRUN=/lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/esmf/src/Infrastructure/stubs/mpiuni/mpirun
module list >& /lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/module-test.log
cd /lustre/f2/dev/Mark.Potts/esmf-test/gfortran_8.3.0_mpiuni_O_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
