Return-Path: <linux-kernel+bounces-790446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E27CDB3A749
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC54E45A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399B334396;
	Thu, 28 Aug 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2wVJupM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BC3314B6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400696; cv=none; b=FsBVa38adptUC24vhk0Ly++AyfiLDO82d5BtE1zz0jcBkox24Np6j/5Kuu5sbE1BcscDqsuPnN8nYiRSenPfsFFkhXBQbZKyRgM3acLK7AoFfmzO19hmEz9eVpBhKiDhTnKYEx9abs8klu6IswdIqkICkdi7lzRw/zjlFTY5+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400696; c=relaxed/simple;
	bh=KjdMnmax17wj/hHZCqG4IeQlHBv3R7AnyEbZo7q4ZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWkOnL+pFzP7qYT27obu5j7b2O7HwvCjqkRIlldC4m/RslYvdlBhWybn3haL66YoiPpRiI/pycE3Zdl/1iTPf00ZmIZlNyxtQNPWNzX9dwfwY4RsuPK5FoV3vnTFzUd8qO/rf+3FnaxSNqo3UoZbrXGTxnpAqNjvh+igT0M7Xp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2wVJupM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756400693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQWSx8bT6V+HM/W9ets+QXcD0v/UrJQL7ZZAexBVPTE=;
	b=J2wVJupM78UKum1FLjUmZlAKDlMOB9CHBLtIY/g+XWwwB1EgQG7k1dh2ORzQ5aaRpPu6uy
	l6BjX0CvftBbY7s3/KGBJG+PIRRih/LpbmnqYm8MrJQRUz2alpcp9PfPchfzazXGPz/73s
	ZHa/y9TSOJBRJPmiCVG6QnqqKCDJj0M=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-GwFuKZE4OEGb90V2x2Hmpg-1; Thu, 28 Aug 2025 13:04:52 -0400
X-MC-Unique: GwFuKZE4OEGb90V2x2Hmpg-1
X-Mimecast-MFC-AGG-ID: GwFuKZE4OEGb90V2x2Hmpg_1756400691
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5228ed1eff1so172838137.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400691; x=1757005491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQWSx8bT6V+HM/W9ets+QXcD0v/UrJQL7ZZAexBVPTE=;
        b=iDWzVx3LCjiFt4I5x0dlfBkGlZZb1evyMznROHF6WlRwozEES+Gsk4win03Wdq0poW
         1zS27ez28TTMkGkKfJLmGGMDmIW6Bn/XzqjM+Sl4S+NbY6zi0YuQhAubh8KkbIpvLJbQ
         NtGQcbp1IskM9OwRlJ1xnENrdSegdSEPAE3JladGBMbpfW2sZXF6BnaRRVboJOImKu0p
         8fQn8IHnpDQ93tfGey6OYD9Ryn6ue1gKwocnCov+GXjljBSprhiS7LjkLHUKHL5G/R+E
         dIJMHQfiGd/0JiTvfsxAOLXfORJZ92NKDXBB+L51DgjY+ds8GVaCfl/o1XF/mSS1sx+1
         xvFg==
X-Forwarded-Encrypted: i=1; AJvYcCXsSlsJdY7orWX1tSIkVzBlSAwFgCOGfdr+EhraKJU+m+rI3T7CVjPjk1fMMZmaLgl5k3wp3jIQi6x6sBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgryOrochCD2sBTpKFUIm3eoFJ8ad0gG/5ZUpgBq70/0QMtGUM
	I6FthbPF0GPlF8iTy8c/F/rkH4tG00LXX/Zaf4FNpPicZQEbGtcghM6ehlB5x+5nILbuAqK/tyE
	3aouW4G++/0dxfnO9czcDBoxgcWMn3TFgHVvabGqeYkaC6rzUQjkhxbuxi5fBDVzk5w==
X-Gm-Gg: ASbGncs9sAhUA4KpX6f73PYCLZXLkaOT2NYAItu5ULIKZMD9Dn6DyLvCvPpwWK4kDlj
	Dq29jzMSascL5xoOTAN7NYM6g94WI7hgqMzr2zQH09DNWvmp+sO/u0F4JMo+45PtpPBTlv0glMw
	ZDQ7Ml5ktWnRUkkVoZXpUZtiQ9KL4c2i12yDQ1PjmU3zSYmu5xykJhGT//12b5O3HN0phUE0TOv
	TxOehl/EkBEWJoWN4PjxLLIXgr7Cu4ff5zpeIrQDYkL/BX8Bdjr0SeAjEBGIUtraxFOxQRHqkk2
	TpW/SRi08Bl04o9UDGVx+pr1XPeHV/wS0vF1t/4DBv+evvfoN6Qxc9gTkChmi633GhElTjJkf2v
	cUjWkixrqfFR7ehs9ziA=
X-Received: by 2002:a05:6102:945:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-521b9f2aa92mr5454480137.13.1756400689776;
        Thu, 28 Aug 2025 10:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK33mKzOVRkyg/syyoWlGXnfN23Xh+fbGd+pr1oPcAGqsYr4OfVhyh6dTOdU8MTFy+2f9q6Q==
X-Received: by 2002:a05:6102:945:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-521b9f2aa92mr5454448137.13.1756400689195;
        Thu, 28 Aug 2025 10:04:49 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc15c83bbasm12882885a.60.2025.08.28.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:04:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:04:46 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan.Wanner@microchip.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 04/32] clk: at91: clk-sam9x60-pll: use clk_parent_data
Message-ID: <aLCMLs6FLp5TZAA8@x1>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <2e7902b73fa6bb5bc8698b3ca0fa7cef583b76f5.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7902b73fa6bb5bc8698b3ca0fa7cef583b76f5.1752176711.git.Ryan.Wanner@microchip.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jul 10, 2025 at 01:06:57PM -0700, Ryan.Wanner@microchip.com wrote:
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
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add SAMA7D65 and SAM9X75 SoCs to the change set.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 14 +++++---------
>  drivers/clk/at91/pmc.h             |  5 +++--
>  drivers/clk/at91/sam9x60.c         |  8 +++++---
>  drivers/clk/at91/sam9x7.c          | 17 ++++++++++++-----
>  drivers/clk/at91/sama7d65.c        | 16 +++++++++++-----
>  drivers/clk/at91/sama7g5.c         | 17 ++++++++++++-----
>  6 files changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index cefd9948e103..03a7d00dcc6d 100644
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
> index 63d4c425bed5..b43f6652417f 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -255,8 +255,9 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
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
> index db6db9e2073e..fd53e54abf88 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -240,7 +240,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	sam9x60_pmc->chws[PMC_MAIN] = hw;
>  
>  	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
> -					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
> +					   &AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MAIN]),
> +					   clk_hw_get_rate(sam9x60_pmc->chws[PMC_MAIN]),
>  					   0, &plla_characteristics,
>  					   &pll_frac_layout,
>  					   /*
> @@ -266,8 +267,9 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
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
> index 31184e11165a..edd5fd3a1fa5 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -739,6 +739,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  {
>  	struct clk_range range = CLK_RANGE(0, 0);
>  	const char *main_xtal_name = "main_xtal";
> +	u8 main_xtal_index = 2;

Is there a #define somewhere that can be used instead of 2? Or a comment
at least? This applies to the other file as well.

Brian


