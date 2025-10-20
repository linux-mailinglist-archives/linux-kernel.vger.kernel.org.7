Return-Path: <linux-kernel+bounces-861590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA043BF3240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5B4FA1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4182D8DA4;
	Mon, 20 Oct 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QnxFvG+i"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C972D7802
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987648; cv=none; b=A4xwM+Nzmyd0nVRxCCKdSohIkJvuc1XsfqLd/ZCX5e1s9fNmkvEV3dEG+3TIjv3s84QK0fPWZ/9OkqrxyYisanL/tqGSvfaG5DVwzc+GpoZRGOp7vC0yztb4DJcMC7YXhBMi2c41IqDUgOAwLuOR1zzFKPnloKNyT/EN52ehTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987648; c=relaxed/simple;
	bh=m+tVu+83RvXRHDE4L736NwxubnHnEhTnYwFshq2Ypjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTzV+UckOI4AJNb+Jh2MpHKHaneLqVEPatlT+30uf10TzO4WaIb5PKoZnRxlO1LUv0J9Tnpi9BpermHvFw7uEu2owzVvlE7cXT3je9q7nkyf6uq6a9pzOpZMWTQHAR9ikAgPOf3eyQObgiqG/tcSE4sdfFdpx2COsmJIc+w9nTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QnxFvG+i; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1058196266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987644; x=1761592444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=394T93MvlNTwJ4OmrNSHdthp7AqCvywv9bIug30d09M=;
        b=QnxFvG+ijsY10To98gWmFOor6sCFbSubLuaqYQ/uI2DUD44ck4d6ZWiaSpiFP7gdxC
         EtnPzvUQe5xTFls4R8grqgtcrQn/HdBc2XqJf4x1BAPnGAndx2UguBpOdf1iSeyjaRPw
         wQl8SNLHeYUqmSOrF/O68J19HFQDu4Uw+75p7o1uvKwmdkrvKR+DH6RyB5i1qG/r6uNA
         PxXs2AZrrHfZVgMUsAoij1i4BmMVLNL7Og3VEvNWNN4OC9RRxkeqsEyAxh78yF30o/WC
         OIHPq8HaVDz/XiO8WPMnzGCdRpYgq7diswWt6hnCFfB/sLav4XtO/q0iW07B8HNLqY05
         QEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987644; x=1761592444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=394T93MvlNTwJ4OmrNSHdthp7AqCvywv9bIug30d09M=;
        b=AGfCefZ0IcjstuxQWk2C2lGrcXOJIiiBmUTNb1OwTZ/umWqzmh8UxcOnbwBy6s0AFY
         DtUWXhYecxTzmLzbeu9QFDQ++OtWYFVYSdFoXncNnFfLtVn9bl5o5cVKWp0on1rp97Ih
         Vy9Vx94nZq7ozA8RmftzQQo0KHZtbp6QPWpXZOeQtj2iIswUhqIub3gQqcLcODYUPcTr
         nh1/ARuwKkcPXw7OWz96A7Mb7Xjavu4Fh4jNqPEYPiBTS0DDQLW+Zx6UkZ2m2wq1Fwku
         Nwnem9C/LLtBjGoaiFAcIr1vBYPNZ0FotuGZJI+0aJH3NbAuvpuaBFZ868vA9+LSoQZT
         hITA==
X-Forwarded-Encrypted: i=1; AJvYcCX3tsPNBpefhwl05Wp2neFKpjJ2BjumD06UZjFyJgfuh5oKIt7ndIdhwJVDgLFjUFUNUdoXcljC7XrzmCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC167Ik8uIwA8FuTauTCbaSrKmMf1Qa53OGSsilFCAY4HtHJpB
	i1usa2tNEzC2gKJvhfiZedfaVWVub3SXwcXzLCkGYNR/MegLJYgoedx2hD53J5B6/Zc=
X-Gm-Gg: ASbGnctROHehxbltMnANlxx8lJCxXG5kEnV8No5YyoHc//tfxamUVK60hsh8wZqbUnP
	YmS1hje2lhPhc9d54sEkyZaHaPscCAlYNNcvQs0AACxdHXucYKb+XQreyzaghaxNYYQjVIerh+5
	ioRgpqTLOOTf22YkYTR0CK6+QauikxzsZruHK3h7M7O+M81bjWP2C++NIU8gKXQM6Uly4sHcG9U
	bCDubzl4Qt6OZ7MROYLwgFt9WGgXPlnCvFdJ5ds5wkckbxDKoOsrtLolEbouAgd1GzSQayZIg0o
	68XFFjtE7jA2mc/pagRmeP3lROP6DAFjsOuH56dThLRQjIIqf45b2YDGm5GQ579Q4Ok7xddRobE
	fBb1S9iccGpWzun1MrqoaKC5D703YxDpt3vkYJl1fSjySdzpj0BW3WDFmHzByXgTkCI8wniQZlJ
	cz/Lb32gQ3
X-Google-Smtp-Source: AGHT+IGwCJgZYKC8FZLAT4kOm6dkEpwAC47hppBn//mgpxVSX8jW4DahXg//7RoX6AQwA7IGTbpD8Q==
X-Received: by 2002:a17:907:7ba8:b0:b41:297c:f7bb with SMTP id a640c23a62f3a-b647245844fmr1618450466b.26.1760987644536;
        Mon, 20 Oct 2025 12:14:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb525d1asm866441566b.58.2025.10.20.12.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:14:04 -0700 (PDT)
Message-ID: <88a560cc-4176-4674-b2c3-009af68f5bf0@tuxon.dev>
Date: Mon, 20 Oct 2025 22:14:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/31] clk: at91: sama7d65: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <cd47c45215f4c6a38447151222094616850a9d0d.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cd47c45215f4c6a38447151222094616850a9d0d.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

In title: s/switch/switch system clocks"

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Switch the system clocks to use parent_hw and parent_data. Having this
> allows the driver to conform to the new clk-system API.
> 
> The parent registration is after the USBCK registration due to one of
> the system clocks being dependent on USBCK.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/sama7d65.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index 986e8ef57dea..38c44b5d5d42 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -537,23 +537,23 @@ static struct {
>  /*
>   * System clock description
>   * @n:	clock name
> - * @p:	clock parent name
> + * @p:	clock parent hw
>   * @id: clock id
>   */
> -static const struct {
> +static struct {
>  	const char *n;
> -	const char *p;
> +	struct clk_hw *parent_hw;
>  	u8 id;
>  } sama7d65_systemck[] = {
> -	{ .n = "uhpck",		.p = "usbck", .id = 6 },
> -	{ .n = "pck0",		.p = "prog0", .id = 8, },
> -	{ .n = "pck1",		.p = "prog1", .id = 9, },
> -	{ .n = "pck2",		.p = "prog2", .id = 10, },
> -	{ .n = "pck3",		.p = "prog3", .id = 11, },
> -	{ .n = "pck4",		.p = "prog4", .id = 12, },
> -	{ .n = "pck5",		.p = "prog5", .id = 13, },
> -	{ .n = "pck6",		.p = "prog6", .id = 14, },
> -	{ .n = "pck7",		.p = "prog7", .id = 15, },
> +	{ .n = "uhpck",		.id = 6 },
> +	{ .n = "pck0",		.id = 8, },
> +	{ .n = "pck1",		.id = 9, },
> +	{ .n = "pck2",		.id = 10, },
> +	{ .n = "pck3",		.id = 11, },
> +	{ .n = "pck4",		.id = 12, },
> +	{ .n = "pck5",		.id = 13, },
> +	{ .n = "pck6",		.id = 14, },
> +	{ .n = "pck7",		.id = 15, },
>  };
>  
>  /* Mux table for programmable clocks. */
> @@ -1299,9 +1299,19 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>  		sama7d65_pmc->pchws[i] = hw;
>  	}
>  
> +	/* Set systemck parent hws. */
> +	sama7d65_systemck[0].parent_hw = usbck_hw;
> +	sama7d65_systemck[1].parent_hw = sama7d65_pmc->pchws[0];
> +	sama7d65_systemck[2].parent_hw = sama7d65_pmc->pchws[1];
> +	sama7d65_systemck[3].parent_hw = sama7d65_pmc->pchws[2];
> +	sama7d65_systemck[4].parent_hw = sama7d65_pmc->pchws[3];
> +	sama7d65_systemck[5].parent_hw = sama7d65_pmc->pchws[4];
> +	sama7d65_systemck[6].parent_hw = sama7d65_pmc->pchws[5];
> +	sama7d65_systemck[7].parent_hw = sama7d65_pmc->pchws[6];
> +	sama7d65_systemck[8].parent_hw = sama7d65_pmc->pchws[7];
>  	for (i = 0; i < ARRAY_SIZE(sama7d65_systemck); i++) {
>  		hw = at91_clk_register_system(regmap, sama7d65_systemck[i].n,
> -					      sama7d65_systemck[i].p, NULL,
> +					      NULL, &AT91_CLK_PD_HW(sama7d65_systemck[i].parent_hw),
>  					      sama7d65_systemck[i].id, 0);

Just saying: we could have been used parent_hw only for system clocks (and
some other clocks updated in this series) if we wouldn't have the dt-compat.c.

>  		if (IS_ERR(hw))
>  			goto err_free;


