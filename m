Return-Path: <linux-kernel+bounces-896365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE6C5034D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7FF3B3940
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8F22A4E9;
	Wed, 12 Nov 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PdLyK7NK"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF52253A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910698; cv=none; b=C+FLl7mc06Ysi7Gr3CQpJ6+kZk8dtKocX+nXGw23iRBFmvFckqZXfDLzPd48pwdAprWg1RnBmsl9A6kYZMbZ2Uj9qHimr4Kb23005bFAzf6ahkzbfAOdCTlWN5pVXH1fkO5pIWUH/d6z8arTuW5PLyu6P70RAgB+ZXEsvSuqa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910698; c=relaxed/simple;
	bh=ERzhnnomwvujPwo520L90t0JWUy/gu8UtiK/UV0WaMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nePTU+pAMDNG8g97LLFpJF/KTpnMmU+eEBRoliZQcD3qceXrsOCSoglS6TWQFpIuxqNixkBYxqzdzPZ2SY1S99Uk/f30N5PpBFz6TNmjTb1V+BrEqX7tsi4ITdTS8GCbV3jrDwJqMvUl+AAXhCh5THBAllHTv5n+FPcXPGkSAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PdLyK7NK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c85c097a-b787-4582-aab5-dede9c43f040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762910684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/i3GfIvLf3jSL0Nu3zD7O50gxNQg7kj48hWTHJwFyA=;
	b=PdLyK7NKiAq/yogXtVDU5YUYnQTHtVPBeYOHEVxvW7Ni+Lb/4j4LOSqcj9rpsqvKJyoqwK
	VwHDCAeS6MtGtjmDeCL1sWOvTXREvt/7e3TUTxI8y9Nfbu5f6MXUm2QcEnih4P0fggOtFS
	HIHXieChvQBCmpTqDR6OVZeQC/i75eM=
Date: Wed, 12 Nov 2025 09:24:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/3] net: stmmac: pci: Use generic PCI
 suspend/resume routines
To: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Philipp Stanner <phasta@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111101158.15630-1-ziyao@disroot.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20251111101158.15630-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/11 18:11, Yao Zi 写道:
> Convert STMMAC PCI glue driver to use the generic platform
> suspend/resume routines for PCI controllers, instead of implementing its
> own one.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>


Thanks,
Yanteng
> ---
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
>   .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++-----------------
>   2 files changed, 6 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index d2bff28fe409..00df980fd4e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -378,11 +378,8 @@ config DWMAC_LOONGSON
>   	  This selects the LOONGSON PCI bus support for the stmmac driver,
>   	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
>   
> -endif
> -
>   config STMMAC_PCI
>   	tristate "STMMAC PCI bus support"
> -	depends on STMMAC_ETH && PCI
>   	depends on COMMON_CLK
>   	help
>   	  This selects the platform specific bus support for the stmmac driver.
> @@ -392,4 +389,7 @@ config STMMAC_PCI
>   	  If you have a controller with this interface, say Y or M here.
>   
>   	  If unsure, say N.
> +
> +endif
> +
>   endif
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 94b3a3b27270..fa92be672c54 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -14,6 +14,7 @@
>   #include <linux/dmi.h>
>   
>   #include "stmmac.h"
> +#include "stmmac_libpci.h"
>   
>   struct stmmac_pci_info {
>   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> @@ -139,37 +140,6 @@ static const struct stmmac_pci_info snps_gmac5_pci_info = {
>   	.setup = snps_gmac5_default_data,
>   };
>   
> -static int stmmac_pci_suspend(struct device *dev, void *bsp_priv)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -
> -	ret = pci_save_state(pdev);
> -	if (ret)
> -		return ret;
> -
> -	pci_disable_device(pdev);
> -	pci_wake_from_d3(pdev, true);
> -	return 0;
> -}
> -
> -static int stmmac_pci_resume(struct device *dev, void *bsp_priv)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -
> -	pci_restore_state(pdev);
> -	pci_set_power_state(pdev, PCI_D0);
> -
> -	ret = pci_enable_device(pdev);
> -	if (ret)
> -		return ret;
> -
> -	pci_set_master(pdev);
> -
> -	return 0;
> -}
> -
>   /**
>    * stmmac_pci_probe
>    *
> @@ -249,8 +219,8 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>   	plat->safety_feat_cfg->prtyen = 1;
>   	plat->safety_feat_cfg->tmouten = 1;
>   
> -	plat->suspend = stmmac_pci_suspend;
> -	plat->resume = stmmac_pci_resume;
> +	plat->suspend = stmmac_pci_plat_suspend;
> +	plat->resume = stmmac_pci_plat_resume;
>   
>   	return stmmac_dvr_probe(&pdev->dev, plat, &res);
>   }

