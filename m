Return-Path: <linux-kernel+bounces-749320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B56B14CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A26A3A57B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C228C872;
	Tue, 29 Jul 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOPyrZ+4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39C288C26
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787869; cv=none; b=d/3wEWadpG/duZw/19e9q9f5ObIU4zJOY5acjQ4QD6+D0rokJFvtQxzhyHAXiny+uvQ1gsISZJfzXP6l/Ty6RAYZdiGGf5huLAviiJPXZWfQRF2AqOpF573xoRLLxQbHUAFs5xN07AqZbYe5f2fTbF1CtbHmPuT0BgCwOFlvzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787869; c=relaxed/simple;
	bh=wEVZhpgt1uNcasnqEQ15dSnD0eh7wUda2VTINBIA7/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4D/ROizmgAIIWFf6pztgwPQdpcTk794xX2sQyk2YiiIeIYrw90BNNZWqsouuEofqG/MNp/XGkb4pLL/qBwO723qZahu6CJmB4qdb/h7zwF1sfnqCVBWy8TBNOe8j6zkCBm8veFn90ChMmQvGNCxg8DyI17p0cXPv30PYegPolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOPyrZ+4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-556fd896c99so4638305e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753787866; x=1754392666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNqyxgyK0nsgvQIxHIvNEn3WYoXCL9lVWy5TTd0G+sE=;
        b=kOPyrZ+4WxhqPscq3pVAzPk2B3g8dQQsE6lOOTWt7PW1FGtp5FdHbx3PLEv+NalMLb
         YdPlRAm8j32xPDJeX45zZdjPV2dIpup7iDiVAoyhzDGSV+eRI2svcHmnqUaUc0EHnVMC
         v1Q+QXdr4INmLiZH3nv1A8bKVp0WEpYjm4ESwx+jnfHPIiC37LH6qela3khFvPzgtums
         C4Lt6i2RAQBrO/Lg7ySVZgXeeu5OycIvKllEYvCjyJJp9M2RUD4/jBc1682E3axBBlJm
         CGu+rpGFDbl8k9udzRFfuW1Dl9/jgVw7mS9gzZyGsq8NcXD86+T1eUVYLwPN5EITbuIm
         CO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787866; x=1754392666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNqyxgyK0nsgvQIxHIvNEn3WYoXCL9lVWy5TTd0G+sE=;
        b=D4F1Q/yNyDCa7KxzWH59YAv5A8dMGIe6qfX7UONzfsPI5fd+8H2RYxF6mrLNS6IPAg
         PnSfVS6ht66NIVRsEolRp1BW2wci4OgVus1YYGBAdvKoZNBjSy0GaSwzZX1he/qQ0Tj1
         EmmjeiNlTPFCRGxkdb09uCbRrXm3UqaZU5PbWE/03MCAmcE//XeG6L4qfZNWN8X+N1un
         iEsHyjURC0Zr047WW5NYSEa4UGShlJR9OnHBXIG57fiiIJN9SuX87p6lnRByHUQIc1Te
         nySeL5NmQCxEVFVE684Q7X62LWQCbECg19nadEBfv1OuSeyWK6YPwDZOu4zxs4gpE1/D
         THWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1V2g7KpLMEEew86XExKUP/5Ib4Lkx2hRsePl36yYDUqOPZHLNLNGfOePMbvDmAL76urVpOUTzQEjk57Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyurAocElj75KhCUHJyEpHv5XqmrjwXaa5xe9ziThG8U83nwnXY
	z8FL1CSg6RkHcou2yx59obshRJhOCrvwn7V5/k7ziecyKzDiJZPP36IxO42M0jZ00sk=
X-Gm-Gg: ASbGncs1cDbPIbFZbfI+ZK8Fr9LrNLZlfWoOfZCPlVTTcg/XE3yH25UbGiMHyI8DEN6
	3ingIlpxbv7eKt7TKRQ5iJxdy4m5jYpxx4qsZcLp4HFsUzcWcu3Gw1aLafZK0dqVUizJVRpcaw6
	ujnl+oK/82bXFMMhW68dJfdnrRhQ/dsYW2EMmx9U3tFcP9FNbo1Em5fNwfdmOYCDLdt+dRgsYlQ
	t24EW+PsrvmPPboRqiJ4yPOk10+gwmTGOHdBZQKa1BWBZNKoGfuPw6NnlDPwVL1K+gquhqTLf0B
	9Q1ateHeYBofdKuD9M3IfQnd2/NgH2F5my6w3eLQCRGwdgdOLhZRGK2zpQbEmIel63sJHXP7MTO
	owiBXFY7vwPA2X1edqHlfLfyQudVpKARgKwtiucesFaV52UVQoGUbmPsg+RThqlPHWnpuV0az
X-Google-Smtp-Source: AGHT+IGssqGSc/l4qTALfsZmnWpz0MEgV6jXLRfV5IBNiy/NKNIKDaCf0ufZ7BJYRZwGjpYZkZDx3g==
X-Received: by 2002:a05:6512:23a2:b0:554:f76a:baba with SMTP id 2adb3069b0e04-55b5f3d5c73mr4808104e87.3.1753787865739;
        Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316db49sm1652507e87.3.2025.07.29.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.17
Date: Tue, 29 Jul 2025 13:17:33 +0200
Message-ID: <20250729111743.14723-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain and cpuidle-psci updates for v6.17.

FYI, this time we have made quite some changes in the pmdomain provider core
(aka genpd), which affects a couple of provider drivers that are sprinkled
across a few more subsystems than usual.

More details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 621a88dbfe9006c318a0cafbd12e677ccfe006e7:

  cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y (2025-07-14 13:09:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17

for you to fetch changes up to 05e35bd07d56780f0a5119973995b97a16843579:

  pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains (2025-07-23 12:12:16 +0200)

----------------------------------------------------------------
pmdomain core:
 - Leave powered-on genpds on until ->sync_state() or late_initcall_sync
 - Export a common ->sync_state() helper for genpd providers
 - Add generic ->sync_state() support
 - Add a bus/driver for genpd provider-devices
 - Introduce dev_pm_genpd_is_on() for consumers

pmdomain providers:
 - cpuidle-psci: Drop redundant ->sync_state() support
 - cpuidle-riscv-sbi: Drop redundant ->sync_state() support
 - imx: Set ISI panic write for imx8m-blk-ctrl
 - qcom: Add support for Glymur and Milos RPMh power-domains
 - qcom: Use of_genpd_sync_state() for power-domains
 - rockchip: Add support for the RK3528 variant
 - samsung: Fix splash-screen handover by enforcing a ->sync_state()
 - sunxi: Add support for Allwinner A523's PCK600 power-controller
 - tegra: Opt-out from genpd's common ->sync_state() support for pmc
 - thead: Instantiate a GPU power sequencer via the auxiliary bus
 - renesas: Move init to postcore_initcalls
 - xilinx: Move ->sync_state() support to firmware driver
 - xilinx: Use of_genpd_sync_state() for power-domains

pmdomain consumers:
 - remoteproc: imx_rproc: Fixup the detect/attach procedure for pre-booted cores

----------------------------------------------------------------
Chen-Yu Tsai (4):
      dt-bindings: power: Add A523 PPU and PCK600 power controllers
      pmdomain: sunxi: sun20i-ppu: add A523 support
      pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power controller
      pmdomain: sunxi: sun20i-ppu: change to tristate and enable for ARCH_SUNXI

Christophe JAILLET (1):
      pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_data

Guillaume La Roque (1):
      pmdomain: ti: Select PM_GENERIC_DOMAINS

Hiago De Franco (3):
      pmdomain: core: introduce dev_pm_genpd_is_on()
      remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
      remoteproc: imx_rproc: detect and attach to pre-booted remote cores

Jonas Karlman (3):
      dt-bindings: power: rockchip: Add support for RK3528
      dt-bindings: rockchip: pmu: Add compatible for RK3528
      pmdomain: rockchip: Add support for RK3528

Kamal Wadhwa (2):
      dt-bindings: power: rpmpd: Add Glymur power domains
      pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains

Krzysztof Hałasa (1):
      imx8m-blk-ctrl: set ISI panic write hurry level

Kuninori Morimoto (2):
      pmdomain: renesas: use menu for Renesas
      pmdomain: renesas: sort Renesas Kconfig configs

Luca Weiss (2):
      dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Milos power domains

Lukas Bulwahn (1):
      pmdomain: arm: scmi_pm_domain: remove code clutter

Michal Wilczynski (2):
      dt-bindings: firmware: thead,th1520: Add resets for GPU clkgen
      pmdomain: thead: Instantiate GPU power sequencer via auxiliary bus

Saravana Kannan (1):
      driver core: Add dev_set_drv_sync_state()

Sven Peter (1):
      pmdomain: apple: Drop default ARCH_APPLE in Kconfig

Ulf Hansson (31):
      pmdomain: core: Use of_fwnode_handle()
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: renesas: rcar-sysc: Add genpd OF provider at postcore_initcall
      pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
      pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
      pmdomain: core: Prevent registering devices before the bus
      pmdomain: core: Add a bus and a driver for genpd providers
      pmdomain: core: Add the genpd->dev to the genpd provider bus
      pmdomain: core: Export a common ->sync_state() helper for genpd providers
      pmdomain: core: Prepare to add the common ->sync_state() support
      soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
      cpuidle: psci: Opt-out from genpd's common ->sync_state() support
      cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
      pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
      pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
      firmware/pmdomain: xilinx: Move ->sync_state() support to firmware driver
      firmware: xilinx: Don't share zynqmp_pm_init_finalize()
      firmware: xilinx: Use of_genpd_sync_state()
      driver core: Export get_dev_from_fwnode()
      pmdomain: core: Add common ->sync_state() support for genpd providers
      pmdomain: core: Default to use of_genpd_sync_state() for genpd providers
      pmdomain: core: Leave powered-on genpds on until late_initcall_sync
      pmdomain: core: Leave powered-on genpds on until sync_state
      cpuidle: psci: Drop redundant sync_state support
      cpuidle: riscv-sbi: Drop redundant sync_state support
      pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next

 .../devicetree/bindings/arm/rockchip/pmu.yaml      |   2 +
 .../bindings/firmware/thead,th1520-aon.yaml        |   7 +
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |   4 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 .../bindings/power/rockchip,power-controller.yaml  |   1 +
 drivers/base/core.c                                |   8 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |  14 --
 drivers/cpuidle/cpuidle-riscv-sbi.c                |  14 --
 drivers/firmware/xilinx/zynqmp.c                   |  18 +-
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       |  12 +-
 drivers/pmdomain/apple/Kconfig                     |   1 -
 drivers/pmdomain/arm/scmi_pm_domain.c              |  12 +-
 drivers/pmdomain/core.c                            | 254 +++++++++++++++++++--
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |  10 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  47 ++++
 drivers/pmdomain/qcom/rpmpd.c                      |   2 +
 drivers/pmdomain/renesas/Kconfig                   | 124 +++++-----
 drivers/pmdomain/renesas/rcar-gen4-sysc.c          |   2 +-
 drivers/pmdomain/renesas/rcar-sysc.c               |  19 +-
 drivers/pmdomain/renesas/rmobile-sysc.c            |   3 +-
 drivers/pmdomain/rockchip/pm-domains.c             |  27 +++
 drivers/pmdomain/samsung/exynos-pm-domains.c       |   9 +
 drivers/pmdomain/sunxi/Kconfig                     |  19 +-
 drivers/pmdomain/sunxi/Makefile                    |   1 +
 drivers/pmdomain/sunxi/sun20i-ppu.c                |  17 ++
 drivers/pmdomain/sunxi/sun55i-pck600.c             | 234 +++++++++++++++++++
 drivers/pmdomain/thead/Kconfig                     |   1 +
 drivers/pmdomain/thead/th1520-pm-domains.c         |  51 +++++
 drivers/pmdomain/ti/Kconfig                        |   2 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c        |  16 --
 drivers/remoteproc/imx_rproc.c                     |  45 +++-
 drivers/soc/tegra/pmc.c                            |  26 ++-
 .../power/allwinner,sun55i-a523-pck-600.h          |  15 ++
 .../dt-bindings/power/allwinner,sun55i-a523-ppu.h  |  12 +
 include/dt-bindings/power/rockchip,rk3528-power.h  |  19 ++
 include/linux/device.h                             |  13 ++
 include/linux/firmware/xlnx-zynqmp.h               |   6 -
 include/linux/pm_domain.h                          |  23 ++
 38 files changed, 918 insertions(+), 174 deletions(-)
 create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
 create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h

