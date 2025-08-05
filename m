Return-Path: <linux-kernel+bounces-757085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1615B1BD7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731518A8417
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44362BDC35;
	Tue,  5 Aug 2025 23:44:02 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E244677;
	Tue,  5 Aug 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437442; cv=none; b=TwtjplHX1Dg9Ctr6XSU/MWGbSDEMrjql1+/PGfde6T3BgAEtI3uPr90vyP/ewZ9B+Gj4+tUCH6BAjNIKNO2f0k8iipBmO85bGHwNSQMaXzFZ9pi0mMFaxdwOOY4RGTqR5fRXaH623BIdMau3p6lTYBwdAYdu2zmlGJw6DU4O6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437442; c=relaxed/simple;
	bh=/NT2dnpnHrxmsvU1wS3RngKCtrPxl59J62GqgdY56Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEb8h/gwu8wEyYVLfi8XCAG62VlGjt+Inr1AoyYIklnWfkSAoIuplc3J8/u6wLYZVsb96C623I+adwc8ZxaSeHNS3wMxXt8q0YC8cXDQYhXBW6zh9u9vwfiL/8deEejShrwqLX0egN4xz4TxbJ3weTtKJYYjg1BuVNsicmA0yTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DAEC43406F2;
	Tue, 05 Aug 2025 23:43:59 +0000 (UTC)
Date: Wed, 6 Aug 2025 07:43:55 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, elder@riscstar.com,
	heylenay@4d2.org, inochiama@outlook.com, krzk+dt@kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, mturquette@baylibre.com,
	robh@kernel.org, sboyd@kernel.org, spacemit@lists.linux.dev,
	ziyao@disroot.org
Subject: Re: [PATCH v4 2/2] clk: spacemit: fix sspax_clk
Message-ID: <20250805234355-GYA958398@gentoo>
References: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
 <E801E7AF425E08C7+20250805131646.2216375-1-troy.mitchell@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E801E7AF425E08C7+20250805131646.2216375-1-troy.mitchell@linux.spacemit.com>

Hi Troy,
  to make the title more clear and explicit, how about:

"clk: spacemit: introduce SSPAx_I2S_BCLK clock for SSPA"

On 21:16 Tue 05 Aug     , Troy Mitchell wrote:
> Hardware Requirement:
> When FNCLKSEL in APBC_SSPAX_CLK_RST is set to 7 (3'b111),
..
> BIT3 must be set to 1 for the SSPAx parent clock to be I2S_BCLK.
> 
> This patch introduces SSPAx_I2S_BCLK as a virtual gate to enable BIT3.
> 
slightly improve the wording, and check if it's accurate:

BIT[3] of this register must be set if need to select i2s_bclk as
SSPA parent clock, to solve this, introduces a new SSPAx_I2S_BCLK
clock as the virtual gate clock.

> Suggested-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Haylen Chu <heylenay@4d2.org>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index cdde37a05235..4a91d28da2fb 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -349,7 +349,14 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
>  
>  CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
>  
> -static const struct clk_parent_data sspa_parents[] = {
> +/*
> + * When i2s_bclk is selected as the parent clock of sspa,
> + * the hardware requires bit3 to be set
> + */
> +CCU_GATE_DEFINE(sspa0_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA0_CLK_RST, BIT(3), 0);
> +CCU_GATE_DEFINE(sspa1_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA1_CLK_RST, BIT(3), 0);
> +
> +static const struct clk_parent_data sspa0_parents[] = {
>  	CCU_PARENT_HW(pll1_d384_6p4),
>  	CCU_PARENT_HW(pll1_d192_12p8),
>  	CCU_PARENT_HW(pll1_d96_25p6),
> @@ -357,10 +364,22 @@ static const struct clk_parent_data sspa_parents[] = {
>  	CCU_PARENT_HW(pll1_d768_3p2),
>  	CCU_PARENT_HW(pll1_d1536_1p6),
>  	CCU_PARENT_HW(pll1_d3072_0p8),
> -	CCU_PARENT_HW(i2s_bclk),
> +	CCU_PARENT_HW(sspa0_i2s_bclk),
>  };
> -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> +CCU_MUX_GATE_DEFINE(sspa0_clk, sspa0_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> +
> +static const struct clk_parent_data sspa1_parents[] = {
> +	CCU_PARENT_HW(pll1_d384_6p4),
> +	CCU_PARENT_HW(pll1_d192_12p8),
> +	CCU_PARENT_HW(pll1_d96_25p6),
> +	CCU_PARENT_HW(pll1_d48_51p2),
> +	CCU_PARENT_HW(pll1_d768_3p2),
> +	CCU_PARENT_HW(pll1_d1536_1p6),
> +	CCU_PARENT_HW(pll1_d3072_0p8),
> +	CCU_PARENT_HW(sspa1_i2s_bclk),
> +};
> +CCU_MUX_GATE_DEFINE(sspa1_clk, sspa1_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> +
>  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> @@ -965,6 +984,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
>  	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
>  	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
>  	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
> +	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
> +	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
>  };
>  
>  static const struct spacemit_ccu_data k1_ccu_apbc_data = {
> -- 
> 2.50.0
> 

-- 
Yixun Lan (dlan)

