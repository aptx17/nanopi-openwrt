cd code
cd kernel/
git apply ../../add_fullconenat.diff
cd ../
git clone https://github.com/openwrt/openwrt && cd openwrt/
git checkout a47279154e08d54df05fa8bf45fe935ebf0df5da
#rm target/linux/generic/pending-5.4/403-mtd-hook-mtdsplit-to-Kbuild.patch
#rm target/linux/generic/hack-5.4/700-swconfig_switch_drivers.patch
cp -a ./target/linux/generic/files/* ../kernel/
./scripts/patch-kernel.sh ../kernel target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/hack-5.4
./scripts/patch-kernel.sh ../kernel target/linux/octeontx/patches-5.4
cd ../
wget https://github.com/torvalds/linux/raw/master/scripts/kconfig/merge_config.sh && chmod +x merge_config.sh
grep -i '_NETFILTER_\|FLOW' ../.config.override > .config.override
./merge_config.sh -m .config.override kernel/arch/arm64/configs/nanopi4_linux_defconfig && mv .config kernel/arch/arm64/configs/nanopi4_linux_defconfig

cat ../scripts/kernel.seed >> kernel/arch/arm64/configs/nanopi4_linux_defconfig
