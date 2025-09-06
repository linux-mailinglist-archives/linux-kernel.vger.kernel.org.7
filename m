Return-Path: <linux-kernel+bounces-804410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDDB47625
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3454F7B3894
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1E27F012;
	Sat,  6 Sep 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cfxcPBq3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00161194A59
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183787; cv=none; b=h3eqTIu1rNk9f/vsPSEepwFj1tUfE06TQdfV3zcHTjLlWN9KBQjtM343fr05aYZC0U04OzVoe8hH/3HL5M2/L1C91JteANByYsvEHTHZVBG9usuljBKHKvi3UW7I3M//umN2e/dUaEXkLRU6pcCr7TYcaYzbRU4VX6ogu09rf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183787; c=relaxed/simple;
	bh=VKVL40eq8AIFhMhXtrVrqkkhF8cIFFkayIOfgvJ0MMo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rhTNqnFHmXePT8HM8PB0EXi1qlf94o4t/uGwEzwyEEQBbSfokWuajzqZ/2RhYzWRPM2EJE8kWVr9bEsZTAh9cC6JWn/vPsIN9Ewi/6vyPOW1caqw687oRZR/9nBLRhpl4x1qBa94A7i2xBDmGPq69sxpxlPGg82/gKFGVejhnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cfxcPBq3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so18039085e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183784; x=1757788584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54ncVaPIl6vgU1gf8JptlaFEnSFvlH9WtRTSq/ZrGMM=;
        b=cfxcPBq3XXS3GZraQIOLbo8mG45CfLA35lkpCntZO6PlNkUdtZjnmDzdDEZdj8KQjW
         aFR2GGBhDmf7jhiptnVZ4sEwPFasPKNN8aK3FULNgmgUQ97GYKH7eHzOJe16NM83qB8R
         cPZl5En8IoO6o5/GGxIxb9Z0/aXbUHrpg4lWG3jK1+8/kEDIMy14YYX2FASjKSjnsabT
         Nup31A0qiacTwo6A/zVNYugVH9iP5ySQOAtahpCKQWTlkGD2qhALabiRnd+rAd8QGS48
         WAqicd57Af5RIVcPs+a0CsitmnQNhigq4VY0SnrP3/9gGK7zy3DGGstxK5mSjybV5BRR
         xORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183784; x=1757788584;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54ncVaPIl6vgU1gf8JptlaFEnSFvlH9WtRTSq/ZrGMM=;
        b=lyAi+d2sjsF5FO3pM05bn4Hsbuw/hZswh3h/AGcQ1k0420ao6QTnpgrJ4ZstkUO98a
         aECnNrbJqGoIW115ZoN6XQID7hgaJ5eWIP8Tb67nHZwf9TX9BnWZFKB+xzdebIzNrYfA
         vsEDFGiNr9oSQNibaTYwOUgYFxaVn1ae7pEJng6m47Rc6g9P7onkLOq15iiC2UnTqB2u
         JBBv8ETH+luoQ+UCwVqD9/DkhViOc5OylBlGPTORFh9y1T2AjcdcjNvojITZFXsDj0Pi
         dWiCktRoS2Yk0OH3Hfs4p+ywUNtoP5ojsXBs/ZKa7emcWZFnCaUcfm3WD9XQAtG1TzO0
         Fbmg==
X-Forwarded-Encrypted: i=1; AJvYcCV3MBPMtHTNKy138UYPXcHNVdewPg11GeyIBZXstjcskFhKJfgnbUTDpdo5dFuH7g8z9Kojh6Ctd7zmZeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZg5E8zD6uQyfM6x5rSsdTB4U74py9vSdMXMRjx6yhQeMspXI
	YEfnnr3qoKYlVuchVNws0IdHyryTPwlFj0DznpI7yeU0om2JxdfxOhqdp6+rnoHGnQk=
X-Gm-Gg: ASbGncuB8YAD1/Y3LdUkR9gl9G5GU9iLh2R6EKPOsnFBYDvP/Ba9KfrrJajkntJj86Z
	bQ6gmgkbMUZR8zYrt39usH00jUo/EK1CYf8gWe9ZQ3y+Pphzw0hP//OVuREDvCkx2d54nZM5Ym5
	+QpDlqpwuUSPIZriI3qBBrrTYP0hsvsBl1cNprKWxGDNQudwsyTnRgKgMOpBx1Dmt682ILez0FL
	04fhDYeHrp79wtsIhTpkGTBNtHHXq0lFtS9INgTATXIF1NiGMY+DonZGGCCzaOOnIwpqI8MaSVR
	o1M06qqO9ONu7D4CXZ6RJ/30VZCSN8Yc1bRebKcvgeYldnMgr5CeKX6rmvpsQcUDZpqFZfN/YU8
	WjRrU6wnHVY7CMg109SQ1jaD3dQyLuoDGaWrBWvm95w==
X-Google-Smtp-Source: AGHT+IHgGwWC3QcD58nUjxRKUaGgpa6imWI7sfXUg1oiAyn2VoRF7Hl9zOTaDpkuJIwGLGlYEOuU5g==
X-Received: by 2002:a05:600c:1993:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-45dddeb74a0mr23287305e9.3.1757183784329;
        Sat, 06 Sep 2025 11:36:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddfe0b654sm29303605e9.3.2025.09.06.11.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:36:23 -0700 (PDT)
Message-ID: <95e19f49-d0df-4d3f-bd7d-8b58b60f1f7a@tuxon.dev>
Date: Sat, 6 Sep 2025 21:36:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 08/32] clk: at91: clk-master: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <4b404eaaab4062464a4142e95aaa76d5cba866f0.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <4b404eaaab4062464a4142e95aaa76d5cba866f0.1752176711.git.Ryan.Wanner@microchip.com>
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
> The md_slck name and index are added for the SAM9X75 SoC so the
> clk-master can properly use parent_data.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add clk-master changes to SAM9X75 and
> SAMA7D65 SoCs. As well as add md_slck commit message.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/clk-master.c | 24 ++++++++++++------------
>   drivers/clk/at91/pmc.h        |  6 +++---
>   drivers/clk/at91/sam9x7.c     | 19 ++++++++++---------
>   drivers/clk/at91/sama7d65.c   | 23 ++++++++++-------------
>   drivers/clk/at91/sama7g5.c    | 29 +++++++++++++----------------
>   5 files changed, 48 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 7a544e429d34..cc4f3beb51e5 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -473,7 +473,7 @@ static struct clk_hw * __init
>   at91_clk_register_master_internal(struct regmap *regmap,
>   		const char *name, int num_parents,
>   		const char **parent_names,
> -		struct clk_hw **parent_hws,
> +		struct clk_parent_data *parent_data,
>   		const struct clk_master_layout *layout,
>   		const struct clk_master_characteristics *characteristics,
>   		const struct clk_ops *ops, spinlock_t *lock, u32 flags)
> @@ -485,7 +485,7 @@ at91_clk_register_master_internal(struct regmap *regmap,
>   	unsigned long irqflags;
>   	int ret;
>   
> -	if (!name || !num_parents || !(parent_names || parent_hws) || !lock)
> +	if (!name || !num_parents || !(parent_names || parent_data) || !lock)
>   		return ERR_PTR(-EINVAL);
>   
>   	master = kzalloc(sizeof(*master), GFP_KERNEL);
> @@ -494,8 +494,8 @@ at91_clk_register_master_internal(struct regmap *regmap,
>   
>   	init.name = name;
>   	init.ops = ops;
> -	if (parent_hws)
> -		init.parent_hws = (const struct clk_hw **)parent_hws;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
> @@ -531,13 +531,13 @@ struct clk_hw * __init
>   at91_clk_register_master_pres(struct regmap *regmap,
>   		const char *name, int num_parents,
>   		const char **parent_names,
> -		struct clk_hw **parent_hws,
> +		struct clk_parent_data *parent_data,
>   		const struct clk_master_layout *layout,
>   		const struct clk_master_characteristics *characteristics,
>   		spinlock_t *lock)
>   {
>   	return at91_clk_register_master_internal(regmap, name, num_parents,
> -						 parent_names, parent_hws, layout,
> +						 parent_names, parent_data, layout,
>   						 characteristics,
>   						 &master_pres_ops,
>   						 lock, CLK_SET_RATE_GATE);
> @@ -546,7 +546,7 @@ at91_clk_register_master_pres(struct regmap *regmap,
>   struct clk_hw * __init
>   at91_clk_register_master_div(struct regmap *regmap,
>   		const char *name, const char *parent_name,
> -		struct clk_hw *parent_hw, const struct clk_master_layout *layout,
> +		struct clk_parent_data *parent_data, const struct clk_master_layout *layout,
>   		const struct clk_master_characteristics *characteristics,
>   		spinlock_t *lock, u32 flags, u32 safe_div)
>   {
> @@ -560,7 +560,7 @@ at91_clk_register_master_div(struct regmap *regmap,
>   
>   	hw = at91_clk_register_master_internal(regmap, name, 1,
>   					       parent_name ? &parent_name : NULL,
> -					       parent_hw ? &parent_hw : NULL, layout,
> +					       parent_data, layout,
>   					       characteristics, ops,
>   					       lock, flags);
>   
> @@ -812,7 +812,7 @@ struct clk_hw * __init
>   at91_clk_sama7g5_register_master(struct regmap *regmap,
>   				 const char *name, int num_parents,
>   				 const char **parent_names,
> -				 struct clk_hw **parent_hws,
> +				 struct clk_parent_data *parent_data,
>   				 u32 *mux_table,
>   				 spinlock_t *lock, u8 id,
>   				 bool critical, int chg_pid)
> @@ -824,7 +824,7 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>   	unsigned int val;
>   	int ret;
>   
> -	if (!name || !num_parents || !(parent_names || parent_hws) || !mux_table ||
> +	if (!name || !num_parents || !(parent_names || parent_data) || !mux_table ||
>   	    !lock || id > MASTER_MAX_ID)
>   		return ERR_PTR(-EINVAL);
>   
> @@ -834,8 +834,8 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>   
>   	init.name = name;
>   	init.ops = &sama7g5_master_ops;
> -	if (parent_hws)
> -		init.parent_hws = (const struct clk_hw **)parent_hws;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index d9a04fddb0b1..54d472276fc9 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -204,14 +204,14 @@ at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
>   struct clk_hw * __init
>   at91_clk_register_master_pres(struct regmap *regmap, const char *name,
>   			      int num_parents, const char **parent_names,
> -			      struct clk_hw **parent_hws,
> +			      struct clk_parent_data *parent_data,
>   			      const struct clk_master_layout *layout,
>   			      const struct clk_master_characteristics *characteristics,
>   			      spinlock_t *lock);
>   
>   struct clk_hw * __init
>   at91_clk_register_master_div(struct regmap *regmap, const char *name,
> -			     const char *parent_names, struct clk_hw *parent_hw,
> +			     const char *parent_names, struct clk_parent_data *parent_data,
>   			     const struct clk_master_layout *layout,
>   			     const struct clk_master_characteristics *characteristics,
>   			     spinlock_t *lock, u32 flags, u32 safe_div);
> @@ -220,7 +220,7 @@ struct clk_hw * __init
>   at91_clk_sama7g5_register_master(struct regmap *regmap,
>   				 const char *name, int num_parents,
>   				 const char **parent_names,
> -				 struct clk_hw **parent_hws, u32 *mux_table,
> +				 struct clk_parent_data *parent_data, u32 *mux_table,
>   				 spinlock_t *lock, u8 id, bool critical,
>   				 int chg_pid);
>   
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index eaae05ba21ad..945983f72140 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -739,7 +739,8 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   {
>   	struct clk_range range = CLK_RANGE(0, 0);
>   	const char *main_xtal_name = "main_xtal";
> -	u8 main_xtal_index = 2;
> +	const char *const md_slck_name = "md_slck";
> +	u8 md_slck_index = 1, main_xtal_index = 2;
>   	struct pmc_data *sam9x7_pmc;
>   	const char *parent_names[9];
>   	void **clk_mux_buffer = NULL;
> @@ -747,12 +748,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	struct regmap *regmap;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>   	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> -	struct clk_parent_data parent_data[2];
> +	struct clk_parent_data parent_data[9];
>   	struct clk_hw *parent_hws[9];
>   	int i, j;
>   
>   	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> -	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> +	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));

Please use:

i = of_property_match_string(np, "clock-names", "md_slck");
if (i < 0)
    return;

md_slck_name = of_clk_get_parent_name(np, i);

Same sama7d65, sama7g5.

>   	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>   
>   	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
> @@ -853,18 +854,18 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   		}
>   	}
>   
> -	parent_hws[0] = md_slck_hw;
> -	parent_hws[1] = sam9x7_pmc->chws[PMC_MAIN];
> -	parent_hws[2] = sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw;
> -	parent_hws[3] = sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw;
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);

AT91_CLK_PD_NAME(md_slck_name);

Same sama7d65, sama7g5.


