# Repack the armpl binaries.
cd armpl
tar -xvf arm-performance-libraries_21.0_RHEL-7_gcc-10.2.tar?revision=df0303bf-296f-4f67-a4bf-344a05563bf4
cd arm-performance-libraries_21.0_RHEL-7_gcc-10.2
./arm-performance-libraries_21.0_*.sh --accept --install-to $PREFIX --force
mkdir $PREFIX/include
mkdir $PREFIX/lib
cp -rn $PREFIX/armpl_21.0_gcc-10.2/include*/* $PREFIX/include
cp -rn $PREFIX/armpl_21.0_gcc-10.2/lib*/* $PREFIX/lib
rm -rf $PREFIX/armpl_21.0_gcc-10.2

