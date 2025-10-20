Return-Path: <linux-kernel+bounces-861644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7BBF33F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C22734FEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF62DE71B;
	Mon, 20 Oct 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ie5RzQlf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC11EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989289; cv=none; b=UnjpSRYX5+W3Ybur5lG6xqTZXhlalXSeXYe7wNBZ3vfYC/dx4BVIl7oHQmf7jJJvnyegyeyj1ItuBr78vLE/jHCW3XaANqi4fjNhF/Ag5JK9TxI1WRxFCIxhM9KUiry9j7etEwIJvK4BgSE/ZPz+vit/A9JSFFuGgZ6pS7ozmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989289; c=relaxed/simple;
	bh=sb/xvSCvi4x1WhDKJCmukIHkLfL1xWtmz/H5UPqzbaA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c46ao1ubyp4GI/Dr7eNJ1GfbCBaGOSrXxzOaDKSfMHLsC1ntgQ6Zd3CJPtKm8+037dRMJIWoxaKVzX8Vp1SKXUMg8utp6vElqHy+Hot+xCgtcpPt2oMeTmeB8AvG66rWJ6CHb4v2Ctic/odMXHT7s9BrxmXzlqIl1owc0gY1S00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ie5RzQlf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1034204566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989285; x=1761594085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onBLaR3b5p0TKSaA4XAOR/ezLcGXv9VkB9uwhzqsH8k=;
        b=ie5RzQlfPCBZQ+ZyoMpyzgyoxxh+roK9DrNiCTDVx3i7whEpp+iM3VblcGg1EvqKLw
         aiJqGfl0dZ5Ng7fVBTaXgcGrs+j9ufTrE3JKPMV4O5Bblbf+zBIGPE0qXTnXlXHNVvT3
         k8s4aG7ZayhiZX92y4Co+64NLgB6VR60DrlaLR5tNrWE7hFlu1zSkFZmHBc4UZ/+F5oU
         JHY6hiPGpYqOQLt9DQi1raHc2NN1Wx+6vwpHKBKNajOQUPj1ISLHPaafP4g7+R/QFD5a
         6qpz2+5yXuF0fTl/ZdUPU2xSrlBpGfjGrhO5EcFtvj8WsZE905yJpouF0nK2laWMnY1M
         KsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989285; x=1761594085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onBLaR3b5p0TKSaA4XAOR/ezLcGXv9VkB9uwhzqsH8k=;
        b=qRp/O7RfwJEHCzSzjorZq5NYmFY+a0WT90+NDU9YTWBMMfGKHiv27OkfH5JBRly2jN
         cw7KkRPu8wXep1Jaq2LFEAXRCrKv4qx3xp57lDGBvRDI6Z3jDyZmUx1EsE7ChztfEbPu
         7C/6SoLfALakqeHM9tEGZeMSGXc55MajA4rb//setwyiQ0HDJB203vUwxflzZJNJpOXj
         qIOBJmmCO6zwPC1WQNHFeJZIvNyVNrKurgQQt5duePIreSOSiblmNb/t9ymJ+4X6vNCM
         IejJOhmZ17rtQ3fgVUoH5MSk9iFIqsQ/jY1Z8krXhp1D2kGNV72e15q0iIJQRG5iCvtm
         QKeg==
X-Forwarded-Encrypted: i=1; AJvYcCW//v7h+Jev1VuKmS/0kASFSreUvRyWCpSXeZf+i2DCT7yjAp0OUWZM7HpK2TWZVxl9FaYIvyGtfdNCKHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mXAb15rp7FpxcrgfaEJYlzy5Bs13EBQgG2JTWmvd/nUyy7Rs
	BfsTeEnbZbYc0kyl8M3iWTDgIuT30kmFzd9d0Q4XlKyALc6GwfMNDccp7yZpgl19SjM=
X-Gm-Gg: ASbGncuUfrmwk1euYX7f+nZVwu11ydGCwmhKNAA6y1KqG4YC47soJ61uIE66i5IpfU8
	D5/dyVNFMfeSMFGQyXvXW0eAshFZUjIQ02kld0bzKno32Zlmk1TQj3VsU2+v62lwn0liSQqapkh
	F5naubeYK8iSRu2K21bUf/Fr4e+MFzy5mzJG0XcJMgeGUXJp3SRQo0ug9+VP4LKk7nV0rTdruRw
	0MsuWUkJa4WswDldsE4eLdeXjzun6EcmsJ5J/wcsMkqIf/SJN4xWgimfycHaXbUXAG0N/kBSvSh
	73QpHV3aiyXTMRVHx6ilz756pR9pIUjBF+6+lCSBlpLKGEWaC1uG+h4/tr+ssd292YwRQrloRyX
	0PF7t6kUfi8i76N0Iqh0p5/UD3NQhAAWe/gbQTfe+wvlwNaTn1UD0OqSt2nzNux+8ksX/VofM/c
	0AYoAo1iQWQp5Gph4Mc4Y=
X-Google-Smtp-Source: AGHT+IHhbdQhGKSUACguShRdbXAdYLQ8jkoHnOdr5MaV8eZ6H913I1UyhQF3tXQ/94Cx59O+/3xyDQ==
X-Received: by 2002:a17:907:3f04:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b64749411b1mr1769618466b.31.1760989285272;
        Mon, 20 Oct 2025 12:41:25 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm878800966b.56.2025.10.20.12.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:41:24 -0700 (PDT)
Message-ID: <253d329d-12f9-478b-833e-096fafa4b109@tuxon.dev>
Date: Mon, 20 Oct 2025 22:41:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 04/31] clk: at91: clk-sam9x60-pll: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <259824455f5325b35d0fb85163866a81ff24304e.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <259824455f5325b35d0fb85163866a81ff24304e.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of struct parent_hw as this leads
> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
> conversion of existing SoC specific clock drivers from parent_names to
> modern clk_parent_data structures. As clk-sam9x60-pll need to know
> parent's rate at initialization we pass it now from SoC specific drivers.
> This will lead in the end at removing __clk_get_hw() in SoC specific
> drivers (that will be solved by subsequent commits).
> 
> Get the main_xtal name via of_clk_get_parent_name() to consistently get
> the correct name for the main_xtal.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add SAMA7D65 and SAM9X75 SoCs to the change set.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 14 +++++---------
>  drivers/clk/at91/pmc.h             |  5 +++--
>  drivers/clk/at91/sam9x60.c         |  8 +++++---
>  drivers/clk/at91/sam9x7.c          | 16 +++++++++++-----
>  drivers/clk/at91/sama7d65.c        | 25 ++++++++++++++-----------
>  drivers/clk/at91/sama7g5.c         | 26 +++++++++++++++-----------
>  6 files changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index 3dc75a394ce1..9895881c67d7 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -630,19 +630,19 @@ static const struct clk_ops sam9x60_fixed_div_pll_ops = {
>  
>  struct clk_hw * __init
>  sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
> -			      const char *name, const char *parent_name,
> -			      struct clk_hw *parent_hw, u8 id,
> +			      const char *name, const struct clk_parent_data *parent_data,
> +			      unsigned long parent_rate, u8 id,
>  			      const struct clk_pll_characteristics *characteristics,
>  			      const struct clk_pll_layout *layout, u32 flags)
>  {
>  	struct sam9x60_frac *frac;
>  	struct clk_hw *hw;
>  	struct clk_init_data init = {};
> -	unsigned long parent_rate, irqflags;
> +	unsigned long irqflags;
>  	unsigned int val;
>  	int ret;
>  
> -	if (id > PLL_MAX_ID || !lock || !parent_hw)
> +	if (id > PLL_MAX_ID || !lock || !parent_data)
>  		return ERR_PTR(-EINVAL);
>  
>  	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
> @@ -650,10 +650,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>  		return ERR_PTR(-ENOMEM);
>  
>  	init.name = name;
> -	if (parent_name)
> -		init.parent_names = &parent_name;
> -	else
> -		init.parent_hws = (const struct clk_hw **)&parent_hw;
> +	init.parent_data = (const struct clk_parent_data *)parent_data;
>  	init.num_parents = 1;
>  	if (flags & CLK_SET_RATE_GATE)
>  		init.ops = &sam9x60_frac_pll_ops;
> @@ -684,7 +681,6 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>  		 * its rate leading to enabling this PLL with unsupported
>  		 * rate. This will lead to PLL not being locked at all.
>  		 */
> -		parent_rate = clk_hw_get_rate(parent_hw);
>  		if (!parent_rate) {
>  			hw = ERR_PTR(-EINVAL);
>  			goto free;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 16c2559889aa..d3fc38cf90eb 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -258,8 +258,9 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
>  
>  struct clk_hw * __init
>  sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
> -			      const char *name, const char *parent_name,
> -			      struct clk_hw *parent_hw, u8 id,
> +			      const char *name,
> +			      const struct clk_parent_data *parent_data,
> +			      unsigned long parent_rate, u8 id,
>  			      const struct clk_pll_characteristics *characteristics,
>  			      const struct clk_pll_layout *layout, u32 flags);
>  
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index 18baf4a256f4..bee35c65aceb 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -242,7 +242,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	sam9x60_pmc->chws[PMC_MAIN] = hw;
>  
>  	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
> -					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
> +					   &AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MAIN]),
> +					   clk_hw_get_rate(sam9x60_pmc->chws[PMC_MAIN]),
>  					   0, &plla_characteristics,
>  					   &pll_frac_layout,
>  					   /*
> @@ -268,8 +269,9 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	sam9x60_pmc->chws[PMC_PLLACK] = hw;
>  
>  	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "upllck_fracck",
> -					   "main_osc", main_osc_hw, 1,
> -					   &upll_characteristics,
> +					   &AT91_CLK_PD_HW(main_osc_hw),
> +					   clk_hw_get_rate(main_osc_hw),
> +					   1, &upll_characteristics,
>  					   &pll_frac_layout, CLK_SET_RATE_GATE);
>  	if (IS_ERR(hw))
>  		goto err_free;
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index cb5849da494f..c80306715d90 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -752,6 +752,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  	struct regmap *regmap;
>  	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>  	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> +	static struct clk_parent_data parent_data;
>  	struct clk_hw *parent_hws[9];
>  	int i, j;
>  
> @@ -799,7 +800,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  
>  	for (i = 0; i < PLL_ID_MAX; i++) {
>  		for (j = 0; j < PLL_COMPID_MAX; j++) {
> -			struct clk_hw *parent_hw;
> +			unsigned long parent_rate;
>  
>  			if (!sam9x7_plls[i][j].n)
>  				continue;
> @@ -808,21 +809,26 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  			case PLL_TYPE_FRAC:
>  				switch (sam9x7_plls[i][j].p) {
>  				case SAM9X7_PLL_PARENT_MAINCK:
> -					parent_hw = sam9x7_pmc->chws[PMC_MAIN];
> +					parent_data = AT91_CLK_PD_NAME("mainck");
> +					hw = sam9x7_pmc->chws[PMC_MAIN];
>  					break;
>  				case SAM9X7_PLL_PARENT_MAIN_XTAL:
> -					parent_hw = main_xtal_hw;
> +					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
> +					hw = main_xtal_hw;
>  					break;
>  				default:
>  					/* Should not happen. */
> -					parent_hw = NULL;
>  					break;
>  				}
>  
> +				parent_rate = clk_hw_get_rate(hw);
> +				if (!parent_rate)
> +					return;
> +
>  				hw = sam9x60_clk_register_frac_pll(regmap,
>  								   &pmc_pll_lock,
>  								   sam9x7_plls[i][j].n,
> -								   NULL, parent_hw, i,
> +								   &parent_data, parent_rate, i,
>  								   sam9x7_plls[i][j].c,
>  								   sam9x7_plls[i][j].l,
>  								   sam9x7_plls[i][j].f);
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index ec2ef1a0249a..6229b7dfbea1 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -1093,7 +1093,7 @@ static const struct clk_pcr_layout sama7d65_pcr_layout = {
>  
>  static void __init sama7d65_pmc_setup(struct device_node *np)
>  {
> -	const char *main_xtal_name = "main_xtal";
> +	const char *main_xtal_name;
>  	struct pmc_data *sama7d65_pmc;
>  	const char *parent_names[11];
>  	void **alloc_mem = NULL;
> @@ -1108,10 +1108,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>  
>  	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
>  	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> -	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
> +	i = of_property_match_string(np, "clock-names", "main_xtal");

Same as in the previous patch, please keep it close to
of_clk_get_parent_name() for main_xtal above and check check also negative
error numbers return by of_property_match_string(). Valid for the other
similar occurrences in this or next patches.


