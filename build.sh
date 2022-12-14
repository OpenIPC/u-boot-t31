#!/bin/sh -e

export ARCH=mips
export CROSS_PATH="../../../../pc/tools/toolchain/gcc_540/mips-gcc540-glibc222-32bit-r3.3.0/bin"
export CROSS_COMPILE="$(readlink -f $CROSS_PATH)/mips-linux-gnu-"

# NOR
# T31N make isvp_t31_sfcnor
# T31L make isvp_t31_sfcnor_lite
# T31X make isvp_t31_sfcnor_ddr128M
# T31A make isvp_t31a_sfcnor_ddr128M
# T31AL make isvp_t31al_sfcnor_ddr128M
# MMC
# T31N make isvp_t31_msc0
# T31L make isvp_t31_msc0_lite
# T31X make isvp_t31_msc0_ddr128M
# T31A make isvp_t31a_msc0_ddr128M
# T31AL make isvp_t31al_msc0_ddr128M

declare -A cfg
cfg[t31n]="isvp_t31_sfcnor"
cfg[t31l]="isvp_t31_sfcnor_lite"
cfg[t31x]="isvp_t31_sfcnor_ddr128M"
cfg[t31a]="isvp_t31a_sfcnor_ddr128M"
cfg[t31al]="isvp_t31al_sfcnor_ddr128M"
cfg[t21n]="isvp_t21_sfcnor"

OUTPUTDIR="${HOME}/uboot"
mkdir -p ${OUTPUTDIR} 2>&1 > /dev/null

for soc in "${!cfg[@]}" ;do

make distclean
make ${cfg[$soc]}
make -j8

cp u-boot-with-spl.bin ${OUTPUTDIR}/u-boot-${soc}-universal.bin

done
