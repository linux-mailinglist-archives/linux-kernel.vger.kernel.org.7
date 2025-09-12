Return-Path: <linux-kernel+bounces-814279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B30B551D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60A4BA18F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4E3164DC;
	Fri, 12 Sep 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZSvTm+E"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1713191C7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687773; cv=none; b=YmOFUOo7N4xSSvdnM4g9jIz+uIUtt3VDEbMbfvIo8UXrD48qPWvFm+YzyNcuhqVjY/Mg6xAFFQmkyHoVbMtLqUKkc7a2xHGgU9jhY9JP7bkr2yu8Zwb28M8euUR9ZvTC0H+BsAtAeGU1Oa+bgLM9YUyyJjHuzkHSu4jUN+yT+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687773; c=relaxed/simple;
	bh=j9kaTJ0bKCkv+asIfBZ9xeTzXm5nY/AgZMBQCcjreZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DGzG7Z2Fb0zdlfiOvUXGzQW+Tgif93EessjxMUfcirlyMcPOdD2xN6MXk7uOMqtYcBNcMWWHkA2eJlw317zjTrvmUyuun/s1AvP6D9R86fst2PZhAud5zCy2Ec/a72I6nvYIU3Wpq0Ta3gAT52iJdSVNTroTbdOWyfiv470bd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZSvTm+E; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f98e7782bso2382675e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687769; x=1758292569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVGUoZl7QKW/jrUqmLdcQ17BKW7CKZzyHqO+L1oBJKU=;
        b=UZSvTm+EtAtoEjBuS9szQw7I8NsqYtJYbx4MnXBvwI2TP9IZtgv9ntnQFZaIiKZ4eb
         7Mw+XRmRzuAjHHI2fePNM44jfX7sNhSnt47ZlAxuu26og+ra+SoKcUdPlQhxyE14th3d
         4SqjMs64nt4dmvjeE4b1Jm/33EG936bfaxMcUGTf/HSksqm15E3jHBfRNXrbAdXkcieF
         3RzUujkVvTz076eCOxROdthH6I1LpITSQA7fAxiJisQHU8VFdNJco5hG6xpZ5zqOqV7u
         PBj/cXKBiyXU86kBtHlMCFnMvuXcLuCYRIL222ATtjdVZ+3nvweE6O3FoT+LDyfiU8s6
         7PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687769; x=1758292569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVGUoZl7QKW/jrUqmLdcQ17BKW7CKZzyHqO+L1oBJKU=;
        b=sFDPUw1/eFgzw10GupuqDSzkh6LUDDaJjAaY2VKEdESxRP9RoQfIo2zgTF84NTCIIg
         Z3eIEPWSWINV3Q4+EYKrUpJEVuPQo++TeuljthifZtuwywfoxUYY7E1wZv23Wr6Dg1Z6
         FNbN9I80v+dXpywfY6YMdfrN46A+8Phq1kd6a+/iruO3TH6wJnwuIwnPI976o0KkFS5K
         g74YavzgHtgGpB1tfa+BySd9GJob5Jh/3PV+7J8Mv69wjvMAU3HdEEJD6qY4idm+UBmf
         pO9TQ21a6s9AivJ62rZp+0MUnSvBK0JAtISIRN2lZMsIajPHJ2P/LiVPmWeKFdFZrirT
         Z4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVjHYHm8pOOQd7PQfEp8TEfUZWCf26N+3B/Nt2VOoKPCeiHBctXnO/rmne8rcsKhzu2nO3oCnwUNuxbsEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvw6f1EunTZJtPZouoA2Z6RN6ZRuteH7kzj9FGoFnK2k/HCoAy
	G/2kK2KAeSxW/AXMdoZEBD72Nt3zlFAtGnq/AGkkUP1xqA8wryA8ZeuIxslipo9sFZc=
X-Gm-Gg: ASbGnctCmGwZ5tvuEzf5Q225PZGQCPr6+8YMLWUM02msa/CRFeKWM1pVI3Wlz4s80V6
	vWMPwYankmYNNWF1K9nyXQpG09GGiK0CQkndmZhvNLefalli1GOr9hHmvaodZBD60hpZ1QJxKlc
	B7dbnqxo0aSgvHXGhSs1SzKqnAtqaiLKnc78HdAOVJILzDy1AQ/wsoehNirkaJ9UpUZp/OlyE4b
	7F0oPRtTmx8IL3H7qt5J0X4WvJkUWLz9KtgmsWUzU9rJagZsdlQ6Slmt7pP950uuQBTHOKZZ56I
	EQspWNXPnp3J4e7OsrUkvzzSL9+hFLQPfKTDKBZSJaDqoCWAiiB6uc8iSwhuAU/dyTK5gpUVnEq
	n6QbWMVjz0ef3ATw1LmErxD/9gV+dvqHSYP2f01qdainvJxPzTL2hDL7YhufYr4VMCA==
X-Google-Smtp-Source: AGHT+IEsSVAtYO0GTF2dOCpPZHkcGM8bs2rKRqzsbq84UASkP3MlDRwNQk3IdJUJ/J8IxFpxvDpQOQ==
X-Received: by 2002:ac2:51d0:0:b0:55f:3ae4:fe55 with SMTP id 2adb3069b0e04-5705be234camr1238974e87.4.1757687767437;
        Fri, 12 Sep 2025 07:36:07 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64fa7192sm1199028e87.124.2025.09.12.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:36:07 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:36:05 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw, geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com, dlan@gentoo.org,
	arnd@arndb.de, zhoubinbin@loongson.cn,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/4] enable ROCKCHIP_PM_DOMAINS
Message-ID: <aMQv1V49xa_MThGq@nuoska>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912143036.2844523-1-mikko.rapeli@linaro.org>
 <20250912142735.2843958-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-1-mikko.rapeli@linaro.org>

Hi,

Sorry I did not use scripts/get_maintainers.pl correctly after
changes were moving from one susbsystem to another based on review
comments but I hope correct maintainers and lists have received
the patches now.

Cheers,

-Mikko

On Fri, Sep 12, 2025 at 05:22:49PM +0300, Mikko Rapeli wrote:
> Hi,
> 
> MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
> on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
> more visible, or the default with ARCH_ROCKCHIP if possible.
> 
> v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
>     by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
>     COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
>     remove PM dependency as suggested by
>     Geert Uytterhoeven <geert@linux-m68k.org>
> 
> v2: changed from "depend on" in MMC driver to "select" as default
>     on ARCH_ROCKCHIP as suggested by Ulf and Heiko
>     https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org
> 
> v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/
> 
> Mikko Rapeli (4):
>   pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>   mmc: add COMPILE_TEST to multiple drivers
>   mmc: remove COMPILE_TEST from MMC_LOONGSON2
>   ARM: rockchip: remove REGULATOR conditional to PM
> 
>  arch/arm/mach-rockchip/Kconfig    |  2 +-
>  drivers/mmc/host/Kconfig          | 10 +++++-----
>  drivers/pmdomain/rockchip/Kconfig |  1 +
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 

On Fri, Sep 12, 2025 at 05:27:35PM +0300, Mikko Rapeli wrote:
> On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> Heiko Stübner <heiko@sntech.de> all SoCs since 2012 have power
> domains so the support should be enabled by default
> on both arm and arm64.
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
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Heiko Stübner <heiko@sntech.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
> index 218d43186e5b9..17f2e6fe86b6f 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
>  
>  config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
> +	default ARCH_ROCKCHIP
>  	depends on PM
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
>  	depends on REGULATOR
> -- 
> 2.34.1
> 

On Fri, Sep 12, 2025 at 05:30:36PM +0300, Mikko Rapeli wrote:
> PM is explicitly enabled in lines just below so
> REGULATOR can be too.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index b7855cc665e94..c90193dd39283 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -13,7 +13,7 @@ config ARCH_ROCKCHIP
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
>  	select DW_APB_TIMER_OF
> -	select REGULATOR if PM
> +	select REGULATOR
>  	select ROCKCHIP_TIMER
>  	select ARM_GLOBAL_TIMER
>  	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> -- 
> 2.34.1
> 


