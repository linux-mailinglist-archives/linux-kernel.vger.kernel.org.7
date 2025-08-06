Return-Path: <linux-kernel+bounces-757725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8EB1C5FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2044016FC0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F128B400;
	Wed,  6 Aug 2025 12:37:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F71CA5E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483850; cv=none; b=QFHMQXp59OX+feEfejGQAe8ASIWlkCvl6I8AyuKapQbgXX9l8kM09oqVHACrmx4D0HRKP6/wEJKl5IN+GtSByfh3SSqZFqCxsv1jvfAHbNFhN6p156bVxAoHPWNgm6MwSPuTsN7dvKgXrWpH56VnhiMH4e+kUsbHUw0WqD0LUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483850; c=relaxed/simple;
	bh=bhG0RFNtYTVRTzy7O4uppFs8+/k9rPPwWKBzuWcVMzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYcZXmYRURAG/75huWDrviODULQOODvoRRnynYDpaDTXbvbJ3S2b855YiY8p3OvNzRX7+M2FYhze1yXZIv1N1e04tKGjxQ1kREhh01OgffPLrD2t3hvvmjdLT9UF3tbNng3QC3y/CDbutfG7YRTuGlQER/d81EZl+wrTKOquPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9912119F0;
	Wed,  6 Aug 2025 05:37:18 -0700 (PDT)
Received: from [10.57.6.125] (unknown [10.57.6.125])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4545A3F5A1;
	Wed,  6 Aug 2025 05:37:24 -0700 (PDT)
Message-ID: <1d57d1b3-cbaa-41d1-baf1-fa2fec1fd285@arm.com>
Date: Wed, 6 Aug 2025 13:37:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
To: Arnd Bergmann <arnd@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuu?= <linux@weissschuh.net>,
 Qiu-ji Chen <chenqiuji666@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
References: <20250805161059.4006484-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250805161059.4006484-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-05 5:10 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> x86 does not use CONFIG_GENERIC_MSI_IRQ, and trying to enable it anyway
> results in a build failure:
> 
> In file included from include/linux/ssb/ssb.h:10,
>                   from drivers/ssb/pcihost_wrapper.c:18:
> include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
>     41 |         msi_alloc_info_t        msiinfo;
>        |                                 ^~~~~~~
> In file included from include/linux/kvm_host.h:19,
>                   from arch/x86/events/intel/core.c:17:
> include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type
>    528 |         msi_alloc_info_t        alloc_info;
> 
> Change the driver to actually build without this symbol and remove the
> incorrect 'select' statements.

Looks OK to me, the Makefile is clearly trying to support building 
without this force-enabled anyway. In fact I'd go as far as saying that 
this also deserves a

Fixes: e8b18c11731d ("cdx: Fix missing GENERIC_MSI_IRQ on compile test")

And FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/cdx/Kconfig                     | 1 -
>   drivers/cdx/cdx.c                       | 2 +-
>   drivers/cdx/controller/Kconfig          | 1 -
>   drivers/cdx/controller/cdx_controller.c | 3 ++-
>   4 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index 3af41f51cf38..1f1e360507d7 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -8,7 +8,6 @@
>   config CDX_BUS
>   	bool "CDX Bus driver"
>   	depends on OF && ARM64 || COMPILE_TEST
> -	select GENERIC_MSI_IRQ
>   	help
>   	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>   	  exposes Fabric devices which uses composable DMA IP to the
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 092306ca2541..1a5c95ba09ba 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -310,7 +310,7 @@ static int cdx_probe(struct device *dev)
>   	 * Setup MSI device data so that generic MSI alloc/free can
>   	 * be used by the device driver.
>   	 */
> -	if (cdx->msi_domain) {
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
>   		error = msi_setup_device_data(&cdx_dev->dev);
>   		if (error)
>   			return error;
> diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
> index 0641a4c21e66..a480b62cbd1f 100644
> --- a/drivers/cdx/controller/Kconfig
> +++ b/drivers/cdx/controller/Kconfig
> @@ -10,7 +10,6 @@ if CDX_BUS
>   config CDX_CONTROLLER
>   	tristate "CDX bus controller"
>   	depends on HAS_DMA
> -	select GENERIC_MSI_IRQ
>   	select REMOTEPROC
>   	select RPMSG
>   	help
> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
> index fca83141e3e6..5e3fd89b6b56 100644
> --- a/drivers/cdx/controller/cdx_controller.c
> +++ b/drivers/cdx/controller/cdx_controller.c
> @@ -193,7 +193,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
>   	cdx->ops = &cdx_ops;
>   
>   	/* Create MSI domain */
> -	cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ))
> +		cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
>   	if (!cdx->msi_domain) {
>   		ret = dev_err_probe(&pdev->dev, -ENODEV, "cdx_msi_domain_init() failed");
>   		goto cdx_msi_fail;


