Return-Path: <linux-kernel+bounces-804412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7339B47629
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DD97B423F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D927C869;
	Sat,  6 Sep 2025 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ouqMwJaD"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417F21171D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183847; cv=none; b=pBGAXrWtj+ybYT//3OGu7HHzsLm+IbriGRb+z/fcCOvsBKMK1oIRzfF85+eltWph3j8kntC8Tpjg2/J76tClWUANfHo1yjxV7tLzKVZk70AEiMIwjZyT3yd7cCadTVBeQ7ELDEHnaik4Z9iV96e727vM3Qj2jYMxZS/PzVl4Ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183847; c=relaxed/simple;
	bh=PgOaTE/wisn47JebcAxiiOEEbzG61QwtFAnGbhbliMc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OuifpuwwK3eQ+n2DSvy7G91b/e50gASM90lJ/mbby7F5gMhFBGMU9aaY4uweg7Vb2RmaHQpySnzaqsiadLRl+7UAZVsYBHRRSBk+pz5rkQsYcugQhQbJbyYgsKw6ag1sgF17wOJZRumUJXg3oLpLWnCpR6DOgFkjq23mFhT8lKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ouqMwJaD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb5492350so20200405e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183844; x=1757788644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=asMwycMgdJ6wmjQEJEXq9PlkPbXrAScvnIzSzlc8XJ0=;
        b=ouqMwJaDVUDagTM1ntZ+msleJ2R1n4waN8tZRaJrx3dZTs4YG0uJhpKrcuio2j1O5V
         aB07N3x3zqhdBlGzN6S0Yhqfk8p02WZxVXRBFm3HIZBN3RK1ptuFteYfGYBMJqShRpcD
         JEy7KwD/st3yI5Ih2Khw2QkN7+/7E842T74wLWkLILznjsu6KRb/K2rQG2rmC60WByOa
         wlLEpL0xq/+jDrYuQf4hm31UZcoFHoOZcoDtizv/ZF/sBcxQ6OTvyzjSLKuQX0jVCduE
         I7vW2aHNxBE5rL0q6TRDwFtPi/UVqqmd8BhdaHCQdDfn3t4h4VbOEhQm8E50UxwFVU8x
         N7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183844; x=1757788644;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asMwycMgdJ6wmjQEJEXq9PlkPbXrAScvnIzSzlc8XJ0=;
        b=ar22jWDug413Twy4hQARk+ArAXJ8CfOMRz0p+KneNT4dy0d60aXKuwvq/k3cghof1Z
         VemxS/8bw7s4fK9BIYyuN+OADEmSWRokblFOG8BMZ9sAuadKHK3GpiNH1DYl7QCpUBVQ
         njJBfO4sYnOZrm4N8jXOWRbgA7PfJ3oLBOq4pyvdwZpSD3tRBkdqzRN4CgoUjX1Qun+x
         /eW6Yx5EoHplHN+BaHLWfSoY2uFEjW1pj5ZczBWamOv5JBd9Y6JTJDMzcBjkn9LQC0kS
         Q5uzNh7QCD7iw+vWmyQ72O3l85j6NrzD5hm7BOWYwmrGQELceDeBaqAMSiH+ig3MyQkZ
         x8tA==
X-Forwarded-Encrypted: i=1; AJvYcCXXoCbBwLzcFM1UTWMOpdy/GDcSKO4IS1d50WpgUSwzZex0vhmMihYMrIMQ94i9sFaR7mAQRM0PASigSgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWZZL0HXXTanFGq1s5b2Dvuf98qkklWB7pcKhk/DknQIBFxfe
	05otokmCYSBrWHimoh7soFSVryKnPxhOgcPUOBR+2g2lm4RY65JQZ3j5SDeE1230+zY=
X-Gm-Gg: ASbGncs3rbXrTeH8tEhf1oxZMfGY17Vi1Ge2dlTox7cnobzglPLCOpqZOvVo5bWzjNG
	Lfo1JjzRZZLVA48bCKr3YipJx7SSNwcOwbmBoW2Nppur+J3Pta49fR9gupO8HiVtTZUquH1uO5N
	NqPhboGhLpFXz5/usR55sT4ZEdgGL0VlBywKwLUbdh3qQfnv5x3/zCrY4H6L7d1YvPTZGW28tYX
	XGyEiXsPIfWhDKCH4QeuVmxgbBU3jSZas4PkiMsqGHG6sF8QCQK9mMLTWmR9oBTba/0b9Cgdsja
	PwxSaYVhT2tfIgVdy6OIBUt7JGwsdjDOACzAB8YdtOkHiTOVAMOzkvVO+RB8JsmdRpVR7Dua4re
	DXJprOlKoCK4DTym6iuc/H6S+wCzpzUuOhULzvb3lBA==
X-Google-Smtp-Source: AGHT+IFVpAPkEBgsqd2phzJ5PQ/8I7hk0nfqyimYq1sXGXWWNpSyZbGpfJlRrjeLGnPeIjRM34lALQ==
X-Received: by 2002:a05:6000:420f:b0:3ce:a06e:f248 with SMTP id ffacd0b85a97d-3e642026e45mr2100552f8f.17.1757183844016;
        Sat, 06 Sep 2025 11:37:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm35344599f8f.25.2025.09.06.11.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:37:23 -0700 (PDT)
Message-ID: <5f2d9137-5dd5-477a-9b65-9a55b4223380@tuxon.dev>
Date: Sat, 6 Sep 2025 21:37:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 10/32] clk: at91: clk-generated: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <c22f1546e25cfe0d4ae3f6f2507b522311190812.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <c22f1546e25cfe0d4ae3f6f2507b522311190812.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of struct parent_hw as this leads
> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
> conversion of existing SoC specific clock drivers from parent_names to
> modern clk_parent_data structures.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Added SAMA7D65 and SAM9X75 SoCs to the
> clk-generated changes. Adjust clk name variable order.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/clk-generated.c |  8 ++++----
>   drivers/clk/at91/pmc.h           |  2 +-
>   drivers/clk/at91/sam9x7.c        | 26 ++++++++++----------------
>   drivers/clk/at91/sama7d65.c      | 31 +++++++++++++------------------
>   drivers/clk/at91/sama7g5.c       | 30 +++++++++++-------------------
>   5 files changed, 39 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 4b4edeecc889..d9e00167dbc8 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -319,7 +319,7 @@ struct clk_hw * __init
>   at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>   			    const struct clk_pcr_layout *layout,
>   			    const char *name, const char **parent_names,
> -			    struct clk_hw **parent_hws,
> +			    struct clk_parent_data *parent_data,
>   			    u32 *mux_table, u8 num_parents, u8 id,
>   			    const struct clk_range *range,
>   			    int chg_pid)
> @@ -329,7 +329,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>   	struct clk_hw *hw;
>   	int ret;
>   
> -	if (!(parent_names || parent_hws))
> +	if (!(parent_names || parent_data))
>   		return ERR_PTR(-ENOMEM);
>   
>   	gck = kzalloc(sizeof(*gck), GFP_KERNEL);
> @@ -338,8 +338,8 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>   
>   	init.name = name;
>   	init.ops = &generated_ops;
> -	if (parent_hws)
> -		init.parent_hws = (const struct clk_hw **)parent_hws;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 34036f2d0578..0646775dfb1d 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -171,7 +171,7 @@ struct clk_hw * __init
>   at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
>   			    const struct clk_pcr_layout *layout,
>   			    const char *name, const char **parent_names,
> -			    struct clk_hw **parent_hws, u32 *mux_table,
> +			    struct clk_parent_data *parent_data, u32 *mux_table,
>   			    u8 num_parents, u8 id,
>   			    const struct clk_range *range, int chg_pid);
>   
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index 86d624cd92b2..c4578944611e 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -739,8 +739,8 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   {
>   	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
>   	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *main_xtal_name = "main_xtal";
> -	const char * const td_slck_name = "td_slck";
> +	const char *const main_xtal_name = "main_xtal";
> +	const char *const td_slck_name = "td_slck";

Please use the pattern specified in the previous patches to retrieve the
parent names. Same for the other patches in this series.

>   	const char *const md_slck_name = "md_slck";
>   	struct pmc_data *sam9x7_pmc;
>   	const char *parent_names[9];
> @@ -748,16 +748,13 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	int clk_mux_buffer_size = 0;
>   	struct regmap *regmap;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> -	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> +	struct clk_hw *usbck_hw;
>   	struct clk_parent_data parent_data[9];
> -	struct clk_hw *parent_hws[9];
>   	int i, j;
>   
> -	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, td_slck_name));
> -	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));
>   	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>   
> -	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
> +	if (!main_xtal_hw)
>   		return;
>   
>   	regmap = device_node_to_regmap(np);
> @@ -933,13 +930,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   		sam9x7_pmc->phws[sam9x7_periphck[i].id] = hw;
>   	}
>   
> -	parent_hws[0] = md_slck_hw;
> -	parent_hws[1] = td_slck_hw;
> -	parent_hws[2] = sam9x7_pmc->chws[PMC_MAIN];
> -	parent_hws[3] = sam9x7_pmc->chws[PMC_MCK];
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
> +	parent_data[2] = AT91_CLK_PD_HW(sam9x7_pmc->chws[PMC_MAIN]);
> +	parent_data[3] = AT91_CLK_PD_HW(sam9x7_pmc->chws[PMC_MCK]);
>   	for (i = 0; i < ARRAY_SIZE(sam9x7_gck); i++) {
>   		u8 num_parents = 4 + sam9x7_gck[i].pp_count;
> -		struct clk_hw *tmp_parent_hws[6];
>   		u32 *mux_table;
>   
>   		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
> @@ -954,15 +950,13 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   			u8 pll_id = sam9x7_gck[i].pp[j].pll_id;
>   			u8 pll_compid = sam9x7_gck[i].pp[j].pll_compid;
>   
> -			tmp_parent_hws[j] = sam9x7_plls[pll_id][pll_compid].hw;
> +			parent_data[4 + j] = AT91_CLK_PD_HW(sam9x7_plls[pll_id][pll_compid].hw);
>   		}
> -		PMC_FILL_TABLE(&parent_hws[4], tmp_parent_hws,
> -			       sam9x7_gck[i].pp_count);
>   
>   		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
>   						 &sam9x7_pcr_layout,
>   						 sam9x7_gck[i].n,
> -						 NULL, parent_hws, mux_table,
> +						 NULL, parent_data, mux_table,
>   						 num_parents,
>   						 sam9x7_gck[i].id,
>   						 &sam9x7_gck[i].r,
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index 7463719260e0..4d47d20e65fb 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -1092,22 +1092,20 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>   	const char * const main_xtal_name = "main_xtal";
> +	const char * const td_slck_name = "td_slck";
> +	const char * const md_slck_name = "md_slck";
>   	struct clk_parent_data parent_data[10];
>   	struct pmc_data *sama7d65_pmc;
>   	const char *parent_names[11];
>   	void **alloc_mem = NULL;
>   	int alloc_mem_size = 0;
>   	struct regmap *regmap;
> -	struct clk_hw *td_slck_hw, *md_slck_hw;
> -	struct clk_hw *parent_hws[10];
>   	bool bypass;
>   	int i, j;
>   
> -	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> -	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
>   	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>   
> -	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
> +	if (!main_xtal_hw)
>   		return;
>   
>   	regmap = device_node_to_regmap(np);
> @@ -1216,8 +1214,8 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	sama7d65_pmc->chws[PMC_MCK] = hw;
>   	sama7d65_mckx[PCK_PARENT_HW_MCK0].hw = hw;
>   
> -	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
> -	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
>   	parent_data[2] = AT91_CLK_PD_HW(sama7d65_pmc->chws[PMC_MAIN]);
>   	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7d65_mckx); i++) {
>   		u8 num_parents = 3 + sama7d65_mckx[i].ep_count;
> @@ -1262,8 +1260,8 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> -	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
> -	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
>   	parent_data[2] = AT91_CLK_PD_HW(sama7d65_pmc->chws[PMC_MAIN]);
>   	parent_data[3] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw);
>   	parent_data[4] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_DDR][PLL_COMPID_DIV0].hw);
> @@ -1313,13 +1311,12 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   		sama7d65_pmc->phws[sama7d65_periphck[i].id] = hw;
>   	}
>   
> -	parent_hws[0] = md_slck_hw;
> -	parent_hws[1] = td_slck_hw;
> -	parent_hws[2] = sama7d65_pmc->chws[PMC_MAIN];
> -	parent_hws[3] = sama7d65_pmc->chws[PMC_MCK1];
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
> +	parent_data[2] = AT91_CLK_PD_HW(sama7d65_pmc->chws[PMC_MAIN]);
> +	parent_data[3] = AT91_CLK_PD_HW(sama7d65_pmc->chws[PMC_MCK1]);
>   	for (i = 0; i < ARRAY_SIZE(sama7d65_gck); i++) {
>   		u8 num_parents = 4 + sama7d65_gck[i].pp_count;
> -		struct clk_hw *tmp_parent_hws[8];
>   		u32 *mux_table;
>   
>   		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
> @@ -1336,15 +1333,13 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   			u8 pll_id = sama7d65_gck[i].pp[j].pll_id;
>   			u8 pll_compid = sama7d65_gck[i].pp[j].pll_compid;
>   
> -			tmp_parent_hws[j] = sama7d65_plls[pll_id][pll_compid].hw;
> +			parent_data[4 + j] = AT91_CLK_PD_HW(sama7d65_plls[pll_id][pll_compid].hw);
>   		}
> -		PMC_FILL_TABLE(&parent_hws[4], tmp_parent_hws,
> -			       sama7d65_gck[i].pp_count);
>   
>   		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
>   						 &sama7d65_pcr_layout,
>   						 sama7d65_gck[i].n, NULL,
> -						 parent_hws, mux_table,
> +						 parent_data, mux_table,
>   						 num_parents,
>   						 sama7d65_gck[i].id,
>   						 &sama7d65_gck[i].r,
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index a6824d0accb9..505db97e989b 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -971,10 +971,10 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   {
>   	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
>   	const char * const main_xtal_name = "main_xtal";
> +	const char * const td_slck_name = "td_slck";
> +	const char * const md_slck_name = "md_slck";
>   	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
>   	struct clk_parent_data parent_data[10];
> -	struct clk_hw *td_slck_hw, *md_slck_hw;
> -	struct clk_hw *parent_hws[10];
>   	struct pmc_data *sama7g5_pmc;
>   	void **alloc_mem = NULL;
>   	int alloc_mem_size = 0;
> @@ -983,11 +983,6 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   	bool bypass;
>   	int i, j;
>   
> -	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> -	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> -	if (!td_slck_hw || !md_slck_hw)
> -		return;
> -
>   	main_xtal = of_clk_get(np, main_xtal_index);
>   	if (IS_ERR(main_xtal))
>   		return;
> @@ -1097,8 +1092,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   
>   	sama7g5_mckx[PCK_PARENT_HW_MCK0].hw = sama7g5_pmc->chws[PMC_MCK] = hw;
>   
> -	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
> -	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
>   	parent_data[2] = AT91_CLK_PD_HW(sama7g5_pmc->chws[PMC_MAIN]);
>   	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7g5_mckx); i++) {
>   		u8 num_parents = 3 + sama7g5_mckx[i].ep_count;
> @@ -1141,8 +1136,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   
>   	sama7g5_pmc->chws[PMC_UTMI] = hw;
>   
> -	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
> -	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
>   	parent_data[2] = AT91_CLK_PD_HW(sama7g5_pmc->chws[PMC_MAIN]);
>   	parent_data[3] = AT91_CLK_PD_HW(sama7g5_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw);
>   	parent_data[4] = AT91_CLK_PD_HW(sama7g5_plls[PLL_ID_DDR][PLL_COMPID_DIV0].hw);
> @@ -1191,12 +1186,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   		sama7g5_pmc->phws[sama7g5_periphck[i].id] = hw;
>   	}
>   
> -	parent_hws[0] = md_slck_hw;
> -	parent_hws[1] = td_slck_hw;
> -	parent_hws[2] = sama7g5_pmc->chws[PMC_MAIN];
> +	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> +	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
> +	parent_data[2] = AT91_CLK_PD_HW(sama7g5_pmc->chws[PMC_MAIN]);
>   	for (i = 0; i < ARRAY_SIZE(sama7g5_gck); i++) {
>   		u8 num_parents = 3 + sama7g5_gck[i].pp_count;
> -		struct clk_hw *tmp_parent_hws[8];
>   		u32 *mux_table;
>   
>   		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
> @@ -1211,15 +1205,13 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   			u8 pll_id = sama7g5_gck[i].pp[j].pll_id;
>   			u8 pll_compid = sama7g5_gck[i].pp[j].pll_compid;
>   
> -			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
> +			parent_data[3 + j] = AT91_CLK_PD_HW(sama7g5_plls[pll_id][pll_compid].hw);
>   		}
> -		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> -			       sama7g5_gck[i].pp_count);
>   
>   		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
>   						 &sama7g5_pcr_layout,
>   						 sama7g5_gck[i].n, NULL,
> -						 parent_hws, mux_table,
> +						 parent_data, mux_table,
>   						 num_parents,
>   						 sama7g5_gck[i].id,
>   						 &sama7g5_gck[i].r,


