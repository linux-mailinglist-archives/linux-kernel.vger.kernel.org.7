Return-Path: <linux-kernel+bounces-804406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC85B4761D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F6CA42166
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386125E834;
	Sat,  6 Sep 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="D6bnonCn"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDE27AC41
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183688; cv=none; b=KsNIXAo347dQGr72yKvxiLiOdoZ1clWToj8ZfzwwAwfGqFa1CYcIZ3QguR/Spp4LPI39f9xO+Q6zb1wOQ3T/6B/AFSEqfsdAtVBTqMPc6meq8q3fk300wsGzGvdrxXssAkajJCQKcbew986jOUz+i19F7Vi+riz/ZkhdbtrD2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183688; c=relaxed/simple;
	bh=Kkrp4Wv1v/M1RmFI3yiMxghk8W27Ki+YUXdi7Wn8+6s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hn1pJZAcqour2xedE5SYk5skxTDaFgc9IIcZo5s+hr+jZ50VxsQ9oq5mk3ILhCLIt/adMoSqNQiWvhSrW+In4fidFIBINPprLzFTgMMtvBoOVBvapPu/ZCLGosWLdkmQqqthB7RFkp5xIP6pliaKLnQtQKXznXite1dGuNpF7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=D6bnonCn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df3be0e098so1658162f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183684; x=1757788484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qnerf/c2JmfLDaWdwE5/5ZjM5iHDZF/Oj+pWXPinn3Y=;
        b=D6bnonCns3tQkXf9YWAEBfLZlzrFSTJNavY5C/w5Pjr9eVuTcv8fOQ6+kLn5a+4ZYg
         O6REoQHaDE0LjIk9aUz3OKWqhnV78mQuw/oiAmarmEEXlTYs+qztIqAMRXnqBbt90iOV
         BPu5uuKqVIZNNfMt68Oht4bB0y5v3m56g85sZ8u/ihiC8F2+Dav766StrogA88SIsLBY
         wanow9tXrdEStFOYdnzZ35HPVOL5CyiYJk/PtQc+lCurSYFYAUuH82RpewweRWeUq/Fn
         uChyp0d8vW5bYHOXonpGl4gHrL+q4o4oNHmqbWJYN7wsSMeZ4SwRcBfr/nZvphtJyZ/m
         NBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183684; x=1757788484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnerf/c2JmfLDaWdwE5/5ZjM5iHDZF/Oj+pWXPinn3Y=;
        b=hwQHBbJQoJEKR0r2HAbwGX78AOoox+BSHUCy6cxz4pvmCJMzisjcS9JPvrd6KQd3jk
         z8EKpsV+VbdpW8VS6wpKSwPngfwPvP6KwV8n+W0iYmmMTmHXFCEATpsxMQVB+yEYoHaQ
         t6CttlVQlVIgmFCNENmBswNgNqlb7XYF8hM5zo8z3XpGD2hfeJYgD+//RWBpMoV0QdCh
         Cajx76nUdbVDmclVwqpeXx1TMvlIA5qUYIJYx2O3wJgMPYWYwKDMaiucrbFpDVASzJ0B
         UaFlKh2SpuVqqUKOp+E4AIuyMBKWrohswQnV8bQX7a/8emeFiOUFiSGUII+teyoBnZNV
         HYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXo2RXE7qqtv5Y46D9+8J9TwnLxbOIyBAv4olworGa0QMNllAhtPL/MN5ezrNVFGEEWwsFYpF5ZA+B48AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIKITL0szd4VpdwoiVLpEZmZVh6vvIvRefjoPBvQoM0iasz7Q
	iRlfj7biQf5xvOyyju7hWRlFv3ehsXBpUfFEZB5kFvW9lICk568PQNJn4ETKjTdgDyk=
X-Gm-Gg: ASbGncsLG6TFsEyWKETYrJcR8mB8cUF3003tMAenFZv5GaptFSr+8stm3Ax1PTTdcbG
	T/o+DDzygE0ekGzEgIbBeW2sXFxRYGHLH/+wGCApkp8Iabf69SVuWgw6qdRuDgnUAHIaiCEYRFw
	GMQfUrSI32KZNjLlZJFyGnqCsVddHIAyjGnafmO4tvUfkU87VS6TyPBQcsFWlHMK6pZKAVmF7Ux
	Wb5yAEVacGsNMHroxtBmcTAPWEeL0lXFg/y/Xl7nYOmmnJPJhzkzB3yrpIptwaC6siVqv941kek
	C7JkPjUXetwMX/aNUBSWFUdY25ZvVf9cKwtEsETu+kKEG9Bu+Yd3zA7Eo29tFEfzvcru4Fx9K5D
	ICh6UnaysHxweqS45aBVLX6L8v6DDaP4=
X-Google-Smtp-Source: AGHT+IGm0fa7QgRHF7b6Hmgbln8RYhjeirstMPYGWUhdpZoD+rT+0Ec/cadTeuSZa533WVVHZ2EoIA==
X-Received: by 2002:a5d:5f88:0:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3e6440eef4emr1810219f8f.39.1757183684539;
        Sat, 06 Sep 2025 11:34:44 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3df4fd372c1sm13719925f8f.29.2025.09.06.11.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:34:44 -0700 (PDT)
Message-ID: <ad360a5f-6fff-4438-ace1-07632ea48156@tuxon.dev>
Date: Sat, 6 Sep 2025 21:34:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 05/32] clk: at91: clk-peripheral: switch to
 clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <657143d460ed5f2f726413385895c0c80ddddef9.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <657143d460ed5f2f726413385895c0c80ddddef9.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:06, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of parent_hw for peripheral clocks.

I would prefer a description as provided for other conversions:

Use struct clk_parent_data instead of struct parent_hw as this leads
to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
conversion of existing SoC specific clock drivers from parent_names to
modern clk_parent_data structures.


> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add SAMA7D65 and SAM9X7 SoCs to the use the
> structs.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/clk-peripheral.c | 16 ++++++++--------
>   drivers/clk/at91/pmc.h            |  4 ++--
>   drivers/clk/at91/sam9x7.c         |  2 +-
>   drivers/clk/at91/sama7d65.c       |  2 +-
>   drivers/clk/at91/sama7g5.c        |  2 +-
>   5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index c173a44c800a..ed97b3c0a66b 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -97,7 +97,7 @@ static const struct clk_ops peripheral_ops = {
>   
>   struct clk_hw * __init
>   at91_clk_register_peripheral(struct regmap *regmap, const char *name,
> -			     const char *parent_name, struct clk_hw *parent_hw,
> +			     const char *parent_name, struct clk_parent_data *parent_data,
>   			     u32 id)
>   {
>   	struct clk_peripheral *periph;
> @@ -105,7 +105,7 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
>   	struct clk_hw *hw;
>   	int ret;
>   
> -	if (!name || !(parent_name || parent_hw) || id > PERIPHERAL_ID_MAX)
> +	if (!name || !(parent_name || parent_data) || id > PERIPHERAL_ID_MAX)
>   		return ERR_PTR(-EINVAL);
>   
>   	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
> @@ -114,8 +114,8 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
>   
>   	init.name = name;
>   	init.ops = &peripheral_ops;
> -	if (parent_hw)
> -		init.parent_hws = (const struct clk_hw **)&parent_hw;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = &parent_name;
>   	init.num_parents = 1;
> @@ -448,7 +448,7 @@ struct clk_hw * __init
>   at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
>   				    const struct clk_pcr_layout *layout,
>   				    const char *name, const char *parent_name,
> -				    struct clk_hw *parent_hw,
> +				    struct clk_parent_data *parent_data,
>   				    u32 id, const struct clk_range *range,
>   				    int chg_pid, unsigned long flags)
>   {
> @@ -457,7 +457,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
>   	struct clk_hw *hw;
>   	int ret;
>   
> -	if (!name || !(parent_name || parent_hw))
> +	if (!name || !(parent_name || parent_data))
>   		return ERR_PTR(-EINVAL);
>   
>   	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
> @@ -465,8 +465,8 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
>   		return ERR_PTR(-ENOMEM);
>   
>   	init.name = name;
> -	if (parent_hw)
> -		init.parent_hws = (const struct clk_hw **)&parent_hw;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>   	else
>   		init.parent_names = &parent_name;
>   	init.num_parents = 1;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index b43f6652417f..b6f2aca1e1fd 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -226,13 +226,13 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>   
>   struct clk_hw * __init
>   at91_clk_register_peripheral(struct regmap *regmap, const char *name,
> -			     const char *parent_name, struct clk_hw *parent_hw,
> +			     const char *parent_name, struct clk_parent_data *parent_data,
>   			     u32 id);
>   struct clk_hw * __init
>   at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
>   				    const struct clk_pcr_layout *layout,
>   				    const char *name, const char *parent_name,
> -				    struct clk_hw *parent_hw,
> +				    struct clk_parent_data *parent_data,
>   				    u32 id, const struct clk_range *range,
>   				    int chg_pid, unsigned long flags);
>   
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index edd5fd3a1fa5..d7dc5f381ebe 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -922,7 +922,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
>   							 &sam9x7_pcr_layout,
>   							 sam9x7_periphck[i].n,
> -							 NULL, sam9x7_pmc->chws[PMC_MCK],
> +							 NULL, &AT91_CLK_PD_HW(sam9x7_pmc->chws[PMC_MCK]),
>   							 sam9x7_periphck[i].id,
>   							 &range, INT_MIN,
>   							 sam9x7_periphck[i].f);
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index 17725c175d3b..372e530f4107 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -1306,7 +1306,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   							 &sama7d65_pcr_layout,
>   							 sama7d65_periphck[i].n,
>   							 NULL,
> -							 sama7d65_mckx[sama7d65_periphck[i].p].hw,
> +							 &AT91_CLK_PD_HW(sama7d65_mckx[sama7d65_periphck[i].p].hw),
>   							 sama7d65_periphck[i].id,
>   							 &sama7d65_periphck[i].r,
>   							 sama7d65_periphck[i].chgp ? 0 :
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index 733e4fc6a515..f28fe419ae5e 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -1181,7 +1181,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   						&sama7g5_pcr_layout,
>   						sama7g5_periphck[i].n,
>   						NULL,
> -						sama7g5_mckx[sama7g5_periphck[i].p].hw,
> +						&AT91_CLK_PD_HW(sama7g5_mckx[sama7g5_periphck[i].p].hw),
>   						sama7g5_periphck[i].id,
>   						&sama7g5_periphck[i].r,
>   						sama7g5_periphck[i].chgp ? 0 :


