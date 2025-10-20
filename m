Return-Path: <linux-kernel+bounces-861639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C765ABF33DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D94825DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF22D94B6;
	Mon, 20 Oct 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DS3Vf5h8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EE1EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989112; cv=none; b=C0NAJIjSr2B/As+cZU96WuktvivmGTU+pUVPGkXx8MubRB6xELm5QndWmbdY35i1U7A3dge8XOJl/3QZyON9+k/gMb1ROdIhSoKAupHZIYKckWrp0WPTb4NUT3HyjAmbXFKOOuh32Ih5mjo97c/npJAarmtdTlAOfhMh3DRDiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989112; c=relaxed/simple;
	bh=eebYZ6zXLx76cYE+gcR91bkMT5gnmpTffdOPN3ar8/o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H2AR0uy3U3oMn9hXGrzEFyCD9qWElDTUKMkf1p7l1AS3NyzzkhJs9Xqo6eE+l+o+xsf38ZbpNcG73S4T+gU2majBLvjaP4hDBTdJo62Znq8USksCRSY0juPvBGDzsrjNH/XaXb+EeIDLYHiIm1fSUaPsHHO/EZocQ4NXzT07rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DS3Vf5h8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2db014easo1044723066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989108; x=1761593908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+POII8yE39Tn3Tv94O818PXGkTF4y8feAyeQOz6HMQ=;
        b=DS3Vf5h8QtUt07EsUMb+KUYIbN9LYUv7IC2POAvzSLkBNKcg1s6CC+loItEWAhUEaJ
         DLdrAwHHvYB3FyRnYEu0rEcRw4dft6mXlJ6pdIh4IyWg4rlfMTyJntB0fupw0FuOsygG
         dV4Xg4lipWVS5/9W8zh/jEt9WBLqnUq2tV7c96p47NS44T1ukUiZBw8KN5UKW/Ot58AS
         XaBOrX0mCqUKddB5rrumi+gWH8M+m1hnRpfzNxFeCMqhkJ+mByUqihAIX0m7IJUHq53N
         qtMBGOnqaH8bW1yrYqYh48v01XBqYfMJ21Jbe3x+aJa6EbjKDwGvH1qTMKq98iqpZdbe
         SrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989108; x=1761593908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+POII8yE39Tn3Tv94O818PXGkTF4y8feAyeQOz6HMQ=;
        b=Iulwjbs7Cnog2klggIv91BMws/tXTDa8etBrqD3FWMRIqUlrU4RgbcRuLefgkLxX3/
         HzVy7DqPn7Pi0/BUmzw7d43lhd7cIpg5NrZ4neX2kH8Q8kTzHbPBcAlzgUHdJXZXJO7o
         44Uze6jxIFC2fla37eUzoP9f5PErv+eQVc42XMRuTkr5ZxlUZqyiNvHCgTDMluFfN9Xl
         oZzTR9EABW+HGkon9he30D+0ndwg7SVPtYZ8hqXYsb3l+hNAfUSCIB2BBIqzPBkdqrJz
         yzk3TPRa6awGml8dtcBGFl17UHmAjK+eaqOP4G6yii/ENJWJPesUhaZLeeXXMQuaXdyO
         z81g==
X-Forwarded-Encrypted: i=1; AJvYcCWK11FdOSL0TV8GtelUePNQfxqREXKg2mL2stR1AkSrXkCKAGh3RmbZmQoVOM5vC+mNqQa+ktbzpKIAc5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwbottFW1F+qkm538CKMjghrfiuvELFBXuNazi73KjpqHNHTe
	yg4zH0cvUkLrLRurO6HL+58oYPHSt/ZAjQszpdKZH/5a7nCLy3zgUhzeWeZ9szWhAwc=
X-Gm-Gg: ASbGncs0xMGXiXfJpSLHkpCPbjra9ERRioyDBXlkBIX/fegEZT2PwNZ7Ft+QjeN2n70
	7VcGRks7BjCRqKJEZ3f08Drh+hz4dK3splNgxdAF9o2Hvy7n/O+gGDGgY0FCB3pfd8nrz6nPEaT
	ClaTULDwXeGEJGpZA+TI7o7DlQ/wG7wJumIu+eM9mjNmG0mZspWqqUbxiNvmLUKA0l0rhzvhifr
	eD7rjr6ErE78dxNvOnLbmEUxSIk8kHW86xqGzozGVHHPBW6tmSuinmKir6EeO0R4UoTsbMsoX3p
	LcNnuBLCOy2e9dEE7T1V8jbeKYIGbtsJENm89kTTcsNnNgyDF95yxrAWG1jI14KnzmzPIBBUTGs
	7FG1l7pzP3WOM+uvA8O02EeTyQlwBfXpXa9kLrU3gx9FXEciEwx3ffTFdLUBsxz89+1D3dBwiKL
	1Bh0wBNH2Qvxjl8MJjcOKuAGzP2BPDJw==
X-Google-Smtp-Source: AGHT+IFdcQDIo2mOF/i8zi/X2ww0d2oBPJM2lD8zVmbbp1jaSiX2zU6I5RocEU06qb06iAN1mVpxnA==
X-Received: by 2002:a17:907:2d23:b0:b55:c837:f6f5 with SMTP id a640c23a62f3a-b6472b5f7c3mr1647314766b.1.1760989107987;
        Mon, 20 Oct 2025 12:38:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm861289966b.21.2025.10.20.12.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:38:27 -0700 (PDT)
Message-ID: <63bcb444-7baf-4332-bca5-9582818691b3@tuxon.dev>
Date: Mon, 20 Oct 2025 22:38:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 03/31] clk: at91: sam9x75: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <42d01c533eecf4018174ab5c3e0a6130e3dc34f0.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <42d01c533eecf4018174ab5c3e0a6130e3dc34f0.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Switch SAM9X75 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> The USBCLK will be updated in subsequent patches that update the clock
> registration functions to use parent_hw and parent_data.
> 
> __clk_get_hw() will be removed in subsequent patches in this series.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/sam9x7.c | 308 +++++++++++++++++++++-----------------
>  1 file changed, 173 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index 89868a0aeaba..cb5849da494f 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -33,10 +33,22 @@ enum pll_ids {
>  	PLL_ID_UPLL,
>  	PLL_ID_AUDIO,
>  	PLL_ID_LVDS,
> -	PLL_ID_PLLA_DIV2,
>  	PLL_ID_MAX,
>  };
>  
> +/*
> + * PLL component identifier
> + * @PLL_COMPID_FRAC: Fractional PLL component identifier
> + * @PLL_COMPID_DIV0: 1st PLL divider component identifier
> + * @PLL_COMPID_DIV1: 2nd PLL divider component identifier
> + */
> +enum pll_component_id {
> +	PLL_COMPID_FRAC,
> +	PLL_COMPID_DIV0,
> +	PLL_COMPID_DIV1,
> +	PLL_COMPID_MAX,
> +};
> +
>  /**
>   * enum pll_type - PLL type identifiers
>   * @PLL_TYPE_FRAC:	fractional PLL identifier
> @@ -185,6 +197,18 @@ static const struct clk_pll_layout pll_divio_layout = {
>  	.endiv_shift	= 30,
>  };
>  
> +/*
> + * SAM9X7 PLL possible parents
> + * @SAM9X7_PLL_PARENT_MAINCK: MAINCK is PLL a parent
> + * @SAM9X7_PLL_PARENT_MAIN_XTAL: MAIN XTAL is a PLL parent
> + * @SAM9X7_PLL_PARENT_FRACCK: Frac PLL is a PLL parent (for PLL dividers)
> + */
> +enum sam9x7_pll_parent {
> +	SAM9X7_PLL_PARENT_MAINCK,
> +	SAM9X7_PLL_PARENT_MAIN_XTAL,
> +	SAM9X7_PLL_PARENT_FRACCK
> +};
> +
>  /*
>   * PLL clocks description
>   * @n:		clock name
> @@ -192,22 +216,24 @@ static const struct clk_pll_layout pll_divio_layout = {
>   * @l:		clock layout
>   * @t:		clock type
>   * @c:		pll characteristics
> + * @hw:		pointer to clk_hw
>   * @f:		clock flags
>   * @eid:	export index in sam9x7->chws[] array
>   */
> -static const struct {
> +static struct {
>  	const char *n;
> -	const char *p;
>  	const struct clk_pll_layout *l;
>  	u8 t;
>  	const struct clk_pll_characteristics *c;
> +	struct clk_hw *hw;
>  	unsigned long f;
> +	enum sam9x7_pll_parent p;
>  	u8 eid;
> -} sam9x7_plls[][3] = {
> +} sam9x7_plls[][PLL_COMPID_MAX] = {
>  	[PLL_ID_PLLA] = {
> -		{
> +		[PLL_COMPID_FRAC] = {
>  			.n = "plla_fracck",
> -			.p = "mainck",
> +			.p = SAM9X7_PLL_PARENT_MAINCK,
>  			.l = &plla_frac_layout,
>  			.t = PLL_TYPE_FRAC,
>  			/*
> @@ -218,9 +244,9 @@ static const struct {
>  			.c = &plla_characteristics,
>  		},
>  
> -		{
> +		[PLL_COMPID_DIV0] = {
>  			.n = "plla_divpmcck",
> -			.p = "plla_fracck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
>  			.l = &pll_divpmc_layout,
>  			.t = PLL_TYPE_DIV,
>  			/* This feeds CPU. It should not be disabled */
> @@ -228,21 +254,35 @@ static const struct {
>  			.eid = PMC_PLLACK,
>  			.c = &plla_characteristics,
>  		},
> +
> +		[PLL_COMPID_DIV1] = {
> +			.n = "plla_div2pmcck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
> +			.l = &plladiv2_divpmc_layout,
> +			/*
> +			 * This may feed critical parts of the system like timers.
> +			 * It should not be disabled.
> +			 */
> +			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> +			.c = &plladiv2_characteristics,
> +			.eid = PMC_PLLADIV2,
> +			.t = PLL_TYPE_DIV,
> +		},
>  	},
>  
>  	[PLL_ID_UPLL] = {
> -		{
> +		[PLL_COMPID_FRAC] = {
>  			.n = "upll_fracck",
> -			.p = "main_osc",
> +			.p = SAM9X7_PLL_PARENT_MAIN_XTAL,
>  			.l = &pll_frac_layout,
>  			.t = PLL_TYPE_FRAC,
>  			.f = CLK_SET_RATE_GATE,
>  			.c = &upll_characteristics,
>  		},
>  
> -		{
> +		[PLL_COMPID_DIV0] = {
>  			.n = "upll_divpmcck",
> -			.p = "upll_fracck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
>  			.l = &pll_divpmc_layout,
>  			.t = PLL_TYPE_DIV,
>  			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> @@ -253,18 +293,18 @@ static const struct {
>  	},
>  
>  	[PLL_ID_AUDIO] = {
> -		{
> +		[PLL_COMPID_FRAC] = {
>  			.n = "audiopll_fracck",
> -			.p = "main_osc",
> +			.p = SAM9X7_PLL_PARENT_MAIN_XTAL,
>  			.l = &pll_frac_layout,
>  			.f = CLK_SET_RATE_GATE,
>  			.c = &audiopll_characteristics,
>  			.t = PLL_TYPE_FRAC,
>  		},
>  
> -		{
> +		[PLL_COMPID_DIV0] = {
>  			.n = "audiopll_divpmcck",
> -			.p = "audiopll_fracck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
>  			.l = &pll_divpmc_layout,
>  			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>  			     CLK_SET_RATE_PARENT,
> @@ -273,9 +313,9 @@ static const struct {
>  			.t = PLL_TYPE_DIV,
>  		},
>  
> -		{
> +		[PLL_COMPID_DIV1] = {
>  			.n = "audiopll_diviock",
> -			.p = "audiopll_fracck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
>  			.l = &pll_divio_layout,
>  			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>  			     CLK_SET_RATE_PARENT,
> @@ -286,18 +326,18 @@ static const struct {
>  	},
>  
>  	[PLL_ID_LVDS] = {
> -		{
> +		[PLL_COMPID_FRAC] = {
>  			.n = "lvdspll_fracck",
> -			.p = "main_osc",
> +			.p = SAM9X7_PLL_PARENT_MAIN_XTAL,
>  			.l = &pll_frac_layout,
>  			.f = CLK_SET_RATE_GATE,
>  			.c = &lvdspll_characteristics,
>  			.t = PLL_TYPE_FRAC,
>  		},
>  
> -		{
> +		[PLL_COMPID_DIV0] = {
>  			.n = "lvdspll_divpmcck",
> -			.p = "lvdspll_fracck",
> +			.p = SAM9X7_PLL_PARENT_FRACCK,
>  			.l = &pll_divpmc_layout,
>  			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>  			     CLK_SET_RATE_PARENT,
> @@ -306,22 +346,6 @@ static const struct {
>  			.t = PLL_TYPE_DIV,
>  		},
>  	},
> -
> -	[PLL_ID_PLLA_DIV2] = {
> -		{
> -			.n = "plla_div2pmcck",
> -			.p = "plla_fracck",
> -			.l = &plladiv2_divpmc_layout,
> -			/*
> -			 * This may feed critical parts of the system like timers.
> -			 * It should not be disabled.
> -			 */
> -			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> -			.c = &plladiv2_characteristics,
> -			.eid = PMC_PLLADIV2,
> -			.t = PLL_TYPE_DIV,
> -		},
> -	},
>  };
>  
>  static const struct clk_programmable_layout sam9x7_programmable_layout = {
> @@ -339,9 +363,9 @@ static const struct clk_pcr_layout sam9x7_pcr_layout = {
>  	.pid_mask = GENMASK(6, 0),
>  };
>  
> -static const struct {
> +static struct {
>  	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>  	u8 id;
>  	unsigned long flags;
>  } sam9x7_systemck[] = {
> @@ -349,10 +373,10 @@ static const struct {
>  	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>  	 * to keep it enabled in case there is no Linux consumer for it.
>  	 */
> -	{ .n = "ddrck",		.p = "masterck_div",	.id = 2,	.flags = CLK_IS_CRITICAL },
> -	{ .n = "uhpck",		.p = "usbck",		.id = 6 },
> -	{ .n = "pck0",		.p = "prog0",		.id = 8 },
> -	{ .n = "pck1",		.p = "prog1",		.id = 9 },
> +	{ .n = "ddrck",		.id = 2,	.flags = CLK_IS_CRITICAL },
> +	{ .n = "uhpck",		.id = 6 },
> +	{ .n = "pck0",		.id = 8 },
> +	{ .n = "pck1",		.id = 9 },
>  };
>  
>  /*
> @@ -426,7 +450,8 @@ static const struct {
>  /*
>   * Generic clock description
>   * @n:			clock name
> - * @pp:			PLL parents
> + * @pp:			PLL parents (entry formed by PLL components identifiers
> + *			(see enum pll_component_id))
>   * @pp_mux_table:	PLL parents mux table
>   * @r:			clock output range
>   * @pp_chg_id:		id in parent array of changeable PLL parent
> @@ -435,7 +460,10 @@ static const struct {
>   */
>  static const struct {
>  	const char *n;
> -	const char *pp[8];
> +	struct {
> +			int pll_id;
> +			int pll_compid;

2 tabs here should be enough.

> +	} pp[8];
>  	const char pp_mux_table[8];
>  	struct clk_range r;
>  	int pp_chg_id;
> @@ -445,7 +473,7 @@ static const struct {
>  	{
>  		.n = "flex0_gclk",
>  		.id = 5,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -454,7 +482,7 @@ static const struct {
>  	{
>  		.n = "flex1_gclk",
>  		.id = 6,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -463,7 +491,7 @@ static const struct {
>  	{
>  		.n = "flex2_gclk",
>  		.id = 7,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -472,7 +500,7 @@ static const struct {
>  	{
>  		.n = "flex3_gclk",
>  		.id = 8,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -481,7 +509,7 @@ static const struct {
>  	{
>  		.n = "flex6_gclk",
>  		.id = 9,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -490,7 +518,7 @@ static const struct {
>  	{
>  		.n = "flex7_gclk",
>  		.id = 10,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -499,7 +527,7 @@ static const struct {
>  	{
>  		.n = "flex8_gclk",
>  		.id = 11,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -509,7 +537,7 @@ static const struct {
>  		.n = "sdmmc0_gclk",
>  		.id = 12,
>  		.r = { .max = 105000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -518,7 +546,7 @@ static const struct {
>  	{
>  		.n = "flex4_gclk",
>  		.id = 13,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -527,7 +555,7 @@ static const struct {
>  	{
>  		.n = "flex5_gclk",
>  		.id = 14,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -536,7 +564,7 @@ static const struct {
>  	{
>  		.n = "flex9_gclk",
>  		.id = 15,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -545,7 +573,7 @@ static const struct {
>  	{
>  		.n = "flex10_gclk",
>  		.id = 16,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -554,7 +582,7 @@ static const struct {
>  	{
>  		.n = "tcb0_gclk",
>  		.id = 17,
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -563,7 +591,7 @@ static const struct {
>  	{
>  		.n = "adc_gclk",
>  		.id = 19,
> -		.pp = { "upll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(UPLL, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 5, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -573,7 +601,7 @@ static const struct {
>  		.n = "lcd_gclk",
>  		.id = 25,
>  		.r = { .max = 75000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -583,7 +611,7 @@ static const struct {
>  		.n = "sdmmc1_gclk",
>  		.id = 26,
>  		.r = { .max = 105000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -593,7 +621,7 @@ static const struct {
>  		.n = "mcan0_gclk",
>  		.id = 29,
>  		.r = { .max = 80000000 },
> -		.pp = { "upll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(UPLL, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 5, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -603,7 +631,7 @@ static const struct {
>  		.n = "mcan1_gclk",
>  		.id = 30,
>  		.r = { .max = 80000000 },
> -		.pp = { "upll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(UPLL, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 5, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -612,7 +640,7 @@ static const struct {
>  	{
>  		.n = "flex11_gclk",
>  		.id = 32,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -621,7 +649,7 @@ static const struct {
>  	{
>  		.n = "flex12_gclk",
>  		.id = 33,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -631,7 +659,7 @@ static const struct {
>  		.n = "i2s_gclk",
>  		.id = 34,
>  		.r = { .max = 100000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -641,7 +669,7 @@ static const struct {
>  		.n = "qspi_gclk",
>  		.id = 35,
>  		.r = { .max = 200000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -650,7 +678,7 @@ static const struct {
>  	{
>  		.n = "pit64b0_gclk",
>  		.id = 37,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -660,7 +688,7 @@ static const struct {
>  		.n = "classd_gclk",
>  		.id = 42,
>  		.r = { .max = 100000000 },
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -669,7 +697,7 @@ static const struct {
>  	{
>  		.n = "tcb1_gclk",
>  		.id = 45,
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -678,7 +706,7 @@ static const struct {
>  	{
>  		.n = "dbgu_gclk",
>  		.id = 47,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -688,7 +716,7 @@ static const struct {
>  		.n = "mipiphy_gclk",
>  		.id = 55,
>  		.r = { .max = 27000000 },
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -697,7 +725,7 @@ static const struct {
>  	{
>  		.n = "pit64b1_gclk",
>  		.id = 58,
> -		.pp = { "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 8, },
>  		.pp_count = 1,
>  		.pp_chg_id = INT_MIN,
> @@ -706,7 +734,7 @@ static const struct {
>  	{
>  		.n = "gmac_gclk",
>  		.id = 67,
> -		.pp = { "audiopll_divpmcck", "plla_div2pmcck", },
> +		.pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(PLLA, DIV1), },
>  		.pp_mux_table = { 6, 8, },
>  		.pp_count = 2,
>  		.pp_chg_id = INT_MIN,
> @@ -716,33 +744,25 @@ static const struct {
>  static void __init sam9x7_pmc_setup(struct device_node *np)
>  {
>  	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *td_slck_name, *md_slck_name, *mainxtal_name;
> +	const char *main_xtal_name;
>  	struct pmc_data *sam9x7_pmc;
>  	const char *parent_names[9];
>  	void **clk_mux_buffer = NULL;
>  	int clk_mux_buffer_size = 0;
> -	struct clk_hw *main_osc_hw;
>  	struct regmap *regmap;
> -	struct clk_hw *hw;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> +	struct clk_hw *parent_hws[9];
>  	int i, j;
>  
> -	i = of_property_match_string(np, "clock-names", "td_slck");
> -	if (i < 0)
> -		return;
> -
> -	td_slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "md_slck");
> -	if (i < 0)
> -		return;
> -
> -	md_slck_name = of_clk_get_parent_name(np, i);
> -
> +	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> +	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
>  	i = of_property_match_string(np, "clock-names", "main_xtal");

Could you please move this above:

        main_xtal_name = of_clk_get_parent_name(np, i);

and have it like:

	i = of_property_match_string(np, "clock-names", "main_xtal");
	if (i < 0)
		return;
	mainxtal_name = of_clk_get_parent_name(np, i);


> -	if (i < 0)
> +
> +	if (!td_slck_hw || !md_slck_hw || !i)

I would keep the checking of i close to of_property_match_string(). Also,
you changed check only zero as invalid value. Is that right?
of_property_match_string() can return negative error numbers as well.

>  		return;
> -	mainxtal_name = of_clk_get_parent_name(np, i);
>  
> +	main_xtal_name = of_clk_get_parent_name(np, i);
>  	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
>  		return;
> @@ -760,26 +780,25 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  	if (!clk_mux_buffer)
>  		goto err_free;
>  
> -	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
> -					   50000000);
> -	if (IS_ERR(hw))
> +	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
> +						   50000000);
> +	if (IS_ERR(main_rc_hw))
>  		goto err_free;
>  
> -	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
> -	if (IS_ERR(hw))
> +	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &AT91_CLK_PD_NAME(main_xtal_name), 0);

Could you please add a line break before &AT91_CLK_PD_NAME() ?



