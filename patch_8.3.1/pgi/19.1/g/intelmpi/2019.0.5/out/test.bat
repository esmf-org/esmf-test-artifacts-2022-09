#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_intelmpi_g_patch_8.3.1/test.bat_%j.o
#SBATCH -e /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_intelmpi_g_patch_8.3.1/test.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load cmake
export ESMF_MPIRUN=mpirun.srun
module load pgi/19.10 impi/2019.0.5

set -x
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_intelmpi_g_patch_8.3.1/esmf
export ESMF_COMPILER=pgi
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_intelmpi_g_patch_8.3.1/module-test.log
cd /scratch1/NCEPDEV/stmp2/Rocky.Dunlap/esmf-testing/pgi_19.1_intelmpi_g_patch_8.3.1/esmf
make install 2>&1| tee ../install.log
make all_tests 2>&1| tee ../test.log
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd ../nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc.log
