Return-Path: <linux-kernel+bounces-757883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE04B1C7DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3110E18A6F16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894CC1D88D0;
	Wed,  6 Aug 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GlGZkvQP"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAF192B96
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491683; cv=none; b=lXKfSB2TSgp0txML8HYwMCPjhs7iggUc7CSJZOEXxxXxlXZu2MH6DjUVhyIXvElsOsjhnjX1XB3gUOeuJvGy1f0E6Sm0UB+tUcGfSmcRcOX8RcITQdkw4uSkZD/mYJuiFMbTfJgj/Hx8N6Xj2mrntc58M1zq8H/NyFexOozQrx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491683; c=relaxed/simple;
	bh=nagcVWDgivgYkG4H/gH1qCcHu6Fjcnp2VtEXdVXsMvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sjosWLEG5j+801gUaLWj6HYpv+xEIo3NRHEFtlYO6qK49KCM6gRAsMngTlW1FJJUg7Zz/xwJiBqn2LUK9yzcZK+i97M4g6PMfvmZF4qJTBn8zThM50knG3ZGeSGW0/1E9SS2e/kZ644PGuzVpjoAAPS06Kquea8DYaszdniSb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GlGZkvQP; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576EloOm539020;
	Wed, 6 Aug 2025 09:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754491670;
	bh=nNdYi/P3Vm7YhgLbOZzyZO2vNSPhfW3P2AS/YBfGhXM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GlGZkvQP3gvJXS/SyQ/wO1mAbb6UunwxzrXL7dBh+Lv9TB2czQUR6QvBpt28Sesc7
	 /+B4Rbgtni8eeybF3l+b6kNiWX8Qb+EXm1yefWloMoHshIgic51GUKVkr4SV9RgqJT
	 SBG8Va6z8wNfWFQSmNy0eZ+skoCH4ZsRtOlKB+FY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576Eloan3163511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 09:47:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 09:47:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 09:47:49 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576ElncW3693508;
	Wed, 6 Aug 2025 09:47:49 -0500
Message-ID: <11e7159a-d712-405c-a345-6dbb8171c1d1@ti.com>
Date: Wed, 6 Aug 2025 09:47:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: multi_v7_defconfig: Enable more OMAP related configs
To: Beleswar Padhi <b-padhi@ti.com>, <linux@armlinux.org.uk>, <arnd@arndb.de>
CC: <krzk@kernel.org>, <u-kumar1@ti.com>, <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250806141808.4013462-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250806141808.4013462-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/6/25 9:18 AM, Beleswar Padhi wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> This allows us to enable various peripherals in the TI OMAP family
> platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
> AM57XX-EVM using the multi_v7_defconfig, instead of only with the
> OMAP specific defconfigs.
> 
> IKCONFIG*:
> Allows reading the current kernel configuration through /proc/config.gz
> 

This gives the "what" the config does, but not the "why" it should be
in multi_v7_defconfig. For this item a better "why" would be something
explaining that the majority of platform specific defconfigs have this
and so does the main ARM64 defconfig, so it should be reasonable for
the main common ARMv7 defconfig to also have it.

Anyway these are all reasonable to have and help us make this shared
defconfig useful for more platforms,

Acked-by: Andrew Davis <afd@ti.com>

> {TI/DRA752}_THERMAL:
> Enables TI's bandgap temperature sensor and thermal zone framework for
> thermal management on the OMAP SoC family.
> 
> THERMAL_EMULATION:
> Adds emul_temp sysfs node under thermal zones to allow emulating
> temperature changes.
> 
> DRM_PANEL_OSD_OSD101T2587_53TS:
> TOUCHSCREEN_EDT_FT5X06:
> Enables OSD LCD panel and capacitive touchscreen support used in AM57XX
> evaluation modules.
> 
> SPI_TI_QSPI:
> Enables TI's QSPI master controller driver for accessing flash devices
> on OMAP5 platforms.
> 
> FANOTIFY:
> Allows sending open file descriptors to userspace listeners along with
> file access events.
> 
> USER_NS:
> NAMESPACES:
> Enable user NS to provide user info of different users for different
> process.
> 
> POSIX_MQUEUE:
> Supports POSIX message queues for priority-based IPC.
> 
> BSD_PROCESS_ACCT:
> Enables BSD process accounting to allow user space program to write
> process accounting information to a file.
> 
> bloat-o-meter:
> Total: Before=24537037, After=24640034, chg +0.42%
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> Co-developed-by: Carlos Hernandez <ceh@ti.com>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f2822eeefb95..d88177cbf2ce 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1,7 +1,13 @@
>   CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
>   CONFIG_NO_HZ_IDLE=y
>   CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BSD_PROCESS_ACCT=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
>   CONFIG_CGROUPS=y
> +CONFIG_NAMESPACES=y
> +CONFIG_USER_NS=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_EXPERT=y
>   CONFIG_PERF_EVENTS=y
> @@ -333,7 +339,7 @@ CONFIG_TOUCHSCREEN_ADC=m
>   CONFIG_TOUCHSCREEN_ATMEL_MXT=m
>   CONFIG_TOUCHSCREEN_ELAN=m
>   CONFIG_TOUCHSCREEN_MMS114=m
> -CONFIG_TOUCHSCREEN_EDT_FT5X06=m
> +CONFIG_TOUCHSCREEN_EDT_FT5X06=y
>   CONFIG_TOUCHSCREEN_WM97XX=m
>   CONFIG_TOUCHSCREEN_ST1232=m
>   CONFIG_TOUCHSCREEN_STMPE=y
> @@ -453,6 +459,7 @@ CONFIG_SPI_GXP=m
>   CONFIG_SPI_GPIO=m
>   CONFIG_SPI_FSL_DSPI=m
>   CONFIG_SPI_OMAP24XX=y
> +CONFIG_SPI_TI_QSPI=y
>   CONFIG_SPI_ORION=y
>   CONFIG_SPI_PL022=y
>   CONFIG_SPI_ROCKCHIP=m
> @@ -547,6 +554,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
>   CONFIG_SENSORS_INA2XX=m
>   CONFIG_CPU_THERMAL=y
>   CONFIG_DEVFREQ_THERMAL=y
> +CONFIG_THERMAL_EMULATION=y
>   CONFIG_IMX_THERMAL=y
>   CONFIG_QORIQ_THERMAL=m
>   CONFIG_ROCKCHIP_THERMAL=y
> @@ -555,6 +563,8 @@ CONFIG_ARMADA_THERMAL=y
>   CONFIG_BCM2711_THERMAL=m
>   CONFIG_BCM2835_THERMAL=m
>   CONFIG_BRCMSTB_THERMAL=m
> +CONFIG_TI_THERMAL=y
> +CONFIG_DRA752_THERMAL=y
>   CONFIG_ST_THERMAL_MEMMAP=y
>   CONFIG_TEGRA_SOCTHERM=m
>   CONFIG_TEGRA30_TSENSOR=m
> @@ -747,6 +757,7 @@ CONFIG_DRM_PANEL_SIMPLE=y
>   CONFIG_DRM_PANEL_EDP=y
>   CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
>   CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
> +CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
>   CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> @@ -1260,6 +1271,7 @@ CONFIG_COUNTER=m
>   CONFIG_STM32_LPTIMER_CNT=m
>   CONFIG_STM32_TIMER_CNT=m
>   CONFIG_EXT4_FS=y
> +CONFIG_FANOTIFY=y
>   CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y


