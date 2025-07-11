Return-Path: <linux-kernel+bounces-727147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3BB015C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3108167E84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB2221544;
	Fri, 11 Jul 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P32IEVOy"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF70220698
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221595; cv=none; b=oUKy4n7noaA8HnJ89WQsc+28taryAU+zqxyV4KX5I9p9G+a8e7XVJoXxTotOmPIK5Kx116TZczByMdXml7rPVBMpgHF2mcOFzGu1FSdwj6c6R/b37YAdROwmXlPVP1wLIdve/4hYkvU/1MBjQHRdBGWn6yzp6CyceCwSqAdUZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221595; c=relaxed/simple;
	bh=It/yphRANUlJSlQ/pjrS7u1qQe6YLFeX6f/hFkv/BuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LOf0phMdxW4vHxKaN8FwbYjCk5Cm0YQUjQk4lgw7FR3g27xE78alLt/01y/XfI5xYfd7xgzy5lmcSbj3TIHgZgSjtubTLrFPRKonlez6qhs+7M4qM2UKnESzTH3vqZzdJeYk+e2ukDpNSBrpWsBnJAW4TILaJZVyXuwpZCfGUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P32IEVOy; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B8Cgee1984752;
	Fri, 11 Jul 2025 03:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752221562;
	bh=WMD3xrgiF98me+Yp3/1SVavZPEcDUvxBFb64BI/zS2w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=P32IEVOyFAD8NZJz9gZyCjxXBR4MF9E8XCNrJ3VTWPqXR+a+tZNRbATgglGDDBqj7
	 BP+mvEd9w7r/CMoBxuwFWupEgf7iMndyTUiUK+x2nG+DWdWddJIdWEt6KtvDRWksWz
	 SKNv9ynD6HGEk3a0ZY+CCGFeeXK6WTTiQBjhVozk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B8Cg1J126244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 03:12:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 03:12:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 03:12:41 -0500
Received: from [172.24.227.12] (hkshenoy.dhcp.ti.com [172.24.227.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B8CbQ33138235;
	Fri, 11 Jul 2025 03:12:38 -0500
Message-ID: <c2576c2f-2e19-40e8-bfea-27cf0acdc686@ti.com>
Date: Fri, 11 Jul 2025 13:42:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] phy: cadence: cdns-dphy: Update calibration wait
 time for startup state machine
To: Devarsh Thakkar <devarsht@ti.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <j-choudhary@ti.com>,
        "Shenoy,
 Harikrishna" <h-shenoy@ti.com>
References: <20250704125915.1224738-1-devarsht@ti.com>
 <20250704125915.1224738-3-devarsht@ti.com>
Content-Language: en-US
From: Harikrishna Shenoy <a0512644@ti.com>
In-Reply-To: <20250704125915.1224738-3-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Devarsh,

Thank you for the patch.

On 04/07/25 18:29, Devarsh Thakkar wrote:
> Do read-modify-write so that we re-use the characterized reset value as
> specified in TRM [1] to program calibration wait time which defines number
> of cycles to wait for after startup state machine is in bandgap enable
> state.
>
> This fixes PLL lock timeout error faced while using RPi DSI Panel on TI's
> AM62L and J721E SoC since earlier calibration wait time was getting
> overwritten to zero value thus failing the PLL to lockup and causing
> timeout.
>
> [1] AM62P TRM (Section 14.8.6.3.2.1.1 DPHY_TX_DPHYTX_CMN0_CMN_DIG_TBIT2):
> Link: https://www.ti.com/lit/pdf/spruj83
>
> Cc: stable@vger.kernel.org
> Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>


Tested-by: Harikrishna Shenoy <h-shenoy@ti.com>


> ---
> V4: No change
> V3:
> - Do read-modify-write to preserve reset value for calibration wait
>    time
> V2:
> Introduced this as as separate patch
>
>   drivers/phy/cadence/cdns-dphy.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index da8de0a9d086..24a25606996c 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -30,6 +30,7 @@
>   
>   #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
>   #define DPHY_CMN_SSM_EN			BIT(0)
> +#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
>   #define DPHY_CMN_TX_MODE_EN		BIT(9)
>   
>   #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
> @@ -410,7 +411,8 @@ static int cdns_dphy_power_on(struct phy *phy)
>   	writel(reg, dphy->regs + DPHY_BAND_CFG);
>   
>   	/* Start TX state machine. */
> -	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
> +	reg = readl(dphy->regs + DPHY_CMN_SSM);
> +	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
>   	       dphy->regs + DPHY_CMN_SSM);
>   
>   	ret = cdns_dphy_wait_for_pll_lock(dphy);
>

