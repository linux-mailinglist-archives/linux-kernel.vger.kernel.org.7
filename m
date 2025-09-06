Return-Path: <linux-kernel+bounces-804411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC333B47627
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E82D561D83
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D527BF85;
	Sat,  6 Sep 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VRV1xQUk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BA27B35A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183805; cv=none; b=bRm/LWZM95vHPeiNRwp6EZ3kRn4LTAn1DP2upmy5mJ0ChqGWpYS83WL3r7c/RwR4UWeUmujJah3GKXd/TDK1NA8R2O9bAStDseXy7YBmo50kOtgypzk+xQt8TnsiMpnXzRBR6dTVp8tZgmGh/TNn2lND0xrPXUY8UJc/D4kwGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183805; c=relaxed/simple;
	bh=YO55bqOPflOkRwVnWnwk97PL8rmmDj5TiEsNI/x4hUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9LFoLOA8yxws1+Xm7k3e6V1OKdDg6kSlGe0TXHMRK1s9kQlAzB7YoaFqnu4CGhG3CqT5pm92eNLK4KVxNb7SAG+zEieGho+Tnz3FBboTMp+4HBK4ospC180MAqB5zEbSjx0fH6YyBMR7awP01xvIItNpYl3pZ5smnjtJLknY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VRV1xQUk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso3774035e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183803; x=1757788603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7c9v7WS7SgWPvY1/iQev0Y/b4zhJciSfPhNQ1aVFAg=;
        b=VRV1xQUku0R8CHHV2g6DmjLtkZjzpEM+tGffWoaRCJFHthO3/0oBjCHhMwSCTXc9mN
         lLFhMmV0Cb2ZGGVMXJmNHHnpE9KV6ZGsuiw75dORKg9i9VDj+SYgm6HhO61zENI6Yqbh
         ohYUyM+PJx8K06HbasSKm4GdcNvwWBrggW7RxnN2ixAMW1O2SP9VsXud3lnjfExm8vnq
         knHJ3sxWyNujZ7Dmj+GKB2B83aa7jvulXgUCoO4jXgcldomy80OodYw+xuD4LQVp6zw3
         hpPCp1vQup2U5xqryYNbqDB8W28E7CLpl3+gohE8RVqVNG7w+v6IDgBloqgl3vskSgoa
         Jp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183803; x=1757788603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7c9v7WS7SgWPvY1/iQev0Y/b4zhJciSfPhNQ1aVFAg=;
        b=cupXSarY8iocS6XR36YPEkgxac7i6dMqfXTUqEel9oAhmjmQaGgRffua0nmL9yGnD9
         dMmRaAtWWZcCpM2blIv53AnQs1cCvhFHY2z0+52g8/1zXYDZSCOX2wBwuLIQ6VqG8Ems
         ICrWl8prNtQuiBPWIkCFm3eLaW/0HdUjg0/HeTtOQHMGJPDl/ncCN6/fELIik6MvXl7G
         SZitKtxDABNMr3V9OIUaU2S4C36ajMSyq047ZIUHVgK7nFnbsTjeez5YgH/GM2FGqCYo
         9zdvSXMRnQp2wwTrebxNC6UterJlAqJcSzzaP99j0ux8zP4/XzYaILDHEMe7kVsMHRbe
         q3/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4GvNYNDeuUPJ6+izilHfRPhYV4mYSYozUOpR1g1H0fOj7v6EoW45SeQO6urVf5BJJJfN4WbNPqcZD3hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6h4mLLPdHN+Erw0OdQCZEImI7Yfd7mgs+bTNmquP7LAE3UAi
	f26xaOdpLBaBAJIDEavKmJiTL/2k/yBptVo1VogAsG4UVzeb1lVdhJooS04snaKnzmk=
X-Gm-Gg: ASbGncu6mpZ9GVD0SgUD2SZ0rGXAuEqX1E2sZ+ftpXzqcXwqqf1YAkA2p5zmeqtWZHP
	Y1XiDHVEc3FmssAoFsTNgiBbQq99JkmHRmCPaiL06Q0D+NQJ67Y382NevSOMcqCZlx0kO605jG7
	NckYFnuyw71mDxF6ylrk/URfMQn1edaMj7YJSq4+ElFsPA1yBeSYC2ZtoMO/TqG9VRsZedrmDWU
	vM9V2a4aTvD1ZDN2ZYUXlGh81xMKUeUEFDFaEEONgU8tR2euP1SqgN7yxqvm/Xg9SgXSFWZZU1N
	92cIY/VgclzD9h69AhmK5qGBPG/HLmSrChl3/5IGQKPa7sVh4eL17l3/Bix55h1wN57QQQ+NVgv
	RaIf1q2hmTOxBCe6Ry93u6R56H6jbiSQ=
X-Google-Smtp-Source: AGHT+IEn2KyTrQwMN8+aAJseCCgB1jUIJoNjfsgRExWZNCB1C5IQQmu9eW0YceImHVyoB6Oun7Fw7g==
X-Received: by 2002:a05:600c:3b1d:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-45ddde92816mr25903165e9.10.1757183802614;
        Sat, 06 Sep 2025 11:36:42 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm222805945e9.2.2025.09.06.11.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:36:42 -0700 (PDT)
Message-ID: <282ca7c4-7213-4e5d-9936-63687b5f4928@tuxon.dev>
Date: Sat, 6 Sep 2025 21:36:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 09/32] clk: at91: clk-programmable: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <aa1bae53bf124b8e46ff413b12528071262febb3.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <aa1bae53bf124b8e46ff413b12528071262febb3.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of struct parent_hw as this leads
> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
> conversion of existing SoC specific clock drivers from parent_names to
> modern clk_parent_data structures.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add the clk-programmable changes to the
> SAMA7D65 and SAM9X75 SoCs. Add td_slck_name variable and index for the
> SAM9X75.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/clk-programmable.c |  8 ++++----
>   drivers/clk/at91/pmc.h              |  2 +-
>   drivers/clk/at91/sam9x7.c           | 21 +++++++++++----------
>   drivers/clk/at91/sama7d65.c         | 20 ++++++++++----------
>   drivers/clk/at91/sama7g5.c          | 20 ++++++++++----------
>   5 files changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
> index 1195fb405503..275ca701f294 100644
> --- a/drivers/clk/at91/clk-programmable.c
> +++ b/drivers/clk/at91/clk-programmable.c
> @@ -215,7 +215,7 @@ static const struct clk_ops programmable_ops = {
>   struct clk_hw * __init
>   at91_clk_register_programmable(struct regmap *regmap,
>   			       const char *name, const char **parent_names,
> -			       struct clk_hw **parent_hws, u8 num_parents, u8 id,
> +			       struct clk_parent_data *parent_data, u8 num_parents, u8 id,
>   			       const struct clk_programmable_layout *layout,
>   			       u32 *mux_table)
>   {
> @@ -224,7 +224,7 @@ at91_clk_register_programmable(struct regmap *regmap,
>   	struct clk_init_data init = {};
>   	int ret;
>   
> -	if (id > PROG_ID_MAX || !(parent_names || parent_hws))
> +	if (id > PROG_ID_MAX || !(parent_names || parent_data))
>   		return ERR_PTR(-EINVAL);
>   
>   	prog = kzalloc(sizeof(*prog), GFP_KERNEL);
> @@ -233,8 +233,8 @@ at91_clk_register_programmable(struct regmap *regmap,
>   
>   	init.name = name;
>   	init.ops = &programmable_ops;
> -	if (parent_hws)
> -		init.parent_hws = (const struct clk_hw **)parent_hws;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 54d472276fc9..34036f2d0578 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -263,7 +263,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>   
>   struct clk_hw * __init
>   at91_clk_register_programmable(struct regmap *regmap, const char *name,
> -			       const char **parent_names, struct clk_hw **parent_hws,
> +			       const char **parent_names, struct clk_parent_data *parent_data,
>   			       u8 num_parents, u8 id,
>   			       const struct clk_programmable_layout *layout,
>   			       u32 *mux_table);
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index 945983f72140..86d624cd92b2 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -737,10 +737,11 @@ static const struct {
>   
>   static void __init sam9x7_pmc_setup(struct device_node *np)
>   {
> +	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
>   	struct clk_range range = CLK_RANGE(0, 0);
>   	const char *main_xtal_name = "main_xtal";
> +	const char * const td_slck_name = "td_slck";
>   	const char *const md_slck_name = "md_slck";
> -	u8 md_slck_index = 1, main_xtal_index = 2;
>   	struct pmc_data *sam9x7_pmc;
>   	const char *parent_names[9];
>   	void **clk_mux_buffer = NULL;
> @@ -752,7 +753,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	struct clk_hw *parent_hws[9];
>   	int i, j;
>   
> -	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> +	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, td_slck_name));

Please use a pattern like:

i = of_property_match_string(np, "clock-names", "td_slck");
if (i < 0)
    return;

td_slck_name = of_clk_get_parent_name(np, i);

Same sama7d65, sama7g5.


>   	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));
>   	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>   
> @@ -880,20 +881,20 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	if (IS_ERR(usbck_hw))
>   		goto err_free;
>   
> -	parent_hws[0] = md_slck_hw;
> -	parent_hws[1] = td_slck_hw;
> -	parent_hws[2] = sam9x7_pmc->chws[PMC_MAIN];
> -	parent_hws[3] = sam9x7_pmc->chws[PMC_MCK];
> -	parent_hws[4] = sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw;
> -	parent_hws[5] = sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw;
> -	parent_hws[6] = sam9x7_plls[PLL_ID_AUDIO][PLL_COMPID_DIV0].hw;
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);

AT91_CLK_PD_NAME(md_slck_name);

> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);

AT91_CLK_PD_NAME(td_slck_name);

Same sama7d65, sama7g5.

