Return-Path: <linux-kernel+bounces-838993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB110BB0963
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8E11946753
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4492FCC01;
	Wed,  1 Oct 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNivAtKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A3284681
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327178; cv=none; b=F97YfGuH4juRQdSLTBzzCAowvGAnp4aw9VQHfRme2/5uBAhxNEGo/aqhS1OoKl3ah57A/DcbGN96QSm8ghr/jTemn1MfQMCkakiejEhjPKCunZrvNRGRJ5zbR8loNp0dRPQkAItm+YvqGPQ+ndfHyLYF4UatXqaxrX3mjsSHYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327178; c=relaxed/simple;
	bh=3C7RNBL6QGfxdNhMcny6ejj3Y0AdTk/dq055LmVmasg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oaZTZLl1EK7BZ+dkJEJ6x0ElZoUzbLN93DAAINqcXIkXWVP+n1LUlLcBgYC9PY6tMKBa056O0IYvuJuHgGC+pdi3Hqbv6LubugDUIjLYHzVWhzOnabBp+viVJLRv+fVzL+Zh9Qbg+MfIYq9n4Ahe8aRnsfTuh2hJl2Kt0z+jtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNivAtKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4176C4CEF1;
	Wed,  1 Oct 2025 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327177;
	bh=3C7RNBL6QGfxdNhMcny6ejj3Y0AdTk/dq055LmVmasg=;
	h=Date:From:To:Cc:Subject:From;
	b=mNivAtKJMGAeVmKttXeDTR80qaMmamLzomK0dPEu/WDXSVFswzFSIgOWGiJjguLpF
	 AhcSJ908h6oyOtZJ+WR2MI0cIiX3NcuhtbFNmqD2X0f2fl3SwKY8GMX6OMOu78cY6i
	 uFu81hXa7giMJBa7Vjv/bVIVhq+8XcgdCRblbI+lN0ABpT5INlGiwiw2je1yu3YTJe
	 au0aYuLbk5OAWbBrX/31G70Z8IhcN3IVdANSZmjt/cB8mP6gDgWzXMjnUFsESswi/O
	 aZGwG+2PYu7pLZlnTqlz/kmYUY+UYMaNXyGy/aqddDODpLgsR1BBmJGQn9HB/MDFo8
	 8DrP62yFecLkQ==
Date: Wed, 1 Oct 2025 14:59:34 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.18
Message-ID: <20251001135934.GU8757@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.18

for you to fetch changes up to b9d6cfe2ae699bbf230a6c8e0e32212b04bff661:

  mfd: simple-mfd-i2c: Add compatible string for LX2160ARDB (2025-10-01 10:46:00 +0100)

----------------------------------------------------------------
MFD for v6.18

This round of updates contains a fair amount of new device support, a couple of fixes and
some refactoring.  The most notable additions include new drivers for Loongson's Security
Engine, RNG and TPM, new drivers for TI's TPS6594 Power Button and BQ257xx Charger ICs.

The rest of the set provides a return value check fix and a refactoring to use a more modern
GPIO API for the VEXPRESS sysreg driver, the removal of a deprecated IRQ ACK function from the
MC13xxx RTC driver and a new DT binding for the aforementioned TI BQ257xx charger.

New Support & Features
- Add a suite of drivers for the Loongson Security Engine, including the core controller, a
  Random Number Generator (RNG) and Trusted Platform Module (TPM) support.
- Introduce support for the TI TPS6594 PMIC's power button, including the input driver, MFD
  cell registration, and a system power-off handler.
- Add comprehensive support for the TI BQ257xx series of charger ICs, including the core MFD
  driver and a power supply driver for the charger functionality.

Improvements & Fixes
- Check the return value of devm_gpiochip_add_data() in the VEXPRESS sysreg driver to prevent
  potential silent failures.

Cleanups & Refactoring
- Add a MAINTAINERS entry for the new Loongson Security Engine drivers.
- Convert the VEXPRESS sysreg driver to use the modern generic GPIO chip API.

Removals
- Remove the deprecated and unused mc13xxx_irq_ack() function from the MC13xxx RTC, input and
  touchscreen drivers.

Device Tree Bindings Updates
- Add device tree bindings for the TI BQ25703A charger.

----------------------------------------------------------------
Alex Elder (2):
      dt-bindings: mfd: Add support the SpacemiT P1 PMIC
      mfd: simple-mfd-i2c: Add SpacemiT P1 support

Alexander Kurz (3):
      mfd: input: rtc: mc13783: Remove deprecated mc13xxx_irq_ack()
      dt-bindings: mfd: fsl,mc13xxx: Convert txt to DT schema
      dt-bindings: mfd: fsl,mc13xxx: Add buttons node

Alexander Stein (5):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-spi: Use module_spi_driver to remove boilerplate
      mfd: stmpe-i2c: Use module_i2c_driver to remove boilerplate
      mfd: stmpe-spi: Add missing MODULE_LICENSE
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Arnd Bergmann (4):
      mfd: madera: Work around false-positive -Wininitialized warning
      mfd: arizona: Make legacy gpiolib interface optional
      mfd: si476x: Add GPIOLIB_LEGACY dependency
      mfd: aat2870: Add GPIOLIB_LEGACY dependency

Bartosz Golaszewski (3):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      mfd: vexpress-sysreg: Use new generic GPIO chip API
      mfd: vexpress-sysreg: Use more common syntax for compound literals

Bastien Curutchet (1):
      mfd: core: Increment of_node's refcount before linking it to the platform device

Binbin Zhou (2):
      mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
      mfd: ls2kbmc: Add Loongson-2K BMC reset function support

Charles Keepax (2):
      mfd: cs42l43: Move IRQ enable/disable to encompass force suspend
      mfd: cs42l43: Remove IRQ masking in suspend

Chris Morgan (4):
      dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
      mfd: bq257xx: Add support for BQ25703A core driver
      power: supply: bq257xx: Add support for BQ257XX charger
      regulator: bq257xx: Add bq257xx boost regulator driver

Colin Ian King (1):
      mfd: Kconfig: Fix spelling mistake "infontainment" -> "infotainment"

Conor Dooley (1):
      dt-bindings: mfd: syscon: Document the control-scb syscon on PolarFire SoC

Cosmin Tanislav (1):
      mfd: rz-mtu3: Fix MTU5 NFCR register offset

Duje Mihanović (1):
      mfd: 88pm886: Add GPADC cell

Dzmitry Sankouski (1):
      mfd: max77705: Setup the core driver as an interrupt controller

Hans de Goede (1):
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

Heijligen, Thomas (1):
      mfd: kempld: Switch back to earlier ->init() behavior

Heiko Stuebner (7):
      dt-bindings: mfd: qnap,ts433-mcu: Add qnap,ts233-mcu compatible
      mfd: qnap-mcu: Add driver data for TS233 variant
      dt-bindings: mfd: qnap,ts433-mcu: Allow nvmem-layout child node
      mfd: qnap-mcu: Include linux/types.h in qnap-mcu.h shared header
      mfd: qnap-mcu: Handle errors returned from qnap_mcu_write
      mfd: qnap-mcu: Convert to guard(mutex) in qnap_mcu_exec
      mfd: qnap-mcu: Improve structure in qnap_mcu_exec

Ilpo Järvinen (1):
      mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs

Ioana Ciornei (3):
      mfd: simple-mfd-i2c: Add compatible strings for Layerscape QIXIS FPGA
      mfd: simple-mfd-i2c: Keep compatible strings in alphabetical order
      mfd: simple-mfd-i2c: Add compatible string for LX2160ARDB

Janne Grunau (1):
      mfd: macsmc: Add "apple,t8103-smc" compatible

Jens Kehne (1):
      mfd: da9063: Split chip variant reading in two bus transactions

Jihed Chaibi (1):
      dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x

Job Sava (1):
      input: tps6594-pwrbutton: Add power button functionality

Kamel Bouhara (2):
      mfd: Add max7360 support
      pwm: max7360: Add MAX7360 PWM support

Krzysztof Kozlowski (1):
      dt-bindings: mfd: Move embedded controllers to own directory

Lee Jones (1):
      Merge branches 'ib-mfd-char-crypto-6.18', 'ib-mfd-gpio-6.18', 'ib-mfd-gpio-hwmon-i2c-can-rtc-watchdog-6.18', 'ib-mfd-gpio-input-pinctrl-pwm-6.18', 'ib-mfd-input-6.18', 'ib-mfd-input-rtc-6.18' and 'ib-mfd-power-regulator-6.18' into ibs-for-mfd-merged

Lukas Bulwahn (1):
      MAINTAINERS: Adjust file entry in LOONGSON SECURITY ENGINE DRIVERS

Mathieu Dubois-Briand (8):
      dt-bindings: mfd: gpio: Add MAX7360
      pinctrl: Add MAX7360 pinctrl driver
      gpio: regmap: Allow to allocate regmap-irq device
      gpio: regmap: Allow to provide init_valid_mask callback
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

Matti Vaittinen (1):
      mfd: bd71828, bd71815: Prepare for power-supply support

Michael Walle (5):
      mfd: tps6594: Add power button functionality
      mfd: tps6594: Add board power-off support
      dt-bindings: mfd: sl28cpld: Add sa67mcu compatible
      dt-bindings: mfd: tps6594: Allow gpio-line-names
      dt-bindings: watchdog: Add SMARC-sAM67 support

Ming Yu (7):
      mfd: Add core driver for Nuvoton NCT6694
      gpio: Add Nuvoton NCT6694 GPIO support
      i2c: Add Nuvoton NCT6694 I2C support
      can: Add Nuvoton NCT6694 CANFD support
      watchdog: Add Nuvoton NCT6694 WDT support
      hwmon: Add Nuvoton NCT6694 HWMON support
      rtc: Add Nuvoton NCT6694 RTC support

Nathan Chancellor (2):
      mfd: tps6594: Explicitly include bitfield.h
      tpm: loongson: Add bufsiz parameter to tpm_loongson_send()

Nuno Sá (1):
      mfd: adp5585: Drop useless return statement

Qunqin Zhao (4):
      mfd: Add support for Loongson Security Engine chip controller
      crypto: loongson - add Loongson RNG driver support
      tpm: Add a driver for Loongson TPM device
      MAINTAINERS: Add entry for Loongson Security Engine drivers

Rob Herring (Arm) (3):
      dt-bindings: mfd: aspeed-lpc: Add missing "clocks" property on lpc-snoop node
      dt-bindings: mfd: syscon: Add "marvell,armada-3700-usb2-host-device-misc" compatible
      dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT schema

Ryan Chen (1):
      dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles

Waqar Hameed (1):
      mfd: macsmc: Remove error prints for devm_add_action_or_reset()

Wolfram Sang (1):
      mfd: Remove unneeded 'fast_io' parameter in regmap_config

Xichao Zhao (2):
      mfd: kempld: Use PTR_ERR_OR_ZERO() to simplify code
      mfd: max899x: Use dedicated interrupt wake setters

 .../acer,aspire1-ec.yaml                           |   2 +-
 .../google,cros-ec.yaml                            |   2 +-
 .../gw,gsc.yaml}                                   |   2 +-
 .../huawei,gaokun3-ec.yaml}                        |   2 +-
 .../kontron,sl28cpld.yaml                          |   9 +-
 .../lenovo,yoga-c630-ec.yaml                       |   2 +-
 .../microsoft,surface-sam.yaml                     |   2 +-
 .../bindings/gpio/kontron,sl28cpld-gpio.yaml       |   2 +-
 .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++
 .../bindings/hwmon/kontron,sl28cpld-hwmon.yaml     |   2 +-
 .../kontron,sl28cpld-intc.yaml                     |   2 +-
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |  37 +-
 .../devicetree/bindings/mfd/aspeed-lpc.yaml        |   3 +
 .../devicetree/bindings/mfd/fsl,mc13xxx.yaml       | 288 +++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 191 +++++
 Documentation/devicetree/bindings/mfd/mc13xxx.txt  | 156 ----
 .../devicetree/bindings/mfd/qnap,ts433-mcu.yaml    |   4 +
 .../devicetree/bindings/mfd/spacemit,p1.yaml       |  86 ++
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   4 +
 .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 117 +++
 .../devicetree/bindings/mfd/ti,tps6594.yaml        |   1 +
 Documentation/devicetree/bindings/mfd/ti,twl.yaml  | 319 ++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt      |  48 --
 .../devicetree/bindings/misc/aspeed-p2a-ctrl.txt   |  46 -
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   2 +-
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml         |   2 +-
 .../devicetree/bindings/pwm/ti,twl-pwm.txt         |  17 -
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt      |  17 -
 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   4 +-
 .../bindings/sound/google,cros-ec-codec.yaml       |   2 +-
 .../bindings/watchdog/kontron,sl28cpld-wdt.yaml    |   9 +-
 MAINTAINERS                                        |  46 +-
 drivers/char/tpm/Kconfig                           |   9 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm_loongson.c                    |  84 ++
 drivers/crypto/Kconfig                             |   1 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/loongson/Kconfig                    |   5 +
 drivers/crypto/loongson/Makefile                   |   1 +
 drivers/crypto/loongson/loongson-rng.c             | 209 +++++
 drivers/gpio/Kconfig                               |  24 +
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/gpio-max7360.c                        | 257 ++++++
 drivers/gpio/gpio-nct6694.c                        | 499 +++++++++++
 drivers/gpio/gpio-regmap.c                         |  30 +-
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/nct6694-hwmon.c                      | 949 +++++++++++++++++++++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-nct6694.c                   | 196 +++++
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 308 +++++++
 drivers/input/misc/Kconfig                         |  20 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/max7360-rotary.c                | 192 +++++
 drivers/input/misc/mc13783-pwrbutton.c             |   1 -
 drivers/input/misc/tps6594-pwrbutton.c             | 126 +++
 drivers/input/touchscreen/mc13783_ts.c             |   4 -
 drivers/mfd/88pm886.c                              |   1 +
 drivers/mfd/Kconfig                                |  81 +-
 drivers/mfd/Makefile                               |   8 +
 drivers/mfd/adp5585.c                              |   1 -
 drivers/mfd/arizona-irq.c                          |   5 +-
 drivers/mfd/bq257xx.c                              |  99 +++
 drivers/mfd/cs42l43.c                              |  32 +-
 drivers/mfd/da9063-i2c.c                           |  27 +-
 drivers/mfd/exynos-lpass.c                         |   1 -
 drivers/mfd/fsl-imx25-tsadc.c                      |   1 -
 drivers/mfd/intel-lpss-pci.c                       |  13 +
 drivers/mfd/intel_soc_pmic_chtdc_ti.c              |   2 +
 drivers/mfd/kempld-core.c                          |  36 +-
 drivers/mfd/loongson-se.c                          | 253 ++++++
 drivers/mfd/ls2k-bmc-core.c                        | 528 ++++++++++++
 drivers/mfd/macsmc.c                               |   5 +-
 drivers/mfd/madera-core.c                          |   4 +-
 drivers/mfd/max7360.c                              | 171 ++++
 drivers/mfd/max77705.c                             |  35 +-
 drivers/mfd/max8997.c                              |   4 +-
 drivers/mfd/max8998.c                              |   4 +-
 drivers/mfd/mfd-core.c                             |   1 +
 drivers/mfd/nct6694.c                              | 388 +++++++++
 drivers/mfd/qnap-mcu.c                             |  39 +-
 drivers/mfd/rohm-bd71828.c                         |  44 +-
 drivers/mfd/rz-mtu3.c                              |   2 +-
 drivers/mfd/simple-mfd-i2c.c                       |  22 +-
 drivers/mfd/stm32-lptimer.c                        |   1 -
 drivers/mfd/stmpe-i2c.c                            |  14 +-
 drivers/mfd/stmpe-spi.c                            |  14 +-
 drivers/mfd/stmpe.c                                |   3 +
 drivers/mfd/sun4i-gpadc.c                          |   1 -
 drivers/mfd/tps6594-core.c                         |  59 +-
 drivers/mfd/vexpress-sysreg.c                      |  25 +-
 drivers/net/can/usb/Kconfig                        |  11 +
 drivers/net/can/usb/Makefile                       |   1 +
 drivers/net/can/usb/nct6694_canfd.c                | 832 ++++++++++++++++++
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-max7360.c                  | 215 +++++
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bq257xx_charger.c             | 755 ++++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 209 +++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bq257xx-regulator.c              | 186 ++++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-mc13xxx.c                          |  13 -
 drivers/rtc/rtc-nct6694.c                          | 297 +++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/nct6694_wdt.c                     | 307 +++++++
 include/linux/gpio/regmap.h                        |  18 +
 include/linux/mfd/arizona/pdata.h                  |   6 +
 include/linux/mfd/bq257xx.h                        | 104 +++
 include/linux/mfd/loongson-se.h                    |  53 ++
 include/linux/mfd/max7360.h                        | 109 +++
 include/linux/mfd/mc13xxx.h                        |   6 -
 include/linux/mfd/nct6694.h                        | 102 +++
 include/linux/mfd/qnap-mcu.h                       |   2 +
 include/linux/mfd/rohm-bd71828.h                   |  63 ++
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/arizona-jack.c                    |  17 +-
 127 files changed, 9235 insertions(+), 524 deletions(-)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/acer,aspire1-ec.yaml (94%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
 rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
 rename Documentation/devicetree/bindings/{platform/huawei,gaokun-ec.yaml => embedded-controller/huawei,gaokun3-ec.yaml} (97%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (94%)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/lenovo,yoga-c630-ec.yaml (95%)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/microsoft,surface-sam.yaml (92%)
 create mode 100644 Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mc13xxx.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/gpio/gpio-max7360.c
 create mode 100644 drivers/gpio/gpio-nct6694.c
 create mode 100644 drivers/hwmon/nct6694-hwmon.c
 create mode 100644 drivers/i2c/busses/i2c-nct6694.c
 create mode 100644 drivers/input/keyboard/max7360-keypad.c
 create mode 100644 drivers/input/misc/max7360-rotary.c
 create mode 100644 drivers/input/misc/tps6594-pwrbutton.c
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 drivers/mfd/ls2k-bmc-core.c
 create mode 100644 drivers/mfd/max7360.c
 create mode 100644 drivers/mfd/nct6694.c
 create mode 100644 drivers/net/can/usb/nct6694_canfd.c
 create mode 100644 drivers/pinctrl/pinctrl-max7360.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/pwm/pwm-max7360.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 drivers/rtc/rtc-nct6694.c
 create mode 100644 drivers/watchdog/nct6694_wdt.c
 create mode 100644 include/linux/mfd/bq257xx.h
 create mode 100644 include/linux/mfd/loongson-se.h
 create mode 100644 include/linux/mfd/max7360.h
 create mode 100644 include/linux/mfd/nct6694.h

-- 
Lee Jones [李琼斯]

