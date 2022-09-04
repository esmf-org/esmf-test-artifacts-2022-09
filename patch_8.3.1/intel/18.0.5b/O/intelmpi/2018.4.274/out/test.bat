#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/intel_18.0.5b_intelmpi_O_patch_8.3.1/test.bat_%j.o
#SBATCH -e /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/intel_18.0.5b_intelmpi_O_patch_8.3.1/test.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
export ESMF_MPIRUN=mpirun.srun
module load intel/18.0.5.274 impi/2018.4.274
module load netcdf-hdf5parallel/4.7.4

set -x
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/intel_18.0.5b_intelmpi_O_patch_8.3.1/esmf
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_NETCDF=nc-config
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/intel_18.0.5b_intelmpi_O_patch_8.3.1/module-test.log
cd /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/intel_18.0.5b_intelmpi_O_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
