Return-Path: <linux-kernel+bounces-812308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4CB53608
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BF1188AD4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8EC340DA7;
	Thu, 11 Sep 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0kph9Ev"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED24335BAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601838; cv=none; b=iazsk7QjdxWRCeTQ+GPgmemQ4it3xMD69PTFNPW3mL7y/qcmTXbg36qIsgatuUxzVbQMbkorsRwXXKKWjbA5PWQx74rywCVEdGScmJUpKFviKuGXKhZLpYhmM1k7n6TLYDTE1leudztNbatWcEhXDY3YwfxS8ZdwLk2j0dIpN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601838; c=relaxed/simple;
	bh=38yRiC80JuWhs1D+D1Pu/Q3vZf/XnDvUjgzlOBYahng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIXvAVDqRfzyVjTuCFFXH8SFTOHbUv74BsnMeoGEe+PJ/wJfR/PR6OOhBknOX8wEVGDz+4kGutI31nvH+FyEgeHLtwFy7mS3y8orkSCQbmVr/a21KWfL6+RKoRv5LvSLWQUYXsufjw6ObsHEZn115oBidRtvy7gtNzrlu2AxoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0kph9Ev; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336af6356a5so6917491fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601835; x=1758206635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alSX5mQtfS5Pj4sYwMRLRLHW0y2RAG5QbtudXmPXeaY=;
        b=O0kph9Evz8AUn5xx3oeBjj9MlM3F76JhR6E32zxmEgoBO7Aw7NVFazBeDiPHnFX2yT
         W6lkD246BTAxVZPHb+W9Up84hQ0DtpO2CbTW5JY9uBCNKA3DSLqPeLNBlmUwQARg7/HP
         bgxPHQQNf49QGSJCMHsH3UGIVZSbgRSwkmOzFOQEen5MYQPCAk0vgtfc14xkLOnn/y8h
         hKi2hDk86xyG8uPOpRRkJXVRYhotWJGe3jrv5W0asrNsd+BJpuSfF0i0iQrxvZ1os/H6
         sugT44OBiyQeK9xGMhTqbh/cSTbm7JQWDJihrreVVlZ2dad/JVVgiX/JfXvYBmDYy7vu
         U2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601835; x=1758206635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alSX5mQtfS5Pj4sYwMRLRLHW0y2RAG5QbtudXmPXeaY=;
        b=Wc2S7mlKTmqVvmG9zEtqT//S9DVqUEUtMHl1Hd0xAUD0ugtwAqfGSAj/knZ424VhkG
         bBA0a+X/+9QOYs8o4B2IVUdSXlxWTuHQn/cMcZiTGg3mQde1BRukezFoMWIJZUgHWW2Y
         ExF1Wv2uCe9iAI+AaVrBuuSb1RYanZJDnumuH8rpvqmUGGiB3Og7eZVPsqOUZP2YGiud
         V8EZZBcKA6ddas7NfHwrTVQ/y2K6pAWoERhjdNmOjaNa+sNUQvo/E9bFSZV+hGD8cXEb
         /BGFtE5268M3f0iHB7Wt4FqopnlGgAvDYMaK8CdLmQmbcX9jHe0r/0UAxR3bXwpQWrXV
         9qvg==
X-Gm-Message-State: AOJu0YzJnH+ZJCZaPo58Xm4S8yBXf0C7FBMIBygT7tAKkzJOsrUIMjZ4
	GYfJ0M6UwjTcivdI3ldSQki2ttMSoxMFAiJv2lbiSbmKMx9oE/YUSv+LueIUZRvxX08=
X-Gm-Gg: ASbGncuT8eiq+wvkS5bgtxxDqXA2txJUUY288tVsykQ041HNg9gsAAtS4my3CX+yFMA
	X95Tw2ANfki6pymlFSqEvKbFvwhTHiQaJH7gnZZACmjs5kvzNzPqnjSI87hVdclBt9tXK+hYbne
	Wd/NlJKLxxAsKrrPnwG/LrTnKqPVIDn2tOovVwh1D/G72B7aGzOpM3pddksCagu6usqBDGxfWDZ
	r9gkXMWpPF+3KcaibYQfMsEAAk2voEPEG51DZCNK10KZSPeo8KIT0ObF8gLvRBAkrzwNiGfC+Ep
	j3nf361I9UU68TXGwxy+SMBvhd/mefjqnKYfwe9oVQ/S/NwuYsnjLlOUiBL29PysxLyJo1kHfwU
	c1Z6/PCYFKj6SLepxVnOr+236J5TpLim+8lbVu376dx98M0bZHFfYc/RGrSYT+IQGZQ==
X-Google-Smtp-Source: AGHT+IGkL9+D5a4mzX3QTxoDZArVpIammMSKTjjb3SIYEk+XqOS1xGbNC4DtMQ/5SZZCaVDzpamVgw==
X-Received: by 2002:a2e:a54c:0:b0:336:de53:7f67 with SMTP id 38308e7fff4ca-33b572953camr58961111fa.35.1757601834666;
        Thu, 11 Sep 2025 07:43:54 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35062c8da78sm1016621fa.0.2025.09.11.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:43:54 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH] mmc: dw_mmc-rockchip: add dependency to ROCKCHIP_PM_DOMAINS
Date: Thu, 11 Sep 2025 17:43:13 +0300
Message-ID: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On rockpi4b, mounting rootfs from mmc fails unless ROCKCHIP_PM_DOMAINS
is enabled. This dependency is not exactly clear so make it really
explicit.

Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119268

/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
root '/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e' doesn't exist or does not contain a /dev.
rk_gmac-dwmac fe300000.ethernet: deferred probe timeout, ignoring dependency
rk_gmac-dwmac fe300000.ethernet: probe with driver rk_gmac-dwmac failed with error -110
rk_iommu ff650800.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff650800.iommu: probe with driver rk_iommu failed with error -110
dwmmc_rockchip fe320000.mmc: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff7c0000.phy: deferred probe timeout, ignoring dependency
dwmmc_rockchip fe320000.mmc: probe with driver dwmmc_rockchip failed with error -110
rockchip-typec-phy ff7c0000.phy: probe with driver rockchip-typec-phy failed with error -110
rockchip-typec-phy ff800000.phy: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff800000.phy: probe with driver rockchip-typec-phy failed with error -110
rk_iommu ff660480.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff660480.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff8f3f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff8f3f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff903f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff903f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff914000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff914000.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff924000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff924000.iommu: probe with driver rk_iommu failed with error -110
platform fe800000.usb: deferred probe pending: platform: wait for supplier /phy@ff7c0000/usb3-port
sdhci-arasan fe330000.mmc: deferred probe timeout, ignoring dependency
platform fe900000.usb: deferred probe pending: platform: wait for supplier /phy@ff800000/usb3-port
sdhci-arasan fe330000.mmc: probe with driver sdhci-arasan failed with error -110
platform ff1d0000.spi: deferred probe pending: (reason unknown)
platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error

Working boot with CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119272

dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
dwmmc_rockchip fe320000.mmc: Version ID is 270a
dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 45,32 bit host data width,256 deep fifo
dwmmc_rockchip fe320000.mmc: Got CD GPIO
ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 44, base_baud = 1500000) is a 16550A
printk: legacy console [ttyS2] enabled
mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
dw_wdt ff848000.watchdog: No valid TOPs array specified
mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
mmc0: CQHCI version 5.10
rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
mmc1: new high speed SDHC card at address aaaa
fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
mmcblk1: mmc1:aaaa SC16G 14.8 GiB
rk_gmac-dwmac fe300000.ethernet: IRQ sfty not found
GPT:Primary header thinks Alt. header is not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: Deprecated MDIO bus assumption used
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
GPT:Alternate GPT header not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
GPT: Use GNU Parted to correct GPT errors.
rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
 mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c06887..8664df524f7a7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -866,7 +866,7 @@ config MMC_DW_PCI
 
 config MMC_DW_ROCKCHIP
 	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ROCKCHIP
+	depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Rockchip SoC specific extensions to the
-- 
2.34.1


