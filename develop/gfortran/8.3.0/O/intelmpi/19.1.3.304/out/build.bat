#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_intelmpi_O_develop/build.bat_%j.o
#SBATCH -e /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_intelmpi_O_develop/build.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID


module load comp/gcc/8.3.0 mpi/impi/19.1.3.304

set -x
export ESMF_DIR=/discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_intelmpi_O_develop/esmf
export ESMF_COMPILER=gfortran
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
module list >& /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_intelmpi_O_develop/module-build.log
cd /discover/nobackup/projects/sbu/mpotts/esmf-test/gfortran_8.3.0_intelmpi_O_develop/esmf
set -o pipefail
make info 2>&1| tee ../info.log
make -j 28 2>&1| tee ../build.log
