Return-Path: <linux-kernel+bounces-757233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC6B1BF85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0377018420C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3A1CAA7B;
	Wed,  6 Aug 2025 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="umEtVZaz"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3224143748
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754453644; cv=none; b=Gj3MPSgMGNUg4ckmDnimF9t/9rDHoDD2bjKVbYUs2420PtVvHcmJsXHBwV0eNTyhC9lfx4hrNlZ+5G77f9yyvHmuj0saQBoRwez9Ysp7LGuEBiFlDAvOCv+oviz4vVDl0O2csly3kn4Pw7apnHXP02Y3Z2lRDngEnW1ajlvCTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754453644; c=relaxed/simple;
	bh=A/Sa7v/fQpAbGHwT+nNN1d0AiRB9AFEclzit1wCtAAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3RMyUwYdXxKXb/d9d4SkWf6fXddawhHiG96+m0eQmthyfuPdHv/VUF+pN/L98J6UUA14DwRPzS5KGjRHncY+TfXUZ7rwxgTclyLA2ap0JJ/JauG+39JpT01V805GY53scCo44+HopZiMQLR4H5trhhxM8AXwzQr4sroTcQRleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=umEtVZaz; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5764Dq9H433309;
	Tue, 5 Aug 2025 23:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754453632;
	bh=UFOsYzaDbUpzLRfMOXFVDzr3S9Ise1+WhEi/jD9Ur4k=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=umEtVZaz7qHyOmT8AeV3Typz6x4qjlfP0YAbuhXPqTc1pSjSZ2RafZrr0Uyb/d3vf
	 N93/1Y4MsUP7O/Flpgrkf79ZBp6ZWC/faRm+4SrmtR3D7mxsPQy7XJH4Ny0I1H0hLx
	 vsgKJtnZCkQNJykJ61EzlUxBniDsr+aa5Zq+To9A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5764Dqmk3941416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 23:13:52 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 23:13:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 23:13:52 -0500
Received: from [172.24.18.25] (lt5cd2489kgj.dhcp.ti.com [172.24.18.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5764Dmnb2923105;
	Tue, 5 Aug 2025 23:13:49 -0500
Message-ID: <1ebb82ea-4b6c-4496-b7c0-17d4168d8ddf@ti.com>
Date: Wed, 6 Aug 2025 09:43:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: phy: cadence: cdns-dphy: Enabling lower
 resolutions in dphy
To: Harikrishna Shenoy <h-shenoy@ti.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <s-jain1@ti.com>, <u-kumar1@ti.com>
References: <20250801115311.1384313-1-h-shenoy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250801115311.1384313-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Thanks Hari for this patch

On 8/1/2025 5:23 PM, Harikrishna Shenoy wrote:
> The patch enables cdns dphy for hs_clk_rate in range between

No need of 'The patch' word

> 80 Mbps to 160 Mbps as mentioned in TRM [0] by setting the
> pll_opdiv field to 16.This change enables lower resolutions
> like 640x480 at 60Hz.

If you like to reword commit message, please feel free to use below

Enable support for hs_clk_rate between 80-160 Mbps cdns dphy
as mentioned in TRM [0] .....
With update in commit message, Please use
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> [0]: https://www.ti.com/lit/zip/spruil1
> (Table 12-552. DPHY_TX_PLL_CTRL Register Field Descriptions)
>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
> Test log: https://gist.github.com/h-shenoy/3975156baf403a0ff8dbcce5b49b2b89
>
>   drivers/phy/cadence/cdns-dphy.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index ed87a3970f83..9abed2ece9b0 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -139,7 +139,7 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>   
>   	dlane_bps = opts->hs_clk_rate;
>   
> -	if (dlane_bps > 2500000000UL || dlane_bps < 160000000UL)
> +	if (dlane_bps > 2500000000UL || dlane_bps < 80000000UL)
>   		return -EINVAL;
>   	else if (dlane_bps >= 1250000000)
>   		cfg->pll_opdiv = 1;
> @@ -149,6 +149,8 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>   		cfg->pll_opdiv = 4;
>   	else if (dlane_bps >= 160000000)
>   		cfg->pll_opdiv = 8;
> +	else if (dlane_bps >= 80000000)
> +		cfg->pll_opdiv = 16;
>   
>   	cfg->pll_fbdiv = DIV_ROUND_UP_ULL(dlane_bps * 2 * cfg->pll_opdiv *
>   					  cfg->pll_ipdiv,

