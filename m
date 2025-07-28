Return-Path: <linux-kernel+bounces-747938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1FB13A72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED573AD6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C7264630;
	Mon, 28 Jul 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moTTfd+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E6263F34
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705474; cv=none; b=HzOnunWpULRWyjV7vGfKzKaUlLJChtR+EK4gwRfa2cfL6xlIIc1m8Q0Hz1lGdrS6lPFO5LKIP5NHbCpSa1XjTgfL48hSeFwscLVwlEEbb0zp8zuv5oaISu+Uk6YwDf2UlnN2thSHN2GUIYyLrIYShwgUTHkIW5H7NHI8AvVKTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705474; c=relaxed/simple;
	bh=3wfX7LOWDn+/a+ynSS4YsFbqvDCu6ZVRm+uCK7FhuAM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=rgJalggKI/09K5lpnWKmxZYg+G6P/6ylzPIlEENHChMDLCkA+udcryZ7FXWDBDoo6B3fQ/Eq32YFMURMWA13wZLGhbuKY742MDAOa7f3YfVDdS5U1/YTJ+J/yu+72rX759XUJcVkx56k68mQAX+/ZLHLPTRPxrS5b3KpR6FNT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moTTfd+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F8CC4CEE7;
	Mon, 28 Jul 2025 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753705474;
	bh=3wfX7LOWDn+/a+ynSS4YsFbqvDCu6ZVRm+uCK7FhuAM=;
	h=From:To:Cc:Subject:Date:From;
	b=moTTfd+KDSKl1/GKsRGQQFhHVSxYyAjM4I8f4QLM1i5ZS3wUYkwh8swRJ6OD4siOw
	 q9wCSN4ueLFdIjkGgYe0yfa7/bso4Dctt3GQpvpRRqyZE5EdpyftNenTB/5dIMp8LJ
	 W0gUu05pyVa3ezDhYVP/M7oxR4E/SFvqrxX7n33dW00nZcbRsioD5uSzD0QpndDDct
	 1dj+W9iqbOQWg8ssRK2qpT6k/OSqylo7N6DuwnBzc/MHNPAo3vV4ZEkUrPEWXEvYRY
	 neN4aG0dmlFhUQo8BCYUyGBdS3S3TRy9YJxARTFwkuvROg2Nwt1ClmP1O7CS4KhHnh
	 JeIEEEwesZewA==
Message-ID: <a887f34ce497dc8d6b92f087e3cc3a65.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.17
Date: Mon, 28 Jul 2025 13:24:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.17

for you to fetch changes up to 0bd042ae771d61ef7ccd5882f7aeca59a25f71d9:

  regulator: mt6370: Fix spelling mistake in mt6370_regualtor_register (2025-07-24 18:04:38 +0100)

----------------------------------------------------------------
regulator: Updates for v6.17

The big change in this release is the addition of Rust bindings from
Daniel Almeida, allowing fairly basic consumer use with support for
enable and voltage setting operations.  This should be good for the vast
majority of consumers.  Otherwise it's been quite quiet, a few new
devices supported, plus some cleanups and fixes.

 - Basic Rust bindings.
 - A fix for making large voltage changes on regulators where we limit
   the size of voltage change we will do in one step, previously we just
   got as close as we could in one step.
 - Cleanups of our usage of the PM autosuspend functions, this pulls in
   some PM core changes on a shared tag.
 - Mode setting support for PCA9450.
 - Support for Mediatek MT6893 and MT8196 DVFSRC, Qualcomm PM7550 and
   PMR735B, Raspberry Pi displays and TI TPS652G1.

The TI driver pulls in the MFD portion of the support for the device and
the pinctrl driver which was in the same tag.

----------------------------------------------------------------
Andy Shevchenko (1):
      regulator: core: Don't use "proxy" headers

AngeloGioacchino Del Regno (4):
      dt-bindings: regulator: mediatek-dvfsrc: Add MT6893 support
      regulator: mtk-dvfsrc: Add support for Dimensity 1200 MT6893
      dt-bindings: regulator: mediatek-dvfsrc: Add MT8196 support
      regulator: mtk-dvfsrc: Add support for MediaTek MT8196 DVFSRC

Christophe JAILLET (2):
      regulator: tps6594-regulator: Constify struct tps6594_regulator_irq_type
      regulator: tps6594-regulator: Remove a useless static qualifier

Colin Ian King (2):
      regulator: Kconfig: Fix spelling mistake "regualtor" -> "regulator"
      regulator: mt6370: Fix spelling mistake in mt6370_regualtor_register

Daniel Almeida (2):
      rust: regulator: add a bare minimum regulator abstraction
      MAINTAINERS: add regulator.rs to the regulator API entry

Dave Stevenson (2):
      regulator: rpi-panel-v2: Add regulator for 7" Raspberry Pi 720x1280
      regulator: rpi-panel-v2: Add shutdown hook

Jeff Chang (1):
      regulator: rt6160: Add rt6166 vout min_uV setting for compatible

Jisheng Zhang (5):
      regulator: rt5739: Enable REGCACHE_MAPLE
      regulator: tps6287x-regulator: Enable REGCACHE_MAPLE
      regulator: tps6286x-regulator: Enable REGCACHE_MAPLE
      regulator: sy8827n: make enable gpio NONEXCLUSIVE
      regulator: tps6286x-regulator: Fix a copy & paste error

Luca Weiss (4):
      regulator: dt-bindings: qcom,rpmh: Add PM7550 compatible
      regulator: dt-bindings: qcom,rpmh: Add PMR735B compatible
      regulator: qcom-rpmh: add support for pmr735b regulators
      regulator: qcom-rpmh: add support for pm7550 regulators

Marek Vasut (3):
      regulator: dt-bindings: rpi-panel: Add regulator for 7" Raspberry Pi 720x1280
      regulator: rpi-panel-v2: Add missing GPIOLIB dependency
      regulator: rpi-panel-v2: Fix missing OF dependency

Mark Brown (5):
      regulator: dvfsrc: Add support for MT8196 and
      treewide: Remove redundant
      regulator: Merge tps6594 driver changes
      Add RPMh regulator support for PM7550 & PMR735B
      Add a bare-minimum Regulator abstraction

Martijn de Gouw (2):
      dt-bindings: regulator: add pca9450: Add regulator-allowed-modes
      regulator: pca9450: Add support for mode operations

Matti Vaittinen (1):
      regulator: bd718x7: Clarify comment by moving it

Michael Walle (8):
      mfd: tps6594: Add TI TPS652G1 support
      misc: tps6594-pfsm: Add TI TPS652G1 PMIC PFSM
      pinctrl: pinctrl-tps6594: Add TPS652G1 PMIC pinctrl and GPIO
      dt-bindings: mfd: ti,tps6594: Add TI TPS652G1 PMIC
      regulator: tps6594-regulator: remove interrupt_count
      regulator: tps6594-regulator: remove hardcoded buck config
      regulator: tps6594-regulator: refactor variant descriptions
      regulator: tps6594-regulator: Add TI TPS652G1 PMIC regulators

Primoz Fiser (1):
      regulator: pca9450: Support PWM mode also for pca9451a

Romain Gantois (1):
      regulator: core: repeat voltage setting request for stepped regulators

Sakari Ailus (7):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      regulator: stm32-vrefbuf: Remove redundant pm_runtime_mark_last_busy() calls

 .../devicetree/bindings/mfd/ti,tps6594.yaml        |   1 +
 .../mediatek,mt6873-dvfsrc-regulator.yaml          |   2 +
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  14 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  35 ++
 ...pberrypi,7inch-touchscreen-panel-regulator.yaml |   7 +-
 Documentation/power/runtime_pm.rst                 |  50 ++-
 MAINTAINERS                                        |   1 +
 drivers/mfd/tps6594-core.c                         |  88 ++++-
 drivers/mfd/tps6594-i2c.c                          |  10 +-
 drivers/mfd/tps6594-spi.c                          |  10 +-
 drivers/misc/tps6594-pfsm.c                        |  31 +-
 drivers/pinctrl/pinctrl-tps6594.c                  |  35 ++
 drivers/regulator/Kconfig                          |  13 +-
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd718x7-regulator.c              |  27 +-
 drivers/regulator/core.c                           |  43 ++-
 drivers/regulator/mt6370-regulator.c               |   4 +-
 drivers/regulator/mtk-dvfsrc-regulator.c           |  38 ++
 drivers/regulator/pca9450-regulator.c              | 141 ++++++-
 drivers/regulator/qcom-rpmh-regulator.c            |  58 +++
 drivers/regulator/rpi-panel-v2-regulator.c         | 125 ++++++
 drivers/regulator/rt5739.c                         |   9 +
 drivers/regulator/rt6160-regulator.c               |  19 +-
 drivers/regulator/stm32-vrefbuf.c                  |   6 -
 drivers/regulator/sy8827n.c                        |   3 +-
 drivers/regulator/tps6286x-regulator.c             |   9 +
 drivers/regulator/tps6287x-regulator.c             |   7 +
 drivers/regulator/tps6594-regulator.c              | 275 ++++++++------
 .../dt-bindings/regulator/nxp,pca9450-regulator.h  |  18 +
 include/linux/mfd/tps6594.h                        |   1 +
 include/linux/pm_runtime.h                         | 187 +++++++--
 include/linux/regulator/coupler.h                  |   3 +-
 rust/bindings/bindings_helper.h                    |   1 +
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/regulator.c                           |  43 +++
 rust/kernel/lib.rs                                 |   1 +
 rust/kernel/regulator.rs                           | 418 +++++++++++++++++++++
 37 files changed, 1513 insertions(+), 222 deletions(-)
 create mode 100644 drivers/regulator/rpi-panel-v2-regulator.c
 create mode 100644 include/dt-bindings/regulator/nxp,pca9450-regulator.h
 create mode 100644 rust/helpers/regulator.c
 create mode 100644 rust/kernel/regulator.rs

