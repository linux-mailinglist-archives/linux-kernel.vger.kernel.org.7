Return-Path: <linux-kernel+bounces-757271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F154B1C01C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181A57AEEE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89335202983;
	Wed,  6 Aug 2025 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ukV00SyL"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AFEACE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459734; cv=none; b=LK/6vkCgJVgQkevSkYfi9Ette6CvPhuAtzxH1r82+R6m9iRc3uhEYjeWThZdOMcVAsGixw6ooq4PAr6wrzxrlxdeiMHPDCKFaMxTU9oiO9g0p6sRW4KmyRkTg9Stz/vEZjmNtm/SQhHvd/I9kMip6DDeOb+uMIEKZEMI+2tEboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459734; c=relaxed/simple;
	bh=KMNxKsuvBgIyNdgFvtgwLyzVEBm6uRzDHm/fMzoCbjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BScGBBKRhVM4oVGrnt0J0AIXgm+9ruwq+QAsj3jpgUetfdFs33HkDWecdBmmA/4EDuz3zxyJXv+LFh+1Puiptdl0GkfZ5HQtxAnFXkBOCHVslDQeoNdkIB4wQAQomMAInFvrL0leFqGkFkVCPZaRdBLcGgA7tF7WGFzsqfI8dtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ukV00SyL; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5765tOjD052489;
	Wed, 6 Aug 2025 00:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754459724;
	bh=gcuSVn9btBKHc65kLz4H5AYTIgr2bH7AoR+0HbNH/CM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ukV00SyLTfHvl3tmbh2Hvkaq76gjpkBqzVcR57VB8EDfaOpn1Kgjv+7SO9FaKDSEn
	 X9Z4wcB0ugHpRv00Rgd7aWcdbBWb1wJjJ0jzABdrAfQsJYXenNfrpkOLVtolWREHN1
	 QUCb9skmabje6lwSW4pQe2+mqoXQQRE1ptWCOb1M=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5765tOUn2860820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 00:55:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 00:55:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 00:55:23 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5765tKDV3348142;
	Wed, 6 Aug 2025 00:55:21 -0500
Message-ID: <385d9185-e187-48c2-9854-10cdd98d2f1b@ti.com>
Date: Wed, 6 Aug 2025 11:25:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: phy: cadence: cdns-dphy: Enable lower
 resolutions in dphy
To: Harikrishna Shenoy <h-shenoy@ti.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <s-jain1@ti.com>
References: <20250806052650.429767-1-h-shenoy@ti.com>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <20250806052650.429767-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 06/08/25 10:56, Harikrishna Shenoy wrote:
> Enable support for hs_clk_rate between 80-160 Mbps cdns dphy

Enable support for data lane rates between 80-160 Mbps

> as mentioned in TRM [0] by setting the pll_opdiv field to 16.
> This change enables lower resolutions like 640x480 at 60Hz.
> 
> [0]: https://www.ti.com/lit/zip/spruil1
> (Table 12-552. DPHY_TX_PLL_CTRL Register Field Descriptions)
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>

With suggested change,
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
> Changes in v2:
> - Updated commit message and title.
> - Added Reviewed-by tag.
> - Link to v1: https://lore.kernel.org/all/1ebb82ea-4b6c-4496-b7c0-17d4168d8ddf@ti.com/
> 
> Test log: https://gist.github.com/h-shenoy/3975156baf403a0ff8dbcce5b49b2b89
> 
>  drivers/phy/cadence/cdns-dphy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index ed87a3970f83..9abed2ece9b0 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -139,7 +139,7 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  
>  	dlane_bps = opts->hs_clk_rate;
>  
> -	if (dlane_bps > 2500000000UL || dlane_bps < 160000000UL)
> +	if (dlane_bps > 2500000000UL || dlane_bps < 80000000UL)
>  		return -EINVAL;
>  	else if (dlane_bps >= 1250000000)
>  		cfg->pll_opdiv = 1;
> @@ -149,6 +149,8 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  		cfg->pll_opdiv = 4;
>  	else if (dlane_bps >= 160000000)
>  		cfg->pll_opdiv = 8;
> +	else if (dlane_bps >= 80000000)
> +		cfg->pll_opdiv = 16;
>  
>  	cfg->pll_fbdiv = DIV_ROUND_UP_ULL(dlane_bps * 2 * cfg->pll_opdiv *
>  					  cfg->pll_ipdiv,


