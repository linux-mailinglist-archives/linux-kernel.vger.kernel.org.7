Return-Path: <linux-kernel+bounces-804420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E88CB4764A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD637C7447
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870827A462;
	Sat,  6 Sep 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M0nNHLPB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3F14A8E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184520; cv=none; b=R0Tw4NEPSH/6X9H7x1k1mD5tf5PG004BVAo7mcAFnl7+tcHczuba9/rXiCgTz9gJOrXowC8jBkDZyJnuaV3BBnXnM2V6Fcx6x/4ZFYn6D1LuyagBgUYG+OnE4X/22zmbAijbuq/AA8ZK78LzDeaRpTwk0GI+Yat9LFRMhc/8lNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184520; c=relaxed/simple;
	bh=Wlm2TUGUQHR65VwbYHEx8NwbIjb7dZT7CtLfA+JhaO8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=afyDqi9nmf8/VpwjOV4cTgvxYaUY0Nqy0ZAp3iYF8vrqyBPYiYiP52zwUxXQA9mk9jeL/iJ2/hE2mwQYRggRWiH2h+oOQZmejYKAbmacS3VAOSAgbSl5FxL8H3R1l+MC2hYhV7j5tTvaH8qb+zDN7NbfGDGmeSdnRGWSZlH/HsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M0nNHLPB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso3797895e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757184515; x=1757789315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ItxyGgS7E2CVkqaAgZtR5mA+Tn6EFqfbGhszvfBwvE=;
        b=M0nNHLPBDKy5rslNhWdY7ImrW6DzoKx99WWInzC0mMfwd8roehhOFm4RSelYTPlZuS
         3WU81BTkk9+k5dx3zJ1t9DmmpU9j6cu7Wp3PbEl1ZhKChEfSL2tSE118Nqa61HAywPny
         9aJE6g4QFqAcqP0GpaJJMCj+nOR/QSeqgJz1wA5HlKTuwDYbomy8vf7q7o2nDzmiC4t5
         +ZRum897S1pYgxpoTP8KTf/JvVaYJFx0KfHm9zEmxBkpf9yRybLXQELR+0HTvgU8RdQs
         IZDTRFone5TeVNt1kpYenVEQT3behAsnaYunRapsD3Pe0+MWn93+ydqPrZ6KlXR8neLl
         rTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184515; x=1757789315;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ItxyGgS7E2CVkqaAgZtR5mA+Tn6EFqfbGhszvfBwvE=;
        b=YzebFFM0Pe7532PbFDHxe269X+dRWGWWqHv020R8hUPhjt1Tsy3/r4k/4Fe2PS6DnX
         wEg1ExD5IpggiD75gZRgl2PmCUUf2mgUG7wQki4TvXKJRAAnOhQOMWX7b9CmGp/NZdGD
         5Bt2f+TlejZZl3mlZuQhiQBUh2EkeksDwkb2WIQ3aU7jc+i1bKTpYfNXkaArkYqEg9Di
         K0FdHgd16GQwwArKvaRBTgs72qBhw1evoECqrLj1Hr2Y0VOdM7JQ5kWaWTc4+dOhtyxQ
         kz2GIhNz+jhR9MV7hLIjTzBjQcDHbxe6Mu5ORtEE9nCdkrDC3i5aDTZ/K8op3oOPpBxh
         oUfw==
X-Forwarded-Encrypted: i=1; AJvYcCW+9Re4GPnr0DYf40XsHj8JKbFzB1nmGGa26CEwBapLcK18xYfJtDZ3DUckgmHvugYwig3y6R0N9YJNtBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4foBWFwfJFjX5JWtlx9h9MrD1rncJvQUDtd8mOzc9/sRwwn78
	v9mF8wCqT56zZ0O9MQEEqcbRPqgKWWRtWmiMCB737UEsmq3JJZYo+vJiFLsv7agLCHw=
X-Gm-Gg: ASbGncurJhPvdK2n4i+0455gaFDuXjmxsEFFIkKYzYNPyFQ9IuXXVFGPfcsx1yjc+Kg
	i2vZ1AxHJfoV0i7P+3HtI+l1tBqlFOnLEUMYDVbJlNPj/36vA0pyzY3eoZjefh2hqSSzWq7/Pyu
	oQQkkq2bqbNRtPU+kinm1xzJUCEyF/6lTYDtXPQFdhDkXjNGQElkCynrotq7mJF5lGQVF0YipDT
	OpJXK7YUhHcr7VZ6WhyA3CvB1kN38hrrHg4vsIRICyW19XHy6vnpkNA7DMdQzH4ortwbN4oj15x
	wVIN4X2x4RNOx3mvg/gvfcjEpMRpmPCvhWud6jh3NQhRiVYJQFs11iq2JmbmQghh9VbE87bBRHu
	aP5r4/0XW/R03+9ZGsgkb1kJYBCDoSII9yUZe5icDiw==
X-Google-Smtp-Source: AGHT+IHTpgtyModfxsIQAemnthqZ9Byeaws22gLsiNTaGF/G3vxl6nHs3mKSEO1Ko1X3b2mJaMKTSQ==
X-Received: by 2002:a05:600c:4ed1:b0:459:db71:74d7 with SMTP id 5b1f17b1804b1-45ddded6d45mr22663215e9.27.1757184515506;
        Sat, 06 Sep 2025 11:48:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm95138195e9.1.2025.09.06.11.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:48:35 -0700 (PDT)
Message-ID: <7ea4f72d-ac4a-4f8c-80db-ac439f04f21d@tuxon.dev>
Date: Sat, 6 Sep 2025 21:48:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 23/32] clk: at91: sama5d2: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <e245b72936832627469e74a694af1d1cb65a40ab.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <e245b72936832627469e74a694af1d1cb65a40ab.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch SAMA5D2 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Adjust commit message.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/sama5d2.c | 168 +++++++++++++++++++------------------
>   1 file changed, 86 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index f5d6c7a96cf2..538ffb8deedb 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -37,9 +37,9 @@ static const struct clk_pcr_layout sama5d2_pcr_layout = {
>   	.pid_mask = GENMASK(6, 0),
>   };
>   
> -static const struct {
> +static struct {
>   	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>   	unsigned long flags;
>   	u8 id;
>   } sama5d2_systemck[] = {
> @@ -47,14 +47,14 @@ static const struct {
>   	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>   	 * to keep it enabled in case there is no Linux consumer for it.
>   	 */
> -	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
> -	{ .n = "uhpck", .p = "usbck",        .id = 6 },
> -	{ .n = "udpck", .p = "usbck",        .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",        .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",        .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",        .id = 10 },
> -	{ .n = "iscck", .p = "masterck_div", .id = 18 },
> +	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "lcdck", .id = 3 },
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
> +	{ .n = "iscck", .id = 18 },
>   };
>   
>   static const struct {
> @@ -164,25 +164,15 @@ static const struct clk_programmable_layout sama5d2_programmable_layout = {
>   
>   static void __init sama5d2_pmc_setup(struct device_node *np)
>   {
> +	struct clk_hw *hw, *audio_fracck_hw, *usbck_hw, *main_rc_hw, *main_osc_hw;
> +	const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
> +	u8 slow_clk_index = 0, main_xtal_index = 1;
>   	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *slck_name, *mainxtal_name;
> -	struct pmc_data *sama5d2_pmc;
> -	const char *parent_names[6];
> +	struct clk_parent_data parent_data[6];
>   	struct regmap *regmap, *regmap_sfr;
> -	struct clk_hw *hw;
> -	int i;
> +	struct pmc_data *sama5d2_pmc;
>   	bool bypass;

Please keep these starting here:

> -
> -	i = of_property_match_string(np, "clock-names", "slow_clk");
> -	if (i < 0)
> -		return;
> -
> -	slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "main_xtal");
> -	if (i < 0)
> -		return;
> -	mainxtal_name = of_clk_get_parent_name(np, i);

ending here, and use the retrieved names with AT91_CLK_PD_NAME()


