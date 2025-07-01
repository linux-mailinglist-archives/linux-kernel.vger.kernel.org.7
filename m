Return-Path: <linux-kernel+bounces-711155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF39AEF705
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632A117974F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA959242D86;
	Tue,  1 Jul 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH7fCI/9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6551A29A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370468; cv=none; b=LhhgMM3fl5pLdZMQaQnJcAQW1lKUa7cJ2SgHt0ZDvUCmoV5VmeFOPyU4/bnsGa0TVnBO/XFXSMf6PJHtNS5DQgnhw/k4SvAgUSYYSnblQUoR5igAXja/jITuan8tcwbL+OnZrBFX6YNjfHN+aTikzHxVCbP/lOjQQPn485aYGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370468; c=relaxed/simple;
	bh=RE4tQl1bLw4Bdz6vsD8Am1PSure6jPJf0Xnvxh4XDDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJiFJFqx/Y2N8Njxn7w7YsHXH1Op0TwZrMSnSDssgwj3XByP4tlUsjYjcqEP6HJ9+WzVJaRCitqtgj2p3doepGT6CLsBbMkntwcTEczJPtwan8Y9pHDZXqrw6QsdKbiHXuih9vO0MvrcpiiLvHAPaZ44mE39PkzJi2pkTdKad5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FH7fCI/9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553bcf41440so5665871e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370464; x=1751975264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoOnZ3Y5OuCPaJSe04VL4I/hU24z8+Cw4G4Ln/A/Lw8=;
        b=FH7fCI/9/tdce4NJS75lYM78SS3W6Mdu7rFeaaqrZQ4uZ6sqzL3j4GWF+6qzoaBL0I
         9ME2hs+zVtJBwP2m+ocTzhJGzJcCpVu1RuJ1KfPYTXPL5eyLVr9mpLmgoPQjBnfGB90b
         nOVWQs253jSw2V2aSF2hJLQA3zGGAUG2H1yiqo1mDM1H9r+n9ky9pc8D7uLrEO/gdaLD
         CEsY+0687RgJSYnKfp1R0Jk0NA6xSNQipInDUCVFjvdq0VrqF7Biu/KRH7DBkf882eR1
         q3x5+GOiZzLXVScmzzasUQifWZ2TXLf7ixIf2RKgX1xnZynbd1bkox8SF8twdpArbyUF
         omPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370464; x=1751975264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoOnZ3Y5OuCPaJSe04VL4I/hU24z8+Cw4G4Ln/A/Lw8=;
        b=N6QUyn7Tx2ZvC+83Ns27OslJy0t9fdvsSehHG2bANQvSaDMI5EWGa6SKAohML+c6OR
         1f6AJJ933SrvA+iMKi59wRLP5ON9tgAs8fF98ZuTgzeBYewqrI1EQ4yor7rwiUQONZp9
         0pc5tlG1LuGF9zH/zEXBEAcqmFGwCGl8IFPm/08FDuu4SRfc9bB0lpWmpGSGHu6pkfv3
         nujTjXQuWjBiEwMX+MDy7LKpAkcejHcBnyKUeUV4Y8Tc4LD+ksM8AIgXORfio7bwT+53
         4cktQH1WqiTDQqar1RlEP2mmQqFopw3jgUX4jC9NE8P9A9oKtWvqbYF7WktbaSwdFanC
         a3sw==
X-Forwarded-Encrypted: i=1; AJvYcCX2EA0gPCeUAhZhQGsWjOnPXDbWBn6DOPVZ6FHmRF4qJKFtZnsAHtGfcgcGVN/whHwNL38LEeHd7ya/Hpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcijoKfki1avDB1dZHrMu2VU+rDzlf3I2alFtOaRF/OYeRPeN
	my56E5kP2X0Lg8P7bQ9/ouha1/5yBtZqV6kXgBBq0ZvBMozVpiWyh49S1lf+O9AQ+7Q=
X-Gm-Gg: ASbGnctiDh0lUgxMnJvB+GWPSMbsEGzXNvJL6eH5ZESPTQDTnvPUdvG6Ovq70RYR71G
	6RI+kMbJzJEtkheEKQ1ozDmguEbxROyIQfcB5zIgfoSfWg0/4dKmDjc/Nixm3eghMgyK59/ml7q
	93UdcZqnJRDVYe+lLJde5JXTwf8QeUtt0Bwze0xjIgGka9fpS55m5D1qQAAoSsNXvco81g67EQ1
	ctXB5sJIiwtEAcktNv/1huiv+ONXd5xUg0OLi/GSZ2BqmQBqTY/gV+uMjYzSXaeGWA39Id476u8
	aRoL4ZJS8yH0f2skQnDsV+YpyUCJfjpqb1Uz5G9yRU/FSCMr/84pXdrvevYq/tbmZGckLX5/0gu
	SxKBrjZxsSqJ8zh6VgfduIV/jMA2P/V0sGg8S
X-Google-Smtp-Source: AGHT+IFEnI8edSGqM0HnhUhPwpSZ3r1Gp9Zq3NgqwGOKGx5afReOxMS/S22NLgTkPgvFIWV29dureQ==
X-Received: by 2002:a05:6512:b86:b0:553:5429:bb87 with SMTP id 2adb3069b0e04-5550b9eedfdmr4938325e87.36.1751370464185;
        Tue, 01 Jul 2025 04:47:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:43 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
Date: Tue,  1 Jul 2025 13:47:02 +0200
Message-ID: <20250701114733.636510-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
	- Added a couple of patches to adress problems on some Renesas
	platforms. Thanks Geert and Tomi for helping out!
	- Adressed a few comments from Saravanna and Konrad.
	- Added some tested-by tags.

Changes in v2:
	- Well, quite a lot as I discovered various problems when doing
	additional testing of corner-case. I suggest re-review from scratch,
	even if I decided to keep some reviewed-by tags.
	- Added patches to allow some drivers that needs to align or opt-out
	from the new common behaviour in genpd.

If a PM domain (genpd) is powered-on during boot, there is probably a good
reason for it. Therefore it's known to be a bad idea to allow such genpd to be
powered-off before all of its consumer devices have been probed. This series
intends to fix this problem.

We have been discussing these issues at LKML and at various Linux-conferences
in the past. I have therefore tried to include the people I can recall being
involved, but I may have forgotten some (my apologies), feel free to loop them
in.

I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
Let me know if you want me to share this code too.

Please help review and test!
Finally, a big thanks to Saravana for all the support!

Kind regards
Ulf Hansson


Saravana Kannan (1):
  driver core: Add dev_set_drv_sync_state()

Ulf Hansson (23):
  pmdomain: renesas: rcar-sysc: Add genpd OF provider at
    postcore_initcall
  pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
  pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
  pmdomain: core: Prevent registering devices before the bus
  pmdomain: core: Add a bus and a driver for genpd providers
  pmdomain: core: Add the genpd->dev to the genpd provider bus
  pmdomain: core: Export a common ->sync_state() helper for genpd
    providers
  pmdomain: core: Prepare to add the common ->sync_state() support
  soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
  cpuidle: psci: Opt-out from genpd's common ->sync_state() support
  cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
  pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
  pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
  firmware/pmdomain: xilinx: Move ->sync_state() support to firmware
    driver
  firmware: xilinx: Don't share zynqmp_pm_init_finalize()
  firmware: xilinx: Use of_genpd_sync_state()
  driver core: Export get_dev_from_fwnode()
  pmdomain: core: Add common ->sync_state() support for genpd providers
  pmdomain: core: Default to use of_genpd_sync_state() for genpd
    providers
  pmdomain: core: Leave powered-on genpds on until late_initcall_sync
  pmdomain: core: Leave powered-on genpds on until sync_state
  cpuidle: psci: Drop redundant sync_state support
  cpuidle: riscv-sbi: Drop redundant sync_state support

 drivers/base/core.c                         |   8 +-
 drivers/cpuidle/cpuidle-psci-domain.c       |  14 --
 drivers/cpuidle/cpuidle-riscv-sbi.c         |  14 --
 drivers/firmware/xilinx/zynqmp.c            |  18 +-
 drivers/pmdomain/core.c                     | 211 ++++++++++++++++++--
 drivers/pmdomain/qcom/rpmhpd.c              |   2 +
 drivers/pmdomain/qcom/rpmpd.c               |   2 +
 drivers/pmdomain/renesas/rcar-gen4-sysc.c   |   2 +-
 drivers/pmdomain/renesas/rcar-sysc.c        |  19 +-
 drivers/pmdomain/renesas/rmobile-sysc.c     |   3 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
 drivers/soc/tegra/pmc.c                     |  26 ++-
 include/linux/device.h                      |  13 ++
 include/linux/firmware/xlnx-zynqmp.h        |   6 -
 include/linux/pm_domain.h                   |  17 ++
 15 files changed, 291 insertions(+), 80 deletions(-)

-- 
2.43.0


