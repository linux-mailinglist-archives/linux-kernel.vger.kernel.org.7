Return-Path: <linux-kernel+bounces-804414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596BB4762E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B059EA42E71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6327E7DD;
	Sat,  6 Sep 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qf2XBN/Q"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870D27BF95
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183878; cv=none; b=GaJYb7ff165CfrWmsAMoKyg4vAfZrS55jwPKZ/Yiu82uAyrdUtJHjYx3dOiJ2GT4WxuF6McoV6C49xNTb5nR15ZmNdzWmu/7lkBRKpRzEB4eL33WE1XYKUX67AgztlOfhl4urMsGc2iMtWFplDWoBusyuWL0avioTIAUPmA0dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183878; c=relaxed/simple;
	bh=+3oazX626tyvFNfK08BPhUYln0whbR4S249zC/8GDwg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V74JUwNnFxMPAWkTx6FeKDFzMX6DsI1ktMu5/Z0yTgsPgmFFGi9P37HRyBMACH8E+lYYHLZOjj3SHjD9Mfh+ooZQAs8gtK8aVlY84GKQv8xwcfekUmsWeo/YWmYLwRuYGGwDkTTCS2QlZnphI1t8BQMjA5oqM1MQDg38Sz3Y8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qf2XBN/Q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso1776676f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183875; x=1757788675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTKT4Qoeb431f2YzYmEWycPNxA4C0cxkkaziB2hUHho=;
        b=Qf2XBN/QmPMVbnq+r54bTWLsW3BhPn7rctLbDxt8eFyhaZrvWtr8uCoW2zjMYOyEtG
         cmUXdLVWjMWzQoiEG+k2ctHENyAydPTdxv/Fmu+lG+2sN4tT9XzLKcNJ4LwrgkKc8P9r
         rTkl0ts2iKwTf4P1GY0D+E7ucCy9NyyXGezfud+XpvEodf/IapXRIc+ergSiqN39FYPC
         xfo7fZovMBxwRnKc76hOJeFO2S2n+003gL/uw2kZEcdAVeZuPFURxnUn8LFwKMTEb1Qk
         gRoJxyarO3/wI7VSDufj2VCxylgwtg9dob1ctWrfmhTqLnt1JTqf2q+sqi2k1TtTTEqw
         2HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183875; x=1757788675;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTKT4Qoeb431f2YzYmEWycPNxA4C0cxkkaziB2hUHho=;
        b=BZ7cvaPLo2kL1nRF9I8zCcgueVkLD9+uFo8oHtRuNWPNkpTxuSRxSasWrUMIhvmIq6
         KXYuk03HMdND0nrVf7kIi5a4bhZAwpbIq7nyi/79RXLpx9FqDjkxCH6grkkPJJg7nMZX
         3Sti5zjIw9tySESkLsVQDEy7ogjWVzGWfJaE4mcRfHmOWDwbwr2k1hRq/mLcBLHLxoX0
         VAFw8m6LHj6Mp71jt3jxWgo5aBMxyLJ23sZ2+jjQ4kdKIM/BDjprrWFwhquZKBGQosMb
         7AAaN9bgv3lfOQZKjgD8vOym27yOwcRqTN1+vSrkNSJaKdMiCEJTiPz/FBjxl0KoBtXh
         ennw==
X-Forwarded-Encrypted: i=1; AJvYcCWXADwpQxR4ZgNyuwOvpAKFwcI2qNpmMJjfTKZe5SGxljftzFVBc0RrSbvnHFV6s7ERDbB2bImHWeKv96M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEfOOS3arlq3yEGrE3sjIDtGip6zHt6EMK4OQSuX9QdQ60bde
	JqIdZICsBd4eYb8rnpsNRVj58TTG4co8RPkxqVu+PnTW3J+0+WaYXTY3I27OqwfX/n8=
X-Gm-Gg: ASbGncvivrm5WJwAxMyh8Mh23YeGP+qilVMA517UDn/ZZZFBmDWfBXKpgfE0OUk2d4d
	DVhkdFTGjm1dVxBWFHwJzKhxYUBiGp+W/qtjzCyWLPpRVG6tS1K6UttIzZ9IS1nQsXTzwFgMGWj
	8uuNTuaWbjLUPOAAJTNagm4V7YCMy7ngggjKgdqO0ygWZuAqP3Hqu54S6PkNbTlgCobe88sU/K6
	y84UO8Uc8NUtrZTkRDQMVH0oh8BmSjDH1dsUX4OuhX6yoDXZ9k92Htugn3Ce6eEOUOV6dyGQ+ev
	EE+jx26GibTcJiUx6XDPka8ewpuFt+XUN4QPHdMnyO8oJtYNyxmmMXrPheNobI/9ik98PPvFoEe
	qo6/a0rL9dQFi/7D7i2/sJmneseMc2Lw=
X-Google-Smtp-Source: AGHT+IEKJkmT+/CLM/NvML+uy2ULQdso9fIovRncwmnTLe/Ez2KthZT+wTUuSKuKcJwSIv+GJP2jqA==
X-Received: by 2002:a05:6000:1aca:b0:3e1:1f54:56c4 with SMTP id ffacd0b85a97d-3e643369ba9mr1961524f8f.24.1757183874644;
        Sat, 06 Sep 2025 11:37:54 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm6309868f8f.57.2025.09.06.11.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:37:54 -0700 (PDT)
Message-ID: <67b25c71-443c-4964-b08a-538448caaf92@tuxon.dev>
Date: Sat, 6 Sep 2025 21:37:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 11/32] clk: at91: clk-usb: add support for
 clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <47b460245338e9a59b75dd72ea378a47b058a0be.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <47b460245338e9a59b75dd72ea378a47b058a0be.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for clk_parent_data in usb clock driver.
> 
> All the SoC based drivers that rely on clk-usb were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to the changes.
> Change how the main_xtal and slcks are initialized so they match the
> parent_data API]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/at91rm9200.c  |  2 +-
>   drivers/clk/at91/at91sam9260.c |  2 +-
>   drivers/clk/at91/at91sam9g45.c |  2 +-
>   drivers/clk/at91/at91sam9n12.c |  2 +-
>   drivers/clk/at91/at91sam9x5.c  |  2 +-
>   drivers/clk/at91/clk-usb.c     | 41 ++++++++++++++++++++++------------
>   drivers/clk/at91/dt-compat.c   |  6 ++---
>   drivers/clk/at91/pmc.h         | 11 +++++----
>   drivers/clk/at91/sam9x60.c     |  2 +-
>   drivers/clk/at91/sam9x7.c      | 27 +++++++++++-----------
>   drivers/clk/at91/sama5d2.c     |  2 +-
>   drivers/clk/at91/sama5d3.c     |  2 +-
>   drivers/clk/at91/sama5d4.c     |  2 +-
>   drivers/clk/at91/sama7d65.c    | 33 ++++++++++++++-------------
>   14 files changed, 76 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index 3f19e737ae4d..e5a034f208d8 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -157,7 +157,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>   
>   	at91rm9200_pmc->chws[PMC_MCK] = hw;
>   
> -	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
> +	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index 0799a13060ea..ae6f126f204a 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -434,7 +434,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>   
>   	at91sam9260_pmc->chws[PMC_MCK] = hw;
>   
> -	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
> +	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index f45a7b80f7d8..684d2bcb36e8 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -176,7 +176,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>   
>   	parent_names[0] = "plladivck";
>   	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
> +	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index 751786184ae2..9fc20b177b13 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -201,7 +201,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>   
>   	at91sam9n12_pmc->chws[PMC_MCK] = hw;
>   
> -	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck");
> +	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck", NULL);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 3b801d12fac0..5728cfb9036f 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -222,7 +222,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>   
>   	parent_names[0] = "plladivck";
>   	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
> +	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index b0696a928aa9..b2503fad4543 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -221,12 +221,12 @@ static const struct clk_ops at91sam9n12_usb_ops = {
>   
>   static struct clk_hw * __init
>   _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
> -			     const char **parent_names, u8 num_parents,
> -			     u32 usbs_mask)
> +			     const char **parent_names, struct clk_parent_data *parent_data,
> +			     u8 num_parents, u32 usbs_mask)
>   {
>   	struct at91sam9x5_clk_usb *usb;
>   	struct clk_hw *hw;
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>   	int ret;
>   
>   	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
> @@ -235,7 +235,10 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
>   
>   	init.name = name;
>   	init.ops = &at91sam9x5_usb_ops;
> -	init.parent_names = parent_names;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
> +	else
> +		init.parent_names = parent_names;
>   	init.num_parents = num_parents;
>   	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>   		     CLK_SET_RATE_PARENT;
> @@ -257,27 +260,30 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
>   
>   struct clk_hw * __init
>   at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
> -			    const char **parent_names, u8 num_parents)
> +			    const char **parent_names, struct clk_parent_data *parent_data,
> +			    u8 num_parents)
>   {
>   	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
> -					    num_parents, SAM9X5_USBS_MASK);
> +					    parent_data, num_parents, SAM9X5_USBS_MASK);
>   }
>   
>   struct clk_hw * __init
>   sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
> -			 const char **parent_names, u8 num_parents)
> +			 const char **parent_names, struct clk_parent_data *parent_data,
> +			 u8 num_parents)
>   {
>   	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
> -					    num_parents, SAM9X60_USBS_MASK);
> +					    parent_data, num_parents,
> +					    SAM9X60_USBS_MASK);
>   }
>   
>   struct clk_hw * __init
>   at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
> -			     const char *parent_name)
> +			     const char *parent_name, struct clk_parent_data *parent_data)
>   {
>   	struct at91sam9x5_clk_usb *usb;
>   	struct clk_hw *hw;
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>   	int ret;
>   
>   	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
> @@ -286,7 +292,10 @@ at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
>   
>   	init.name = name;
>   	init.ops = &at91sam9n12_usb_ops;
> -	init.parent_names = &parent_name;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
> +	else
> +		init.parent_names = &parent_name;
>   	init.num_parents = 1;
>   	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
>   
> @@ -390,11 +399,12 @@ static const struct clk_ops at91rm9200_usb_ops = {
>   
>   struct clk_hw * __init
>   at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
> -			    const char *parent_name, const u32 *divisors)
> +			    const char *parent_name, struct clk_parent_data *parent_data,
> +			    const u32 *divisors)
>   {
>   	struct at91rm9200_clk_usb *usb;
>   	struct clk_hw *hw;
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>   	int ret;
>   
>   	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
> @@ -403,7 +413,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
>   
>   	init.name = name;
>   	init.ops = &at91rm9200_usb_ops;
> -	init.parent_names = &parent_name;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
> +	else
> +		init.parent_names = &parent_name;
>   	init.num_parents = 1;
>   	init.flags = CLK_SET_RATE_PARENT;
>   
> diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
> index f5a5f9ba7634..7883198f6a98 100644
> --- a/drivers/clk/at91/dt-compat.c
> +++ b/drivers/clk/at91/dt-compat.c
> @@ -946,7 +946,7 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
>   	if (IS_ERR(regmap))
>   		return;
>   
> -	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
> +	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names, NULL,
>   					 num_parents);
>   	if (IS_ERR(hw))
>   		return;
> @@ -976,7 +976,7 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
>   	if (IS_ERR(regmap))
>   		return;
>   
> -	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
> +	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name, NULL);
>   	if (IS_ERR(hw))
>   		return;
>   
> @@ -1009,7 +1009,7 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
>   	of_node_put(parent_np);
>   	if (IS_ERR(regmap))
>   		return;
> -	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
> +	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, NULL, divisors);
>   	if (IS_ERR(hw))
>   		return;
>   
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 0646775dfb1d..c66ee44255d7 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -285,16 +285,19 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
>   
>   struct clk_hw * __init
>   at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
> -			    const char **parent_names, u8 num_parents);
> +			    const char **parent_names, struct clk_parent_data *parent_data,
> +			    u8 num_parents);
>   struct clk_hw * __init
>   at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
> -			     const char *parent_name);
> +			     const char *parent_name, struct clk_parent_data *parent_data);
>   struct clk_hw * __init
>   sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
> -			 const char **parent_names, u8 num_parents);
> +			 const char **parent_names, struct clk_parent_data *parent_data,
> +			 u8 num_parents);
>   struct clk_hw * __init
>   at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
> -			    const char *parent_name, const u32 *divisors);
> +			    const char *parent_name, struct clk_parent_data *parent_data,
> +			    const u32 *divisors);
>   
>   struct clk_hw * __init
>   at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index fd53e54abf88..eb38da77d69a 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -306,7 +306,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>   	parent_names[0] = "pllack_divck";
>   	parent_names[1] = "upllck_divck";
>   	parent_names[2] = "main_osc";
> -	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
> +	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, NULL, 3);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index c4578944611e..fdff799f0a22 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -738,23 +738,21 @@ static const struct {
>   static void __init sam9x7_pmc_setup(struct device_node *np)
>   {
>   	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *usbck_hw;
>   	struct clk_range range = CLK_RANGE(0, 0);
>   	const char *const main_xtal_name = "main_xtal";
>   	const char *const td_slck_name = "td_slck";
>   	const char *const md_slck_name = "md_slck";
>   	struct pmc_data *sam9x7_pmc;
> -	const char *parent_names[9];
>   	void **clk_mux_buffer = NULL;
>   	int clk_mux_buffer_size = 0;
> +	struct clk *main_xtal;
>   	struct regmap *regmap;
> -	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> -	struct clk_hw *usbck_hw;
>   	struct clk_parent_data parent_data[9];
>   	int i, j;
>   
> -	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
> -
> -	if (!main_xtal_hw)
> +	main_xtal = of_clk_get(np, main_xtal_index);

This could be moved close to clk_get_rate()

> +	if (IS_ERR(main_xtal))
>   		return;
>   
>   	regmap = device_node_to_regmap(np);
> @@ -804,19 +802,18 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   				switch (sam9x7_plls[i][j].p) {
>   				case SAM9X7_PLL_PARENT_MAINCK:
>   					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
> -					hw = sam9x7_pmc->chws[PMC_MAIN];
> +					parent_rate = clk_hw_get_rate(sam9x7_pmc->chws[PMC_MAIN]);
>   					break;
>   				case SAM9X7_PLL_PARENT_MAIN_XTAL:
>   					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
>   									  main_xtal_index);
> -					hw = main_xtal_hw;
> +					parent_rate = clk_get_rate(main_xtal);
>   					break;
>   				default:
>   					/* Should not happen. */
>   					break;
>   				}
>   
> -				parent_rate = clk_hw_get_rate(hw);
>   				if (!parent_rate)
>   					return;
>   
> @@ -871,10 +868,10 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   
>   	sam9x7_pmc->chws[PMC_MCK] = hw;
>   
> -	parent_names[0] = "plla_divpmcck";
> -	parent_names[1] = "upll_divpmcck";
> -	parent_names[2] = "main_osc";
> -	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
> +	parent_data[0] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw);
> +	parent_data[1] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw);
> +	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
> +	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);
>   	if (IS_ERR(usbck_hw))
>   		goto err_free;
>   
> @@ -971,7 +968,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sam9x7_pmc);
>   	kfree(clk_mux_buffer);
>   
> -	return;
> +	goto put_main_xtal;
>   
>   err_free:
>   	if (clk_mux_buffer) {
> @@ -980,6 +977,8 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   		kfree(clk_mux_buffer);
>   	}
>   	kfree(sam9x7_pmc);
> +put_main_xtal:
> +	clk_put(main_xtal);
>   }
>   
>   /* Some clks are used for a clocksource */
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index c16594fce90c..8bbc34e22cda 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -284,7 +284,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>   
>   	parent_names[0] = "plladivck";
>   	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
> +	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 522ce6031446..05d0cdd22bc4 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -201,7 +201,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>   
>   	parent_names[0] = "plladivck";
>   	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
> +	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 160c0bddb6a3..da84b4cef827 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -222,7 +222,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>   
>   	parent_names[0] = "plladivck";
>   	parent_names[1] = "utmick";
> -	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
> +	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
>   	if (IS_ERR(hw))
>   		goto err_free;
>   
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index 4d47d20e65fb..f10faabc7ffe 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -1090,34 +1090,33 @@ static const struct clk_pcr_layout sama7d65_pcr_layout = {
>   static void __init sama7d65_pmc_setup(struct device_node *np)
>   {
>   	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
> -	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *usbck_hw;
>   	const char * const main_xtal_name = "main_xtal";
>   	const char * const td_slck_name = "td_slck";
>   	const char * const md_slck_name = "md_slck";
>   	struct clk_parent_data parent_data[10];
>   	struct pmc_data *sama7d65_pmc;
> -	const char *parent_names[11];
>   	void **alloc_mem = NULL;
>   	int alloc_mem_size = 0;
> +	struct clk *main_xtal;
>   	struct regmap *regmap;
>   	bool bypass;
>   	int i, j;
>   
> -	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
> -
> -	if (!main_xtal_hw)
> +	main_xtal = of_clk_get(np, main_xtal_index);

Could be moved close to clk_get_rate()

> +	if (IS_ERR(main_xtal))
>   		return;
>   
>   	regmap = device_node_to_regmap(np);
>   	if (IS_ERR(regmap))
> -		return;
> +		goto put_main_xtal;
>   
>   	sama7d65_pmc = pmc_data_allocate(PMC_INDEX_MAX,
>   					 nck(sama7d65_systemck),
>   					 nck(sama7d65_periphck),
>   					 nck(sama7d65_gck), 8);
>   	if (!sama7d65_pmc)
> -		return;
> +		goto put_main_xtal;
>   
>   	alloc_mem = kmalloc(sizeof(void *) *
>   			    (ARRAY_SIZE(sama7d65_mckx) + ARRAY_SIZE(sama7d65_gck)),
> @@ -1158,18 +1157,18 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   				switch (sama7d65_plls[i][j].p) {
>   				case SAMA7D65_PLL_PARENT_MAINCK:
>   					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
> -					hw = sama7d65_pmc->chws[PMC_MAIN];
> +					parent_rate = clk_hw_get_rate(sama7d65_pmc->chws[PMC_MAIN]);
>   					break;
>   				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
>   					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
>   									  main_xtal_index);
> -					hw = main_xtal_hw;
> +					parent_rate = clk_get_rate(main_xtal);
>   					break;
>   				default:
>   					/* Should not happen. */
>   					break;
>   				}
> -				parent_rate = clk_hw_get_rate(hw);
> +
>   				if (!parent_rate)
>   					return;
>   
> @@ -1253,11 +1252,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   			sama7d65_pmc->chws[sama7d65_mckx[i].eid] = hw;
>   	}
>   
> -	parent_names[0] = "syspll_divpmcck";
> -	parent_names[1] = "usbpll_divpmcck";
> -	parent_names[2] = "main_osc";
> -	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
> -	if (IS_ERR(hw))
> +	parent_data[0] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw);
> +	parent_data[1] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_USB][PLL_COMPID_DIV0].hw);
> +	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
> +	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);
> +	if (IS_ERR(usbck_hw))
>   		goto err_free;
>   
>   	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> @@ -1353,7 +1352,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama7d65_pmc);
>   	kfree(alloc_mem);
>   
> -	return;
> +	goto put_main_xtal;
>   
>   err_free:
>   	if (alloc_mem) {
> @@ -1363,6 +1362,8 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   	}
>   
>   	kfree(sama7d65_pmc);
> +put_main_xtal:
> +	clk_put(main_xtal);
>   }
>   
>   /* Some clks are used for a clocksource */


