Return-Path: <linux-kernel+bounces-814259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935EB551B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155214604E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E3322763;
	Fri, 12 Sep 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joc1cDfP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4F3093D3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687272; cv=none; b=Rkba8ftjYWNg2Z1V+IDLSt8ho55UMv+bG1b5hM1fgavyXwbsOs5YO3y0lgcS4pwoDXNTrrSqcAHf7l10+rzknpuzgVYXV4Jk/C4AswCY7Ztv6t0rqMHSobSiYWlRCnl+qiUZeNWEBMn0HGGkVqZ2JIpDvld+LMmFJI31POUNApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687272; c=relaxed/simple;
	bh=/SxMVDTkZvMbBsZ1m84K+ZCGY5O9Fq7p3OG5ytCeDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7Uy82eTjP8AAA6/T4nF7FXe9vn9VrhSMLdDJNQQLZxxlWJ71qxsTmChBNrMPb7tiH40WGUrjXDll3WVLZtES1VfjOT/BjmEktWCAxgMVFgKjcIW/5wWu3wQ7Vb4yKeOgSahMz5VlbylIH7icr+kPYontub3EmtUGXBhBtKWIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joc1cDfP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5607c2f1598so2236519e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687269; x=1758292069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=joc1cDfPDmNxrVrnsk35GiUVgBpO3oSxEGlmtf7cz5zwa7R4qCPYM0Jn9285n67I92
         SYqHhgQWTPkwQ5cpLrYQ4kbnCGV5d93a+slSx8/CgU0LY3H2Ns4jNQ8q8ImH+MYfJcwr
         rOPlG6ebtjntN91qacbfaahjIj8y6tzXpq3/kHrGC2B92OLYoSTA5hfMqYAPc+78pp4v
         4/3OFM6SGdGWNltT4Y/sjmLQshgL0BXmHlYL8FMmu9XwSkBLSsFOMrdz/AtkFWdz1k2D
         VMDw7CEkaOR75XvWOZfTBbG1l75iNZCFhQ+ruBLMLpIsw0Ire8oq8dfH92dx9S6+sMQQ
         emEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687269; x=1758292069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=FS9lSOr0r+nj3j5c8auSMvxT5UGHGCeVz0GwaXEq1ycAEjGj+Kkj0a2OloXuEc1j2N
         RVQ5SYEkgeL9z5ke2H3LrjP4FBrDrz25xkqWWB8gR0otoEe2AVdg6elqeACLX1Wr3gpd
         T2KSu6SLShtK0J3+mFRIJF/mhmaful6FzXPyJJlsQ1t+WmCayzFw87jDW5SGTayYUx7/
         UOByLw5tIWqSU4zyxfoi7AqMQzIgtvdq5bddb2mOnoFbQo13d7dHuxCcGuKLAHhods0e
         cFw3+YKesAAFPeTYkoZz28II165FJ8E1BXeBHA8PPNAdK92RlTQiI4FQmWuSthQVlc2M
         8BIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcr3BWQky5kfuH84Z6zmdwbhu1Zk//kC5Px8lK3rmD5WJdt29ar+JsP/lu9YOz0rj/EeSYG1jhwITvknI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFiShxuL2o3xk/8QhOYPfrU3/wFWrLE6spa9rngjC98iGMjyx
	tWbkKD7E0m9MhHE9OJvBfcJr1cD5R4s/sxtiXpUV/Q6NQHKTZkPFCJQfHYHEp4Pm42I=
X-Gm-Gg: ASbGnctxWTZrC65hE5cpL6JcQcX8bNZ9btosFZ4jIQNP5/xNnh7zUxb9YZmxZhWbQmT
	ye0su4ZDxyVbtfwRtU+TKzKMRvdhK6NWfUMh7peugfidrCRVleS+WunVqckD+fuBYUPL92UBtXi
	FOMbB+SwYR5JJubFGG4NIdrOnVl8DyDqZIAhRp1oaFHA0exbUAR7mjeAkNOe1KFREh4VxGOOUqU
	PgUzyl5mwsUNIkzx7qSbGyfm9JNFVOuEG8HLim25+/xIJy/f0yVxLzLCIp4eC/xCpnTALBWxSV8
	fQ9xxRKr2WYbgbO5cdg/nx4KhBlgkCbB/yN01HP471k7eiTLeT8/eQHGrGjXUdy2QKNKCoSBzgL
	Am541EB3gxF23Gqa5k+3EksSm/TTvjNc3djG8WU9ekSAb02Sd9d4GL34=
X-Google-Smtp-Source: AGHT+IEElym8VeagaBl+nzdswFEmu7VAD/4OSv6vmc7bSL5e4EMGTxBVOdIqLiD6z+3vnjFAisOdJQ==
X-Received: by 2002:a19:6a13:0:b0:55f:6a68:c44a with SMTP id 2adb3069b0e04-5704a105f44mr667707e87.2.1757687268467;
        Fri, 12 Sep 2025 07:27:48 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63daesm1171816e87.77.2025.09.12.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:27:48 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Fri, 12 Sep 2025 17:27:35 +0300
Message-ID: <20250912142735.2843958-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
Heiko Stübner <heiko@sntech.de> all SoCs since 2012 have power
domains so the support should be enabled by default
on both arm and arm64.

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

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Heiko Stübner <heiko@sntech.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/pmdomain/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
index 218d43186e5b9..17f2e6fe86b6f 100644
--- a/drivers/pmdomain/rockchip/Kconfig
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
 
 config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
+	default ARCH_ROCKCHIP
 	depends on PM
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	depends on REGULATOR
-- 
2.34.1


