$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo ----- Making recovery image ------
	cp device/jiayu/g4/repack-MT65xx.pl $(PRODUCT_OUT)/repack-MT65xx.pl
	cp device/jiayu/g4/mkbootimg $(PRODUCT_OUT)/mkbootimg
	chmod 644 $(PRODUCT_OUT)/recovery/root/default.prop
	chmod 750 $(PRODUCT_OUT)/recovery/root/init
	chmod 750 $(PRODUCT_OUT)/recovery/root/sbin/adbd
	chmod 750 $(PRODUCT_OUT)/recovery/root/sbin/fix_permissions.sh
	chmod 750 $(PRODUCT_OUT)/recovery/root/sbin/healthd
	chmod 750 $(PRODUCT_OUT)/recovery/root/sbin/mount.exfat
	chmod 750 $(PRODUCT_OUT)/recovery/root/sbin/parted
	chmod 750 $(PRODUCT_OUT)/recovery/root/supersu/install-supersu.sh
	cd $(PRODUCT_OUT) && perl repack-MT65xx.pl -recovery kernel recovery/root $@
	rm $(PRODUCT_OUT)/repack-MT65xx.pl
	rm $(PRODUCT_OUT)/mkbootimg
	@echo ----- Made recovery image -------- $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)


$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	perl device/jiayu/g4/repack-MT65xx.pl -boot $(recovery_kernel) $(PRODUCT_OUT)/root $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
