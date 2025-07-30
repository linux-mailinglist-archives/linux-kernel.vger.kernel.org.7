Return-Path: <linux-kernel+bounces-750960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D665B1635C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C93A9818
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521A2DC35C;
	Wed, 30 Jul 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7IJN0k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC2DC349
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888134; cv=none; b=KLUztAW0pcXcjKCsDKwInK/2/zKsXbWwj0xQgddbGKFB/zaFgD6XS47uh/ioFm/4VDd+YQUm5lVahB3iteyVN1HK+jdD4QSbbE27RGDECFsSf6/ryI2m7O1QiufqzEFf8mTiKPjmhkzwCMduIyV07hW7IELAn1Eqsd0MfAjtyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888134; c=relaxed/simple;
	bh=3O1qpyxUPOt3p6ij40XinQth6bajgkyKIfKL0uH2NPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E4eH04Vul6PK0HuaYuRDkNzjlLiNI4xIReObgMhxfYA4WlEMtwn5PPMqIz9w2V7jp00sYpXO/Z+wJl+jBC1xSSJasxuanuEKYe1JQ6/3T9p6bvDbDQlNsmtUXBg48HuAtc3twoWBpFFO72xqv76ZrE06EX429h4lgm9t5TnyQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7IJN0k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC4C4CEE3;
	Wed, 30 Jul 2025 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888134;
	bh=3O1qpyxUPOt3p6ij40XinQth6bajgkyKIfKL0uH2NPg=;
	h=Date:From:To:Cc:Subject:From;
	b=b7IJN0k2MN90sIlfGiu/snb2CDHw7/0k87cd+u0Z1273YCtUwXqpSXOA5f93Fe2bD
	 hNhZ1r4YNqTcVKChCoLyN8MsTBPSh3vVNQu5kmGsH53A+AuSGSy5UW9bRNyM4321OA
	 yuzeoDT0BdiuhoIHWw0zSb1c0BZStzVEdKcuWyCElCI0sb6HWBHDMb8wDbxuF8un0w
	 8Rl9TDp0hIMNu0IyRJIaQTy58KyS8RZ2j1g01rEyzbc4VIbbRUWQktSb0ddS24+pXr
	 FvxU33l82JOEKTDOL7O/gtpcRE1/VVzUd7KMeH6oX/klib4MWwNYFf5JRzRIXx0bR2
	 bHAF6aCvv57yQ==
Date: Wed, 30 Jul 2025 16:08:50 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.17
Message-ID: <20250730150850.GB6782@google.com>
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

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.17

for you to fetch changes up to 006aa8f57f55dd5bf68c4ada1e0d3f4e59027d71:

  mfd: dt-bindings: Convert TPS65910 to DT schema (2025-07-30 08:16:45 +0100)

----------------------------------------------------------------
MFD for v6.17

- New Support & Features
  * Add extensive support for the Analog Devices ADP5589 I/O expander, including
    core MFD, GPIO, PWM, and a new keypad matrix input driver. This also adds
    support for handling various events including GPI, keypad, reset and unlock
    ev ents.
  * Add support for the TI TPS652G1 PMIC, a stripped-down version of the TPS65224,
    including core MFD, PFSM, pinctrl, and GPIO support.
  * Add support for the Apple Silicon System Management Controller (SMC), including
    the core MFD driver which handles the RTKit-based protocol, a new GPIO driver
    for PMU GPIOs, and a new reboot/power-off driver.

- Improvements & Fixes
  * Dynamically add ADP5585 sub-devices based on device tree properties.
  * Move ADP5585 oscillator control from the child PWM driver to the main MFD
    driver to better handle shared resources.
  * Add support for a hardware reset pin and VDD regulator to the ADP5585 driver.
  * Update the TPS65219 MFD cell's GPIO compatible string for the TPS65214 to
    reflect hardware capabilities correctly.
  * Separate the ChromeOS EC charge-control probing from the USB-PD subsystem,
    allowing it to probe independently based on the dedicated EC_FEATURE_CHARGER.
  * Fix an interrupt naming typo in the MT6370 driver.
  * Fix RK806 PMIC reset behavior by allowing the reset mode to be customized via a
    new device tree property.
  * Fix AXP20X regulator cell ID conflicts for secondary PMICs on boards without an
    IRQ line connected.
  * Fix MT6397 keypad sub-device creation to use specific names instead of a
    generic one, ensuring correct driver binding.
  * Fix a build warning in the stm32-timers driver by adding a missing include for
    export.h.

- Cleanups & Refactoring
  * Refactor the ADP5585 driver to simplify how regmap defaults are handled, making
    it easier to add new chip variants.
  * Introduce per-chip register map structures for the ADP5585/ADP5589 family to
    handle differences between the devices.
  * Convert several drivers to use dev_fwnode() instead of of_fwnode_handle().
  * Make various static structures const in the cs40l50, rohm-bd71828, tps65219,
    and twl6040 drivers.
  * Remove redundant pm_runtime_mark_last_busy() calls from several drivers.
  * Alphabetize Kconfig entries for Cirrus Logic and Maxim drivers.
  * Remove unused fields from the 'tps65219' struct.
  * Update several MFD-related headers to follow the 'Include What You Use' (IWYU)
    principle.

- Removals
  * Remove the old, platform-data-based adp5589-keys input driver, which is now
    superseded by the new MFD-based adp5585-keys driver.
  * Remove the unused twl6030_mmc_card_detect() functions and associated header
    declarations.
  * Remove the now unused pcf50633/core.h header file.
  * Remove the fsl,imx8qxp-csr device tree binding, which was being used
    incorrectly.

- Device Tree Bindings Updates
  * Add support for the Analog Devices ADP5589 I/O expander to the adi,adp5585.yaml
    binding.
  * Add new properties to the adi,adp5585.yaml binding for input events, including
    keypad pins, unlock events, and reset events.
  * Add a reset-gpios property to the adi,adp5585.yaml binding.
  * Add the TI TPS652G1 PMIC to the ti,tps6594.yaml binding.
  * Add new bindings for the Apple Mac System Management Controller (SMC) and its
    sub-devices: apple,smc.yaml, apple,smc-gpio.yaml, and apple,smc-reboot.yaml.
  * Convert the Freescale MXS LRADC binding (mxs-lradc) to YAML schema format.
  * Convert and combine the NXP LPC1850 CREG, DMAMUX, and USB OTG PHY bindings into
    a single YAML schema file.
  * Convert the TI TPS65910 binding to YAML schema format.
  * Add a comment to the samsung,s2mps11.yaml binding to clarify the use of 'oneOf'
    for interrupt properties.
  * Add the rockchip,reset-mode property to the rockchip,rk806.yaml binding to
    allow customization of the PMIC's reset behavior.

----------------------------------------------------------------
André Draszik (1):
      dt-bindings: mfd: samsung,s2mps11: Add comment about interrupts properties

Andy Shevchenko (4):
      mfd: davinci_voicecodec: Don't use "proxy" headers
      mfd: wm8350-core: Don't use "proxy" headers
      mfd: madera: Don't use "proxy" headers
      mfd: syscon: atmel-smc: Don't use "proxy" headers

Antonio Borneo (1):
      mfd: stm32-timers: Fix build warnings about export.h

Charles Keepax (1):
      mfd: Minor Cirrus/Maxim Kconfig order fixes

Chen-Yu Tsai (2):
      mfd: axp20x: Set explicit ID for AXP313 regulator
      mfd: axp20x: Set explicit ID for regulator cell if no IRQ line is present

ChiYuan Huang (1):
      mfd: mt6370: Fix the interrupt naming typo

Christophe JAILLET (4):
      mfd: rohm-bd71828: Constify some structures
      mfd: tps65219: Constify struct regmap_irq_sub_irq_map and tps65219_chip_data
      mfd: tps65219: Remove an unused field from 'struct tps65219'
      mfd: tps65219: Remove another unused field from 'struct tps65219'

Dario Binacchi (1):
      dt-bindings: mfd: convert mxs-lradc bindings to json-schema

Dmitry Torokhov (1):
      mfd: mt6397: Do not use generic name for keypad sub-devices

Dr. David Alan Gilbert (2):
      mfd: twl6030-irq: Remove unused twl6030_mmc_card_detect*
      mfd: pcf50633: Remove the header file core.h

Frank Li (1):
      dt-bindings: mfd: Convert lpc1850-creg-clk, pc1850-dmamux and phy-lpc18xx-usb-otg to YAML format

Hector Martin (2):
      gpio: Add new gpio-macsmc driver for Apple Macs
      power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC

Jiri Slaby (SUSE) (1):
      mfd: Use dev_fwnode() instead of of_fwnode_handle()

Krzysztof Kozlowski (1):
      mfd: Constify reg_sequence and regmap_irq

Lee Jones (1):
      Merge branches 'ib-mfd-gpio-input-pwm-6.17', 'ib-mfd-gpio-power-soc-6.17' and 'ib-mfd-misc-pinctrl-6.17' into ibs-for-mfd-merged

Liu Ying (1):
      dt-bindings: mfd: fsl,imx8qxp-csr: Remove binding documentation

Michael Walle (4):
      mfd: tps6594: Add TI TPS652G1 support
      misc: tps6594-pfsm: Add TI TPS652G1 PMIC PFSM
      pinctrl: pinctrl-tps6594: Add TPS652G1 PMIC pinctrl and GPIO
      dt-bindings: mfd: ti,tps6594: Add TI TPS652G1 PMIC

Nuno Sá (20):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: Only add devices given in FW
      mfd: adp5585: Enable oscillator during probe
      mfd: adp5585: Make use of MFD_CELL_NAME()
      dt-bindings: mfd: adp5585: document adp5589 I/O expander
      mfd: adp5585: Refactor how regmap defaults are handled
      mfd: adp5585: Add support for adp5589
      mfd: adp5585: Add a per chip reg struture
      gpio: adp5585: add support for the adp5589 expander
      pwm: adp5585: add support for adp5589
      dt-bindings: mfd: adp5585: add properties for input events
      mfd: adp5585: Add support for event handling
      mfd: adp5585: Support reset and unlock events
      mfd: adp5585: Add support for input devices
      gpio: adp5585: support gpi events
      Input: adp5585: Add Analog Devices ADP5585/89 support
      Input: adp5589: remove the driver
      mfd: adp5585: Support getting vdd regulator
      dt-bindings: mfd: adp5585: document reset gpio
      mfd: adp5585: Add support for a reset pin

Quentin Schulz (2):
      dt-bindings: mfd: rk806: Allow to customize PMIC reset mode
      mfd: rk8xx-core: Allow to customize RK806 reset mode

Russell King (Oracle) (2):
      dt-bindings: gpio: Add Apple Mac SMC GPIO block
      dt-bindings: mfd: Add Apple Mac System Management Controller

Sakari Ailus (1):
      mfd: Remove redundant pm_runtime_mark_last_busy() calls

Shree Ramamoorthy (2):
      mfd: tps65219: Update TPS65214 MFD cell's GPIO compatible string
      mfd: dt-bindings: Convert TPS65910 to DT schema

Sven Peter (3):
      dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
      soc: apple: rtkit: Make shmem_destroy optional
      mfd: Add Apple Silicon System Management Controller

Thomas Weißschuh (1):
      mfd: cros_ec: Separate charge-control probing from USB-PD

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml        |    7 +-
 .../devicetree/bindings/clock/lpc1850-creg-clk.txt |   52 -
 .../devicetree/bindings/dma/lpc1850-dmamux.txt     |   54 -
 .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |   29 +
 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/mfd/apple,smc.yaml         |   79 ++
 .../devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml   |  192 ----
 .../devicetree/bindings/mfd/mxs-lradc.txt          |   45 -
 .../devicetree/bindings/mfd/mxs-lradc.yaml         |  134 +++
 .../devicetree/bindings/mfd/nxp,lpc1850-creg.yaml  |  148 +++
 .../devicetree/bindings/mfd/rockchip,rk806.yaml    |   21 +
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |    3 +
 .../devicetree/bindings/mfd/ti,tps65910.yaml       |  318 ++++++
 .../devicetree/bindings/mfd/ti,tps6594.yaml        |    1 +
 Documentation/devicetree/bindings/mfd/tps65910.txt |  205 ----
 .../bindings/phy/phy-lpc18xx-usb-otg.txt           |   26 -
 .../bindings/power/reset/apple,smc-reboot.yaml     |   40 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    8 +
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-adp5585.c                        |  364 ++++++-
 drivers/gpio/gpio-macsmc.c                         |  292 ++++++
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  371 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/Kconfig                                |  114 ++-
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/ab8500-core.c                          |    3 +-
 drivers/mfd/adp5585.c                              |  739 +++++++++++++-
 drivers/mfd/arizona-irq.c                          |    1 -
 drivers/mfd/atmel-smc.c                            |    9 +-
 drivers/mfd/axp20x.c                               |    8 +-
 drivers/mfd/cros_ec_dev.c                          |   10 +-
 drivers/mfd/cs40l50-core.c                         |    3 +-
 drivers/mfd/cs42l43.c                              |    1 -
 drivers/mfd/fsl-imx25-tsadc.c                      |    4 +-
 drivers/mfd/lp8788-irq.c                           |    2 +-
 drivers/mfd/macsmc.c                               |  498 +++++++++
 drivers/mfd/mt6358-irq.c                           |    3 +-
 drivers/mfd/mt6370.c                               |    2 +-
 drivers/mfd/mt6370.h                               |    2 +-
 drivers/mfd/mt6397-core.c                          |   12 +-
 drivers/mfd/mt6397-irq.c                           |    4 +-
 drivers/mfd/qcom-pm8xxx.c                          |    4 +-
 drivers/mfd/rk8xx-core.c                           |   12 +
 drivers/mfd/rohm-bd71828.c                         |   12 +-
 drivers/mfd/stm32-timers.c                         |    1 +
 drivers/mfd/stmfx.c                                |    5 +-
 drivers/mfd/tps65217.c                             |    4 +-
 drivers/mfd/tps65219.c                             |   17 +-
 drivers/mfd/tps6586x.c                             |    6 +-
 drivers/mfd/tps6594-core.c                         |   88 +-
 drivers/mfd/tps6594-i2c.c                          |   10 +-
 drivers/mfd/tps6594-spi.c                          |   10 +-
 drivers/mfd/twl6030-irq.c                          |   79 +-
 drivers/mfd/twl6040.c                              |    2 +-
 drivers/mfd/wm831x-irq.c                           |   10 +-
 drivers/misc/tps6594-pfsm.c                        |   31 +-
 drivers/pinctrl/pinctrl-tps6594.c                  |   35 +
 drivers/power/reset/Kconfig                        |    9 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/macsmc-reboot.c                |  290 ++++++
 drivers/pwm/pwm-adp5585.c                          |   78 +-
 drivers/soc/apple/rtkit.c                          |    3 +-
 include/linux/mfd/adp5585.h                        |  118 ++-
 include/linux/mfd/davinci_voicecodec.h             |    8 +-
 include/linux/mfd/macsmc.h                         |  279 +++++
 include/linux/mfd/madera/pdata.h                   |    3 +-
 include/linux/mfd/pcf50633/core.h                  |  229 -----
 include/linux/mfd/rk808.h                          |    2 +
 include/linux/mfd/syscon/atmel-smc.h               |    8 +-
 include/linux/mfd/tps65219.h                       |    5 -
 include/linux/mfd/tps6594.h                        |    1 +
 include/linux/mfd/twl.h                            |   21 -
 include/linux/mfd/wm8350/core.h                    |   10 +-
 77 files changed, 4286 insertions(+), 2253 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/apple,smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,lpc1850-creg.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65910.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 create mode 100644 drivers/gpio/gpio-macsmc.c
 create mode 100644 drivers/input/keyboard/adp5585-keys.c
 delete mode 100644 drivers/input/keyboard/adp5589-keys.c
 create mode 100644 drivers/mfd/macsmc.c
 create mode 100644 drivers/power/reset/macsmc-reboot.c
 create mode 100644 include/linux/mfd/macsmc.h
 delete mode 100644 include/linux/mfd/pcf50633/core.h
 
-- 
Lee Jones [李琼斯]

