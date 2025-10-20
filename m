Return-Path: <linux-kernel+bounces-861650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115BBF341E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6E494FCC17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32412BEC23;
	Mon, 20 Oct 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y34Uxxv/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C32DE71B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989402; cv=none; b=Z6gEbnkIxLMqz/47cOiKeI+2gjUjGC3O2VGdOxPxa9h0IzK2OwhHo+blBmX7GjdmNUnt+IpWd2K936+PGTxLy+aqZ9DBceCMJ3JPconxyj0KZ+aJeVcZaUaNTZnpPmuxd5aKtEae4AFrj+ktiQJBaOjZrqjO/I+5yWxLB5CMX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989402; c=relaxed/simple;
	bh=VJM4/DdbT7H1VG7QERkhEiMoX1aBxdIXTavIKIb63bM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GFT5ioYIelwwJ66pnC0IjCxImGJkScjFrDjVRzJbTfAyqiKg7WsHPkdrXqabRcRPPqz1dyp2DA5HEn58GkjcOu7mPHaDUcNjWF1J16Ve24TP0hvjN2KwxsmCSUGLkyNUxkF/rXADK5i3FniCxgj69N3WMkY+QAXBel559RryRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y34Uxxv/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d5088259eso735805066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989399; x=1761594199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WnrihOd4AsebH9UmcXUF+DGII/SVijUJ5cnGJII058=;
        b=Y34Uxxv/TjADgw+9r1qDnQvywtn7r2R5Na24VWic2zSO2/u4vI6k7P5Sxx1diq13mP
         YYUs2bybXstBzIZkRiY7fJlEMH5GoWktqEk3W7sUGcaoER8/b3Bt++XS1QTU/+Ij7uOh
         LgNePv9BMzjgSGawjx0Lk+vV46mRxd6TDoe/9nxNmk2RHyGmqkTFimkH5vgh8wCoX5Vp
         CrIeVH8icxgEet4DlzLoto36bdTGX/O551ivbnzmff/djH6zhSVA4pTFE7jn/RkJGEww
         fSbGTn3Ec7/IkuAD4vDqZK/7Z2faFI+v0KG1QKJxtJIXbifniTH9OE/5JiAS24nM0uDT
         lkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989399; x=1761594199;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WnrihOd4AsebH9UmcXUF+DGII/SVijUJ5cnGJII058=;
        b=ufzKC9+sw1TCGMp5zpQTprbt6W0AwSMjTWTs3EWEu4SUd1wwmqH9VgxfcRr885r1h6
         opKC31Qvs/SAlzI6gJ4+iWpkHsZ1+2kTiIoaQuz5xVnKv0Fi2s69d9VVJLrH6nbyAZzQ
         8/3yZ5GoLugFhbDOjq76LDom8KDIOVQyH/U7CTO5uwRosijBPWB+PzCW+ZPnL0MTg2Z4
         6bfILKd84sjSkU+gipRXnH5PNqW+Krq61YgBvoam/T4cSLDCYUhKrfQViccP6KSLCMW9
         AfoL7Upvx9Y/6WY2ov86OjPWa3inWTEEL471YmZby/7GQ9iXdXXiH0WuZLlxIBA0lcxH
         2LTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtOyZ+KSBMd4z2e4isDD+Y6Q7+6Y7sc+YgfPFBzMf36bdJK15JeuU83JjfL1UNh1C6OBBr/5tKt93wFko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWAbRfWWEPIXo4D9pFms8kMce0GzS/q1KwnNNo5yh+IDWG4d7
	Wi6l2URLjpnkystDLY6qJDHdGp3lpazurzDDE5qg52AYS+lM71YiO/J8iqKZokm3yVc=
X-Gm-Gg: ASbGncvj6NNFq8aXpQ8D3G/0xodCXF/1Yb/bmL+nQPY+kt/sV2RmtIaPSW4LboZnGJC
	nvI4+NxX71X8uYjePPLmipL2SaihcNIK5VOJBGx5zOl/cFM7MpdzMaevFrFNRtYyD/sjf38NAVU
	oRfD8f9mUbnkiK6E4f30Vkjp3TJXBYzEOLIq5I8O80QDPcG9TSGDeVhB4y+0ru+tLU1MmnrRvpo
	jLI1V0eECYy2YKXtH6mmt9J17rFP5sviCPqPp4YWyPNtbWxgLglnq5UjYKdSoZ6Jg1aP1BsEigI
	nvWjHbj+gOGS5CQdGE1HOjafKy4wE7RaAEE5kE7+Xr3WdTHHalN8ndrcysZ0Tx465x2ihLUQlp8
	TX1Q/64WEV1qt7eQ0r7k5oiOeIw5AJsFVxRje81J3fncZlqyeT/ftTiboFGnJtHdKWJ7zmHViXD
	Q4+gq3Nb68KMY85uhylS4=
X-Google-Smtp-Source: AGHT+IEA4WJiFVCo5i3lXWM9cTARgkcQvZpClBs7kLwlr1bv/oiPFR5QlLTNGP2c3IF9GX6YbAtlWg==
X-Received: by 2002:a17:907:3f89:b0:b0c:1701:bf77 with SMTP id a640c23a62f3a-b64732424e1mr1670530466b.18.1760989399157;
        Mon, 20 Oct 2025 12:43:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb03649dsm868542666b.50.2025.10.20.12.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:43:18 -0700 (PDT)
Message-ID: <26ea14dd-d331-41ee-b5b0-865918aa7690@tuxon.dev>
Date: Mon, 20 Oct 2025 22:43:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 07/31] clk: at91: clk-utmi: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <87a3e3615345c975acc669207cd8bd9f849b0fb0.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <87a3e3615345c975acc669207cd8bd9f849b0fb0.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of struct parent_hw as this leads
> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
> conversion of existing SoC specific clock drivers from parent_names to
> modern clk_parent_data structures.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/clk-utmi.c | 16 ++++++++--------
>  drivers/clk/at91/pmc.h      |  4 ++--
>  drivers/clk/at91/sama7g5.c  | 21 +++++++++++++--------
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
> index b991180beea1..38ffe4d712a5 100644
> --- a/drivers/clk/at91/clk-utmi.c
> +++ b/drivers/clk/at91/clk-utmi.c
> @@ -144,7 +144,7 @@ static struct clk_hw * __init
>  at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
>  				struct regmap *regmap_sfr,
>  				const char *name, const char *parent_name,
> -				struct clk_hw *parent_hw,
> +				struct clk_parent_data *parent_data,
>  				const struct clk_ops *ops, unsigned long flags)
>  {
>  	struct clk_utmi *utmi;
> @@ -152,7 +152,7 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
>  	struct clk_init_data init = {};
>  	int ret;
>  
> -	if (!(parent_name || parent_hw))
> +	if (!(parent_name || parent_data))
>  		return ERR_PTR(-EINVAL);
>  
>  	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
> @@ -161,8 +161,8 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
>  
>  	init.name = name;
>  	init.ops = ops;
> -	if (parent_hw)
> -		init.parent_hws = (const struct clk_hw **)&parent_hw;
> +	if (parent_data)
> +		init.parent_data = (const struct clk_parent_data *)parent_data;
>  	else
>  		init.parent_names = &parent_name;
>  	init.num_parents = 1;
> @@ -185,10 +185,10 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
>  struct clk_hw * __init
>  at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
>  		       const char *name, const char *parent_name,
> -		       struct clk_hw *parent_hw)
> +		       struct clk_parent_data *parent_data)
>  {
>  	return at91_clk_register_utmi_internal(regmap_pmc, regmap_sfr, name,
> -			parent_name, parent_hw, &utmi_ops, CLK_SET_RATE_GATE);
> +			parent_name, parent_data, &utmi_ops, CLK_SET_RATE_GATE);
>  }
>  
>  static int clk_utmi_sama7g5_prepare(struct clk_hw *hw)
> @@ -287,8 +287,8 @@ static const struct clk_ops sama7g5_utmi_ops = {
>  
>  struct clk_hw * __init
>  at91_clk_sama7g5_register_utmi(struct regmap *regmap_pmc, const char *name,
> -			       const char *parent_name, struct clk_hw *parent_hw)
> +			       const char *parent_name, struct clk_parent_data *parent_data)
>  {
>  	return at91_clk_register_utmi_internal(regmap_pmc, NULL, name,
> -			parent_name, parent_hw, &sama7g5_utmi_ops, 0);
> +			parent_name, parent_data, &sama7g5_utmi_ops, 0);
>  }
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 13d125793216..ee77c14e8b25 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -302,10 +302,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
>  struct clk_hw * __init
>  at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
>  		       const char *name, const char *parent_name,
> -		       struct clk_hw *parent_hw);
> +		       struct clk_parent_data *parent_data);
>  
>  struct clk_hw * __init
>  at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
> -			       const char *parent_name, struct clk_hw *parent_hw);
> +			       const char *parent_name, struct clk_parent_data *parent_data);
>  
>  #endif /* __PMC_H_ */
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index b1b0e9e67228..dde662a6133f 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -976,10 +976,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>  	void **alloc_mem = NULL;
>  	int alloc_mem_size = 0;
>  	struct regmap *regmap;
> -	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
>  	struct clk_hw *td_slck_hw, *md_slck_hw;
> -	static struct clk_parent_data parent_data;
> +	struct clk_parent_data parent_data[2];

This should be part of patch 6/31.

>  	struct clk_hw *parent_hws[10];
> +	struct clk *main_xtal;

This could be moved in the for block where of_clk_get_by_name(np,
main_xtal_name); is called.

