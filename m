Return-Path: <linux-kernel+bounces-836238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E354EBA9140
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA863B4B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508DE3016EE;
	Mon, 29 Sep 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+foXsNS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591B19D880
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146157; cv=none; b=s6/hM78IBMh6X50UO/BmgJOlsSe5IZe14XTmCYUu65RK0FfNetDt2IgdPtrh7wuQMhMXUSqkD72qtrHC84R0cEzmuk0VrItQm0oCbMt3GJUszF9fQgT2gEIrDBf3OXKS+muYbHIHzzjXnrha9IQSmXWH+2CvgrQpYbkb+EpIn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146157; c=relaxed/simple;
	bh=N3fnyLc+4qCJS9hDjFW2m2I5TjUGxQcJNTYpMDjxtkk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=M958+h19XU4v6POnEVzLvaOus067pTouWkhokPvbhXTDifkkgREbEdKDfM7TTrdG9QpwHP7uyhHB/g6U2wpa4IO6Mtz72154uWvCUgKdTLgADR99CC8dJt2IMWSoveILSpq3Xd43+iFFojIa3mbZSF33NgFEbQVjj+dcD3vTbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+foXsNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED7C4CEF4;
	Mon, 29 Sep 2025 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759146157;
	bh=N3fnyLc+4qCJS9hDjFW2m2I5TjUGxQcJNTYpMDjxtkk=;
	h=From:To:Cc:Subject:Date:From;
	b=t+foXsNS4GZta2sPX6j2vT8ysPiqLWapi3Smsve1HtlnyBJxc3ulk0bJnvaqyHGjy
	 eja5PKmA7W34IQ+lJVHPjDrz5XLmuPOVxgwTXUxbFXecwJjs+mOXQ7B1Nje0dFqhgH
	 YBE1uhwb4p7z4Vi7mIDSydzrfPFgJzBHoqwyTxChKgEK42QcV00gBizD8VQOtSsxxC
	 sO54c6UAkEyZImM4yaByFFuIp4GPCjNYdeyiwf7htid0c/dW47LDrUhRNt4JWgnu5m
	 FuWsSvg6OuupIwZhZaSQaB8SEprAfRHi2QwSHBjzlBJBgviZZp8WmQgHGsv+vJPq1U
	 gTKNURWYYUuww==
Message-ID: <b4d0f23a75d33f696ba585401a385c2d@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.18
Date: Mon, 29 Sep 2025 12:42:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.18

for you to fetch changes up to e609438851928381e39b5393f17156955a84122a:

  regulator: dt-bindings: qcom,sdm845-refgen-regulator: document more platforms (2025-09-23 10:56:54 +0200)

----------------------------------------------------------------
regulator: Updates for v6.18

This is a very quiet release for regulator, almost all the changes are
new drivers but we do also have some improvements for the Rust bindings.

 - Additional APIs added to the Rust bindings.
 - Support for Maxim MAX77838, NXP PF0900 and PF5300, Richtek RT5133 and
   SpacemiT P1.

----------------------------------------------------------------
Alex Elder (1):
      regulator: spacemit: support SpacemiT P1 regulators

Chen Ni (1):
      regulator: tps6594-regulator: Remove unneeded semicolon

Colin Ian King (1):
      regulator: rt5133: Fix spelling mistake "regualtor" -> "regulator"

Dan Carpenter (1):
      regulator: rt5133: Fix IS_ERR() vs NULL bug in rt5133_validate_vendor_info()

Daniel Almeida (4):
      rust: regulator: remove needless &mut from member functions
      rust: regulator: implement Send and Sync for Regulator<T>
      rust: regulator: remove Regulator<Dynamic>
      rust: regulator: add devm_enable and devm_enable_optional

Dmitry Baryshkov (1):
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: document more platforms

Dzmitry Sankouski (1):
      regulator: add s2dos05 regulator support

Igor Belwon (1):
      regulator: Fix MAX77838 selection

Ivaylo Ivanov (2):
      dt-bindings: regulator: document max77838 pmic
      regulator: max77838: add max77838 regulator driver

Javier Carrasco (1):
      regulator: consumer.rst: document bulk operations

Jeff Chang (2):
      regulator: dt-bindings: Add Richtek RT5133 Support
      regulator: rt5133: Add RT5133 PMIC regulator Support

Joy Zou (2):
      dt-bindings: regulator: add PF0900 regulator yaml
      regulator: pf0900: Add PMIC PF0900 support

Liao Yuanhong (2):
      regulator: tps6524x: Remove unnecessary memset
      regulator: core: Remove redundant ternary operators

Marek Vasut (1):
      regulator: dt-bindings: rpi-panel: Split 7" Raspberry Pi 720x1280 v2 binding

Mark Brown (4):
      regulator: add new PMIC PF0900 support
      rust: regulator: relax a few constraints on
      regulator: pf530x: NXP PF530x regulator driver
      regulator: max77838: add max77838 regulator driver

Onur Özkan (1):
      rust: regulator: use `to_result` for error handling

Qianfeng Rong (2):
      regulator: bd718x7: Use kcalloc() instead of kzalloc()
      regulator: scmi: Use int type to store negative error codes

Rob Herring (Arm) (1):
      regulator: dt-bindings: Clean-up active-semi,act8945a duplication

Wolfram Sang (1):
      regulator: remove unneeded 'fast_io' parameter in regmap_config

Woodrow Douglass (2):
      regulator: dt-bindings: nxp,pf530x: Add NXP PF5300/PF5301/PF5302 PMICs
      regulator: pf530x: Add a driver for the NXP PF5300 Regulator

 Documentation/devicetree/bindings/mfd/act8945a.txt |  82 --
 .../power/supply/active-semi,act8945a-charger.yaml |  76 --
 .../bindings/regulator/active-semi,act8945a.yaml   |  25 +-
 .../bindings/regulator/maxim,max77838.yaml         |  68 ++
 .../devicetree/bindings/regulator/nxp,pf0900.yaml  | 163 ++++
 .../devicetree/bindings/regulator/nxp,pf5300.yaml  |  54 ++
 .../regulator/qcom,sdm845-refgen-regulator.yaml    |   3 +
 ...rrypi,7inch-touchscreen-panel-regulator-v2.yaml |  61 ++
 ...pberrypi,7inch-touchscreen-panel-regulator.yaml |   7 +-
 .../bindings/regulator/richtek,rt5133.yaml         | 178 ++++
 Documentation/power/regulator/consumer.rst         |  30 +-
 MAINTAINERS                                        |  15 +-
 drivers/regulator/Kconfig                          |  62 ++
 drivers/regulator/Makefile                         |   6 +
 drivers/regulator/bd718x7-regulator.c              |   2 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/max77838-regulator.c             | 221 +++++
 drivers/regulator/pf0900-regulator.c               | 975 +++++++++++++++++++++
 drivers/regulator/pf530x-regulator.c               | 375 ++++++++
 drivers/regulator/qcom-refgen-regulator.c          |   1 -
 drivers/regulator/rt5133-regulator.c               | 642 ++++++++++++++
 drivers/regulator/s2dos05-regulator.c              | 165 ++++
 drivers/regulator/scmi-regulator.c                 |   3 +-
 drivers/regulator/spacemit-p1.c                    | 157 ++++
 drivers/regulator/tps6524x-regulator.c             |   1 -
 drivers/regulator/tps6594-regulator.c              |   2 +-
 include/linux/regulator/s2dos05.h                  |  73 ++
 rust/helpers/regulator.c                           |  10 +
 rust/kernel/regulator.rs                           | 171 ++--
 29 files changed, 3354 insertions(+), 278 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/act8945a.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77838.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator-v2.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
 create mode 100644 drivers/regulator/max77838-regulator.c
 create mode 100644 drivers/regulator/pf0900-regulator.c
 create mode 100644 drivers/regulator/pf530x-regulator.c
 create mode 100644 drivers/regulator/rt5133-regulator.c
 create mode 100644 drivers/regulator/s2dos05-regulator.c
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 include/linux/regulator/s2dos05.h

