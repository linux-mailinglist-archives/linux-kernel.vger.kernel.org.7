Return-Path: <linux-kernel+bounces-748287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A143B13F14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB60A3AFABB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961901A254E;
	Mon, 28 Jul 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkTbAqM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FF1EFFB7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717381; cv=none; b=nqm0q6wlveKIuZBC0p+hIBL1sdw0I7mikgk1GWCv2MC1WyjAcbF6scB/eQCFq4zZGxKtC2pa5qhdEqhn+Y5G1IEEfZqwXTNFZAtQwXiab6VYUgVKvR2RoTXeL8iv8sAqqE/m04GokTpGPyj1fQIrlJULRdvKt8e80qu/F5Zssvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717381; c=relaxed/simple;
	bh=S/F/dLG5WRxc8kfGpDdNYrqCRO8IEe2gCA+gZ49v0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=avTrS5PPBrWOPKeOz9BotUKALUEJLLgAepK0MyjJfAo7rZOpRWTAKUx8ZKqlZj/2rpBQS/L88oJrOe7ShaYqhANSd4NxN7vMyBW4dT2SmY90F9PO/YLxLxiPbUO93UOYvC1bMl9pFonD5IIiFfb0co0U1BeFz04M03clXP/WXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkTbAqM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3B3C4CEE7;
	Mon, 28 Jul 2025 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753717381;
	bh=S/F/dLG5WRxc8kfGpDdNYrqCRO8IEe2gCA+gZ49v0T4=;
	h=Date:From:To:Cc:Subject:From;
	b=VkTbAqM0pX47eMs90s5ZrGEVkByRwezdutcV4h2z/R0lc+3PNWFBloCU50uhGE75S
	 Q+ejPuLz7qleffhTE9jlLRQ7UJ1VrBAEzsppUKMYaeCK4tpCxt/qKiGLmMc21B+cnC
	 2GfAg9Cvnz3BRDWbXNHlDOv3wSphDWKOXhQg1nOA=
Date: Mon, 28 Jul 2025 17:42:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver updates for 6.17-rc1
Message-ID: <aIeagbhjBqBFGjj7@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc1

for you to fetch changes up to fa3f79e82dce7b04f7b8cf1791268a775b3d6f9f:

  binder: Use seq_buf in binder_alloc kunit tests (2025-07-24 11:42:43 +0200)

----------------------------------------------------------------
Char / Misc / IIO / other driver updates for 6.17-rc1

Here is the big set of char/misc/iio and other smaller driver subsystems
for 6.17-rc1.  It's a big set this time around, with the huge majority
being in the iio subsystem with new drivers and dts files being added
there.

Highlights include:
  - IIO driver updates, additions, and changes making more code const
    and cleaning up some init logic
  - bus_type constant conversion changes
  - misc device test functions added
  - rust miscdevice minor fixup
  - unused function removals for some drivers
  - mei driver updates
  - mhi driver updates
  - interconnect driver updates
  - Android binder updates and test infrastructure added
  - small cdx driver updates
  - small comedi fixes
  - small nvmem driver updates
  - small pps driver updates
  - some acrn virt driver fixes for printk messages
  - other small driver updates

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhinav Ananthu (1):
      mcb: use sysfs_emit_at() instead of scnprintf() in show functions

Adam Xue (1):
      bus: mhi: host: pci_generic: Add support for EM929x and set MRU to 32768 for better performance.

Aleksander Jan Bajkowski (1):
      dt-bindings: iio: adc: Add support for MT7981

Alexander Sverdlin (2):
      eeprom: at25: fram: Detect and support inside-out chip variants
      eeprom: at25: convert to spi-mem API

Alexander Usyskin (2):
      mei: bus: use cldev in prints
      mei: more prints with client prefix

Alexander Wilhelm (1):
      bus: mhi: host: Fix endianness of BHI vector table

Alok Tiwari (1):
      nvmem: core: Fix typos in comments and MODULE_AUTHOR strings

Ana-Maria Cusco (1):
      iio: adc: Add basic support for AD4170-4

Andrew Ijano (1):
      iio: accel: sca3000: replace error_ret labels by simple returns

Andy Shevchenko (1):
      iio: imu: inv_icm42600: Convert to uXX and sXX integer types

Angelo Dureghello (10):
      iio: dac: adi-axi-dac: use unique bus free check
      iio: adc: ad7606: enable Vdrive power supply
      iio: adc: ad7606: add enabling of optional Vrefin voltage
      Documentation: ABI: IIO: add new convdelay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: exit for invalid fdt dt_schema properties
      iio: adc: ad7606: rename chan_scale to a more generic chan_info
      iio: adc: ad7606: add gain calibration support

AngeloGioacchino Del Regno (6):
      dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
      dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
      iio: adc: mt6359: Add ready register index and mask to channel data
      iio: adc: mt6359: Move reference voltage to platform data
      iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
      iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC

Ankit Chauhan (1):
      misc: ocxl: Replace scnprintf() with sysfs_emit() in sysfs show functions

Antonio Borneo (3):
      iio: adc: stm32-dfsdm: Fix build warnings about export.h
      iio: trigger: stm32-timer: Fix build warnings about export.h
      iio: trigger: stm32-lptimer: Fix build warnings about export.h

Antoniu Miclaus (12):
      iio: backend: add support for filter config
      iio: backend: add support for data alignment
      iio: backend: add support for number of lanes
      dt-bindings: iio: adc: add ad408x axi variant
      iio: adc: adi-axi-adc: add filter type config
      iio: adc: adi-axi-adc: add data align process
      iio: adc: adi-axi-adc: add num lanes support
      dt-bindings: iio: adc: add ad4080
      iio: adc: ad4080: add driver support
      Documentation: ABI: add sinc1 and sinc5+pf1 filter
      dt-bindings: iio: adc: ad4851: add spi-3wire
      iio: adc: ad4851: add spi 3-wire support

Bartosz Golaszewski (1):
      greybus: gb-beagleplay: remove unneeded calls to devm_gpiod_put()

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Carlos Llamas (1):
      binder: fix reversed pid/tid in log

Chelsy Ratnawat (1):
      iio: imu: inv_mpu6050: Replace scnprintf with sysfs_emit

Chen-Yu Tsai (1):
      dt-bindings: nvmem: mediatek: efuse: split MT8186/MT8188 from base version

Colin Ian King (1):
      iio: adc: ti-ads131e08: Fix spelling mistake "tweek" -> "tweak"

Daniele Palmas (1):
      bus: mhi: host: pci_generic: Add Telit FN990B40 modem support

David Lechner (80):
      iio: amplifiers: ada4250: use DMA-safe memory for regmap_bulk_read()
      iio: adc: ad7173: check return value of spi_setup()
      iio: amplifiers: ada4250: used dev local variable
      iio: amplifiers: ada4250: don't fail on bad chip ID
      iio: amplifiers: ada4250: use devm_regulator_get_enable_read_voltage()
      iio: amplifiers: ada4250: move offset_uv in struct
      iio: amplifiers: ada4250: use dev_err_probe()
      iio: accel: adxl372: use = { } instead of memset()
      iio: accel: msa311: use = { } instead of memset()
      iio: adc: dln2-adc: use = { } instead of memset()
      iio: adc: mt6360-adc: use = { } instead of memset()
      iio: adc: rockchip_saradc: use = { } instead of memset()
      iio: adc: rtq6056: use = { } instead of memset()
      iio: adc: stm32-adc: use = { } instead of memset()
      iio: adc: ti-ads1015: use = { } instead of memset()
      iio: adc: ti-ads1119: use = { } instead of memset()
      iio: adc: ti-lmp92064: use = { } instead of memset()
      iio: adc: ti-tsc2046: use = { } instead of memset()
      iio: chemical: scd4x: use = { } instead of memset()
      iio: chemical: scd30: use = { } instead of memset()
      iio: chemical: sunrise_co2: use = { } instead of memset()
      iio: dac: ad3552r: use = { } instead of memset()
      iio: imu: inv_icm42600: use = { } instead of memset()
      iio: imu: inv_mpu6050: use = { } instead of memset()
      iio: light: bh1745: use = { } instead of memset()
      iio: light: ltr501: use = { } instead of memset()
      iio: light: opt4060: use = { } instead of memset()
      iio: light: veml6030: use = { } instead of memset()
      iio: magnetometer: af8133j: use = { } instead of memset()
      iio: pressure: bmp280: use = { } instead of memset()
      iio: pressure: mpl3115: use = { } instead of memset()
      iio: pressure: mprls0025pa: use = { } instead of memset()
      iio: pressure: zpa2326: use = { } instead of memset()
      iio: proximity: irsd200: use = { } instead of memset()
      iio: temperature: tmp006: use = { } instead of memset()
      iio: adc: ad7173: simplify clock enable/disable
      iio: adc: ad7380: remove unused oversampling_ratio getter
      iio: accel: adxl345: make adxl345_events const
      iio: accel: mma9553: make mma9553_event_info const
      iio: adc: ad7091r5: make ad7091r5_init_info const
      iio: adc: ad7091r8: make ad7091r_init_info const
      iio: adc: at91_adc: make at91_adc_caps const
      iio: adc: axp20x_adc: make axp717_maps const
      iio: adc: mp2629_adc: make mp2629_channels const
      iio: adc: qcom-vadc: make scale_adc5_fn const
      iio: adc: stm32-adc: make stm32_adc_trig_info const
      iio: amplifiers: ad8366: make ad8366_info const
      iio: chemical: atlas-ezo-sensor: make atlas_ezo_devices const
      iio: common: hid-sensor-attributes: make unit_conversion const
      iio: dac: ad5770r: make ad5770r_rng_tbl const
      iio: dac: ltc2688: make ltc2688_dither_ext_info const
      iio: imu: bmi160: make bmi160_regs const
      iio: light: isl76682: make isl76682_range_table const
      iio: light: zopt2201: make zopt2201_scale const
      iio: pressure: abp060mg: make abp_config const
      iio: proximity: vcnl3020: pass struct vcnl3020_property by pointer
      iio: proximity: vcnl3020: make vcnl3020_property const
      iio: adc: ad7124: Use separate structures rather than array for chip info
      iio: imu: adis16400: Use separate structures rather than an array for chip info
      iio: light: cm3232: move calibscale to struct cm3232_chip
      iio: light: cm3232: make struct cm3232_als_info const
      iio: pressure: dlhl60d: Use separate structures rather than an array for chip info
      iio: adc: ad_sigma_delta: don't overallocate scan buffer
      iio: adc: ad_sigma_delta: sort includes
      iio: adc: ad_sigma_delta: use u8 instead of uint8_t
      iio: adc: ad_sigma_delta: use sizeof() in ALIGN()
      iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
      iio: adc: ad_sigma_delta: audit included headers
      iio: adc: ad_sigma_delta: refactor setting read address
      iio: adc: ad_sigma_delta: use spi_optimize_message()
      iio: adc: ad_sigma_delta: add SPI offload support
      iio: adc: ad4000: don't use shift_right()
      iio: imu: bno055: fix OOB access of hw_xlate array
      iio: imu: bno055: make bno055_sysfs_attr const
      iio: ABI: fix correctness of I and Q modifiers
      iio: adc: ad_sigma_delta: change to buffer predisable
      iio: adc: ad7173: fix channels index for syscalib_mode
      iio: adc: ad7173: fix num_slots
      iio: adc: ad7173: fix calibration channel
      iio: adc: ad7173: fix setting ODR in probe

Denis Benato (2):
      iio: bmi270: suspend and resume triggering on relevant pm operations
      iio: bmi160: suspend and resume triggering on relevant pm operations

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dmitry Antipov (2):
      binder: use kstrdup() in binderfs_binder_device_create()
      binder: use guards for plain mutex- and spinlock-protected sections

Dmitry Baryshkov (2):
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes

Dr. David Alan Gilbert (3):
      misc: vmw_vmci: Remove unused vmci_ctx functions
      misc: vmw_vmci: Remove unused vmci_doorbell_notify
      misc: vmw_vmci: Remove unused qpair functions

Eliav Farber (1):
      pps: clients: gpio: fix interrupt handling order in remove path

Frank Li (3):
      dt-bindings: iio: adc: nxp,lpc3220-adc: allow clocks property
      dt-bindings: nvmem: convert lpc1857-eeprom.txt to yaml format
      dt-bindings: nvmem: convert vf610-ocotp.txt to yaml format

Georgi Djakov (1):
      Merge branch 'icc-milos' into icc-next

Greg Kroah-Hartman (8):
      drivers: misc: sram: fix up some const issues with recent attribute changes
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      fsi: make fsi_bus_type constant
      nvmem: make nvmem_bus_type constant
      Merge tag 'mhi-for-v6.17' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'fpga-for-6.17-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'iio-for-6.17a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'icc-6.17-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next

Gustavo Silva (2):
      iio: imu: bmi270: add channel for step counter
      iio: imu: bmi270: add step counter watermark event

Gwendal Grignou (1):
      iio: cros_ec_sensors: add cros_ec_activity driver

Gyeyoung Baek (1):
      iio: buffer: Fix checkpatch.pl warning

Hans de Goede (10):
      mei: vsc: Drop unused vsc_tp_request_irq() and vsc_tp_free_irq()
      mei: vsc: Don't re-init VSC from mei_vsc_hw_reset() on stop
      mei: vsc: Don't call vsc_tp_reset() a second time on shutdown
      mei: vsc: Use vsc_tp_remove() as shutdown handler
      mei: vsc: Destroy mutex after freeing the IRQ
      mei: vsc: Event notifier fixes
      mei: vsc: Unset the event callback on remove and probe errors
      mei: vsc: Run event callback from a workqueue
      mei: vsc: Fix "BUG: Invalid wait context" lockdep error
      mei: bus: Check for still connected devices in mei_cl_bus_dev_release()

Ian Abbott (1):
      comedi: fix race between polling and detaching

Isabella Caselli (1):
      iio: imu: inv_mpu6050: refactor aux read/write to use shared xfer logic

Jean-Baptiste Maneyrol (3):
      iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

Jiri Slaby (SUSE) (4):
      misc: Use dev_fwnode()
      iio: adc: stm32-adc: Use dev_fwnode()
      bus: moxtet: Use dev_fwnode()
      misc: ti_fpc202: Switch to of_fwnode_handle()

Johannes Berg (1):
      drivers: char: SONYPI depends on HAS_IOPORT

Jonathan Cameron (2):
      iio: potentiometer: Drop unused export.h includes
      iio: accel: kionix-kx022a: Apply approximate iwyu principles to includes

Jonathan Santos (11):
      iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
      dt-bindings: trigger-source: add generic GPIO trigger source
      dt-bindings: iio: adc: ad7768-1: document regulator provider property
      dt-bindings: iio: adc: ad7768-1: Document GPIO controller
      dt-bindings: iio: adc: ad7768-1: add trigger-sources property
      iio: adc: ad7768-1: add regulator to control VCM output
      iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
      iio: adc: ad7768-1: add support for Synchronization over SPI
      iio: adc: ad7768-1: replace manual attribute declaration
      iio: adc: ad7768-1: add filter type and oversampling ratio attributes
      iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Konrad Dybcio (2):
      interconnect: qcom: qcs615: Drop IP0 interconnects
      dt-bindings: interconnect: qcom,msm8998-bwmon: Allow 'nonposted-mmio'

Krzysztof Kozlowski (9):
      cdx: Enable compile testing
      cdx: controller: Simplify with dev_err_probe()
      cdx: controller: Drop useless probe success message
      cdx: controller: Do not open-code module_platform_driver()
      cdx: controller: Drop unneeded driver.pm NULL assignment
      iio: adc: vf610: Drop -ENOMEM error message
      iio: adc: vf610: Simplify with dev_err_probe
      iio: dac: vf610: Simplify with devm_clk_get_enabled()
      cdx: Fix missing GENERIC_MSI_IRQ on compile test

Lizhi Xu (2):
      vmci: Prevent the dispatching of uninitialized payloads
      vmci: Prevent the dispatching of uninitialized payloads

Lothar Rubusch (16):
      iio: accel: adxl345: extend sample frequency adjustments
      iio: accel: adxl345: add g-range configuration
      iio: accel: adxl313: add debug register
      iio: accel: adxl345: make data struct variable irq function local
      iio: accel: adxl345: simplify measure enable
      iio: accel: adxl345: replace magic numbers by unit expressions
      iio: accel: adxl313: make use of regmap cache
      iio: accel: adxl313: add function to enable measurement
      iio: accel: adxl313: add buffered FIFO watermark with interrupt handling
      iio: accel: adxl313: add activity sensing
      iio: accel: adxl313: add inactivity sensing
      iio: accel: adxl313: implement power-save on inactivity
      iio: accel: adxl313: add AC coupled activity/inactivity events
      docs: iio: add ADXL313 accelerometer
      iio: accel: adxl345: simplify interrupt mapping
      iio: accel: adxl345: simplify reading the FIFO

Luca Weiss (3):
      dt-bindings: interconnect: qcom: Remove double colon from description
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm Milos SoC
      interconnect: qcom: Add Milos interconnect provider driver

Manivannan Sadhasivam (1):
      bus: mhi: host: Make local functions static

Marcelo Schmitt (11):
      dt-bindings: iio: adc: Add AD4170-4
      iio: adc: ad4170-4: Add support for calibration gain
      iio: adc: ad4170-4: Add support for calibration bias
      Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available list
      iio: adc: ad4170-4: Add digital filter and sample frequency config support
      iio: adc: ad4170-4: Add support for buffered data capture
      iio: adc: ad4170-4: Add timestamp channel
      iio: adc: ad4170-4: Add clock provider support
      iio: adc: ad4170-4: Add GPIO controller support
      iio: adc: ad4170-4: Add support for internal temperature sensor
      iio: adc: ad4170-4: Add support for weigh scale, thermocouple, and RTD sens

Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

Matti Vaittinen (1):
      iio: adc: ad7476: Support ROHM BU79100G

Mikhail Kalashnikov (1):
      dt-bindings: nvmem: SID: Add binding for A523 SID controller

Moon Hee Lee (1):
      mei: bus: replace sprintf/scnprintf with sysfs_emit in show functions

Nathan Chancellor (1):
      iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and SPI_OFFLOAD

Nattan Ferreira (1):
      iio: light: apds9306: Refactor threshold get/set functions to use helper

Pop Ioan Daniel (5):
      iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
      iio: backend: update iio_backend_oversampling_ratio_set
      iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
      dt-bindings: iio: adc: add ad7405
      iio: adc: ad7405: add ad7405 driver

Randy Dunlap (1):
      pc104: move PC104 option to drivers/Kconfig

Raviteja Laggyshetty (1):
      dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC

Ricky Wu (2):
      misc: rtsx: Add support for RTS5264 Version B and optimize init flow
      misc: rtsx: usb: Ensure mmc child device is active when card is present

Rob Herring (Arm) (2):
      misc: fastrpc: Use of_reserved_mem_region_to_resource() for "memory-region"
      fsi: master-ast-cf: Use of_reserved_mem_region_to_resource for "memory-region"

Rodrigo Gobbi (2):
      dt-bindings: iio: adc: st,spear600-adc: txt to yaml format conversion.
      dt-bindings: iio: gyroscope: invensense,itg3200: add binding

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Add GPIO controller support

Slark Xiao (2):
      bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640
      bus: mhi: host: pci_generic: Add Foxconn T99W696 modem

Steven Rostedt (1):
      binder: Remove unused binder lock events

Sven Peter (2):
      nvmem: apple: drop default ARCH_APPLE in Kconfig
      dt-bindings: nvmem: fixed-layout: Allow optional bit positions

Tamir Duberstein (1):
      rust: miscdevice: remove unnecessary import

Thadeu Lima de Souza Cascardo (1):
      char: misc: add test cases

Thomas Weiﬂschuh (1):
      drivers: virt: acrn: Don't use %pK through printk

Tiffany Yang (8):
      binder: Fix selftest page indexing
      binder: Store lru freelist in binder_alloc
      kunit: test: Export kunit_attach_mm()
      binder: Scaffolding for binder_alloc KUnit tests
      binder: Convert binder_alloc selftests to KUnit
      binder: encapsulate individual alloc test cases
      binder: Add copyright notice to new kunit files
      binder: Use seq_buf in binder_alloc kunit tests

Vivek Pernamitta (1):
      bus: mhi: host: pci_generic: Disable runtime PM for QDU100

Waqar Hameed (8):
      iio: irsd200: Remove print of error code from dev_err_probe
      iio: Remove single use of macro definition for driver name
      iio: Remove single use of macro definition for IRQ name
      iio: Remove single use of macro definition for regmap name
      iio: Remove unused macro definition for driver and IRQ name
      dt-bindings: vendor-prefixes: Add Nicera
      dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR sensor
      iio: Add driver for Nicera D3-323-AA PIR sensor

Xu Yilun (1):
      MAINTAINERS: Update FPGA MANAGER maintainer

Youssef Samir (1):
      bus: mhi: host: Detect events pointing to unexpected TREs

Yumeng Fang (2):
      misc: enclosure: Use str_on_off() helper
      bus: mhi: host: Use str_true_false() helper

Zijun Hu (3):
      char: misc: Remove redundant forward declarations
      char: misc: Fix improper and inaccurate error code returned by misc_init()
      char: misc: Rename a local variable in misc_init()

chuguangqing (10):
      iio: chemical: bme680: convert to use maple tree register cache
      iio: dac: ad5380: convert to use maple tree register cache
      iio: dac: bd79703: convert to use maple tree register cache
      iio: health: afe4403: convert to use maple tree register cache
      iio: health: afe4404: convert to use maple tree register cache
      iio: imu: icm42600: convert to use maple tree register cache
      iio: imu: bno055: convert to use maple tree register cache
      iio: light: isl29028: convert to use maple tree register cache
      iio: light: ltr501: convert to use maple tree register cache
      iio: light: opt4060: convert to use maple tree register cache

 Documentation/ABI/obsolete/sysfs-bus-iio           |   12 -
 Documentation/ABI/testing/sysfs-bus-iio            |   67 +-
 .../ABI/testing/sysfs-bus-iio-frequency-admv1013   |    4 +-
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   96 +
 .../devicetree/bindings/iio/adc/adi,ad4170-4.yaml  |  554 ++++
 .../devicetree/bindings/iio/adc/adi,ad4851.yaml    |    2 +
 .../devicetree/bindings/iio/adc/adi,ad7405.yaml    |   60 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   29 +
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |   68 +-
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |    2 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    4 +
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |    2 +
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml          |    3 +
 .../bindings/iio/adc/st,spear600-adc.yaml          |   69 +
 .../bindings/iio/gyroscope/invensense,itg3200.yaml |   59 +
 .../bindings/iio/proximity/nicera,d3323aa.yaml     |   62 +
 .../bindings/interconnect/qcom,milos-rpmh.yaml     |  136 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    2 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |    5 +
 .../bindings/interconnect/qcom,sa8775p-rpmh.yaml   |    2 +-
 .../bindings/interconnect/qcom,sar2130p-rpmh.yaml  |    2 +-
 .../bindings/interconnect/qcom,sc7280-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,sc8280xp-rpmh.yaml  |    2 +-
 .../bindings/interconnect/qcom,sm7150-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,sm8450-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,sm8550-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,sm8750-rpmh.yaml    |    2 +-
 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  |    2 +-
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |    1 +
 .../devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml |   47 +
 .../bindings/nvmem/layouts/fixed-layout.yaml       |    2 +-
 .../devicetree/bindings/nvmem/lpc1857-eeprom.txt   |   28 -
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   17 +-
 .../bindings/nvmem/nxp,lpc1857-eeprom.yaml         |   61 +
 .../devicetree/bindings/nvmem/vf610-ocotp.txt      |   19 -
 .../bindings/staging/iio/adc/spear-adc.txt         |   24 -
 .../bindings/trigger-source/gpio-trigger.yaml      |   40 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/adxl313.rst                      |  293 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   24 +-
 drivers/Kconfig                                    |    6 +
 drivers/android/Kconfig                            |   15 +-
 drivers/android/Makefile                           |    2 +-
 drivers/android/binder.c                           |   49 +-
 drivers/android/binder_alloc.c                     |   53 +-
 drivers/android/binder_alloc.h                     |   22 +-
 drivers/android/binder_alloc_selftest.c            |  306 --
 drivers/android/binder_internal.h                  |    4 +
 drivers/android/binder_trace.h                     |   21 -
 drivers/android/binderfs.c                         |    5 +-
 drivers/android/tests/.kunitconfig                 |    7 +
 drivers/android/tests/Makefile                     |    6 +
 drivers/android/tests/binder_alloc_kunit.c         |  572 ++++
 drivers/bus/mhi/host/boot.c                        |    8 +-
 drivers/bus/mhi/host/debugfs.c                     |    3 +-
 drivers/bus/mhi/host/init.c                        |    8 +-
 drivers/bus/mhi/host/internal.h                    |   11 +-
 drivers/bus/mhi/host/main.c                        |   14 +-
 drivers/bus/mhi/host/pci_generic.c                 |   84 +-
 drivers/bus/moxtet.c                               |    3 +-
 drivers/cdx/Kconfig                                |    3 +-
 drivers/cdx/controller/Kconfig                     |    1 +
 drivers/cdx/controller/cdx_controller.c            |   27 +-
 drivers/char/Kconfig                               |    2 +-
 drivers/char/misc.c                                |   10 +-
 drivers/comedi/comedi_fops.c                       |   33 +-
 drivers/comedi/comedi_internal.h                   |    1 +
 drivers/comedi/drivers.c                           |   13 +-
 drivers/fpga/zynq-fpga.c                           |    4 +-
 drivers/fsi/fsi-core.c                             |    2 +-
 drivers/fsi/fsi-master-ast-cf.c                    |   11 +-
 drivers/greybus/gb-beagleplay.c                    |   25 +-
 drivers/iio/accel/adxl313.h                        |   33 +-
 drivers/iio/accel/adxl313_core.c                   |  923 +++++-
 drivers/iio/accel/adxl313_i2c.c                    |    6 +
 drivers/iio/accel/adxl313_spi.c                    |    6 +
 drivers/iio/accel/adxl345.h                        |    3 +-
 drivers/iio/accel/adxl345_core.c                   |  288 +-
 drivers/iio/accel/adxl372.c                        |    3 +-
 drivers/iio/accel/bma180.c                         |    3 -
 drivers/iio/accel/bmc150-accel-core.c              |    5 +-
 drivers/iio/accel/kionix-kx022a.c                  |   12 +-
 drivers/iio/accel/kxcjk-1013.c                     |    7 +-
 drivers/iio/accel/mma9551.c                        |    6 +-
 drivers/iio/accel/mma9553.c                        |   11 +-
 drivers/iio/accel/msa311.c                         |    4 +-
 drivers/iio/accel/mxc4005.c                        |    6 +-
 drivers/iio/accel/mxc6255.c                        |    3 +-
 drivers/iio/accel/sca3000.c                        |   29 +-
 drivers/iio/accel/sca3300.c                        |    4 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   43 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad4000.c                           |    2 +-
 drivers/iio/adc/ad4080.c                           |  619 ++++
 drivers/iio/adc/ad4170-4.c                         | 3027 ++++++++++++++++++++
 drivers/iio/adc/ad4851.c                           |   16 +-
 drivers/iio/adc/ad7091r5.c                         |    2 +-
 drivers/iio/adc/ad7091r8.c                         |    6 +-
 drivers/iio/adc/ad7124.c                           |   36 +-
 drivers/iio/adc/ad7173.c                           |   78 +-
 drivers/iio/adc/ad7380.c                           |    5 -
 drivers/iio/adc/ad7405.c                           |  253 ++
 drivers/iio/adc/ad7476.c                           |    7 +
 drivers/iio/adc/ad7606.c                           |  361 ++-
 drivers/iio/adc/ad7606.h                           |   22 +-
 drivers/iio/adc/ad7768-1.c                         |  936 +++++-
 drivers/iio/adc/ad_sigma_delta.c                   |  305 +-
 drivers/iio/adc/adi-axi-adc.c                      |   96 +-
 drivers/iio/adc/at91_adc.c                         |   10 +-
 drivers/iio/adc/axp20x_adc.c                       |    2 +-
 drivers/iio/adc/dln2-adc.c                         |    4 +-
 drivers/iio/adc/hi8435.c                           |    4 +-
 drivers/iio/adc/max9611.c                          |    4 +-
 drivers/iio/adc/mp2629_adc.c                       |    2 +-
 drivers/iio/adc/mt6359-auxadc.c                    |  440 ++-
 drivers/iio/adc/mt6360-adc.c                       |    3 +-
 drivers/iio/adc/qcom-vadc-common.c                 |    2 +-
 drivers/iio/adc/rockchip_saradc.c                  |    4 +-
 drivers/iio/adc/rtq6056.c                          |    4 +-
 drivers/iio/adc/stm32-adc-core.c                   |    3 +-
 drivers/iio/adc/stm32-adc.c                        |    9 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    1 +
 drivers/iio/adc/stm32-dfsdm-core.c                 |    1 +
 drivers/iio/adc/ti-ads1015.c                       |    4 +-
 drivers/iio/adc/ti-ads1119.c                       |    4 +-
 drivers/iio/adc/ti-ads131e08.c                     |   10 +-
 drivers/iio/adc/ti-lmp92064.c                      |    4 +-
 drivers/iio/adc/ti-tsc2046.c                       |    3 +-
 drivers/iio/adc/vf610_adc.c                        |    5 +-
 drivers/iio/amplifiers/ad8366.c                    |    6 +-
 drivers/iio/amplifiers/ada4250.c                   |   55 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |    2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    3 +-
 drivers/iio/chemical/bme680_core.c                 |    2 +-
 drivers/iio/chemical/scd30_core.c                  |    3 +-
 drivers/iio/chemical/scd4x.c                       |    3 +-
 drivers/iio/chemical/sunrise_co2.c                 |    6 +-
 drivers/iio/common/cros_ec_sensors/Kconfig         |    9 +
 drivers/iio/common/cros_ec_sensors/Makefile        |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_activity.c  |  307 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   10 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    2 +-
 drivers/iio/dac/ad3552r.c                          |    3 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5770r.c                          |    2 +-
 drivers/iio/dac/adi-axi-dac.c                      |   42 +-
 drivers/iio/dac/ltc2688.c                          |    2 +-
 drivers/iio/dac/max517.c                           |    4 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/dac/rohm-bd79703.c                     |    2 +-
 drivers/iio/dac/vf610_dac.c                        |   23 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/health/afe4403.c                       |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/health/max30100.c                      |    3 +-
 drivers/iio/health/max30102.c                      |    3 +-
 drivers/iio/humidity/dht11.c                       |    4 +-
 drivers/iio/imu/adis16400.c                        |  314 +-
 drivers/iio/imu/bmi160/bmi160.h                    |    2 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   21 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    2 +
 drivers/iio/imu/bmi160/bmi160_spi.c                |    2 +
 drivers/iio/imu/bmi270/bmi270.h                    |    2 +
 drivers/iio/imu/bmi270/bmi270_core.c               |  327 ++-
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    2 +
 drivers/iio/imu/bmi270/bmi270_spi.c                |    2 +
 drivers/iio/imu/bno055/bno055.c                    |   58 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   62 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  360 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   24 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |   10 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  107 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   41 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c          |   56 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |    6 +-
 drivers/iio/imu/kmx61.c                            |    7 +-
 drivers/iio/industrialio-backend.c                 |   61 +-
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/adux1020.c                       |    3 +-
 drivers/iio/light/apds9160.c                       |    4 +-
 drivers/iio/light/apds9300.c                       |    3 +-
 drivers/iio/light/apds9306.c                       |   36 +-
 drivers/iio/light/apds9960.c                       |    3 +-
 drivers/iio/light/bh1745.c                         |    4 +-
 drivers/iio/light/cm3232.c                         |   18 +-
 drivers/iio/light/isl29028.c                       |    2 +-
 drivers/iio/light/isl76682.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    3 +-
 drivers/iio/light/ltr501.c                         |   14 +-
 drivers/iio/light/opt4060.c                        |    6 +-
 drivers/iio/light/rpr0521.c                        |    6 +-
 drivers/iio/light/stk3310.c                        |    6 +-
 drivers/iio/light/vcnl4035.c                       |    6 +-
 drivers/iio/light/veml6030.c                       |    4 +-
 drivers/iio/light/zopt2201.c                       |    6 +-
 drivers/iio/magnetometer/af8133j.c                 |    4 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    5 +-
 drivers/iio/magnetometer/mmc35240.c                |    3 +-
 drivers/iio/potentiometer/ds1803.c                 |    1 -
 drivers/iio/potentiometer/mcp4131.c                |    1 -
 drivers/iio/pressure/abp060mg.c                    |    4 +-
 drivers/iio/pressure/bmp280-core.c                 |    5 +-
 drivers/iio/pressure/dlhl60d.c                     |   47 +-
 drivers/iio/pressure/mpl3115.c                     |    3 +-
 drivers/iio/pressure/mprls0025pa_i2c.c             |    5 +-
 drivers/iio/pressure/zpa2326.c                     |    4 +-
 drivers/iio/proximity/Kconfig                      |    9 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/d3323aa.c                    |  816 ++++++
 drivers/iio/proximity/irsd200.c                    |   22 +-
 drivers/iio/proximity/sx9500.c                     |    3 +-
 drivers/iio/proximity/vcnl3020.c                   |   16 +-
 drivers/iio/resolver/ad2s1200.c                    |    3 +-
 drivers/iio/temperature/tmp006.c                   |    4 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c        |    1 +
 drivers/iio/trigger/stm32-timer-trigger.c          |    1 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/milos.c                  | 1931 +++++++++++++
 drivers/interconnect/qcom/qcs615.c                 |   42 -
 drivers/interconnect/qcom/sc8180x.c                |    6 +
 drivers/interconnect/qcom/sc8280xp.c               |    1 +
 drivers/mcb/mcb-core.c                             |    8 +-
 drivers/misc/cardreader/rts5264.c                  |   63 +-
 drivers/misc/cardreader/rts5264.h                  |    6 +
 drivers/misc/cardreader/rtsx_pcr.c                 |    2 +-
 drivers/misc/cardreader/rtsx_usb.c                 |   16 +-
 drivers/misc/eeprom/Kconfig                        |    1 +
 drivers/misc/eeprom/at25.c                         |  349 +--
 drivers/misc/enclosure.c                           |    3 +-
 drivers/misc/fastrpc.c                             |   19 +-
 drivers/misc/hi6421v600-irq.c                      |    4 +-
 drivers/misc/mei/bus-fixup.c                       |   10 +-
 drivers/misc/mei/bus.c                             |   41 +-
 drivers/misc/mei/hbm.c                             |   14 +-
 drivers/misc/mei/interrupt.c                       |    2 +-
 drivers/misc/mei/main.c                            |   55 +-
 drivers/misc/mei/platform-vsc.c                    |    8 +
 drivers/misc/mei/vsc-tp.c                          |   80 +-
 drivers/misc/mei/vsc-tp.h                          |    3 -
 drivers/misc/misc_minor_kunit.c                    |  589 +++-
 drivers/misc/ocxl/sysfs.c                          |   12 +-
 drivers/misc/sram.c                                |   10 +-
 drivers/misc/ti_fpc202.c                           |    2 +-
 drivers/misc/vmw_vmci/vmci_context.c               |   56 +-
 drivers/misc/vmw_vmci/vmci_context.h               |    2 -
 drivers/misc/vmw_vmci/vmci_doorbell.c              |   53 -
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |  133 -
 drivers/nvmem/Kconfig                              |    1 -
 drivers/nvmem/core.c                               |   12 +-
 drivers/pps/clients/pps-gpio.c                     |    5 +-
 drivers/pps/pps.c                                  |   11 +-
 drivers/virt/acrn/ioreq.c                          |    4 +-
 drivers/virt/acrn/mm.c                             |    8 +-
 include/dt-bindings/iio/adc/adi,ad7768-1.h         |   10 +
 .../dt-bindings/iio/adc/mediatek,mt6363-auxadc.h   |   24 +
 .../dt-bindings/iio/adc/mediatek,mt6373-auxadc.h   |   19 +
 include/dt-bindings/interconnect/qcom,milos-rpmh.h |  141 +
 include/kunit/test.h                               |   12 +
 include/linux/fsi.h                                |    2 +-
 include/linux/iio/adc/ad_sigma_delta.h             |   27 +-
 include/linux/iio/backend.h                        |   22 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    1 +
 include/linux/iio/types.h                          |    1 +
 include/linux/miscdevice.h                         |    3 -
 include/linux/platform_data/cros_ec_commands.h     |   26 +-
 include/linux/pps_kernel.h                         |    1 +
 include/linux/vmw_vmci_api.h                       |    7 -
 init/Kconfig                                       |    7 -
 lib/Kconfig.debug                                  |    4 +-
 lib/kunit/user_alloc.c                             |    4 +-
 rust/kernel/miscdevice.rs                          |    1 -
 samples/mei/mei-amt-version.c                      |    2 +-
 281 files changed, 15268 insertions(+), 2542 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 Documentation/iio/adxl313.rst
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c
 create mode 100644 drivers/iio/adc/ad4080.c
 create mode 100644 drivers/iio/adc/ad4170-4.c
 create mode 100644 drivers/iio/adc/ad7405.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
 create mode 100644 drivers/iio/proximity/d3323aa.c
 create mode 100644 drivers/interconnect/qcom/milos.c
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,milos-rpmh.h

