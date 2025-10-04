Return-Path: <linux-kernel+bounces-842078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A211ABB8E79
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C04E32BB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D51B15E5BB;
	Sat,  4 Oct 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGqRL6FB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956BCA4E
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586680; cv=none; b=B1/j76SNGf4o+qis3+qgj+5oZRwVJ/quMZgGGBuBV+2efZjHFNuQsAstG9qLk42FNQdC4JwsfJeMa1x/+XX5TBDuKQtYSmKfmiDEk39j3RnTvA31OYARe64WitJt5TwvyidBIwx0sIIzS0Qhhtkw7/HC2GRr2JEWbRZxGfh3PU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586680; c=relaxed/simple;
	bh=B1tNBfz8P3L69YVCnBjJaSTagqDGqzhv+bcMHu6dWek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OttYucF38kxVir9763P6moQakzzKYQaYQJn/ye92webssFYEDT9cSvMjqWDU4R1zj/E13KpZOnXPGmi1PLMh6QU48Ne9+p9Wv2aTWv9at1TNjfrzq5/xEw92wVXmqUu1iUPu8iOoik8SGlXdZ7nOwo6JIz69xTyb1hOs+d7O3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGqRL6FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E49FC4CEF1;
	Sat,  4 Oct 2025 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759586680;
	bh=B1tNBfz8P3L69YVCnBjJaSTagqDGqzhv+bcMHu6dWek=;
	h=Date:From:To:Cc:Subject:From;
	b=UGqRL6FBhqd9tpknBAVfixFj0mBNu0e07qhczmsFGP/Ljq0mNCJr/0tHJ23k9Zj3W
	 qPsIw2oD0BzSXPZxfRMLXGnfJ975YyCnRGql20i9DDFqAwn+d4Zg1EtIJ8/d3WQidw
	 YPYI4PmVHURBfmCwlLANr0Q3D2P8nje6fuGZgo1I=
Date: Sat, 4 Oct 2025 16:04:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver changes for 6.18-rc1
Message-ID: <aOEpdLwn9jxWmz5l@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1

for you to fetch changes up to 22d693e45d4a4513bd99489a4e50b81cc0175b21:

  rust: usb: keep usb::Device private for now (2025-09-26 08:09:08 +0200)

----------------------------------------------------------------
Char/Misc/IIO/Binder changes for 6.18-rc1

Here is the big set of char/misc/iio and other driver subsystem changes
for 6.18-rc1.  Loads of different stuff in here, it was a busy
development cycle in lots of different subsystems, with over 27k new
lines added to the tree.  Included in here are:
  - IIO updates including new drivers, reworking of existing apis, and
    other goodness in the sensor subsystems
  - MEI driver updates and additions
  - NVMEM driver updates
  - slimbus removal for an unused driver and some other minor
    updates
  - coresight driver updates and additions
  - MHI driver updates
  - comedi driver updates and fixes
  - extcon driver updates
  - interconnect driver additions
  - eeprom driver updates and fixes
  - minor UIO driver updates
  - tiny W1 driver updates

But the majority of new code is in the rust bindings and additions,
which includes:
  - misc driver rust binding updates for read/write support, we can now
    write "normal" misc drivers in rust fully, and the sample driver
    shows how this can be done.
  - Initial framework for USB driver rust bindings, which are disabled
    for now in the build, due to limited support, but coming in through
    this tree due to dependencies on other rust binding changes that
    were in here.  I'll be enabling these back on in the build in the
    usb.git tree after -rc1 is out so that developers can continue to
    work on these in linux-next over the next development cycle.
  - Android Binder driver implemented in Rust.  This is the big one, and
    was driving a huge majority of the rust binding work over the past
    years.  Right now there are 2 binder drivers in the kernel, selected
    only at build time as to which one to use as binder wants to be
    included in the system at boot time.  The binder C maintainers all
    agreed on this, as eventually, they want the C code to be removed from
    the tree, but it will take a few releases to get there while both
    are maintained to ensure that the rust implementation is fully
    stable and compliant with the existing userspace apis.

All of these have been in linux-next for a while, with only minor merge
issues showing up (you will hit them as well.)  Just accept both sides
of the merge, it's just some header and include file lines, nothing
major.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abd-Alrhman Masalkhi (3):
      dt-bindings: eeprom: Add ST M24LR support
      eeprom: add driver for ST M24LR series RFID/NFC EEPROM chips
      ABI: sysfs: add documentation for ST M24LR EEPROM and control interface

Adam Xue (1):
      bus: mhi: host: Do not use uninitialized 'dev' pointer in mhi_init_irq_setup()

Akshay Bansod (1):
      iio: st_lsm6dsx: Replace scnprintf() with sysfs_emit()

Akshay Jindal (3):
      iio: light: ltr390: Add debugfs register access support
      iio: light: ltr390: Add device powerdown functionality via devm api
      iio: light: ltr390: Implement runtime PM support

Aleksandar Gerasimovski (1):
      iio/adc/pac1934: fix channel disable configuration

Alexander Usyskin (7):
      mei: hook mei_device on class device
      mei: gsc: fix remove operations order
      mei: me: trigger link reset if hw ready is unexpected
      mei: make a local copy of client uuid in connect
      mei: retry connect if interrupted by link reset
      mei: bus: demote error on connect
      mei: gsc: demote unexpected reset print

Alice Ryhl (5):
      rust: iov: add iov_iter abstractions for ITER_SOURCE
      rust: iov: add iov_iter abstractions for ITER_DEST
      rust: fs: add Kiocb struct
      rust: miscdevice: Provide additional abstractions for iov_iter and kiocb structures
      rust_binder: add Rust Binder driver

Andreas Klinger (3):
      dt-bindings: iio: light: veml6046x00: add color sensor
      iio: light: add support for veml6046x00 RGBIR color sensor
      MAINTAINER: add maintainer for veml6046x00

Andrew Davis (2):
      iio: health: afe4403: Do not store dev pointer in device struct
      iio: health: afe4404: Do not store dev pointer in device struct

Antoniu Miclaus (6):
      iio: add IIO_ALTCURRENT channel type
      iio: add power and energy measurement modifiers
      dt-bindings: iio: adc: add ade9000
      iio: adc: add ade9000 support
      docs: iio: add documentation for ade9000 driver
      Documentation: ABI: iio: add sinc4+lp

Artur Weber (1):
      dt-bindings: extcon: rt8973a: Convert DT bindings to YAML

Ben Collins (6):
      iio: iio_format_list() should set stride=1 for IIO_VAL_CHAR
      dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
      dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
      iio: mcp9600: White space and fixed width cleanup
      iio: mcp9600: Recognize chip id for mcp9601
      iio: mcp9600: Add support for thermocouple-type

Carlos Llamas (6):
      binder: remove MODULE_LICENSE()
      binder: pre-allocate binder_transaction
      binder: add t->is_async and t->is_reply
      binder: add tracepoint for netlink reports
      netlink: specs: binder: replace underscores with dashes in names
      binder: fix double-free in dbitmap

Chandra Mohan Sundar (1):
      iio: adc: ad7768-1: Remove logically dead code

Chen Ni (1):
      misc: eeprom/m24lr: Remove unneeded semicolon

Christian Marangi (2):
      dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
      nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE

Christophe JAILLET (3):
      w1: matrox: Remove some deadcode in matrox_w1_remove()
      uio: Constify struct pci_device_id
      iio: adc: PAC1934: Use devm_mutex_init()

Ciprian Costea (2):
      dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
      nvmem: s32g-ocotp: Add driver for S32G OCOTP

Colin Ian King (4):
      iio: magnetometer: Fix spelling mistake "Magenetometer" -> "Magnetometer"
      iio: light: vl6180: remove space before \n newline
      misc: Fix spelling mistake "STMicroeletronics" -> "STMicroelectronics"
      misc: genwqe: Fix incorrect cmd field being reported in error

Cryolitia PukNgae (1):
      iio: imu: bmi270: Match PNP ID found on newer GPD firmware

Dan Carpenter (2):
      iio: proximity: vl53l0x-i2c: Fix error code in probe()
      coresight: tnoc: Fix a NULL vs IS_ERR() bug in probe

Daniel Almeida (2):
      rust: usb: add basic USB abstractions
      samples: rust: add a USB driver sample

Danilo Krummrich (2):
      rust: usb: don't retain device context for the interface parent
      rust: usb: keep usb::Device private for now

David Heidelberg (1):
      dt-bindings: extcon: linux,extcon-usb-gpio: GPIO must be provided

David Lechner (25):
      iio: proximity: mb1232: use stack allocated scan struct
      iio: proximity: pulsedlight-lidar-lite-v2: use stack allocated scan struct
      iio: proximity: vl53l0x-i2c: use stack allocated scan struct
      iio: fix iio_push_to_buffers_with_ts() typo
      iio: proximity: sx9500: use stack allocated struct for scan data
      iio: proximity: srf08: use stack allocated scan buffer
      iio: accel: bma180: use stack allocated buffer for scan
      iio: adc: ti-adc081c: use individual model structures instead of array
      iio: adc: ad7173: add SPI offload support
      iio: ABI: alphabetize filter types
      dt-bindings: iio: adc: adi,ad7124: fix clocks properties
      iio: adc: ad7124: do not require mclk
      iio: adc: ad7124: add external clock support
      iio: adc: ad7124: add clock output support
      iio: adc: ad7124: fix sample rate for multi-channel use
      iio: adc: ad7124: use clamp()
      iio: adc: ad7124: use read_avail() for scale_available
      iio: adc: ad7124: use guard(mutex) to simplify return paths
      iio: adc: ad7124: support fractional sampling_frequency
      iio: adc: ad7124: add filter support
      iio: ABI: document "sinc4+rej60" filter_type
      iio: adc: ad7173: rename ad7173_chan_spec_ext_info
      iio: adc: ad7173: rename odr field
      iio: adc: ad7173: support changing filter type
      iio: ABI: add filter types for ad7173

Dixit Parmar (14):
      iio: accel: Drop unnecessary -ENOMEM messages
      iio: adc: Drop unnecessary -ENOMEM messages
      iio: dac: Drop unnecessary -ENOMEM messages
      iio: health: Drop unnecessary -ENOMEM messages
      iio: humidity: Drop unnecessary -ENOMEM messages
      iio: light: Drop unnecessary -ENOMEM messages
      iio: potentiostat: Drop unnecessary -ENOMEM messages
      iio: pressure: Drop unnecessary -ENOMEM messages
      iio: proximity: Drop unnecessary -ENOMEM messages
      iio: temperature: Drop unnecessary -ENOMEM messages
      dt-bindings: iio: magnetometer: Infineon TLV493D 3D Magnetic sensor
      iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor
      iio: magnetometer: als31300: remove unused IIO_CHAN_INFO_PROCESSED handling
      iio: magnetometer: tmag5273: remove unused IIO_CHAN_INFO_PROCESSED handling

Duje Mihanović (2):
      dt-bindings: mfd: 88pm886: Add #io-channel-cells
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC

Erick Setubal Bacurau (1):
      docs: iio: bno055: Correct wording in driver documentation

Fabio Estevam (1):
      dt-bindings: w1: imx: Add an entry for the interrupts property

Frank Li (1):
      dt-bindings: iio: adc: max1238: Add #io-channel-cells property

Geert Uytterhoeven (3):
      misc: apds990x: Drop superfluous return statement
      uio: uio_dmem_genirq: Remove dummy PM handling
      uio: uio_pdrv_genirq: Remove dummy PM handling

Georgi Djakov (1):
      Merge branch 'icc-glymur' into icc-next

Greg Kroah-Hartman (13):
      Merge 6.17-rc3 into char-misc-next
      Merge tag 'peci-next-6.18-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next
      Merge patch series "Rust support for `struct iov_iter`"
      Merge tag 'w1-drv-6.18' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
      Merge tag 'counter-updates-for-6.18' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'iio-fixes-for-6.17b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'extcon-next-for-6.18' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge patch series "mei: connect to card in D3cold"
      Merge tag 'icc-6.18-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-for-6.18a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v6.18' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'coresight-next-v6.18-v2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      USB: disable rust bindings from the build for now

Gwendal Grignou (1):
      Documentation: iio: Remove location attribute

Haibo Chen (2):
      iio: adc: imx93_adc: keep one style of the hex values
      iio: adc: imx93_adc: load calibrated values even calibration failed

Hans de Goede (6):
      iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      iio: consumers: Add an iio_multiply_value() helper function
      iio: Improve iio_read_channel_processed_scale() precision
      iio: test: Add KUnit tests for iio_multiply_value()
      iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

Ian Abbott (1):
      comedi: Add new driver for ADLink PCI-7250 series

Ioana Risteiu (4):
      iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
      dt-bindings: iio: adc: add IIO backend support
      iio: adc: extract setup function without backend
      iio: adc: update ad7779 to use IIO backend

James Clark (2):
      coresight: trbe: Add ISB after TRBLIMITR write
      coresight: Fix missing include for FIELD_GET

Jie Gan (1):
      coresight: tpda: fix the logic to setup the element size

Jonas Karlman (1):
      dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain

Jonathan Cameron (12):
      iio: light: acpi-als: Use a structure for layout of data to push to buffer.
      iio: light: acpi-als: Use iio_push_to_buffers_with_ts() to allow runtime source size check
      iio: light: adjd_s311: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: max44000: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: st_uvis25: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: tcs3414: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: tcs3472: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: vcnl4000: Use a structure to make buffer arrangement explicit.
      iio: light: vl6180: Use iio_push_to_buffers_with_ts() to allow source size runtime check
      iio: light: Simple conversions to iio_push_to_buffers_with_ts()
      Merge tag 'v6.17-rc3' into togreg

Jonathan Santos (1):
      iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage()

Jorge Marques (1):
      docs: iio: ad3552r: Fix malformed code-block directive

Junjie Cao (1):
      iio: core: switch info_mask fields to unsigned long to match find_bit helpers

Krzysztof Kozlowski (17):
      dt-bindings: iio: Drop unused header includes in examples
      dt-bindings: iio: adc: Replace hard-coded GPIO/IRQ flag with a define
      dt-bindings: iio: adc: samsung,exynos-adc: Use correct IRQ level in example
      dt-bindings: iio: light: Simplify interrupts property in the example
      iio: adc: ti-adc12138: Simplify with devm_clk_get_enabled()
      dt-bindings: iio: Replace bouncing Analog emails
      dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup in example
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      extcon: axp288: Fix wakeup source leaks on device unbind
      extcon: fsa9480: Fix wakeup source leaks on device unbind
      extcon: qcom-spmi-misc: Fix wakeup source leaks on device unbind
      extcon: adc-jack: Cleanup wakeup source only if it was enabled
      iio: adc: exynos_adc: Drop S3C2410 support
      iio: adc: exynos_adc: Drop touchscreen support
      iio: adc: exynos_adc: Drop platform data support
      dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
      dt-bindings: iio: adc: samsung,exynos: Drop touchscreen support

Lee Jones (1):
      samples: rust_misc_device: Expand the sample to support read()ing from userspace

Leo Yan (13):
      coresight: stm: Remove redundant NULL checks
      coresight: perf: Use %px for printing pointers
      coresight: tmc: Support atclk
      coresight: catu: Support atclk
      coresight: etm4x: Support atclk
      coresight: Appropriately disable programming clocks
      coresight: Appropriately disable trace bus clocks
      coresight: Avoid enable programming clock duplicately
      coresight: Consolidate clock enabling
      coresight: Refactor driver data allocation
      coresight: Make clock sequence consistent
      coresight: Refactor runtime PM
      coresight: trbe: Return NULL pointer for allocation failures

Li Li (2):
      binder: introduce transaction reports via netlink
      binder: add transaction_report feature entry

Lin Yujun (1):
      coresight: Fix incorrect handling for return value of devm_kzalloc

Ling Xu (4):
      dt-bindings: misc: qcom,fastrpc: Add GDSP label
      misc: fastrpc: Remove kernel-side domain checks from capability ioctl
      misc: fastrpc: Cleanup the domain names
      misc: fastrpc: add support for gdsp remoteproc

Lothar Rubusch (7):
      iio: accel: adxl345: simplify tap suppress bit
      iio: accel: adxl345: add activity event feature
      iio: accel: adxl345: add inactivity feature
      iio: accel: adxl345: add coupling detection for activity/inactivity
      iio: accel: adxl345: extend inactivity time for less than 1s
      docs: iio: add documentation for adxl345 driver
      docs: iio: describe inactivity and free-fall detection on the ADXL345

Mao Jinlong (2):
      dt-bindings: arm: Add label in the coresight components
      coresight: Add label sysfs node support

Marcelo Schmitt (1):
      MAINTAINERS: Update max30208 maintainership

Markus Heidelberg (3):
      dt-bindings: eeprom: at25: use "size" for FRAMs without device ID
      eeprom: at25: support Cypress FRAMs without device ID
      eeprom: at25: make FRAM device ID error message more precise

Matti Vaittinen (18):
      iio: adc: ad7476: Simplify chip type detection
      iio: adc: ad7476: Simplify scale handling
      iio: adc: ad7476: Use mV for internal reference
      iio: adc: ad7476: Use correct channel for bit info
      iio: adc: ad7476: use *_cansleep GPIO APIs
      iio: adc: ad7476: Drop convstart chan_spec
      iio: adc: ad7476: Conditionally call convstart
      dt-bindings: iio: adc: ad7476: Drop redundant prop: true
      dt-bindings: iio: adc: ad7476: Add ROHM bd79105
      iio: adc: ad7476: Support ROHM BD79105
      MAINTAINERS: A driver for simple 1-channel SPI ADCs
      dt-bindings: iio: adc: Add BD7910[0,1,2,3]
      iio: adc: adc128s052: Simplify matching chip_data
      iio: adc: adc128s052: Rename channel structs
      iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
      dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
      iio: adc: Support ROHM BD79112 ADC/GPIO
      MAINTAINERS: Support ROHM BD79112 ADC

Max Kellermann (1):
      drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C

Miaoqian Lin (1):
      cdx: Fix device node reference leak in cdx_msi_domain_init

Michael Hennerich (2):
      iio: frequency: adf4350: Fix prescaler usage.
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE

Michael Walle (1):
      dt-bindings: nvmem: sl28cpld: add sa67mcu compatible

Nai-Chen Cheng (1):
      greybus: svc: use string choice helpers instead of ternary operator

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Nuno Sá (3):
      iio: buffer: buffer-cb: drop double initialization of demux list
      iio: imu: adis16475: remove extra line
      iio: dac: ad5791: drop unused member of struct ad5791_state

Primoz Fiser (1):
      dt-bindings: iio: afe: current-sense-amplifier: Add io-channel-cells

Qianfeng Rong (4):
      iio: imu: inv_icm42600: use min() to improve code
      iio: common: scmi_iio: use kcalloc() instead of kzalloc()
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Qiang Liu (1):
      slimbus: messaging: Remove redundant code

Randy Dunlap (2):
      extcon: max14526: avoid defined but not used warning
      extcon: max14526: depends on I2C to prevent build warning/errors

Raviteja Laggyshetty (4):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Glymur SoC
      interconnect: qcom: icc-rpmh: increase MAX_PORTS to support four QoS ports
      interconnect: qcom: add glymur interconnect provider driver
      dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC

Ricky Wu (1):
      misc: rtsx_pci: Add separate CD/WP pin polarity reversal support

Rob Herring (Arm) (1):
      hwtracing: coresight: Use of_reserved_mem_region_to_resource() for "memory-region"

Rodrigo Gobbi (2):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register
      dt-bindings: iio: pressure: add invensense,icp10100

Sakari Ailus (12):
      iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
      iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
      iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
      iio: common: Remove redundant pm_runtime_mark_last_busy() calls
      iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
      iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
      iio: light: Remove redundant pm_runtime_mark_last_busy() calls
      iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
      iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
      iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
      iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
      iio: dac: Remove redundant pm_runtime_mark_last_busy() calls

Salah Triki (3):
      staging: iio: adc: ad7816: Drop unnecessary dev_set_drvdata() call
      iio: pressure: bmp280: Remove noisy dev_info()
      iio: pressure: bmp280: Use gpiod_set_value_cansleep()

Salih Erim (1):
      MAINTAINERS: Update xilinx-ams driver maintainers

Sean Anderson (2):
      iio: xilinx-ams: Unmask interrupts after updating alarms
      iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK

Sean Nyekjaer (5):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
      iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator
      iio: imu: inv_icm42600: use guard() to release mutexes

Shankari Anand (1):
      rust: miscdevice: update ARef import to sync::aref

Slark Xiao (1):
      bus: mhi: host: pci_generic: Add support for all Foxconn T99W696 SKU variants

Srinivas Kandagatla (1):
      slimbus: qcom: remove unused qcom controller driver

Stefano Manni (2):
      iio: adc: ad799x: add reference voltage capability to chip_info
      iio: adc: ad799x: add reference voltage to ad7994

Sumit Kumar (1):
      bus: mhi: ep: Fix chained transfer handling in read path

Svyatoslav Ryhel (2):
      dt-bindings: extcon: Document Maxim MAX14526 MUIC
      extcon: Add basic support for Maxim MAX14526 MUIC

Thorsten Blum (5):
      misc: hisi_hikey_usb: Use str_enabled_disabled() in hub_power_ctrl()
      dw-xdata: Use str_write_read() in dw_xdata_start() and dw_xdata_perf()
      misc: ad525x_dpot: Use str_enabled_disabled() in sysfs_show_reg()
      char/adi: Remove redundant less-than-zero check in adi_write()
      ibmasm: Replace kzalloc() + copy_from_user() with memdup_user_nul()

Vivek Pernamitta (7):
      bus: mhi: host: Notify EE change via uevent
      bus: mhi: host: Add support for separate controller configurations for VF and PF
      bus: mhi: host: pci_generic: Read SUBSYSTEM_VENDOR_ID for VF's to check status
      bus: mhi: host: pci_generic: Add SRIOV support
      bus: mhi: host: pci_generic: Reset QDU100 while the MHI driver is removed
      bus: mhi: core: Improve mhi_sync_power_up handling for SYS_ERR state
      bus: mhi: host: pci_generic: Set DMA mask for VFs

Vivian Wang (1):
      uio: uio_pdrv_genirq: Remove MODULE_DEVICE_TABLE

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Waqar Hameed (2):
      iio: Remove error prints for devm_add_action_or_reset()
      counter: ti-ecap-capture: Use devm_pm_runtime_enable()

William Breathitt Gray (1):
      counter: Alphabetize component_id sysfs attributes Documentation list

Wolfram Sang (2):
      iio: remove unneeded 'fast_io' parameter in regmap_config
      peci: remove unneeded 'fast_io' parameter in regmap_config

Xichao Zhao (11):
      iio: adc: ti-tsc2046: use us_to_ktime() where appropriate
      hpet: Use str_plural() to simplify the code
      iio: accel: msa311: Remove dev_err_probe() if error is -ENOMEM
      iio: adc: Remove dev_err_probe() if error is -ENOMEM
      iio: chemical: Remove dev_err_probe() if error is -ENOMEM
      iio: imu: bmi323: Remove dev_err_probe() if error is -ENOMEM
      iio: light: Remove dev_err_probe() if error is -ENOMEM
      iio: proximity: Remove dev_err_probe() if error is -ENOMEM
      iio: temperature: mlx90635: Remove dev_err_probe() if error is -ENOMEM
      siox: bus-gpio: Remove the use of dev_err_probe()
      slimbus: messaging: fix "transfered"->"transferred"

Xing Guo (1):
      docs: iio: Fix unexpected indentation for adxl345.

Xion Wang (2):
      misc: remove ineffective WARN_ON() check from misc_deregister()
      char: Use list_del_init() in misc_deregister() to reinitialize list pointer

Yeoreum Yun (1):
      coresight: fix indentation error in cscfg_remove_owned_csdev_configs()

Yuanfang Zhang (5):
      coresight: Only register perf symlink for sinks with alloc_buffer
      dt-bindings: arm: Add device Trace Network On Chip definition
      coresight: add coresight Trace Network On Chip driver
      coresight-etm4x: Conditionally access register TRCEXTINSELR
      coresight: tnoc: add new AMBA ID to support Trace Noc V2

Zhang Enpei (1):
      interconnect: core: Use device_match_of_node()

Zijun Hu (8):
      char: misc: Move drivers/misc/misc_minor_kunit.c to drivers/char/
      char: misc: Adapt and add test cases for simple minor space division
      char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR
      char: misc: Add a case to test registering miscdevice again without reinitialization
      char: misc: Make misc_register() reentry for miscdevice who wants dynamic minor
      char: misc: Does not request module for miscdevice with dynamic minor
      char: misc: Register fixed minor EISA_EEPROM_MINOR in linux/miscdevice.h
      sparc: kernel: apc: Remove macro APC_MINOR definition

 .../ABI/testing/sysfs-bus-coresight-devices-cti    |    6 +
 .../sysfs-bus-coresight-devices-dummy-source       |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-etb10  |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-funnel |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-stm    |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |    6 +
 .../ABI/testing/sysfs-bus-coresight-devices-trbe   |    6 +
 Documentation/ABI/testing/sysfs-bus-counter        |    8 +-
 .../ABI/testing/sysfs-bus-i2c-devices-m24lr        |  100 +
 Documentation/ABI/testing/sysfs-bus-iio            |   56 +-
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |   10 -
 .../devicetree/bindings/arm/arm,coresight-cti.yaml |    4 +
 .../bindings/arm/arm,coresight-dummy-sink.yaml     |    4 +
 .../bindings/arm/arm,coresight-dummy-source.yaml   |    4 +
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml |    4 +
 .../arm/arm,coresight-dynamic-replicator.yaml      |    4 +
 .../bindings/arm/arm,coresight-etb10.yaml          |    4 +
 .../devicetree/bindings/arm/arm,coresight-etm.yaml |    4 +
 .../bindings/arm/arm,coresight-static-funnel.yaml  |    4 +
 .../arm/arm,coresight-static-replicator.yaml       |    4 +
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml |    4 +
 .../bindings/arm/arm,coresight-tpiu.yaml           |    4 +
 .../bindings/arm/qcom,coresight-ctcu.yaml          |    4 +
 .../bindings/arm/qcom,coresight-remote-etm.yaml    |    4 +
 .../bindings/arm/qcom,coresight-tnoc.yaml          |  113 +
 .../bindings/arm/qcom,coresight-tpda.yaml          |    4 +
 .../bindings/arm/qcom,coresight-tpdm.yaml          |    4 +
 Documentation/devicetree/bindings/eeprom/at25.yaml |    8 +
 .../devicetree/bindings/eeprom/st,m24lr.yaml       |   52 +
 .../devicetree/bindings/extcon/extcon-rt8973a.txt  |   23 -
 .../bindings/extcon/linux,extcon-usb-gpio.yaml     |    6 +
 .../devicetree/bindings/extcon/maxim,max14526.yaml |   80 +
 .../bindings/extcon/richtek,rt8973a-muic.yaml      |   49 +
 .../bindings/iio/accel/adi,adis16240.yaml          |    4 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |    5 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |    1 -
 .../bindings/iio/accel/bosch,bma400.yaml           |    1 -
 .../bindings/iio/accel/kionix,kxsd9.yaml           |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   24 +-
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |  102 +-
 .../devicetree/bindings/iio/adc/adi,ad7779.yaml    |   44 +-
 .../devicetree/bindings/iio/adc/adi,ade9000.yaml   |   95 +
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |    1 -
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |    3 +
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    2 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 -
 .../bindings/iio/adc/rockchip-saradc.yaml          |    3 +
 .../devicetree/bindings/iio/adc/rohm,bd79104.yaml  |   11 +-
 .../devicetree/bindings/iio/adc/rohm,bd79112.yaml  |  104 +
 .../devicetree/bindings/iio/adc/rohm,bd79124.yaml  |    2 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   33 +-
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml |    1 -
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |    1 -
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    3 +-
 .../bindings/iio/afe/current-sense-amplifier.yaml  |    4 +
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |    3 +-
 .../devicetree/bindings/iio/dac/adi,ltc2664.yaml   |    2 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    3 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    1 -
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    3 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |    2 -
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |    2 -
 .../bindings/iio/light/dynaimage,al3010.yaml       |    2 +-
 .../bindings/iio/light/dynaimage,al3320a.yaml      |    2 +-
 .../devicetree/bindings/iio/light/st,vl6180.yaml   |    1 -
 .../bindings/iio/light/vishay,veml6046x00.yaml     |   51 +
 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    |   45 +
 .../iio/magnetometer/voltafield,af8133j.yaml       |    1 -
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    1 -
 .../bindings/iio/pressure/invensense,icp10100.yaml |   52 +
 .../iio/temperature/microchip,mcp9600.yaml         |   56 +-
 .../bindings/interconnect/qcom,glymur-rpmh.yaml    |  172 ++
 .../bindings/interconnect/qcom,osm-l3.yaml         |    5 +
 .../bindings/mfd/marvell,88pm886-a1.yaml           |    4 +
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |    2 +
 .../bindings/nvmem/airoha,an8855-efuse.yaml        |  123 +
 .../bindings/nvmem/layouts/kontron,sl28-vpd.yaml   |    7 +-
 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml       |   45 +
 .../devicetree/bindings/slimbus/qcom,slim.yaml     |   86 -
 .../devicetree/bindings/slimbus/slimbus.yaml       |   13 +-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 .../devicetree/bindings/w1/fsl-imx-owire.yaml      |    4 +
 Documentation/iio/ad3552r.rst                      |    3 +-
 Documentation/iio/ade9000.rst                      |  268 +++
 Documentation/iio/adxl345.rst                      |  443 ++++
 Documentation/iio/bno055.rst                       |   12 +-
 Documentation/iio/index.rst                        |    2 +
 Documentation/netlink/specs/binder.yaml            |   93 +
 MAINTAINERS                                        |   35 +-
 arch/sparc/kernel/apc.c                            |    3 +-
 drivers/android/Kconfig                            |   16 +-
 drivers/android/Makefile                           |    3 +-
 drivers/android/binder.c                           |  160 +-
 drivers/android/binder/Makefile                    |    9 +
 drivers/android/binder/allocation.rs               |  602 +++++
 drivers/android/binder/context.rs                  |  180 ++
 drivers/android/binder/deferred_close.rs           |  204 ++
 drivers/android/binder/defs.rs                     |  182 ++
 drivers/android/binder/error.rs                    |   99 +
 drivers/android/binder/freeze.rs                   |  388 +++
 drivers/android/binder/node.rs                     | 1131 +++++++++
 drivers/android/binder/node/wrapper.rs             |   78 +
 drivers/android/binder/page_range.rs               |  734 ++++++
 drivers/android/binder/page_range_helper.c         |   24 +
 drivers/android/binder/page_range_helper.h         |   15 +
 drivers/android/binder/process.rs                  | 1696 +++++++++++++
 drivers/android/binder/range_alloc/array.rs        |  251 ++
 drivers/android/binder/range_alloc/mod.rs          |  329 +++
 drivers/android/binder/range_alloc/tree.rs         |  488 ++++
 drivers/android/binder/rust_binder.h               |   23 +
 drivers/android/binder/rust_binder_events.c        |   59 +
 drivers/android/binder/rust_binder_events.h        |   36 +
 drivers/android/binder/rust_binder_internal.h      |   87 +
 drivers/android/binder/rust_binder_main.rs         |  627 +++++
 drivers/android/binder/rust_binderfs.c             |  850 +++++++
 drivers/android/binder/stats.rs                    |   89 +
 drivers/android/binder/thread.rs                   | 1596 ++++++++++++
 drivers/android/binder/trace.rs                    |   16 +
 drivers/android/binder/transaction.rs              |  456 ++++
 drivers/android/binder_internal.h                  |    4 +-
 drivers/android/binder_netlink.c                   |   31 +
 drivers/android/binder_netlink.h                   |   20 +
 drivers/android/binder_trace.h                     |   37 +
 drivers/android/binderfs.c                         |    8 +
 drivers/android/dbitmap.h                          |    1 +
 drivers/bus/mhi/ep/main.c                          |   37 +-
 drivers/bus/mhi/host/init.c                        |    5 +-
 drivers/bus/mhi/host/internal.h                    |    3 +
 drivers/bus/mhi/host/main.c                        |    1 +
 drivers/bus/mhi/host/pci_generic.c                 |   85 +-
 drivers/bus/mhi/host/pm.c                          |   29 +-
 drivers/cdx/cdx_msi.c                              |    1 +
 drivers/char/Makefile                              |    1 +
 drivers/char/adi.c                                 |    2 +-
 drivers/char/hpet.c                                |    2 +-
 drivers/char/misc.c                                |   21 +-
 drivers/{misc => char}/misc_minor_kunit.c          |   95 +-
 drivers/comedi/Kconfig                             |    9 +
 drivers/comedi/drivers/Makefile                    |    1 +
 drivers/comedi/drivers/adl_pci7250.c               |  220 ++
 drivers/counter/ti-ecap-capture.c                  |   12 +-
 drivers/extcon/Kconfig                             |   13 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-adc-jack.c                   |    2 +
 drivers/extcon/extcon-axp288.c                     |    2 +-
 drivers/extcon/extcon-fsa9480.c                    |    2 +-
 drivers/extcon/extcon-max14526.c                   |  302 +++
 drivers/extcon/extcon-qcom-spmi-misc.c             |    2 +-
 drivers/greybus/svc.c                              |    3 +-
 drivers/hwtracing/coresight/Kconfig                |   12 +
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-catu.c       |   53 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    1 +
 drivers/hwtracing/coresight/coresight-core.c       |   54 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   41 +-
 drivers/hwtracing/coresight/coresight-ctcu-core.c  |   24 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   18 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    4 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   17 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   44 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |    1 +
 drivers/hwtracing/coresight/coresight-etm4x.h      |    6 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   66 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   63 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   42 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |    2 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |   71 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   70 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 +
 drivers/hwtracing/coresight/coresight-tnoc.c       |  246 ++
 drivers/hwtracing/coresight/coresight-tpda.c       |    3 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   36 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |    9 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h         |    1 +
 drivers/iio/accel/adxl345_core.c                   |  782 +++++-
 drivers/iio/accel/bma180.c                         |   13 +-
 drivers/iio/accel/bma220_spi.c                     |    4 +-
 drivers/iio/accel/bmc150-accel-core.c              |    7 +-
 drivers/iio/accel/bmi088-accel-core.c              |    3 -
 drivers/iio/accel/dmard06.c                        |    4 +-
 drivers/iio/accel/dmard09.c                        |    4 +-
 drivers/iio/accel/dmard10.c                        |    4 +-
 drivers/iio/accel/fxls8962af-core.c                |    1 -
 drivers/iio/accel/kxcjk-1013.c                     |    4 +-
 drivers/iio/accel/kxsd9.c                          |    3 -
 drivers/iio/accel/mc3230.c                         |    4 +-
 drivers/iio/accel/mma7660.c                        |    4 +-
 drivers/iio/accel/mma8452.c                        |    7 +-
 drivers/iio/accel/mma9551_core.c                   |    5 +-
 drivers/iio/accel/msa311.c                         |   16 +-
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    4 +-
 drivers/iio/adc/88pm886-gpadc.c                    |  393 +++
 drivers/iio/adc/Kconfig                            |   54 +
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/ab8500-gpadc.c                     |    1 -
 drivers/iio/adc/ad4130.c                           |    3 +-
 drivers/iio/adc/ad7124.c                           |  563 ++++-
 drivers/iio/adc/ad7173.c                           |  221 +-
 drivers/iio/adc/ad7476.c                           |  461 ++--
 drivers/iio/adc/ad7768-1.c                         |   37 +-
 drivers/iio/adc/ad7779.c                           |  192 +-
 drivers/iio/adc/ad7949.c                           |    4 +-
 drivers/iio/adc/ad799x.c                           |   30 +-
 drivers/iio/adc/ade9000.c                          | 1799 ++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                      |    1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |   13 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    4 +-
 drivers/iio/adc/cpcap-adc.c                        |    6 +-
 drivers/iio/adc/da9150-gpadc.c                     |    5 +-
 drivers/iio/adc/dln2-adc.c                         |    9 +-
 drivers/iio/adc/exynos_adc.c                       |  286 +--
 drivers/iio/adc/hx711.c                            |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    4 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    6 +-
 drivers/iio/adc/imx93_adc.c                        |   26 +-
 drivers/iio/adc/intel_dc_ti_adc.c                  |  328 +++
 drivers/iio/adc/mcp3564.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/iio/adc/mt6577_auxadc.c                    |    3 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    4 +-
 drivers/iio/adc/pac1921.c                          |    3 +-
 drivers/iio/adc/pac1934.c                          |   31 +-
 drivers/iio/adc/palmas_gpadc.c                     |    4 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    8 +-
 drivers/iio/adc/rn5t618-adc.c                      |    4 +-
 drivers/iio/adc/rockchip_saradc.c                  |    6 +-
 drivers/iio/adc/rohm-bd79112.c                     |  556 +++++
 drivers/iio/adc/rzg2l_adc.c                        |    2 -
 drivers/iio/adc/spear_adc.c                        |   12 +-
 drivers/iio/adc/stm32-adc-core.c                   |    1 -
 drivers/iio/adc/stm32-adc.c                        |    7 -
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    4 +-
 drivers/iio/adc/stmpe-adc.c                        |    4 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    3 -
 drivers/iio/adc/ti-adc081c.c                       |   40 +-
 drivers/iio/adc/ti-adc084s021.c                    |    4 +-
 drivers/iio/adc/ti-adc12138.c                      |   30 +-
 drivers/iio/adc/ti-adc128s052.c                    |  140 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |    1 -
 drivers/iio/adc/ti-ads1119.c                       |   11 +-
 drivers/iio/adc/ti-ads131e08.c                     |    8 +-
 drivers/iio/adc/ti-ads7924.c                       |    9 +-
 drivers/iio/adc/ti-tsc2046.c                       |    6 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    5 +-
 drivers/iio/adc/twl4030-madc.c                     |    4 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/adc/viperboard_adc.c                   |    4 +-
 drivers/iio/adc/xilinx-ams.c                       |   47 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |    1 -
 drivers/iio/chemical/atlas-sensor.c                |    2 -
 drivers/iio/chemical/bme680_core.c                 |    3 -
 drivers/iio/chemical/ens160_core.c                 |    3 +-
 drivers/iio/chemical/scd30_core.c                  |    2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    1 -
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   10 +-
 drivers/iio/dac/ad5360.c                           |    2 +-
 drivers/iio/dac/ad5380.c                           |    4 +-
 drivers/iio/dac/ad5421.c                           |    2 +-
 drivers/iio/dac/ad5764.c                           |    4 +-
 drivers/iio/dac/ad5791.c                           |    4 -
 drivers/iio/dac/ds4424.c                           |    4 +-
 drivers/iio/dac/stm32-dac.c                        |   19 +-
 drivers/iio/dac/ti-dac7311.c                       |    4 +-
 drivers/iio/frequency/adf4350.c                    |   23 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    2 -
 drivers/iio/gyro/mpu3050-core.c                    |    3 -
 drivers/iio/gyro/mpu3050-i2c.c                     |    1 -
 drivers/iio/health/afe4403.c                       |   48 +-
 drivers/iio/health/afe4404.c                       |   48 +-
 drivers/iio/humidity/am2315.c                      |    4 +-
 drivers/iio/humidity/dht11.c                       |    4 +-
 drivers/iio/imu/adis16475.c                        |    1 -
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    2 +
 drivers/iio/imu/bmi323/bmi323_core.c               |    3 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   29 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   65 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  117 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   29 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    6 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    1 -
 drivers/iio/imu/kmx61.c                            |    6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   14 +-
 drivers/iio/industrialio-core.c                    |   11 +-
 drivers/iio/inkern.c                               |   81 +-
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |   19 +-
 drivers/iio/light/adjd_s311.c                      |   12 +-
 drivers/iio/light/al3000a.c                        |    2 +-
 drivers/iio/light/apds9306.c                       |    4 +-
 drivers/iio/light/apds9960.c                       |    1 -
 drivers/iio/light/bh1745.c                         |    7 +-
 drivers/iio/light/bh1780.c                         |    1 -
 drivers/iio/light/gp2ap002.c                       |    2 -
 drivers/iio/light/hid-sensor-als.c                 |    5 +-
 drivers/iio/light/isl29028.c                       |   11 +-
 drivers/iio/light/isl29125.c                       |   14 +-
 drivers/iio/light/ltr390.c                         |  197 +-
 drivers/iio/light/ltr501.c                         |    4 +-
 drivers/iio/light/ltrf216a.c                       |    1 -
 drivers/iio/light/max44000.c                       |   18 +-
 drivers/iio/light/opt4001.c                        |    3 +-
 drivers/iio/light/opt4060.c                        |    7 +-
 drivers/iio/light/pa12203001.c                     |   11 +-
 drivers/iio/light/rohm-bu27034.c                   |    3 +-
 drivers/iio/light/rpr0521.c                        |   10 +-
 drivers/iio/light/si1145.c                         |    5 +-
 drivers/iio/light/st_uvis25.h                      |    5 -
 drivers/iio/light/st_uvis25_core.c                 |   12 +-
 drivers/iio/light/stk3310.c                        |    4 +-
 drivers/iio/light/tcs3414.c                        |   15 +-
 drivers/iio/light/tcs3472.c                        |   14 +-
 drivers/iio/light/tsl2583.c                        |   12 +-
 drivers/iio/light/tsl2591.c                        |    2 -
 drivers/iio/light/us5182d.c                        |   12 +-
 drivers/iio/light/vcnl4000.c                       |   22 +-
 drivers/iio/light/vcnl4035.c                       |   11 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/light/veml6040.c                       |    3 +-
 drivers/iio/light/veml6046x00.c                    | 1030 ++++++++
 drivers/iio/light/vl6180.c                         |   16 +-
 drivers/iio/magnetometer/Kconfig                   |   15 +-
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/ak8974.c                  |    2 -
 drivers/iio/magnetometer/ak8975.c                  |    1 -
 drivers/iio/magnetometer/als31300.c                |    5 +-
 drivers/iio/magnetometer/bmc150_magn.c             |   13 +-
 drivers/iio/magnetometer/tlv493d.c                 |  526 ++++
 drivers/iio/magnetometer/tmag5273.c                |    5 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 -
 drivers/iio/potentiostat/lmp91000.c                |    4 +-
 drivers/iio/pressure/bmp280-core.c                 |    8 +-
 drivers/iio/pressure/dlhl60d.c                     |    4 +-
 drivers/iio/pressure/icp10100.c                    |    1 -
 drivers/iio/pressure/mpl115.c                      |    2 -
 drivers/iio/pressure/zpa2326.c                     |    2 -
 drivers/iio/proximity/d3323aa.c                    |    3 +-
 drivers/iio/proximity/hx9023s.c                    |    3 +-
 drivers/iio/proximity/irsd200.c                    |    6 +-
 drivers/iio/proximity/mb1232.c                     |   15 +-
 drivers/iio/proximity/ping.c                       |    4 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   16 +-
 drivers/iio/proximity/srf04.c                      |    8 +-
 drivers/iio/proximity/srf08.c                      |   18 +-
 drivers/iio/proximity/sx9500.c                     |   27 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   27 +-
 drivers/iio/temperature/Kconfig                    |    8 +-
 drivers/iio/temperature/mcp9600.c                  |  151 +-
 drivers/iio/temperature/mlx90614.c                 |    1 -
 drivers/iio/temperature/mlx90632.c                 |    5 +-
 drivers/iio/temperature/mlx90635.c                 |    9 +-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-multiply.c               |  212 ++
 drivers/interconnect/core.c                        |    2 +-
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/glymur.c                 | 2543 ++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h               |    2 +-
 drivers/misc/Makefile                              |    1 -
 drivers/misc/ad525x_dpot.c                         |    7 +-
 drivers/misc/amd-sbi/Kconfig                       |    1 +
 drivers/misc/apds990x.c                            |    1 -
 drivers/misc/cardreader/rts5227.c                  |   13 +-
 drivers/misc/cardreader/rts5228.c                  |   12 +-
 drivers/misc/cardreader/rts5249.c                  |   16 +-
 drivers/misc/cardreader/rts5264.c                  |   20 +-
 drivers/misc/cardreader/rts5264.h                  |    1 +
 drivers/misc/cardreader/rtsx_pcr.h                 |    2 +
 drivers/misc/dw-xdata-pcie.c                       |    5 +-
 drivers/misc/eeprom/Kconfig                        |   18 +
 drivers/misc/eeprom/Makefile                       |    1 +
 drivers/misc/eeprom/at25.c                         |   67 +-
 drivers/misc/eeprom/m24lr.c                        |  606 +++++
 drivers/misc/fastrpc.c                             |   54 +-
 drivers/misc/genwqe/card_ddcb.c                    |    2 +-
 drivers/misc/hisi_hikey_usb.c                      |    3 +-
 drivers/misc/ibmasm/ibmasmfs.c                     |   12 +-
 drivers/misc/lis3lv02d/Kconfig                     |    4 +-
 drivers/misc/mei/bus-fixup.c                       |    6 +-
 drivers/misc/mei/bus.c                             |   26 +-
 drivers/misc/mei/client.c                          |   82 +-
 drivers/misc/mei/client.h                          |    6 +-
 drivers/misc/mei/dma-ring.c                        |    8 +-
 drivers/misc/mei/gsc-me.c                          |   20 +-
 drivers/misc/mei/hbm.c                             |  121 +-
 drivers/misc/mei/hw-me.c                           |  153 +-
 drivers/misc/mei/hw-txe.c                          |   60 +-
 drivers/misc/mei/hw.h                              |    2 +
 drivers/misc/mei/init.c                            |   66 +-
 drivers/misc/mei/interrupt.c                       |   45 +-
 drivers/misc/mei/main.c                            |  139 +-
 drivers/misc/mei/mei_dev.h                         |   24 +-
 drivers/misc/mei/pci-me.c                          |   20 +-
 drivers/misc/mei/pci-txe.c                         |    4 +-
 drivers/misc/mei/platform-vsc.c                    |   26 +-
 drivers/nvmem/Kconfig                              |   21 +
 drivers/nvmem/Makefile                             |    4 +
 drivers/nvmem/an8855-efuse.c                       |   68 +
 drivers/nvmem/s32g-ocotp-nvmem.c                   |  100 +
 drivers/parisc/eisa_eeprom.c                       |    2 -
 drivers/peci/controller/peci-npcm.c                |    1 -
 drivers/pps/kapi.c                                 |    5 +-
 drivers/pps/pps.c                                  |    5 +-
 drivers/siox/siox-bus-gpio.c                       |    3 +-
 drivers/slimbus/Kconfig                            |    7 -
 drivers/slimbus/Makefile                           |    3 -
 drivers/slimbus/messaging.c                        |    4 +-
 drivers/slimbus/qcom-ctrl.c                        |  735 ------
 drivers/staging/iio/adc/ad7816.c                   |    2 -
 drivers/uio/uio_aec.c                              |    2 +-
 drivers/uio/uio_cif.c                              |    2 +-
 drivers/uio/uio_dmem_genirq.c                      |   23 -
 drivers/uio/uio_hv_generic.c                       |    7 +-
 drivers/uio/uio_netx.c                             |    2 +-
 drivers/uio/uio_pdrv_genirq.c                      |   24 -
 drivers/uio/uio_sercos3.c                          |    2 +-
 drivers/w1/masters/matrox_w1.c                     |   10 +-
 .../dt-bindings/interconnect/qcom,glymur-rpmh.h    |  205 ++
 include/linux/coresight.h                          |   31 +-
 include/linux/iio/consumer.h                       |   18 +
 include/linux/iio/frequency/adf4350.h              |    2 +-
 include/linux/iio/iio.h                            |   20 +-
 include/linux/iio/types.h                          |    1 +
 include/linux/mfd/88pm886.h                        |   58 +
 include/linux/miscdevice.h                         |    9 +
 include/linux/platform_data/touchscreen-s3c2410.h  |   22 -
 include/linux/rtsx_pci.h                           |    2 +
 include/uapi/linux/android/binder.h                |    2 +-
 include/uapi/linux/android/binder_netlink.h        |   37 +
 include/uapi/linux/iio/types.h                     |    5 +
 include/uapi/misc/fastrpc.h                        |    2 +-
 rust/bindings/bindings_helper.h                    |    8 +
 rust/helpers/binder.c                              |   26 +
 rust/helpers/helpers.c                             |    1 +
 rust/helpers/page.c                                |    8 +
 rust/helpers/security.c                            |   24 +
 rust/helpers/usb.c                                 |    8 +
 rust/kernel/cred.rs                                |    6 +
 rust/kernel/fs.rs                                  |    3 +
 rust/kernel/fs/kiocb.rs                            |   68 +
 rust/kernel/iov.rs                                 |  314 +++
 rust/kernel/lib.rs                                 |    1 +
 rust/kernel/miscdevice.rs                          |   63 +-
 rust/kernel/page.rs                                |    6 +
 rust/kernel/security.rs                            |   37 +
 rust/kernel/usb.rs                                 |  456 ++++
 rust/uapi/uapi_helper.h                            |    1 +
 samples/rust/Kconfig                               |   11 +
 samples/rust/Makefile                              |    1 +
 samples/rust/rust_driver_usb.rs                    |   47 +
 samples/rust/rust_misc_device.rs                   |   39 +-
 tools/iio/iio_event_monitor.c                      |   10 +
 .../selftests/filesystems/binderfs/binderfs_test.c |    1 +
 467 files changed, 27363 insertions(+), 3825 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-m24lr
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
 create mode 100644 Documentation/devicetree/bindings/eeprom/st,m24lr.yaml
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
 create mode 100644 Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 create mode 100644 Documentation/iio/ade9000.rst
 create mode 100644 Documentation/iio/adxl345.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder/Makefile
 create mode 100644 drivers/android/binder/allocation.rs
 create mode 100644 drivers/android/binder/context.rs
 create mode 100644 drivers/android/binder/deferred_close.rs
 create mode 100644 drivers/android/binder/defs.rs
 create mode 100644 drivers/android/binder/error.rs
 create mode 100644 drivers/android/binder/freeze.rs
 create mode 100644 drivers/android/binder/node.rs
 create mode 100644 drivers/android/binder/node/wrapper.rs
 create mode 100644 drivers/android/binder/page_range.rs
 create mode 100644 drivers/android/binder/page_range_helper.c
 create mode 100644 drivers/android/binder/page_range_helper.h
 create mode 100644 drivers/android/binder/process.rs
 create mode 100644 drivers/android/binder/range_alloc/array.rs
 create mode 100644 drivers/android/binder/range_alloc/mod.rs
 create mode 100644 drivers/android/binder/range_alloc/tree.rs
 create mode 100644 drivers/android/binder/rust_binder.h
 create mode 100644 drivers/android/binder/rust_binder_events.c
 create mode 100644 drivers/android/binder/rust_binder_events.h
 create mode 100644 drivers/android/binder/rust_binder_internal.h
 create mode 100644 drivers/android/binder/rust_binder_main.rs
 create mode 100644 drivers/android/binder/rust_binderfs.c
 create mode 100644 drivers/android/binder/stats.rs
 create mode 100644 drivers/android/binder/thread.rs
 create mode 100644 drivers/android/binder/trace.rs
 create mode 100644 drivers/android/binder/transaction.rs
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 rename drivers/{misc => char}/misc_minor_kunit.c (89%)
 create mode 100644 drivers/comedi/drivers/adl_pci7250.c
 create mode 100644 drivers/extcon/extcon-max14526.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tnoc.c
 create mode 100644 drivers/iio/adc/88pm886-gpadc.c
 create mode 100644 drivers/iio/adc/ade9000.c
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79112.c
 create mode 100644 drivers/iio/light/veml6046x00.c
 create mode 100644 drivers/iio/magnetometer/tlv493d.c
 create mode 100644 drivers/iio/test/iio-test-multiply.c
 create mode 100644 drivers/interconnect/qcom/glymur.c
 create mode 100644 drivers/misc/eeprom/m24lr.c
 create mode 100644 drivers/nvmem/an8855-efuse.c
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c
 delete mode 100644 drivers/slimbus/qcom-ctrl.c
 create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h
 delete mode 100644 include/linux/platform_data/touchscreen-s3c2410.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h
 create mode 100644 rust/helpers/binder.c
 create mode 100644 rust/helpers/usb.c
 create mode 100644 rust/kernel/fs/kiocb.rs
 create mode 100644 rust/kernel/iov.rs
 create mode 100644 rust/kernel/usb.rs
 create mode 100644 samples/rust/rust_driver_usb.rs

