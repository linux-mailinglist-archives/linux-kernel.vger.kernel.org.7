Return-Path: <linux-kernel+bounces-804407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE3B4761F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB33B2A50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E627CB31;
	Sat,  6 Sep 2025 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TzyWFPF0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213E27B33B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183740; cv=none; b=g7fTrZW+OOsTTm6f1lcp8/82g0Ctov/S827EHDdDF11Tm5LpRpg7nBGyxRIC+2Zrq43VSSCxCKKHbe7uiAPvTv8wuHLKTjSvnjgOA6yUFQq4LBVnfZsCWmzyc9sM92FAOruAAK8EuywGUKjwjkXNVTYZ692xxXSlYJ+II5L7YUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183740; c=relaxed/simple;
	bh=INVKtWZhSgrbYf16941J0EzGl8mycJx6Wzm/74OTaSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=suUbCsEBXyU6GyQNXHvwx2TVXQcje5K649EanzdCjW7yZ4D5Z8gNTYII7o5BpjgNP2mlp/2DkCq02WVRksVQPySnvqmozXD8eMe+hGHlZkhmajRFIxPbzY7N0kF8gch7bWxNrYX9WasQSJq4qTkYtLKkNHpXn7jpItbU/UUnTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TzyWFPF0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso28697995e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183737; x=1757788537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dowxdedaabw9pmvRWcOU8YmdjNMCxfM0EeEvHC1enGo=;
        b=TzyWFPF0Fi0xCXhILED0XVx+rE6K8yDeTFoNHayugxu0pX2ILfRK0jBBxDhdNxuqBQ
         RCa7Q+VzBdbgfdYIsqLP2DzPxiYVEmF1Uf97Fs4cwBo9JwdYzJ0da/0JWWEtozsQfY1W
         nl1jD2xtCLkIgu5hhXZ2ARHBc/drYRDmdYopAa+vBSMKEZAlLfgG3KgjDJ9fkDVKUKDr
         Ub0Zh7URXNaGNl6lgOf/WhB082miYDjLo0C0qFbaNG7cENtseyBOe/NHGGhTjkKQIJjM
         mCZUkix3QyiZdixEBIfpCTIrZIdOp0ZwtBwcMeX9jcS9Jaj//EUhnLooHKDZUIGdxnfY
         WAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183737; x=1757788537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dowxdedaabw9pmvRWcOU8YmdjNMCxfM0EeEvHC1enGo=;
        b=Uy5JCoXR/ST61hBcFBUbHUO1sPHJl7dj9WeCmV0YrcuVwGAu3O98jhGd1pTJpV96ng
         PnFX1iMLRcSUZTtm5WqUi7R3YxN4fNEqJIM+/tEWyOJaNUAxIcmBg1+2CFLf0SoKHfZN
         Meh0IDru/4mCq3FyMFJf8VjxlHLTO2mjGMRV8vYZGKvsoF22gSj84o+4bYg6UXnkWXNA
         6JzccCYM7tZkQeiz4cPZrIFCX0XYbq4rl3nWpoa4PqpNAyqSL39C8Ne881GpjZlGJLyS
         FjoSMBYwBrTefkEfsWC2SAW14M0F06F34SiJnptTLTkoN1ndwY+dX8Tg1pureuuRaaQ9
         A17A==
X-Forwarded-Encrypted: i=1; AJvYcCX8YVJOZAt3gE7Xp9yUZBjRw/JuChreR2UTjdygskbQ7B4+J6biudGo85ZBzm6HEnCm1EIpzDQQVCKe1xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQJ3IwJmgavU+5CLHofhLm6b5A7yMeOPCe75qkOiRoWF6IpAE
	F0Cop9VcrKWH0M0yt9KbnDZCjygULwRJcE+x4FTUUGd5bFK78+rDfEHso0fi2gXOWi0=
X-Gm-Gg: ASbGncuxxFML4BdhFJSIxI/IM3mISjgDr3EIElVYY+sojJopZZP8Fc0zv/9sLVG853k
	/VBz1VXSV+h3U2EkzFsshrh89rOlUGZIMj1xwURHiXfM4mfkc8P6BOYjWVdotyES5f5hlixE12/
	eWJ8v8R1TEAKVr5NrvZrmmhJbaRqMcCty9ylgrbajeiJ7J6uarTB2IZ7EfgufOBbXULPC5b8869
	k8CueG5DoCOD4fGzknNb7g+3Akxt4RTHmEQIJZBQJmAkdqTtnW5ijInx8rrnAQeVfNxdBKE2AGw
	w9/dlVghEQnWlRKYqvHE7yRwH8nd2OxP1SOkyKd0d+Hg+LuZKaaRRCimU9cN2nSg3eDG3pg2MKQ
	DNMh1CUNJ2lUfd8OvyJ6N0h8aZ2bj+lw2d9HDLnXo7Q==
X-Google-Smtp-Source: AGHT+IFqHQftxhyWop0NQsuDuKJieWCJS/ELGIRCmyIaJV/f88uiSxO0l/KEtdpJymZlggSX1ktNCg==
X-Received: by 2002:a05:600c:3b97:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45dde200426mr27655935e9.11.1757183736423;
        Sat, 06 Sep 2025 11:35:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm103081405e9.17.2025.09.06.11.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:35:35 -0700 (PDT)
Message-ID: <e2d8757b-9554-49b0-a067-f5aa657f3003@tuxon.dev>
Date: Sat, 6 Sep 2025 21:35:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 06/32] clk: at91: clk-main: switch to clk parent data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <33cec8a2f82e1bc747aa4315e47d535b7cec5a63.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <33cec8a2f82e1bc747aa4315e47d535b7cec5a63.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:06, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of parent_hw for the main clock.

Same here as in patch 05/32. Please check the other patches as well.


> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to use parent_data.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/clk-main.c | 16 ++++++++--------
>   drivers/clk/at91/pmc.h      |  4 ++--
>   drivers/clk/at91/sam9x7.c   | 21 ++++++++++-----------
>   drivers/clk/at91/sama7d65.c | 21 ++++++++++-----------
>   drivers/clk/at91/sama7g5.c  | 21 ++++++++++-----------
>   5 files changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 9b462becc693..514c5690253f 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -402,7 +402,7 @@ struct clk_hw * __init
>   at91_clk_register_rm9200_main(struct regmap *regmap,
>   			      const char *name,
>   			      const char *parent_name,
> -			      struct clk_hw *parent_hw)
> +			      struct clk_parent_data *parent_data)
>   {
>   	struct clk_rm9200_main *clkmain;
>   	struct clk_init_data init = {};
> @@ -412,7 +412,7 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
>   	if (!name)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (!(parent_name || parent_hw))
> +	if (!(parent_name || parent_data))
>   		return ERR_PTR(-EINVAL);
>   
>   	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
> @@ -421,8 +421,8 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
>   
>   	init.name = name;
>   	init.ops = &rm9200_main_ops;
> -	if (parent_hw)
> -		init.parent_hws = (const struct clk_hw **)&parent_hw;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = &parent_name;
>   	init.num_parents = 1;
> @@ -552,7 +552,7 @@ struct clk_hw * __init
>   at91_clk_register_sam9x5_main(struct regmap *regmap,
>   			      const char *name,
>   			      const char **parent_names,
> -			      struct clk_hw **parent_hws,
> +			      struct clk_parent_data *parent_data,
>   			      int num_parents)
>   {
>   	struct clk_sam9x5_main *clkmain;
> @@ -564,7 +564,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
>   	if (!name)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (!(parent_hws || parent_names) || !num_parents)
> +	if (!(parent_data || parent_names) || !num_parents)
>   		return ERR_PTR(-EINVAL);
>   
>   	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
> @@ -573,8 +573,8 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
>   
>   	init.name = name;
>   	init.ops = &sam9x5_main_ops;
> -	if (parent_hws)
> -		init.parent_hws = (const struct clk_hw **)parent_hws;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index b6f2aca1e1fd..e32a5e85d08f 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -195,11 +195,11 @@ struct clk_hw * __init
>   at91_clk_register_rm9200_main(struct regmap *regmap,
>   			      const char *name,
>   			      const char *parent_name,
> -			      struct clk_hw *parent_hw);
> +			      struct clk_parent_data *parent_data);
>   struct clk_hw * __init
>   at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
>   			      const char **parent_names,
> -			      struct clk_hw **parent_hws, int num_parents);
> +			      struct clk_parent_data *parent_data, int num_parents);
>   
>   struct clk_hw * __init
>   at91_clk_register_master_pres(struct regmap *regmap, const char *name,
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index d7dc5f381ebe..eaae05ba21ad 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -747,7 +747,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	struct regmap *regmap;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>   	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> -	static struct clk_parent_data parent_data;
> +	struct clk_parent_data parent_data[2];
>   	struct clk_hw *parent_hws[9];
>   	int i, j;
>   
> @@ -780,15 +780,14 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	if (IS_ERR(main_rc_hw))
>   		goto err_free;
>   
> -	parent_data.name = main_xtal_name;
> -	parent_data.fw_name = main_xtal_name;
> -	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data, 0);
> +	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> +						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index), 0);

here &AT91_CLK_PD_NAME(main_xtal_name)

where main_xtal_name is retrieved with of_clk_get_parent_name(). Same for
the other SoCs touched in this patch. Same approach would have to be taken
into account for patches in this series using main_xtal, md_slck, td_slck
as parents through AT91_CLK_PD_NAME().

>   	if (IS_ERR(main_osc_hw))
>   		goto err_free;
>   
> -	parent_hws[0] = main_rc_hw;
> -	parent_hws[1] = main_osc_hw;
> -	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
> +	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
> +	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> @@ -805,12 +804,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   			case PLL_TYPE_FRAC:
>   				switch (sam9x7_plls[i][j].p) {
>   				case SAM9X7_PLL_PARENT_MAINCK:
> -					parent_data = AT91_CLK_PD_NAME("mainck", -1);
> +					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
>   					hw = sam9x7_pmc->chws[PMC_MAIN];
>   					break;
>   				case SAM9X7_PLL_PARENT_MAIN_XTAL:
> -					parent_data = AT91_CLK_PD_NAME(main_xtal_name,
> -								       main_xtal_index);
> +					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
> +									  main_xtal_index);
>   					hw = main_xtal_hw;
>   					break;
>   				default:
> @@ -825,7 +824,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   				hw = sam9x60_clk_register_frac_pll(regmap,
>   								   &pmc_pll_lock,
>   								   sam9x7_plls[i][j].n,
> -								   &parent_data, parent_rate, i,
> +								   parent_data, parent_rate, i,
>   								   sam9x7_plls[i][j].c,
>   								   sam9x7_plls[i][j].l,
>   								   sam9x7_plls[i][j].f);
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index 372e530f4107..1d461db0438f 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -1098,7 +1098,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	struct regmap *regmap;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>   	struct clk_hw *td_slck_hw, *md_slck_hw;
> -	static struct clk_parent_data parent_data;
> +	struct clk_parent_data parent_data[2];
>   	struct clk_hw *parent_hws[10];
>   	bool bypass;
>   	int i, j;
> @@ -1134,16 +1134,15 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   
>   	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>   
> -	parent_data.name = main_xtal_name;
> -	parent_data.fw_name = main_xtal_name;
>   	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> -						 &parent_data, bypass);
> +						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index),
> +						 bypass);
>   	if (IS_ERR(main_osc_hw))
>   		goto err_free;
>   
> -	parent_hws[0] = main_rc_hw;
> -	parent_hws[1] = main_osc_hw;
> -	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
> +	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
> +	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> @@ -1160,12 +1159,12 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   			case PLL_TYPE_FRAC:
>   				switch (sama7d65_plls[i][j].p) {
>   				case SAMA7D65_PLL_PARENT_MAINCK:
> -					parent_data = AT91_CLK_PD_NAME("mainck", -1);
> +					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
>   					hw = sama7d65_pmc->chws[PMC_MAIN];
>   					break;
>   				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
> -					parent_data = AT91_CLK_PD_NAME(main_xtal_name,
> -								       main_xtal_index);
> +					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
> +									  main_xtal_index);
>   					hw = main_xtal_hw;
>   					break;
>   				default:
> @@ -1178,7 +1177,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   
>   				hw = sam9x60_clk_register_frac_pll(regmap,
>   					&pmc_pll_lock, sama7d65_plls[i][j].n,
> -					&parent_data, parent_rate, i,
> +					parent_data, parent_rate, i,
>   					sama7d65_plls[i][j].c,
>   					sama7d65_plls[i][j].l,
>   					sama7d65_plls[i][j].f);
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index f28fe419ae5e..f816a5551277 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -977,7 +977,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   	struct regmap *regmap;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>   	struct clk_hw *td_slck_hw, *md_slck_hw;
> -	static struct clk_parent_data parent_data;
> +	struct clk_parent_data parent_data[2];
>   	struct clk_hw *parent_hws[10];
>   	bool bypass;
>   	int i, j;
> @@ -1013,16 +1013,15 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   
>   	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>   
> -	parent_data.name = main_xtal_name;
> -	parent_data.fw_name = main_xtal_name;
>   	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> -						 &parent_data, bypass);
> +						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index),
> +						 bypass);
>   	if (IS_ERR(main_osc_hw))
>   		goto err_free;
>   
> -	parent_hws[0] = main_rc_hw;
> -	parent_hws[1] = main_osc_hw;
> -	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
> +	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
> +	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> @@ -1039,12 +1038,12 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   			case PLL_TYPE_FRAC:
>   				switch (sama7g5_plls[i][j].p) {
>   				case SAMA7G5_PLL_PARENT_MAINCK:
> -					parent_data = AT91_CLK_PD_NAME("mainck", -1);
> +					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
>   					hw = sama7g5_pmc->chws[PMC_MAIN];
>   					break;
>   				case SAMA7G5_PLL_PARENT_MAIN_XTAL:
> -					parent_data = AT91_CLK_PD_NAME(main_xtal_name,
> -								       main_xtal_index);
> +					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
> +									  main_xtal_index);
>   					hw = main_xtal_hw;
>   					break;
>   				default:
> @@ -1058,7 +1057,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   
>   				hw = sam9x60_clk_register_frac_pll(regmap,
>   					&pmc_pll_lock, sama7g5_plls[i][j].n,
> -					&parent_data, parent_rate, i,
> +					parent_data, parent_rate, i,
>   					sama7g5_plls[i][j].c,
>   					sama7g5_plls[i][j].l,
>   					sama7g5_plls[i][j].f);


