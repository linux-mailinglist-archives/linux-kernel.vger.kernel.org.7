Return-Path: <linux-kernel+bounces-804404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F9B47619
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791BAA41FF7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA322FE06;
	Sat,  6 Sep 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DFOTZtGo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E422036FA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183642; cv=none; b=LYS3wivyBuHlFuENBBRKlxGVHOQcj3+gXBQed7Nf/0SAqj0fnwMIJvR5KFfB/0IQj/rSWWgJ+/ahbIbSaKO3S+VzAVRojYzbL1hj/N3h4gtNMqzdXRtc/CFMGs3srftxY+4CO1kxegyG8GpJZ5MM0vj70GvYzVCdIM6j/7fxgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183642; c=relaxed/simple;
	bh=W/2Sq/4yyLLnRl++lsYCiOAuBBkhcepnNFKicgLlL+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr/eSqRrrzqpCF0JMUWHqbJK9eaJAZgRt9wPIfEPsFVohvGZrv2ovuUK4zwc3TmNMTPMBheMmXNouozE4Xub7iiafuvkO2kvUxZIZx3zSDM2q+g1uH4WC8BtTOyXQqqYbqvDY1/kv5cwFzWQf69yjTEs8GMYlJDK4HdrYeNUX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DFOTZtGo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso11177255e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183638; x=1757788438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv6V9tVtGvXzN9JN5JdXHgexWU19RiPJvHD4mnHh1lY=;
        b=DFOTZtGoPmADL2NZ/bfb2N0Be20WmxSoZOI9Bpfk9KEoMz0gBxQMjclI2HuiohsXG3
         8Sslvnd37qAmgqjeyeJn2bwRUXLcxBMn7i4kMgmLw00DMKukqfe3OPGYwZmwvkPq5qFD
         NA2tfF/VDAIXkSSJUFWhP4+YaLg7hFlxewE0WeOz9/MAcKMAtrNyQc+VNxcsA2e3ZSGh
         ckrWw7aLe9DXSjaTxEHjPTmPfx4DKY9pOQTca4/cNm4zkFCEeKo8tPUZouwRKU3NWW1y
         Xap+jMdV7XGLr5QAI5cc+4psHfShfDwBsTuBk3+nZ/aMxXMNdH8zOPhqmdus6JuDu3x7
         x9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183638; x=1757788438;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv6V9tVtGvXzN9JN5JdXHgexWU19RiPJvHD4mnHh1lY=;
        b=rmKPs3mMpFk34aTn0shb5m0KTfrhPsdL0ssnWdFwFo/1/f66vLVLUPtb2l0Vs/YGhD
         tiPqO7tJVTyknpa9l9j7jt/qnNSLzJnzGBUZdTrIg79TMmGa/deQZ4yUkmy270jkAOnb
         5fdIZVbZzyibfAuONmoZKNuB9Pi6joEiQ/xqvCryVg2qb0Be7xo/lvYak7ozubrnYcLN
         sWwxtQ15Kg6TUzeTEUvq3kd0mf6IySNwUpZIA7ppqWXeoN2nVb0xqs1ei4BQY5NXZ2HQ
         slig5DQ4kT/qy/0sGAH+iDaCqKWDjMsCJTaXpZZX6dQSQLIt3GrZ3TSB1XPKtiFcPn4p
         ucvA==
X-Forwarded-Encrypted: i=1; AJvYcCVZSoQUYpj9enY9Xagl3tipgu6Z7XHtZEs2oGgr/DP9zKmHUgkbEdMaXejL7wjlyoIt75/YJOF18wU1jjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hLXZkthEmXhFqzU/KQqBITQC1SLtp6r2DW0mZ6EZgwf5wOsv
	+7wOEjlH3SOeDSWK5COUu8PDTR0qCIDuPLK2gyuI6VcgtdoxP/vYKXbMLieSKL+Xrh/Nv/g/JIS
	Y9HF4
X-Gm-Gg: ASbGncudxpR84FR1FCaNyP9V0ByK7AbLCdnZYLMV4+lTlvTkqhAkIqWGnA77RcvKbCY
	/6lHtOudr1EuNWINBsrtgRkOqxs4P2wxkT/xDIdi9oNNcdTLuq5pKCJEihMTVux8XFBLPEbhDr3
	+XA3tV/5A3DW29Nr9QEWIy5Li+fqVgYAGrKqHJ73cw4S8e9jpObvOkNKIVJ3ZhGUpxwBpJqugBR
	wNeS7Eue44picHS6IaRUYGPZWmE/EklB4cvYYfhmQQyRv8uufaPIH0JmsJxHygYgKwoX1ukhewJ
	kRyn5ttQvqNvxGLzdrzi1hOrWlGu7kuMonfz/eF/T9func75sLfLIH/ZnUJ9lXhOzTJHs9mjZxO
	QgCWKHGhBIaR4OfJTAwu3w36CtRsU4fY=
X-Google-Smtp-Source: AGHT+IGPeBLOpzMXH5QWmLiH/7uxfPzMzBWJEe83t320chzPFpRcaWsKId0R0dA9X9dygo6lURy4DQ==
X-Received: by 2002:a05:6000:2c0b:b0:3e0:37f3:7778 with SMTP id ffacd0b85a97d-3e64317d070mr2097103f8f.26.1757183638489;
        Sat, 06 Sep 2025 11:33:58 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm6301439f8f.57.2025.09.06.11.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:33:58 -0700 (PDT)
Message-ID: <05e16211-7521-452d-9ef3-988dfe70618e@tuxon.dev>
Date: Sat, 6 Sep 2025 21:33:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/32] clk: at91: sam9x75: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <b39fdf4c800103e4fd3fe2ace2c295f635a59d0f.1752176711.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <b39fdf4c800103e4fd3fe2ace2c295f635a59d0f.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:06, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Switch SAM9X75 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> The USBCLK will be updated in subsequent patches that update the clock
> registration functions to use parent_hw and parent_data.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/sam9x7.c | 308 +++++++++++++++++++++-----------------
>  1 file changed, 173 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index cbb8b220f16b..31184e11165a 100644
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
> @@ -180,6 +192,18 @@ static const struct clk_pll_layout pll_divio_layout = {
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
> @@ -187,22 +211,24 @@ static const struct clk_pll_layout pll_divio_layout = {
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
> @@ -213,9 +239,9 @@ static const struct {
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
> @@ -223,21 +249,35 @@ static const struct {
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

According to manual at [1] this looks correct. Maybe mention this move in
commit description.

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X7-Series-Data-Sheet-DS60001813.pdf


[...]

>  static void __init sam9x7_pmc_setup(struct device_node *np)
>  {
>  	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *td_slck_name, *md_slck_name, *mainxtal_name;
> +	const char *main_xtal_name = "main_xtal";
>  	struct pmc_data *sam9x7_pmc;
>  	const char *parent_names[9];
>  	void **clk_mux_buffer = NULL;
>  	int clk_mux_buffer_size = 0;
> -	struct clk_hw *main_osc_hw;
>  	struct regmap *regmap;
> -	struct clk_hw *hw;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> +	static struct clk_parent_data parent_data;
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
> +	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> +	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> +	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>  
> -	i = of_property_match_string(np, "clock-names", "main_xtal");
> -	if (i < 0)
> +	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
>  		return;
> -	mainxtal_name = of_clk_get_parent_name(np, i);
>  
>  	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
> @@ -754,26 +774,27 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
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
> +	parent_data.name = main_xtal_name;
> +	parent_data.fw_name = main_xtal_name;

You should be able to use AT91_CLK_PD_NAME() directly in the above call
where main_xtal_name should be retrieved with of_clk_get_parent_name()


