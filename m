Return-Path: <linux-kernel+bounces-816374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F63B572FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84752162BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8862EFD99;
	Mon, 15 Sep 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn78tMWT"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883E2EFD88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925221; cv=none; b=JnSefuVGzeqSk9En1BwgmncKxZ+k5AjBBzlAwwx7GoNUXtij1Qb1eDUlChOHpD5FkNAyuzgqDkYhx1B95b+s7EGHTQvK+I9y+vy0SzyQZriA6q4s7LBByJm24CoKNsNhVne8S3moScogwpOSJX14V81F54Nad5wzHskCotwnbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925221; c=relaxed/simple;
	bh=yMP93wMP74V7utuukyWPE7pG/2Sf7BC2uR9T05Jq0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGliGi1A5tKCP3XD62PETCYg3pdAF1/qKRgyEGAl1G26vjjMt2lRWddeuX395/qhyrdgA/X++SUz7KceE8IcqD9fgF8FlTf1LrpYk0Bhl1Xoo3n4y1sFeyrbzXZN6q/SBwhqPcYUsI/6AZrNzjF6ghM1y29pcnxSPH+C5rnk3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn78tMWT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f76454f69so4095274e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925218; x=1758530018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhCQj6ti4YtQV74gSqzE0JWivz/zF87SY+DolP82Plk=;
        b=tn78tMWTSUFAUQKx5pC8tfvPX/jB0UEpTNF92D/+j0uatJsjihQv+X7eyozXGybfBD
         M3wppz75tcuWjcHeE8xkKpwydOxzyFkbwhJMG5tjbZHsLRpFOczzXj92sSE0tcB2MPzW
         vVEQZk3Jq6w4fu3dN+BWdISFWR19O3YkVYmP3kTCJwDoVbds8HdYzCL4N1Y8aeim+7vB
         rP8Pn4t8AKSoIAultv6X6bozo6yq0PM1X5wz9MHYrjPth4/+vge1ULs6uYbe02DAcsEK
         t3fi6R+MO2UgnsqokL25YVutf+Ur7IPfB8SjgPqYIQBDSXcKgeBLqZkgS+QWtO6CZWiM
         39XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925218; x=1758530018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhCQj6ti4YtQV74gSqzE0JWivz/zF87SY+DolP82Plk=;
        b=VfHXdFIBrJD/BwmFtqNnJc/RakzbXQ8hjfjMNu9hFNQUY2Xo8QjoWn2UirXBrP4piV
         Gb6nrB+vdIonTQ5mzSDuGeknOuDa8AKcQUnNGbUIlgR+nDR3cwHWA7Z0J7sOqG4M7B1M
         PkrWuvc3MXwboOAjDGiyFU4ZxBsYuHLRFmq7OUQTH2CNIL5ek4JuDdalsCMo4sg6ZAev
         wmRGptGGX72zHNViESqaP9/HsXpMQjOZAYs8N7XhBC9HTpuo5+IJJ750/5tApWx2hHr5
         fn++ZtB8m0+7mHTENj3XBXhs0MJuc864nktg13opoWiFXTsrDa0EEHUVBKekjLSeAN31
         X1dg==
X-Forwarded-Encrypted: i=1; AJvYcCV1jU7Qxf6DBwmCc7WpCZbJOML7jmtPttUZooWsFKO/KIEOLWen5g+4rzaCfoiaP3HCWmppCGtJd8Ceezg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjzWsp2ovBtHDssFNgB1LhVFaWP6pAvkJGQk7e/i0ke/taZ6I
	muyo/LmzhzUJmTr/p/PV/BWt3PI/w4p9IDVlFrO9qIjMh1ByQiWjzRIqPSfqlcIrM9Q=
X-Gm-Gg: ASbGnctv+EvLQQjmND3j83qBm+wLjwVVF+4R4NhDDeC65jBMZRGJ/U/Gei55zqZ1a4H
	2YvumMAh8mVV/04sgn0i18AV8xCoixrhZOnlRGTxQixz3hcLnrHE/EdN4DvT64pZY90H8+ee5HL
	ful7sIvv6vY5hk4qw1ioJSO+EcdE3ZDki6vm8nO+Bp5QTcPFJzoNKEhJN4fcwLjQadNaX69gDYX
	6S/waA6drul/NPMYin1HxlmpWwi2bTt3U2Clq5PIyc/SsztokjcVZOPQdRAJBOtRFTZ9Skuk6Db
	YzP4Yae9CK5Y5eHSc/emwn3Z28ZsOgRSC3jdG4djGrm4oRkgoQZda/J5EV0BYhu/1maLTmSg+0s
	x8AqWTYzYRiOCoZuA5k2+TLHad6ZGSiRUKZFDqsL+JhxXLsVLA1Iaan40TyH44k595g==
X-Google-Smtp-Source: AGHT+IFcLHjxrrKby+Md0dZGhs1/d8RSPE8VaTnfpniHXnX86nTUqa3YezXw3uHyLbu8SVbOt/ZgiQ==
X-Received: by 2002:a05:6512:3158:b0:55f:6831:6eff with SMTP id 2adb3069b0e04-5704ab94916mr3376627e87.4.1757925217538;
        Mon, 15 Sep 2025 01:33:37 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:37 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Mon, 15 Sep 2025 11:33:14 +0300
Message-ID: <20250915083317.2885761-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
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

Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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


