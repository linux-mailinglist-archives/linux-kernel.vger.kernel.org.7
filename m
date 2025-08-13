Return-Path: <linux-kernel+bounces-766979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FEB24D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090CF162C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05123ABBB;
	Wed, 13 Aug 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4wtRnQr"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FA237707
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098795; cv=none; b=RnTZ+XiniYdSPECiEUq09nBgYVCtsESWonJ2qJHUnF31YA2l1vYyTFwf+/vf/OsH7TyzZ1OKJ/4q+0HFID4bGbrySS6HRE6Ew0D2lHEGNMyPmCoLmHoJbch1u4Z8EBAKvxa2UXBIAN1NsLPbIXscwqdF2fHDMVUHk628l4gWKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098795; c=relaxed/simple;
	bh=0oQi+iiyp0itqtl6RIdLSiMtpZOH1aH7EZ9BHYAb/Ts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5WytT3GBbzk+N+dlv6dbKwV4qQvEZh76C5nNmNggBpG4awIf389ipxJdGJhlhxU1fsrbmLDVZ9LjLcu/w0Rf6SPX8NyVNzIucmxoA4/4x0v7RzycVQyQ2crY9WUTAOGU46bnQGJzOIZLJtc0xAGD0QgKsNgFivzDWf4SInOhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s4wtRnQr; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DFQBdF1728877;
	Wed, 13 Aug 2025 10:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755098771;
	bh=f6EBEMYOHLBS/mOMhxKpJJOh8alzp/LH8jTecCxA9Aw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=s4wtRnQrLPtZvTOm8HT2J2f0fERCIvleTqauRAsIg8rBdOGs04emppWtMWLSehjEr
	 BhxqgKtR7G/6gMDl9tES4wpZUnnmLFnksGeoSPXoto11DfOt+RVfDGVW7O6gaOxWqA
	 bHdTe7Hzl4B8jkNuMAz3iEddS8Z7pTsLZKqjl4e8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DFQBLq153772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 10:26:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 10:26:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 10:26:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DFQApP2503743;
	Wed, 13 Aug 2025 10:26:10 -0500
Date: Wed, 13 Aug 2025 10:26:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
Message-ID: <20250813152610.akcdxrzhev6e2kfa@unturned>
References: <20250812-timsi-v2-0-90c8500f3f18@baylibre.com>
 <20250812-timsi-v2-2-90c8500f3f18@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-timsi-v2-2-90c8500f3f18@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 22:36-20250812, Guillaume La Roque wrote:
> Add module support to the TI SCI INTA MSI driver:
> - Change Kconfig from bool to tristate to allow module compilation
> - Add linux/module.h include for module functionality
> - Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros
> 
> This allows the driver to be compiled as a loadable kernel module
> named ti_sci_inta_msi.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/soc/ti/Kconfig           | 5 ++++-
>  drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 1a93001c9e36..0a9eb5ac264b 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -85,7 +85,10 @@ config TI_PRUSS
>  endif # SOC_TI
>  
>  config TI_SCI_INTA_MSI_DOMAIN
> -	bool
> +	tristate "TI SCI INTA MSI Domain driver"
>  	select GENERIC_MSI_IRQ
>  	help
>  	  Driver to enable Interrupt Aggregator specific MSI Domain.
> +
> +	  Say Y here to compile it into the kernel or M to compile it as a
> +	  module. The module will be called ti_sci_inta_msi.
> diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
> index 193266f5e3f9..d92cab319d57 100644
> --- a/drivers/soc/ti/ti_sci_inta_msi.c
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -115,3 +116,7 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Texas Instruments K3 Interrupt Aggregator MSI bus");
> +MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
> 
> -- 
> 2.34.1
> 

If Thomas doesn't mind picking the full series,

Acked-by: Nishanth Menon <nm@ti.com>

This is probably one of the last hold outs for us to move SoC support
into kernel modules.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

