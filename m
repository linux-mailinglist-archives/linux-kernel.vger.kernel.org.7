Return-Path: <linux-kernel+bounces-825684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F66B8C83E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96BD3B45AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843A208CA;
	Sat, 20 Sep 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnqKPjuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47C1E502;
	Sat, 20 Sep 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371434; cv=none; b=FVZ3mIjDSQrAZAuOJ4ov/hSySKdcWS5/Z7EVxl3yo8iiWhSqyWFSFG+ersz/C8Y7umC8hSpETyJNtiw83uTtNP2f5nwpSD9PpJNBK+V49pPf2a3zUf0Yhq6PHZXusOlpojVrTgNLqPPU9yRKDmRGwEkqenFftq7RgQQEZscRa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371434; c=relaxed/simple;
	bh=+ABFe90/6L3G3RwAWo57j6ADE9lXeFOY1J0mVIJdsog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkUCsanrvbrBsSPdWFduqQIr1zNIu0a1nppOXstASK4bICjQ6v2tT76TpSDwe7+UISUSba6SeQwf9tnpvuIeD3BQoid6FXgBtwBhfENt43NXY6RWbyPnIKc+9wF+QXgACgn6LDStHenVv8oKj8fX4rAEIPjSYp9Z8/P8BhNrE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnqKPjuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2752EC4CEEB;
	Sat, 20 Sep 2025 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758371433;
	bh=+ABFe90/6L3G3RwAWo57j6ADE9lXeFOY1J0mVIJdsog=;
	h=From:To:Cc:Subject:Date:From;
	b=fnqKPjuwWPTWO/5/xvtw6GA3iR/3+e48t2cVXcsiVuGjoBLf1x2d7qxVLquQ851p/
	 mB1nGZdkMocGgGbFedR75ni2oawfAproeT66hAy7KfFTmtDjfkLV//U7hL/H5l6jIV
	 yWLVArkD52Hbh2G5zb/YyhWBUsjybmvFqX2vRHfEQLbIYfF06L+g11h5LlHuqmX/5S
	 78QCl+qfgTKv/5I/P5rfIcc8Zqa+TJlRJmTpqPY3mPLNyfR4BBoXvfPaUO8vqgC2qF
	 Hlyp1yid4DOC9Kp3tuVsE+9jZJCS5E5BDbXkN3LgdlCyKwa8GKnCoifEYHqMCcGZTl
	 5pJP+kLsinF1g==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>
Subject: [GIT PULL 1/2] Apple SoC driver changes for v6.18
Date: Sat, 20 Sep 2025 14:30:27 +0200
Message-Id: <20250920123028.49973-1-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git tags/apple-soc-drivers-6.18

for you to fetch changes up to 442816f97a4f84cb321d3359177a3b9b0ce48a60:

  pmdomain: apple: Add "apple,t8103-pmgr-pwrstate" (2025-09-18 21:30:56 +0200)

----------------------------------------------------------------
Apple SoC driver updates for 6.18

Krzysztof Kozlowski asked us to move away from generic compatibles:
- Adjust all dt-bindings to use apple,t8103-XXXX instead of apple,XXXX
  as fallback and add a comment that the old generic list should no
  longer be extended.
- Add new fallback compatibles to pinctrl, pmdomain, spi, and mca
  drivers. These changes have been Acked by their subsystem maintainers
  to be merged through our tree together with the dt-bindings.

Support for pre-M1 Apple Silicon:
- SART and mailbox gain support for Apple's A11, which are both
  required for NVMe.
- NVMe also gains support for Apple's A11 and the nvme maintainers
  prefer that we merge this through the soc tree together with
  the mailbox and SART changes.
- SPMI compatibles for A11 and T2 have been added, also going through
  the soc tree due to conflicts with the generic compatible removal and
  because no driver change is required.

Signed-off-by: Sven Peter <sven@kernel.org>

----------------------------------------------------------------
Janne Grunau (23):
      dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
      dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
      dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic compatible
      dt-bindings: iommu: dart: Add apple,t6020-dart compatible
      dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compatible
      dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
      dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
      dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
      dt-bindings: nvme: apple: Add apple,t6020-nvme-ans2 compatible
      dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
      dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
      dt-bindings: mfd: apple,smc: Add t6020-smc compatible
      dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
      dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
      dt-bindings: clock: apple,nco: Add t6020-nco compatible
      dt-bindings: dma: apple,admac: Add t6020-admac compatible
      ASoC: dt-bindings: apple,mca: Add t6020-mca compatible
      spi: dt-bindings: apple,spi: Add t6020-spi compatible
      pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
      ASoC: apple: mca: Add "apple,t8103-mca" compatible
      spi: apple: Add "apple,t8103-spi" compatible
      pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"

Nick Chan (8):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      dt-bindings: spmi: Add Apple A11 and T2 compatible

Sven Peter (1):
      soc: apple: Drop default ARCH_APPLE in Kconfig

 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |  33 ++--
 .../devicetree/bindings/clock/apple,nco.yaml       |  17 +-
 .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |   3 +
 .../devicetree/bindings/dma/apple,admac.yaml       |  17 +-
 .../devicetree/bindings/gpu/apple,agx.yaml         |   6 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   1 +
 .../devicetree/bindings/iommu/apple,dart.yaml      |  14 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |   5 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   8 +
 .../devicetree/bindings/mfd/apple,smc.yaml         |  17 +-
 .../net/bluetooth/brcm,bcm4377-bluetooth.yaml      |   1 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |   1 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  30 ++--
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |  27 +--
 .../bindings/power/apple,pmgr-pwrstate.yaml        |  27 +--
 .../devicetree/bindings/sound/apple,mca.yaml       |  17 +-
 .../devicetree/bindings/spi/apple,spi.yaml         |  16 +-
 .../devicetree/bindings/spmi/apple,spmi.yaml       |  20 ++-
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |  27 +--
 drivers/nvme/host/apple.c                          | 197 ++++++++++++++-------
 drivers/pinctrl/pinctrl-apple-gpio.c               |   1 +
 drivers/pmdomain/apple/pmgr-pwrstate.c             |   1 +
 drivers/soc/apple/Kconfig                          |   3 -
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 drivers/spi/spi-apple.c                            |   1 +
 sound/soc/apple/mca.c                              |   1 +
 27 files changed, 404 insertions(+), 166 deletions(-)

