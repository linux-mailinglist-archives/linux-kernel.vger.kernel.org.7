Return-Path: <linux-kernel+bounces-812356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75ECB536E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBC45667D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD231355A;
	Thu, 11 Sep 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Koi6kau1"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155882DE711
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603034; cv=none; b=BFG8+5xEdm8d09DarEw6WKJHDR09rhw9/FRZpK0W5RVArVbklIpj+rhQO6U+ujsBxjUHGRN+iqPAvbyYGcyqnRCDHmHeegDB88KMmhTF7KiCLOxue5Qioei/s93HPE/3KMkwHFKgbon8ZwRNlLYdG2B0z2vc7UotnZ+YLI9G2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603034; c=relaxed/simple;
	bh=a6H3Ra4AqDj0K/IuYefQV3ricMHpTCapSCuM5OizOkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ovgg+H+W5gHg0vDGVPCFO2k1meNnUOGNs2yfDp7S8bY1UPApyCn62ypp35+mpYG3gt00krhahydHxhwO3F9Jqt8CIhDYNLRsk7OaouDyKKdPC0y8ZD4hBFXixn13c6XSggVjk8rlHzZF0qFsO/FuGcp0Wu/iUGC+WvUhOmQhHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Koi6kau1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-723ad237d1eso7495527b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757603031; x=1758207831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/w7jeIhxEU1VX6hLopNUH34xEqm4xjt1JcqLEqwaNkE=;
        b=Koi6kau1tkOg55rE126OAzuj6Tv8/L8SWd4GDFNLIjH35x+aHZvLlqeVKK8PM4Onq1
         g8ZEf5ECOsNRgc8q8V7sx0Xs3P30y2drB/VV1r/jBDy2roTdEl6Y8M/mvidzS1JmNsLW
         X/xo66wTUHflFTIqVtRgyxilT1Hdos6r4KSTHKeVZSYMA2zktm/6lF9COzKKrlX9zAse
         sJ08AOaW2WhMMb+ePBGtWACIkBWdR/AezPPc5nRBF5H7bFD7ICl7SD2ZRgLN1FhEsm9p
         x9wWr7cSXIGLBXNlbLta9VzOQ6VM7aVbEaPLEaiJL800hYNsRQVjD8EDH4vfht2vNuYl
         0CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603031; x=1758207831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/w7jeIhxEU1VX6hLopNUH34xEqm4xjt1JcqLEqwaNkE=;
        b=t2js5Zenfy9eiqM5qzvqMT5I8qb9XGFhJn1Fp2Jgd1Ysi8nhH02vLn8H428YV5SomW
         jKxpiLrm+BEQ0NN5s4lRInjE8VIdC6HDysadL3gcWzOy+tlHXoAfnzwOk/Z4KS1kP13B
         WRPkUZAScnORrOmLIIj0AorVkXqeoPiRimKC796TlGg+Va5fU833wa+zwyIxSlnrFlTy
         +OEUpc8YlxuDv4Ci1Xer3fvA0dIhFZT/jFHzXGXm7ogtvvL2vnxe7bemudonVK2gk4oU
         rwFhNYeuhgcX3ubq/mf9qZQiSPr31Tm2t9cdM7o9/PnhprRdC8AYTAIlDMdmJQqg4wDc
         z7og==
X-Forwarded-Encrypted: i=1; AJvYcCWzY2wc3eEmDTPmtRl9PhFwuO7d7pKDh/418bXS9OXJtVKsPscnh8NOfh5xf46OO2tpKK6L2fm70KjdQQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymlt5VCQcOA3TxcqF2nSnX5CI5QSXKAP7jfWeBkPUUKCtqWG5y
	FbrMPl4ii+yp5BkAWoNa8c7ZAOQ2PrPj4ICLLfo+UZSJAVftKOl/4oP7acRULtQbkpq+92YbPNn
	r/fdutT6aW+HGmm5tQLtXXhcClYP96oopVzhHmvqiDg==
X-Gm-Gg: ASbGncuLFz1ao7JkPeS2myTfCspd8j17kKl2QdRrGfZ/OYJeyV35SRDYWGu73dOBzN7
	y+YWvXAPg+QAxKdc+q+z+3n/FqOFYGUFkUZ3KB2z/TLGOUukNUEb86mQKHvBYmJitN9SJ7SFGrO
	9DN2qMd2NbJ6uYh789CBZYn8r/lDU/hF5LZ0BV76whRGvO7EVw0nRhbVi2OrAfuHzzrDXSlLwwy
	eFtUDqB
X-Google-Smtp-Source: AGHT+IHFceNCSpX9awcDRtR1CoMEkUkd9UpK2jzTywvTpSQl8kjFQrhtm7dGuSIsbZRSNOHqzVHDVTGb3XTXpRfIkvo=
X-Received: by 2002:a05:690c:6204:b0:727:637f:873b with SMTP id
 00721157ae682-727f583f1a7mr165026207b3.47.1757603029984; Thu, 11 Sep 2025
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 17:03:14 +0200
X-Gm-Features: Ac12FXx-qAZWZEYtApmNXinr5BvTwqjhp326cnDtPKsat5aizPWLVlPuVv4V9Is
Message-ID: <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to ROCKCHIP_PM_DOMAINS
To: arnd@arndb.de, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, geert+renesas@glider.be, 
	angelogioacchino.delregno@collabora.com, dlan@gentoo.org, 
	zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"

+ Heiko

On Thu, 11 Sept 2025 at 16:43, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> On rockpi4b, mounting rootfs from mmc fails unless ROCKCHIP_PM_DOMAINS
> is enabled. This dependency is not exactly clear so make it really
> explicit.
>
> Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=y:
>
> https://ledge.validation.linaro.org/scheduler/job/119268
>
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> /dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
> dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
> root '/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e' doesn't exist or does not contain a /dev.
> rk_gmac-dwmac fe300000.ethernet: deferred probe timeout, ignoring dependency
> rk_gmac-dwmac fe300000.ethernet: probe with driver rk_gmac-dwmac failed with error -110
> rk_iommu ff650800.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff650800.iommu: probe with driver rk_iommu failed with error -110
> dwmmc_rockchip fe320000.mmc: deferred probe timeout, ignoring dependency
> rockchip-typec-phy ff7c0000.phy: deferred probe timeout, ignoring dependency
> dwmmc_rockchip fe320000.mmc: probe with driver dwmmc_rockchip failed with error -110
> rockchip-typec-phy ff7c0000.phy: probe with driver rockchip-typec-phy failed with error -110
> rockchip-typec-phy ff800000.phy: deferred probe timeout, ignoring dependency
> rockchip-typec-phy ff800000.phy: probe with driver rockchip-typec-phy failed with error -110
> rk_iommu ff660480.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff660480.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff8f3f00.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff8f3f00.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff903f00.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff903f00.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff914000.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff914000.iommu: probe with driver rk_iommu failed with error -110
> rk_iommu ff924000.iommu: deferred probe timeout, ignoring dependency
> rk_iommu ff924000.iommu: probe with driver rk_iommu failed with error -110
> platform fe800000.usb: deferred probe pending: platform: wait for supplier /phy@ff7c0000/usb3-port
> sdhci-arasan fe330000.mmc: deferred probe timeout, ignoring dependency
> platform fe900000.usb: deferred probe pending: platform: wait for supplier /phy@ff800000/usb3-port
> sdhci-arasan fe330000.mmc: probe with driver sdhci-arasan failed with error -110
> platform ff1d0000.spi: deferred probe pending: (reason unknown)
> platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error
>
> Working boot with CONFIG_ROCKCHIP_PM_DOMAINS=y:
>
> https://ledge.validation.linaro.org/scheduler/job/119272
>
> dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
> dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
> dwmmc_rockchip fe320000.mmc: Version ID is 270a
> dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 45,32 bit host data width,256 deep fifo
> dwmmc_rockchip fe320000.mmc: Got CD GPIO
> ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 44, base_baud = 1500000) is a 16550A
> printk: legacy console [ttyS2] enabled
> mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> dw_wdt ff848000.watchdog: No valid TOPs array specified
> mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
> mmc0: CQHCI version 5.10
> rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
> mmc1: new high speed SDHC card at address aaaa
> fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
> rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
> mmcblk1: mmc1:aaaa SC16G 14.8 GiB
> rk_gmac-dwmac fe300000.ethernet: IRQ sfty not found
> GPT:Primary header thinks Alt. header is not at the end of the disk.
> rk_gmac-dwmac fe300000.ethernet: Deprecated MDIO bus assumption used
> GPT:1978417 != 31116287
> rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
> GPT:Alternate GPT header not at the end of the disk.
> rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
> GPT:1978417 != 31116287
> rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
> GPT: Use GNU Parted to correct GPT errors.
> rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
>  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8
>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7232de1c06887..8664df524f7a7 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -866,7 +866,7 @@ config MMC_DW_PCI
>
>  config MMC_DW_ROCKCHIP
>         tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
> -       depends on MMC_DW && ARCH_ROCKCHIP
> +       depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS

Rather than "depends on", I think a "select" is better to be added
from the platform's Kconfig. Probably drivers/soc/rockchip/Kconfig is
where to put this.

Assuming that ROCKCHIP_PM_DOMAINS is a critical piece for most
Rockchip platforms to work.

>         select MMC_DW_PLTFM
>         help
>           This selects support for Rockchip SoC specific extensions to the
> --
> 2.34.1
>

