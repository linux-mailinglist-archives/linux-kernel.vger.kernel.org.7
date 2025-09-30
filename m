Return-Path: <linux-kernel+bounces-837587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816FBACACA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175951C727F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412732F5482;
	Tue, 30 Sep 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KG5npYM6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56F242D97;
	Tue, 30 Sep 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231520; cv=none; b=U8NGIXS0eHBsESpEuLMOnFfuPjtLt9jTL24dXoqtYc3QC39tMdy2neCcXKi2O6A2J8BCNDOO2Dpxzuko1C8nDLxQM0URXPWy1SkqUx+QZh6B3mz8G8i9QjxZeMqYkmV/9UFHbKD0r0+8t/WDUwTxyqP4fgXCfN0BtyZFura0Ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231520; c=relaxed/simple;
	bh=7SubcxjGYV0AISYlk2iMnxIP6fL5kvucfOYBgfqGCnA=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=SNHuqDAUzl7ES/KEkj+LS3AW+/Z/zFmNMoFg9Wdt+HnmOgY7J/ogjEnX1ehCGdyHCQTnXPCKi0csEDLLHl09xWN/A0gy6dyoocXP804Rz2qhIRvOsIOf1uPEJtVAhJlIBw3NokS3MBie3UesHKPvf3g7MSLPqCjlaV1AUuYzfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KG5npYM6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759231518; x=1790767518;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7SubcxjGYV0AISYlk2iMnxIP6fL5kvucfOYBgfqGCnA=;
  b=KG5npYM6G1oZwdeV1/I7jHMe0R5Wss+U0dRoDPbog3HA1zRIVWxNt30k
   eRiMo5bPdGeyDAC//1+DeODhag73HDc1NIETMDxdyW/vDmZ5x7kj1sBVF
   9RLhqnwjbGMKxQN9BMmWUr/60XkFTyGYBQW5P/fUE1sVJ4qc5DXA1YBWJ
   k/8u20lDzBGSjfyLOSN4DSPG66VUdZb5rsRLNLQMOaFx5shn3jkH8Vin/
   DB7Cmjw9FkjupgNb8beziTbEjAbJRRICc9rck00y/YViEQGRlpAV6qK0T
   GCkAZV+2IREZnrou4Z2DHM56TyXsaaa1canxAU+JywHDPwaSkg00a53F+
   w==;
X-CSE-ConnectionGUID: fn0tT83GQaGTrtNXf5gKWA==
X-CSE-MsgGUID: iUnOlsLDSqu6qFKwsuCoEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61593237"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61593237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:25:17 -0700
X-CSE-ConnectionGUID: VN50afsbQL+AFLoPklN3Dw==
X-CSE-MsgGUID: GzTZk/HASlu+VzuAf1F9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="209210887"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:25:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Tue, 30 Sep 2025 14:13:25 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.18-1
Message-ID: <pdx86-pr-20250930141325-34954370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.18.

There's one-liner change into sound/ due to x86-android-tables moving away
from using GPIO legacy APIs which changes the name of a SPI/codec device.

Highlights

- amd/pmf:

  - Add support for adjusting PMF PPT and PPT APU thresholds

  - Extend custom BIOS inputs for more policies

  - Update ta_pmf_action structure to the latest PMF TA

- arm64: thinkpad-t14s-ec: Add EC driver for ThinkPad T14s Gen6 Snapdragon

- int3472: Increase handshake GPIO delay

- intel/pmc:

  - SSRAM support for Lunar Lake and Panther Lake

  - Support reading substate requirements data from S0ix blockers
    (for platforms starting from Panther Lake)

  - Wildcat Lake support

- intel-uncore-freq:

  - Solve duplicate sysfs entry warnings

  - Present unique domain ID per package

- portwell-ec:

  - Support suspend/resume

  - Add hwmon support for voltage and temperature

- redmi-wmi: Add WMI driver for Redmibook keyboard

- think-lmi Certificate support for ThinkCenter

- x86-android-tables + others: Convert away from legacy GPIO APIs

- x86-android-tables:

  - Add support for Acer A1-840 tablet

  - Fix modules list for Lenovo devices

  - Stop using EPROBE_DEFER

- Miscellaneous cleanups / refactoring / improvements

Regards, i.


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-1

for you to fetch changes up to b8754092dfed4fc2fcdb0de32a029ba8f9b464b6:

  platform/x86: pcengines-apuv2: Use static device properties (2025-09-26 14:26:48 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.18-1

Highlights

- amd/pmf:

  - Add support for adjusting PMF PPT and PPT APU thresholds

  - Extend custom BIOS inputs for more policies

  - Update ta_pmf_action structure to the latest PMF TA

- arm64: thinkpad-t14s-ec: Add EC driver for ThinkPad T14s Gen6 Snapdragon

- int3472: Increase handshake GPIO delay

- intel/pmc:

  - SSRAM support for Lunar Lake and Panther Lake

  - Support reading substate requirements data from S0ix blockers
    (for platforms starting from Panther Lake)

  - Wildcat Lake support

- intel-uncore-freq:

  - Solve duplicate sysfs entry warnings

  - Present unique domain ID per package

- portwell-ec:

  - Support suspend/resume

  - Add hwmon support for voltage and temperature

- redmi-wmi: Add WMI driver for Redmibook keyboard

- think-lmi Certificate support for ThinkCenter

- x86-android-tables + others: Convert away from legacy GPIO APIs

- x86-android-tables:

  - Add support for Acer A1-840 tablet

  - Fix modules list for Lenovo devices

  - Stop using EPROBE_DEFER

- Miscellaneous cleanups / refactoring / improvements

The following is an automated shortlog grouped by driver:

Add WMI driver for Redmibook keyboard:
 - Add WMI driver for Redmibook keyboard

amd/hsmp:
 -  Replace dev_err() with dev_info() for non-fatal errors

amd/pmf:
 -  Add custom BIOS input support for AMD_CPU_ID_PS
 -  Add debug logs for pending requests and custom BIOS inputs
 -  Add helper to verify BIOS input notifications are enable/disable
 -  Add support for adjusting PMF PPT and PPT APU thresholds
 -  Call enact function sooner to process early pending requests
 -  Extend custom BIOS inputs for more policies
 -  Fix the custom bios input handling mechanism
 -  Preserve custom BIOS inputs for evaluating the policies
 -  Remove redundant ternary operators
 -  Update ta_pmf_action structure member

arm64: dts: qcom: x1e80100-t14s:
 -  add EC

arm64: thinkpad-t14s-ec:
 -  new driver

barco-p50-gpio:
 -  use software nodes for gpio-leds/keys

dell_rbu:
 -  fix assignment in if condition warning

dt-bindings: embedded-controller:
 -  Add Lenovo Thinkpad T14s EC

int3472:
 -  Convert int3472_gpio_map to use C99 initializers
 -  Increase ov08x40 handshake GPIO delay to 45 ms
 -  Rework regulator enable-time handling

intel/pmc:
 -  Add Wildcat Lake support to intel_pmc_core
 -  Add Wildcat Lake support to Intel PMC SSRAM Telemetry
 -  Enable SSRAM support for Lunar Lake
 -  Enable SSRAM support for Panther Lake
 -  Improve function to show substate header
 -  Move telemetry endpoint register handling
 -  Replace dev_warn() with dev_dbg()
 -  Show substate requirement for S0ix blockers
 -  use kcalloc() instead of kzalloc()

intel-uncore-freq:
 -  Fix warning in partitioned system
 -  Present unique domain ID per package

meraki-mx100:
 -  Use static device properties

pcengines-apuv2:
 -  Use static device properties

portwell-ec:
 -  Add hwmon support for voltage and temperature
 -  Add suspend/resume support for watchdog
 -  don't print superfluous errors

quickstart:
 -  Use devm_mutex_init()

think-lmi:
 -  Add certificate GUID structure
 -  Add extra TC BIOS error messages
 -  Certificate support for ThinkCenter

wmi-capdata01:
 -  Remove unneeded semicolon

x86-android-tablets:
 -  Add support for Acer A1-840 tablet
 -  convert EDT devices to GPIO references
 -  convert Goodix devices to GPIO references
 -  convert gpio_keys devices to GPIO references
 -  convert HiDeep devices to GPIO references
 -  convert HID-I2C devices to GPIO references
 -  convert int3496 devices to GPIO references
 -  convert Novatek devices to GPIO references
 -  convert Wacom devices to GPIO references
 -  convert wm1502 devices to GPIO references
 -  convert Yoga Tab2 fast charger to GPIO references
 -  Fix modules lists for Lenovo devices
 -  Move Acer info to its own file
 -  remove support for GPIO lookup tables
 -  Remove the use of dev_err_probe()
 -  replace bat_swnode with swnode_group
 -  Simplify lenovo_yoga_tab2_830_1050_exit()
 -  Simplify node-group [un]registration
 -  Stop using EPROBE_DEFER
 -  Update my email address
 -  use swnode_group instead of manual registering

xiaomi-wmi:
 -  Use devm_mutex_init()

----------------------------------------------------------------
Chen Ni (1):
      platform/x86: wmi-capdata01: Remove unneeded semicolon

Christophe JAILLET (2):
      platform/x86: xiaomi-wmi: Use devm_mutex_init()
      platform/x86: quickstart: Use devm_mutex_init()

Darshan Rathod (1):
      platform/x86: dell_rbu: fix assignment in if condition warning

Dmitry Torokhov (14):
      platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
      platform/x86: x86-android-tablets: convert Wacom devices to GPIO references
      platform/x86: x86-android-tablets: convert HiDeep devices to GPIO references
      platform/x86: x86-android-tablets: convert Novatek devices to GPIO references
      platform/x86: x86-android-tablets: convert EDT devices to GPIO references
      platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
      platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
      platform/x86: x86-android-tablets: convert HID-I2C devices to GPIO references
      platform/x86: x86-android-tablets: convert Yoga Tab2 fast charger to GPIO references
      platform/x86: x86-android-tablets: remove support for GPIO lookup tables
      platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references
      platform/x86: barco-p50-gpio: use software nodes for gpio-leds/keys
      platform/x86: meraki-mx100: Use static device properties
      platform/x86: pcengines-apuv2: Use static device properties

Gladyshev Ilya (1):
      platform/x86: Add WMI driver for Redmibook keyboard

Hans de Goede (12):
      platform/x86: int3472: Convert int3472_gpio_map to use C99 initializers
      platform/x86: int3472: Rework regulator enable-time handling
      platform/x86: int3472: Increase ov08x40 handshake GPIO delay to 45 ms
      platform/x86: x86-android-tablets: replace bat_swnode with swnode_group
      platform/x86: x86-android-tablets: use swnode_group instead of manual registering
      platform/x86: x86-android-tablets: Simplify node-group [un]registration
      platform/x86: x86-android-tablets: Update my email address
      platform/x86: x86-android-tablets: Move Acer info to its own file
      platform/x86: x86-android-tablets: Add support for Acer A1-840 tablet
      platform/x86: x86-android-tablets: Simplify lenovo_yoga_tab2_830_1050_exit()
      platform/x86: x86-android-tablets: Fix modules lists for Lenovo devices
      platform/x86: x86-android-tablets: Stop using EPROBE_DEFER

Liao Yuanhong (1):
      platform/x86/amd/pmf: Remove redundant ternary operators

Mark Pearson (3):
      platform/x86: think-lmi: Add certificate GUID structure
      platform/x86: think-lmi: Certificate support for ThinkCenter
      platform/x86: think-lmi: Add extra TC BIOS error messages

Qianfeng Rong (1):
      platform/x86/intel/pmc: use kcalloc() instead of kzalloc()

Sebastian Reichel (3):
      dt-bindings: embedded-controller: Add Lenovo Thinkpad T14s EC
      platform: arm64: thinkpad-t14s-ec: new driver
      arm64: dts: qcom: x1e80100-t14s: add EC

Shyam Sundar S K (9):
      platform/x86/amd/pmf: Add support for adjusting PMF PPT and PPT APU thresholds
      platform/x86/amd/pmf: Fix the custom bios input handling mechanism
      platform/x86/amd/pmf: Extend custom BIOS inputs for more policies
      platform/x86/amd/pmf: Update ta_pmf_action structure member
      platform/x86/amd/pmf: Add helper to verify BIOS input notifications are enable/disable
      platform/x86/amd/pmf: Add custom BIOS input support for AMD_CPU_ID_PS
      platform/x86/amd/pmf: Preserve custom BIOS inputs for evaluating the policies
      platform/x86/amd/pmf: Call enact function sooner to process early pending requests
      platform/x86/amd/pmf: Add debug logs for pending requests and custom BIOS inputs

Srinivas Pandruvada (2):
      platform/x86/intel-uncore-freq: Fix warning in partitioned system
      platform/x86/intel-uncore-freq: Present unique domain ID per package

Suma Hegde (1):
      platform/x86/amd/hsmp: Replace dev_err() with dev_info() for non-fatal errors

Wolfram Sang (1):
      platform/x86: portwell-ec: don't print superfluous errors

Xi Pardee (8):
      platform/x86/intel/pmc: Add Wildcat Lake support to Intel PMC SSRAM Telemetry
      platform/x86/intel/pmc: Add Wildcat Lake support to intel_pmc_core
      platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
      platform/x86:intel/pmc: Move telemetry endpoint register handling
      platform/x86:intel/pmc: Improve function to show substate header
      platform/x86:intel/pmc: Show substate requirement for S0ix blockers
      platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
      platform/x86:intel/pmc: Replace dev_warn() with dev_dbg()

Xichao Zhao (1):
      platform/x86: x86-android-tablets: Remove the use of dev_err_probe()

Yen-Chi Huang (2):
      platform/x86: portwell-ec: Add suspend/resume support for watchdog
      platform/x86: portwell-ec: Add hwmon support for voltage and temperature

 .../lenovo,thinkpad-t14s-ec.yaml                   |  50 ++
 MAINTAINERS                                        |  12 +
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  24 +
 drivers/platform/arm64/Kconfig                     |  20 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-thinkpad-t14s.c      | 616 +++++++++++++++++++++
 drivers/platform/x86/Kconfig                       |  12 +
 drivers/platform/x86/Makefile                      |   1 +
 drivers/platform/x86/amd/hsmp/acpi.c               |   4 +-
 drivers/platform/x86/amd/hsmp/plat.c               |   4 +-
 drivers/platform/x86/amd/pmf/acpi.c                |  87 ++-
 drivers/platform/x86/amd/pmf/pmf.h                 |  77 ++-
 drivers/platform/x86/amd/pmf/spc.c                 |  80 ++-
 drivers/platform/x86/amd/pmf/sps.c                 |   2 +-
 drivers/platform/x86/amd/pmf/tee-if.c              |  22 +-
 drivers/platform/x86/barco-p50-gpio.c              | 104 ++--
 drivers/platform/x86/dell/dell_rbu.c               |   8 +-
 drivers/platform/x86/intel/int3472/discrete.c      |  58 +-
 drivers/platform/x86/intel/pmc/Makefile            |   2 +-
 drivers/platform/x86/intel/pmc/arl.c               |   4 +
 drivers/platform/x86/intel/pmc/core.c              | 185 +++++--
 drivers/platform/x86/intel/pmc/core.h              |  27 +
 drivers/platform/x86/intel/pmc/lnl.c               |  18 +
 drivers/platform/x86/intel/pmc/mtl.c               |   2 +
 drivers/platform/x86/intel/pmc/ptl.c               |  37 +-
 drivers/platform/x86/intel/pmc/ssram_telemetry.c   |   1 +
 drivers/platform/x86/intel/pmc/tgl.c               |   4 +-
 drivers/platform/x86/intel/pmc/wcl.c               | 486 ++++++++++++++++
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |  76 ++-
 drivers/platform/x86/lenovo/think-lmi.c            |  94 +++-
 drivers/platform/x86/lenovo/think-lmi.h            |  14 +
 drivers/platform/x86/lenovo/wmi-capdata01.c        |   2 +-
 .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |   5 +
 drivers/platform/x86/meraki-mx100.c                | 404 +++++++++-----
 drivers/platform/x86/pcengines-apuv2.c             | 192 ++++---
 drivers/platform/x86/portwell-ec.c                 | 194 ++++++-
 drivers/platform/x86/quickstart.c                  |  10 +-
 drivers/platform/x86/redmi-wmi.c                   | 130 +++++
 drivers/platform/x86/x86-android-tablets/Makefile  |   2 +-
 drivers/platform/x86/x86-android-tablets/acer.c    | 247 +++++++++
 drivers/platform/x86/x86-android-tablets/asus.c    | 108 ++--
 drivers/platform/x86/x86-android-tablets/core.c    | 121 ++--
 drivers/platform/x86/x86-android-tablets/dmi.c     |  12 +-
 drivers/platform/x86/x86-android-tablets/lenovo.c  | 291 +++++-----
 drivers/platform/x86/x86-android-tablets/other.c   | 334 ++++-------
 .../x86/x86-android-tablets/shared-psy-info.c      |  34 +-
 .../x86/x86-android-tablets/shared-psy-info.h      |   8 +-
 .../x86/x86-android-tablets/vexia_atla10_ec.c      |   2 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |  28 +-
 drivers/platform/x86/xiaomi-wmi.c                  |  10 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |   2 +-
 51 files changed, 3383 insertions(+), 885 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/lenovo,thinkpad-t14s-ec.yaml
 create mode 100644 drivers/platform/arm64/lenovo-thinkpad-t14s.c
 create mode 100644 drivers/platform/x86/intel/pmc/wcl.c
 create mode 100644 drivers/platform/x86/redmi-wmi.c
 create mode 100644 drivers/platform/x86/x86-android-tablets/acer.c

