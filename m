Return-Path: <linux-kernel+bounces-861610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DCBF32E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189764FA6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89FF2D8DD9;
	Mon, 20 Oct 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="krM1SMM8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288622D1901
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987993; cv=none; b=A/1qGg4Ee6PVrvSTO4bbX4KuCDbS/6clyn/rPZZ/1VWB56qbS8r//uo2E72R5aMVh2d1zVUNtpW7pj5mlTDhmlQNIDUiHP1sOuI7oBVaXtR4DFAp9XRqe+GeuC2pJZ6Wvwanb0CKuD/vcRqawnig9uY+bX1dgqdycvANWVhsZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987993; c=relaxed/simple;
	bh=vdPCScQSgAAL2WyPO0aJjHrLCVNYBrruwyni11S9av0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPrcxhfHG6W3SIMsqOCreeJIKwgY2gUcv7m/kvOoXwZk2ifocbCfNzSPv3lD9T5I/LJU+rB9Y/x9nW2Z2+URSseXCIV2TiPJDM9AhK064ITsdON3cdH92HSBAc7qe2px6U6tssADRjbKci+HGJCGbjuGHyEu1zA9zPMEdzcW1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=krM1SMM8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so25554405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987989; x=1761592789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+uFkVa2u5HB8Xqrap3smBvxLAVYpo23297fy2cjAVs=;
        b=krM1SMM8pe1ZEayns2LLs6AnctA7zFXT0P3eNGe5CcXe+B5BmSO4vWwqx9slHy1bsZ
         dmiFFiGyb+eDP84YJcNsx1bGKzx2pRUPFLsSEn0J51A93DZU1qWt+fGptmH2eBs0G9GF
         mtv7DqAsmMvhRUN96mRTruLfempMvNHNnE39NE2rkoGBfk59L1ItzbkecMtCrQEFcLtQ
         tqy7PRe/LvbrrVjEGbH00Sm99caIzWrKHejMsX2LWJLcx3tpfMmJg021lHGtVY8DyZbp
         wekMGp/gEmbkIg39Oco3VzT5qzKyQpJmFiq/93qPREZ5Ib5Wbf3Y/44osIAS1PQhTO0X
         pZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987989; x=1761592789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+uFkVa2u5HB8Xqrap3smBvxLAVYpo23297fy2cjAVs=;
        b=gmNlOjUIjDvxn/oHqNeidVsnMJZGqSda6MG7uNVxmgONjgay3/HUf7APA28O3/BvB4
         50UjGhEnyiMfmXo7S9x+0aZzUCSuul+REBf8hQWxmjDOGPn1Hd7faygpKDJ+/KktZoUU
         +DDZdnA/ZCteJBSg3B55jmGDP3mdpqfQjrV8zMKQxKwLzwUXeXOYb0AQY60qDCLE5g6J
         RZuLbv/vm6OTxO8cV4kuNPkaH37sv9hfVuGASILH8IR6o3MqMOqjtPY3gJ1z9aMfina9
         AI57al4FI7Nk8hq4oDm/TnyPhwqZP953SKlTpWci8dZh10gecLMLVHsP9qBVQOq2tbce
         nZdw==
X-Forwarded-Encrypted: i=1; AJvYcCUAbNIV6HC3gNu3ExEt8mUIwT0qluxLeplUSCu5J/GRRz8ckrW9F3M+9Zb0h4FVKL9MGYhcbitM0UKYq4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKDQ1f7vBkFGBeRWnE+BUC9h4XqHhQMNwdgfz06N3wT2TPQg6
	sWZpVBQX7vysmPdaHSCLBmojFU4F8ZTSPET49NUbLYzvJyzDz9qfNyOpmVCI35sNZ4I=
X-Gm-Gg: ASbGncvSUduOeLAyuT18TeTDN8KgjOSp1P0CJrsddjMpWNImXeg847zLpv4KbBE+L4Y
	a7J4VWHitEHlCfUqkbboUXLwY0SP7dWyqKFeSgsJu6xMN3gaQ7hSy4xdWaRMjAlu6QOE/Ls6h6C
	HgMPWxMYVrcTbs11iEZ5A36gLDl9LXYw/59+58JtXaKuWVaBQjq7RC5u0/CQV9dZ8IeDIF709g4
	rZB5/PahZ7xEYBzpeQ/6JO6QgVYVQqnrueGxe+RAY3mgQCEbMTLqTJ4AV57mjZr++f7h/s42AIU
	BIOw6JT7QxHOvRzLhC/v2wMqrXw+avQb/cVuSDUueTIiCRzb6yBmWARbSYwC1bqlJrKdw4hvsJL
	Qz6PpPnCDrzJW5rlbI6SmVcy5gpG6m4IqoI7OBZjvqvoDonjsTGOBkzPSFuutpA1/+YgEghmxDB
	39182Zcf+Z
X-Google-Smtp-Source: AGHT+IGyDLbOrAVFyVlclFlduDeAPiKLL+XPFcf6nUCR2OVZ1JSE5xowDpETyC6TnlDfw1Og0gsFRg==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr94185105e9.14.1760987989393;
        Mon, 20 Oct 2025 12:19:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c34sm258496125e9.10.2025.10.20.12.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:19:48 -0700 (PDT)
Message-ID: <a007a272-03e3-40fd-871a-aa315f99697c@tuxon.dev>
Date: Mon, 20 Oct 2025 22:19:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/31] clk: at91: at91sam9x5: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <015b98fa475f97ae8e952343ee9703c9c0d37d19.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <015b98fa475f97ae8e952343ee9703c9c0d37d19.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch AT91SAM9X5 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/at91sam9x5.c | 108 +++++++++++++++++++---------------
>  1 file changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 13331e015dd7..46d5ea2e6417 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -38,9 +38,9 @@ static const struct clk_pll_characteristics plla_characteristics = {
>  	.out = plla_out,
>  };
>  
> -static const struct {
> +static struct {
>  	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>  	unsigned long flags;
>  	u8 id;
>  } at91sam9x5_systemck[] = {
> @@ -48,12 +48,12 @@ static const struct {
>  	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>  	 * to keep it enabled in case there is no Linux consumer for it.
>  	 */
> -	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "smdck", .p = "smdclk",   .id = 4 },
> -	{ .n = "uhpck", .p = "usbck",    .id = 6 },
> -	{ .n = "udpck", .p = "usbck",    .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",    .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",    .id = 9 },
> +	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "smdck", .id = 4 },
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
>  };
>  
>  static const struct clk_pcr_layout at91sam9x5_pcr_layout = {
> @@ -133,12 +133,13 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  					const struct pck *extra_pcks,
>  					bool has_lcdck)
>  {
> +	struct clk_hw *main_rc_hw, *main_osc_hw, *hw;
>  	struct clk_range range = CLK_RANGE(0, 0);
>  	const char *slck_name, *mainxtal_name;
>  	struct pmc_data *at91sam9x5_pmc;
> -	const char *parent_names[6];
> +	struct clk_parent_data parent_data[6];
>  	struct regmap *regmap;
> -	struct clk_hw *hw;
> +	struct clk_hw *smdck_hw, *usbck_hw;
>  	int i;
>  	bool bypass;
>  
> @@ -162,56 +163,58 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  	if (!at91sam9x5_pmc)
>  		return;
>  
> -	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
> -					   50000000);
> -	if (IS_ERR(hw))
> +	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
> +						   50000000);
> +	if (IS_ERR(main_rc_hw))
>  		goto err_free;
>  
>  	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>  
> -	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
> -					bypass);
> -	if (IS_ERR(hw))
> +	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> +						 &AT91_CLK_PD_NAME(mainxtal_name), bypass);
> +	if (IS_ERR(main_osc_hw))
>  		goto err_free;
>  
> -	parent_names[0] = "main_rc_osc";
> -	parent_names[1] = "main_osc";
> -	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
> +	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
> +	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
>  	at91sam9x5_pmc->chws[PMC_MAIN] = hw;
>  
> -	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
> +	hw = at91_clk_register_pll(regmap, "pllack", NULL,
> +				   &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]), 0,
>  				   &at91rm9200_pll_layout, &plla_characteristics);
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> -	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
> +	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
>  	at91sam9x5_pmc->chws[PMC_PLLACK] = hw;
>  
> -	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
> +	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL,
> +				    &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]));
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
>  	at91sam9x5_pmc->chws[PMC_UTMI] = hw;
>  
> -	parent_names[0] = slck_name;
> -	parent_names[1] = "mainck";
> -	parent_names[2] = "plladivck";
> -	parent_names[3] = "utmick";
> +	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
> +	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]);
> +	parent_data[2] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
> +	parent_data[3] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
>  	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
> -					   parent_names, NULL,
> +					   NULL, parent_data,
>  					   &at91sam9x5_master_layout,
>  					   &mck_characteristics, &mck_lock);
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> -	hw = at91_clk_register_master_div(regmap, "masterck_div",
> -					  "masterck_pres", NULL,
> +	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL,
> +					  &AT91_CLK_PD_HW(hw),
>  					  &at91sam9x5_master_layout,
>  					  &mck_characteristics, &mck_lock,
>  					  CLK_SET_RATE_GATE, 0);
> @@ -220,28 +223,30 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  
>  	at91sam9x5_pmc->chws[PMC_MCK] = hw;
>  
> -	parent_names[0] = "plladivck";
> -	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
> -	if (IS_ERR(hw))
> +	parent_data[0] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
> +	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
> +	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_data, 2);
> +	if (IS_ERR(usbck_hw))
>  		goto err_free;
>  
> -	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
> -	if (IS_ERR(hw))
> +	parent_data[0] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
> +	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);

No need for these. parent_data[] is already filled from the USB clk
registration.

