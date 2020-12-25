cd code
cd kernel/
git apply ../../add_fullconenat.diff


cat ../scripts/kernel.seed >> kernel/arch/arm64/configs/nanopi4_linux_defconfig
