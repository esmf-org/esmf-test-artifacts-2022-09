#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_mvapich2_g_develop/build.bat_%j.o
#SBATCH -e /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_mvapich2_g_develop/build.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
export ESMF_MPIRUN=mpirun.srun
export LIBRARY_PATH=$LIBRARY_PATH:/apps/mvapich2/2.3-intel/lib
export ESMF_CXXCOMPILEOPTS="-I/apps/mvapich2/2.3-intel/include"
export ESMF_F90COMPILEOPTS="-I/apps/mvapich2/2.3-intel/include"
module load intel/2020.2 mvapich2/2.3
module load netcdf/4.7.0
module load hdf5/1.10.6

set -x
export ESMF_DIR=/lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_mvapich2_g_develop/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=mvapich2
export ESMF_NETCDF=nc-config
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_mvapich2_g_develop/module-build.log
cd /lfs4/HFIP/hfv3gfs/Mark.Potts/esmf-tests/intel_2020.2_mvapich2_g_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 24 2>&1| tee ../build.log
