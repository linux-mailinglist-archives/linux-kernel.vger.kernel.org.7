Return-Path: <linux-kernel+bounces-749352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E9B14D40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B743B294B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662228F533;
	Tue, 29 Jul 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbEnVP60"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034228F51D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790196; cv=none; b=Cc954Wa66hJcxdt3wyBTRTrUW6zLLn0TPzF2RZL+CRIsqxqio8VCTsQfAN8itzAK+1idD1m9mqIcma2cyBAIZ27RVxBxRZ8gSNF+cBuL1m6munS+Fc/krkRsVSPA5BO2HvZvhIkwc0btb0gyzFhLbknFjkzLpTxR8UU7+WXiG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790196; c=relaxed/simple;
	bh=EUBFSrIBvufAvOyMALXkyNiU3XwOAdrsLmtKCdZ9/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WZb0vzIqvWDlnG2qXnjEFQTMQCu+ntxAv7KqYh5cJyhNW2GoRzwu/U1/268J97/jqUe5fWWy4ENUPLVBnY34BPCFsJYc3XQSpmgn+N2XoHu7bRnD9lkI+ohdq8hPu7L/eu64fJtQr4Vv4JlNO+XHQyvr9dLQxE54y5qQtNgsqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BbEnVP60; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55a25635385so6091897e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753790192; x=1754394992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9BDSmPma3UjQ81slGazmNmNV1DlBgyTj8yTNQ8/nB0=;
        b=BbEnVP6074xBziXGrUHsdFz9PEKb8dpZLgO7oDGEePRSZM+PauqHjLnHS3HbYCtKor
         rDXww6f8WqHzZaNVcL6H7yYFoP5/bbbxHHF/1iNhVUAVogkz17N73RM9/zs9gZwAd4bJ
         wEw0g6o2iwFq3lcazhrlKwlnxrFtMRnHoE6W+Vy3ecjtoq3dKdhgasMxHlRYfnoGOEVK
         463LGuBVT8Zb1kdZVRuThsuK0mZC4rpNCnd+m5AqvS+ILL/SctfefOTh4SFZADmpYkRp
         iJ7bgePbsBfODBO/gkDY3pYd+2a/pjEnl3GHCLd7vYHXWqPIsitLY9OPwtEklQnC1vEo
         AFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753790192; x=1754394992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9BDSmPma3UjQ81slGazmNmNV1DlBgyTj8yTNQ8/nB0=;
        b=icAJvLcl9LoY3voW7oVWip15hTq5MMxbEW7xbv/ENOK72ctddZOPQc10dxXUu96KMk
         i0wTWnO9nTIvB75+7RRotP4x0/+3+Uq3uynBqrW6VLEsPqbFyGZ3optkuW/MrL9CkL1c
         E9kvKvfbYys6sN/rgbcy41F0dVHN8VvZnQIxWSXd5VsoofvpexDn+tJipS0x1eyoIsEi
         +wN/w4oI8SvCYJCPnKvd17Q7azrNcMCJ0/k/FaqNA7FyuWAMR43spb4JJyqEkBAwOefs
         rfKVj7R/nQsm26AcXeuFTpyp+W5r/w8K6+8vESBhLZ8RBRdgyCMwCd5GWRM0DEcVxw6+
         0lXw==
X-Forwarded-Encrypted: i=1; AJvYcCVSqHZjO8XQK8Oa1tySIAoPUpAdfcFdfwCOsxAIUCYKG3zM8G8AaX0lo6AOtSbHJNhaXPdBKbtW4dUBSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOGqklmb6GDxOT/axXqXe1NuZRqurKID38xb+2kH7DsTwJJSy
	dsRd5vs1HLBJOaej3fS95XUo3v0IwozTrCpaP076j9OgZC1vQ++4GSyu++k8ssWBXw0=
X-Gm-Gg: ASbGnctUKMZ0xT3U0MxJO57dPuQPJoGnilCpTBfl2b6O6ShRdmQSC0EtGXNYS086LL9
	YuvWNeUWIZY5COOYtJbPj+p4Qg6jxCPGt8l0t2erRjZUbg89id2lNbJNpqQrduW/4zkKh0SMihj
	uAUiY0x6aiEOIZhLPsDGWiX/poNK6X0341E1DQMHI0K9MnTjz5pIApIRMK5hrkzVLd1e3xIX1JT
	ePBDOn/aIp1MaIj4fflLZ4ZBougrJDDwFtTMran3xecyxnEx5JfnN2V61k/DgHxFyNKLF9vwMJn
	Ihy30H14Ww2PQXUIsItwAAvDD76LgM2zuIOu3h3U7uAobOzNXaY26r6ABMecAQW+2vefcn7ecQx
	Eoa4SOcsjoDM5oxHWj+uEmokHALOyyx0DzZ+Ztp2Lnbg3VNcIDazHs6HPSE86icSoIV0BJAKr
X-Google-Smtp-Source: AGHT+IGEWzq3tLsKAIHbDQw6uMrDu8out+Xr5pKnJaLmJryCZUY6r1LldaPSM7kUFZ3MyWBQglqKSA==
X-Received: by 2002:a05:6512:220f:b0:55b:5a1a:6425 with SMTP id 2adb3069b0e04-55b5f487eb5mr4171406e87.35.1753790192427;
        Tue, 29 Jul 2025 04:56:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6339b9b0sm1641464e87.186.2025.07.29.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:56:31 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.17
Date: Tue, 29 Jul 2025 13:56:25 +0200
Message-ID: <20250729115630.16917-1-ulf.hansson@linaro.org>
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

Here's the pull-request with updates for MMC for v6.17. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17

for you to fetch changes up to c3ad4ec3fdaba1f5367dd15b5a2e6dc9a9cde3f1:

  mmc: Merge branch fixes into next (2025-07-16 12:05:36 +0200)

----------------------------------------------------------------
MMC core:
 - Remove redundant pm_runtime_mark_last_busy() calls

MMC host:
 - Convert drivers to use devm_mmc_alloc_host()
 - Remove redundant pm_runtime_mark_last_busy() calls
 - renesas_sdhi: Add support for the RZ/T2H and RZ/N2H variants
 - renesas_sdhi: Fix incorrect auto retuning for an SDIO card
 - rtsx_usb_sdmmc: Add 74 clocks in poweron flow
 - rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()
 - loongson2: Add driver for the Loongson-2K SD/SDIO controller
 - loongson2: Add support for the Loongson-2K2000 SD/SDIO/eMMC controller
 - sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() interface
 - sdhci: Remove the sdhci_free_host() and sdhci_pltfm_free() helpers
 - sdhci-cadence: Add support for the Mobileye EyeQ controller
 - sdhci-esdhc-imx: Optimize clock loopback selection
 - sdhci-esdhc-imx: Don't change pinctrl in suspend if wakeup source
 - sdhci-msm: Add support for the Milos variant
 - sdhci-msm: Add support for the qcs8300 variant
 - sdhci-msm: Ensure SD card power isn't ON when card gets removed
 - sdhci-of-k1: Disable HW busy detection

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Return void from sdhci_runtime_suspend|resume_host()

Avri Altman (1):
      mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Benoît Monin (3):
      dt-bindings: mmc: cdns: add Mobileye EyeQ MMC/SDHCI controller
      mmc: sdhci-cadence: add Mobileye eyeQ support
      mmc: sdhci-cadence: use of_property_present

Binbin Zhou (75):
      mmc: alcor: Use devm_mmc_alloc_host() helper
      mmc: atmel: Use devm_mmc_alloc_host() helper
      mmc: au1xmmc: Use devm_mmc_alloc_host() helper
      mmc: bcm2835: Use devm_mmc_alloc_host() helper
      mmc: cavium: Use devm_mmc_alloc_host() helper
      mmc: cb710: Use devm_mmc_alloc_host() helper
      mmc: davinci_mmc: Use devm_mmc_alloc_host() helper
      mmc: dw_mmc: Use devm_mmc_alloc_host() helper
      mmc: jz4740: Use devm_mmc_alloc_host() helper
      mmc: litex_mmc: Use devm_mmc_alloc_host() helper
      mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
      mmc: mmci: Use devm_mmc_alloc_host() helper
      mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
      mmc: mvsdio: Use devm_mmc_alloc_host() helper
      mmc: mxcmmc: Use devm_mmc_alloc_host() helper
      mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
      mmc: omap: Use devm_mmc_alloc_host() helper
      mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
      mmc: owl-mmc: Use devm_mmc_alloc_host() helper
      mmc: pxamci: Use devm_mmc_alloc_host() helper
      mmc: rtsx_pci: Use devm_mmc_alloc_host() helper
      mmc: rtsx_usb_sdmmc: Use devm_mmc_alloc_host() helper
      mmc: sdricoh_cs: Use devm_mmc_alloc_host() helper
      mmc: sh_mmicf: Use devm_mmc_alloc_host() helper
      mmc: tifm_sd: Use devm_mmc_alloc_host() helper
      mmc: toshsd: Use devm_mmc_alloc_host() helper
      mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
      mmc: ushc: Use devm_mmc_alloc_host() helper
      mmc: via-sdmmc: Use devm_mmc_alloc_host() helper
      mmc: vub300: Use devm_mmc_alloc_host() helper
      mmc: wbsd: Use devm_mmc_alloc_host() helper
      mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
      mmc: tmio: Use devm_mmc_alloc_host() helper
      mmc: sunxi: Use devm_mmc_alloc_host() helper
      mmc: mmc_spi: Use devm_mmc_alloc_host() helper
      mmc: sdhci: Use devm_mmc_alloc_host() helper
      mmc: sdhci-acpi: Drop the use of sdhci_free_host()
      mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
      mmc: sdhci-pci: Drop the use of sdhci_free_host()
      mmc: sdhci-s3c: Drop the use of sdhci_free_host()
      mmc: sdhci-spear: Drop the use of sdhci_free_host()
      mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-bcm-kona: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-brcmstb: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-cadence: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-dove: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-esdhc-imx: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-iproc: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-msm: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-npcm: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-aspeed: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-esdhc: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-k1: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-ma35d1: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-of-sparx5: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-pic32: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-pxav2: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-pxav3: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-st: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-tegra: Drop the use of sdhci_pltfm_free()
      mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
      mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
      mmc: sdhci_f_sdh30: Drop the use of sdhci_pltfm_free()
      mmc: sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() interface
      dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
      mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
      dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for Loongson-2K2000
      mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver
      mmc: loongson2: Unify the function prefixes for loongson2_mmc_pdata

Dan Carpenter (2):
      mmc: sdhci-of-k1: Fix error code in probe()
      mmc: loongson2: Fix error code in loongson2_mmc_resource_request()

Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Frank Li (1):
      dt-bindings: mmc: mxs-mmc: change ref to mmc-controller-common.yaml from mmc-controller.yaml

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: Don't change pinctrl in suspend if wakeup source

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Lad Prabhakar (1):
      dt-bindings: mmc: renesas,sdhi: Document RZ/T2H and RZ/N2H support

Li Dong (2):
      mmc: cb710-mmc: Convert ternary operator to str_plural() helper
      mmc: Convert ternary operator to str_true_false() helper

Luca Weiss (1):
      dt-bindings: mmc: sdhci-msm: document the Milos SDHCI Controller

Luke Wang (2):
      mmc: sdhci-esdhc-imx: refactor clock loopback selection logic
      mmc: sdhci-esdhc-imx: optimize clock loopback selection with dummy pad support

Masami Hiramatsu (Google) (2):
      mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
      mtk-sd: Prevent memory corruption from DMA map failure

Nathan Chancellor (2):
      mmc: rtsx_usb_sdmmc: Fix clang -Wimplicit-fallthrough in sd_set_power_mode()
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()

Ricky Wu (1):
      mmc: rtsx_usb_sdmmc: Add 74 clocks in poweron flow

Sakari Ailus (7):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      mmc: Remove redundant pm_runtime_mark_last_busy() calls

Sarthak Garg (1):
      mmc: sdhci-msm: Ensure SD card power isn't ON when card removed

Sayali Lokhande (1):
      dt-bindings: mmc: Add sdhci compatible for qcs8300

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Sergio Perez Gonzalez (1):
      mmc: loongson2: prevent integer overflow in ret variable

Thomas Fourier (1):
      mmc: bcm2835: Fix dma_unmap_sg() nents value

Ulf Hansson (11):
      mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()
      mmc: rtsx_usb_sdmmc: Print debug-messages at power-on/off errors
      mmc: rtsx_usb_sdmmc: Convert sd_set_power_mode() into void
      mmc: rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()
      mmc: Merge branch fixes into next
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge tag pm-runtime-6.17-rc1 into next
      mmc: Merge branch fixes into next

Victor Shih (3):
      mmc: core: Adjust some error messages for SD UHS-II cards
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode
      mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card

Yixun Lan (2):
      mmc: sdhci-of-k1: make register definition vendor specific
      mmc: sdhci-of-k1: disable HW busy detection

Yoshihiro Shimoda (2):
      mmc: host: tmio: Add .sdio_irq()
      mmc: host: renesas_sdhi: Fix incorrect auto retuning for an SDIO card

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |    1 +
 .../bindings/mmc/loongson,ls2k0500-mmc.yaml        |  112 +++
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |    7 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   85 +-
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    2 +
 Documentation/power/runtime_pm.rst                 |   50 +-
 MAINTAINERS                                        |    7 +
 drivers/memstick/core/memstick.c                   |    2 +-
 drivers/mmc/core/core.c                            |    1 -
 drivers/mmc/core/quirks.h                          |   12 +-
 drivers/mmc/core/sd_uhs2.c                         |    4 +-
 drivers/mmc/host/Kconfig                           |   13 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/alcor.c                           |   20 +-
 drivers/mmc/host/atmel-mci.c                       |   12 +-
 drivers/mmc/host/au1xmmc.c                         |   14 +-
 drivers/mmc/host/bcm2835.c                         |    8 +-
 drivers/mmc/host/cavium.c                          |   10 +-
 drivers/mmc/host/cb710-mmc.c                       |    8 +-
 drivers/mmc/host/davinci_mmc.c                     |   22 +-
 drivers/mmc/host/dw_mmc.c                          |   15 +-
 drivers/mmc/host/jz4740_mmc.c                      |   40 +-
 drivers/mmc/host/litex_mmc.c                       |   12 +-
 drivers/mmc/host/loongson2-mmc.c                   | 1030 ++++++++++++++++++++
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   13 +-
 drivers/mmc/host/mmc_spi.c                         |    4 +-
 drivers/mmc/host/mmci.c                            |   32 +-
 drivers/mmc/host/moxart-mmc.c                      |   40 +-
 drivers/mmc/host/mtk-sd.c                          |   21 +-
 drivers/mmc/host/mvsdio.c                          |   24 +-
 drivers/mmc/host/mxcmmc.c                          |   31 +-
 drivers/mmc/host/mxs-mmc.c                         |   31 +-
 drivers/mmc/host/omap.c                            |   25 +-
 drivers/mmc/host/omap_hsmmc.c                      |   20 +-
 drivers/mmc/host/owl-mmc.c                         |   37 +-
 drivers/mmc/host/pxamci.c                          |   42 +-
 drivers/mmc/host/renesas_sdhi.h                    |    1 +
 drivers/mmc/host/renesas_sdhi_core.c               |   54 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |    5 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   42 +-
 drivers/mmc/host/sdhci-acpi.c                      |   11 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |    2 -
 drivers/mmc/host/sdhci-brcmstb.c                   |    1 -
 drivers/mmc/host/sdhci-cadence.c                   |   34 +-
 drivers/mmc/host/sdhci-dove.c                      |   12 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   78 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   25 +-
 drivers/mmc/host/sdhci-iproc.c                     |   18 +-
 drivers/mmc/host/sdhci-milbeaut.c                  |   19 +-
 drivers/mmc/host/sdhci-msm.c                       |   26 +-
 drivers/mmc/host/sdhci-npcm.c                      |   15 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   26 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |   10 +-
 drivers/mmc/host/sdhci-of-at91.c                   |   38 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   14 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   11 +-
 drivers/mmc/host/sdhci-of-k1.c                     |  144 +--
 drivers/mmc/host/sdhci-of-ma35d1.c                 |   23 +-
 drivers/mmc/host/sdhci-of-sparx5.c                 |   24 +-
 drivers/mmc/host/sdhci-omap.c                      |   23 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   31 +-
 drivers/mmc/host/sdhci-pic32.c                     |    9 +-
 drivers/mmc/host/sdhci-pltfm.c                     |   16 +-
 drivers/mmc/host/sdhci-pltfm.h                     |    1 -
 drivers/mmc/host/sdhci-pxav2.c                     |   26 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   17 +-
 drivers/mmc/host/sdhci-s3c.c                       |   26 +-
 drivers/mmc/host/sdhci-spear.c                     |   11 +-
 drivers/mmc/host/sdhci-sprd.c                      |   34 +-
 drivers/mmc/host/sdhci-st.c                        |    6 +-
 drivers/mmc/host/sdhci-tegra.c                     |    9 +-
 drivers/mmc/host/sdhci-uhs2.c                      |   20 +-
 drivers/mmc/host/sdhci-xenon.c                     |   24 +-
 drivers/mmc/host/sdhci.c                           |   26 +-
 drivers/mmc/host/sdhci.h                           |   21 +-
 drivers/mmc/host/sdhci_am654.c                     |   38 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   13 +-
 drivers/mmc/host/sdricoh_cs.c                      |   10 +-
 drivers/mmc/host/sh_mmcif.c                        |   17 +-
 drivers/mmc/host/sunxi-mmc.c                       |   22 +-
 drivers/mmc/host/tifm_sd.c                         |    7 +-
 drivers/mmc/host/tmio_mmc.h                        |    2 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   24 +-
 drivers/mmc/host/toshsd.c                          |    4 +-
 drivers/mmc/host/uniphier-sd.c                     |    8 +-
 drivers/mmc/host/usdhi6rol0.c                      |   30 +-
 drivers/mmc/host/ushc.c                            |    4 +-
 drivers/mmc/host/via-sdmmc.c                       |    7 +-
 drivers/mmc/host/vub300.c                          |   16 +-
 drivers/mmc/host/wbsd.c                            |    4 +-
 drivers/mmc/host/wmt-sdmmc.c                       |    8 +-
 include/linux/pm_runtime.h                         |  187 +++-
 92 files changed, 2050 insertions(+), 1092 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
 create mode 100644 drivers/mmc/host/loongson2-mmc.c

