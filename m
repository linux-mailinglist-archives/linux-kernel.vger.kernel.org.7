Return-Path: <linux-kernel+bounces-757861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C16BB1C784
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8E7B10B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937528C867;
	Wed,  6 Aug 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRj1cGqe"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723828A71E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489912; cv=none; b=hadzl+PPFXf9Uqb53srTcvth5xAwbDfz9cztzANAfbxq9AJl65zTtgq22Qgy7IL29nM7XWlG5+V4ZdWytinc1HALVZL7TPljWK0hV8K70o2zrry8bhbs6aeDF7rWFNV+qe2EWktp6WwoGe/EhFmR4c+rQtqbmOORPBbwGbiOdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489912; c=relaxed/simple;
	bh=Sfg0GSbou+8V/x0l0JpzQXAfO2yUmEE4nmZ8Dwn/SaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T0rf/OyQlOyvPLFgPj3yweLT8gqq67GzKHcsaN5qoNO2Z0qqcqBCJdSU/Rws/dzfh5nwolMqVaVsvPP8s03k+D9GNB3Y+Rbwtd8aZ/qHzcgGsgzGro4TuQb/K7tAzxcWtm2/mjIpRyXtTQmUxuDjSh6wAJ2Sgg4+Yu8uKDOn9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nRj1cGqe; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576EIDHA533654;
	Wed, 6 Aug 2025 09:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754489893;
	bh=0mZGzS0QWiURQ97XlwTObgVhbrqqFm/z0cPMS39Y0vE=;
	h=From:To:CC:Subject:Date;
	b=nRj1cGqe8DYiEDPHF2IosYaKiP71l85wdJR+izXf8Yk3Q52Hm9HcZAs9Rp5Lf7NBs
	 msyjOAex7wZBUGyuJpQVU/1IMB4Yl6lvhO+QovtOgky3x3z305T2QWHqq1mK6sXNdm
	 ejwit472wZRvb2OMEMnkyWcHZ6fpazjfkKSoOrN8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576EICJL3625938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 09:18:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 09:18:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 09:18:12 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576EI9EM3951059;
	Wed, 6 Aug 2025 09:18:09 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>
CC: <krzk@kernel.org>, <afd@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>,
        <b-padhi@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: multi_v7_defconfig: Enable more OMAP related configs
Date: Wed, 6 Aug 2025 19:48:08 +0530
Message-ID: <20250806141808.4013462-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Sinthu Raja <sinthu.raja@ti.com>

This allows us to enable various peripherals in the TI OMAP family
platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
AM57XX-EVM using the multi_v7_defconfig, instead of only with the
OMAP specific defconfigs.

IKCONFIG*:
Allows reading the current kernel configuration through /proc/config.gz

{TI/DRA752}_THERMAL:
Enables TI's bandgap temperature sensor and thermal zone framework for
thermal management on the OMAP SoC family.

THERMAL_EMULATION:
Adds emul_temp sysfs node under thermal zones to allow emulating
temperature changes.

DRM_PANEL_OSD_OSD101T2587_53TS:
TOUCHSCREEN_EDT_FT5X06:
Enables OSD LCD panel and capacitive touchscreen support used in AM57XX
evaluation modules.

SPI_TI_QSPI:
Enables TI's QSPI master controller driver for accessing flash devices
on OMAP5 platforms.

FANOTIFY:
Allows sending open file descriptors to userspace listeners along with
file access events.

USER_NS:
NAMESPACES:
Enable user NS to provide user info of different users for different
process.

POSIX_MQUEUE:
Supports POSIX message queues for priority-based IPC.

BSD_PROCESS_ACCT:
Enables BSD process accounting to allow user space program to write
process accounting information to a file.

bloat-o-meter:
Total: Before=24537037, After=24640034, chg +0.42%

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Co-developed-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f2822eeefb95..d88177cbf2ce 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,7 +1,13 @@
 CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
@@ -333,7 +339,7 @@ CONFIG_TOUCHSCREEN_ADC=m
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_MMS114=m
-CONFIG_TOUCHSCREEN_EDT_FT5X06=m
+CONFIG_TOUCHSCREEN_EDT_FT5X06=y
 CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
@@ -453,6 +459,7 @@ CONFIG_SPI_GXP=m
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
+CONFIG_SPI_TI_QSPI=y
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=m
@@ -547,6 +554,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
+CONFIG_THERMAL_EMULATION=y
 CONFIG_IMX_THERMAL=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=y
@@ -555,6 +563,8 @@ CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
+CONFIG_TI_THERMAL=y
+CONFIG_DRA752_THERMAL=y
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA30_TSENSOR=m
@@ -747,6 +757,7 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
 CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
+CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
 CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
@@ -1260,6 +1271,7 @@ CONFIG_COUNTER=m
 CONFIG_STM32_LPTIMER_CNT=m
 CONFIG_STM32_TIMER_CNT=m
 CONFIG_EXT4_FS=y
+CONFIG_FANOTIFY=y
 CONFIG_AUTOFS_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
2.34.1


