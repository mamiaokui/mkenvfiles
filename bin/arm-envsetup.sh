export NDK=/home/mamk/Downloads/android-ndk-r8e
export SYSROOT=$NDK/platforms/android-8/arch-arm
export PATH=/home/mamk/Downloads/android-ndk-r8e/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86_64/bin:$PATH
alias CC="arm-linux-androideabi-gcc --sysroot=$SYSROOT"
