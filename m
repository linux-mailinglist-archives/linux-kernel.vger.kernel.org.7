Return-Path: <linux-kernel+bounces-861648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD78BF340F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F24FCB66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88B330319;
	Mon, 20 Oct 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Zd5uConY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A711EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989368; cv=none; b=nVqUFEqyXFl/RKguTpz5uQnPnpYgG68tzxg65vxnMVE40kL0suBX8i62tx51r3rtUVSFr7B6rQYi8Qjrti3bUiQd/eSRETFS+rf8jInBtv4VkIHMHeEiO1TGrKBzeQyYVZgOxxVMI/Ubr7hvkNm/wYtG8mnhN1gKmB6LllGnQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989368; c=relaxed/simple;
	bh=Bcib7GgDvbxG8dNMZol8O5N62eoUHF7edKC5bkNsAo0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DQOokO4rucq9+tDvIuCBhiAdxCRVWeC1UxDgi+D3q3z6af850qM1XGzCMbuXBBTfbOk/M/3sy8G2wzVPPb/8U5ez8iFcKj5XUrUzXCUMCMDThG2CR+6vJy7y0V7eE3huabBYUZYR1zkOmugI97KaLTsVuE4iodX27VgeK68w6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Zd5uConY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3d80891c6cso1115431966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989365; x=1761594165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Uq5LFMJuGM/xM9Jid2EcKy6jYFa1OSnWMslrM9L2Xw=;
        b=Zd5uConYHo7E15j/bDQDH9oVidNkRsA9nm1D9JrzQkL73VvOtIjMxF13BLpSU9Ct0n
         qofP5imqbk59fxdrCw8bLP1UPapsc8a29RhbNcmoL/LuRReoOZ9bK2vw2UHFtXV390LY
         MiuXNGkEsgV7556VldpE2LBMEnhA8M2IuRyPwwofJ7UjSPwS3bUFy1Vl0bmOkzSs8imj
         kAKphKlnPkygHXr5PlTFBXCy3pGAW7VVhyNMgKht9AUK2YWULVjqaOI/VGxwITwgpuZk
         NI04Jb9jPmrQJVBs+8KthXTOxUViUV8pENXbjovh8SqhgX3qz5Iah2o4kRpisdXdiAmo
         3z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989365; x=1761594165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uq5LFMJuGM/xM9Jid2EcKy6jYFa1OSnWMslrM9L2Xw=;
        b=VL43Ad7/t0fXYuQrTgYgk94YEGPA+Df1BuyE+/qBbq8qtrNRXvfDOprDTaPc4GRktD
         arxz3kfMH4H1BcI6VvGEasQ0eI5GKxvw444s6m8GR//oJ1d0EMq0BmPkusQIg7xYA3+c
         oX6heHgcKVTzs4aLlU/x+6JnQXU0yNuTEDeRa/iACBfOGdMHer7pepQ1XqB5JYNTWRWF
         zhuO0mKy4bpnm2Nz/BJv8pfyA5ndJm30Zx4bbu82objLUYPJIcjd0FUyZuy7uh/hxoGP
         j8MfPjYvAEnnOtfo2umY0D/iTAZnBv/Yx9VEQ6BfmYVgJszsJI4z+feOcL41Pbyo/RPc
         UiEw==
X-Forwarded-Encrypted: i=1; AJvYcCX8k2cVJswRlBgkxF3ansRhQpxHEGLKa3ROAyUGDr8TRiP2D8YjD4BqLgnbdlSQpB7V0Cy3QPxHRThOMtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxBx5Mh1LGErX50nsJaJ+IcefFqO8mKD0EYCbvmwaW+VpyNgM
	lH2Wc2hiYBeA4+Sei9gepFQewhvUObEwg5kztCa747m5s4u0riKmeOmjBLq5fc/7Y1A=
X-Gm-Gg: ASbGncs76xbc2G6s6F5rk+b4wlG89F3I45h2DTKpK755rBH7NxFQnqxscCkla0c6jW/
	TOb47LFXL2OrrtIeKmMzUSex0XrJfX9xktSl3r56B5op9Cy8uDECqjohBvh4dT4iqWs0fRtx+3c
	FvY9bFze9sO2Nwsny2GzpBTP5Og7zYUCWlbALx4cEXt+nyzaMhhy8CBqIDQ5dOE3Kc8gukV0dUC
	Y/XCq8dN4kU+fGFrFYwH9mlZxP1NxKlsDwiETJy6yBXgJNpH7t2ylaXiQKw4lr2GH27Q8bO71fL
	idQQCsNUwyvSA6fODk48+vPZorUx3xC40CbppZS9L1FnNW4cfSZ7e/xh7mOS2Ilhj4zma/Fvlpr
	cgGiM3US+9O+eat7vRxlOGInomoNeczSXKPsPgXK8Gv9GsgJkPE6Gh8fH5BGXomGvbOLQTijV5Z
	3ODJ4kRrLqlCn/N1vk5KI=
X-Google-Smtp-Source: AGHT+IGHu2znjunMS42qnTeHNhloC2OADaigESnIDF75k5aPWsi00OCyrhzBuu/+FUhbaAk7uDtcAQ==
X-Received: by 2002:a17:907:890b:b0:b07:e348:8278 with SMTP id a640c23a62f3a-b6054cdd6d3mr1791255066b.25.1760989364997;
        Mon, 20 Oct 2025 12:42:44 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f003sm7581371a12.27.2025.10.20.12.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:42:44 -0700 (PDT)
Message-ID: <e5f4a505-86ff-4d89-86d6-5433cf7c5665@tuxon.dev>
Date: Mon, 20 Oct 2025 22:42:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 06/31] clk: at91: clk-main: switch to clk parent data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <0f8054488ac3cd658d7a6fc0d5cd4f684ce8355a.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <0f8054488ac3cd658d7a6fc0d5cd4f684ce8355a.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of parent_hw for the main clock
> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler

Probably missing "This" in front of "to less" or something similar?

> conversion of existing SoC specific clock drivers from parent_names to
> modern clk_parent_data structures. This will lead in the end at removing
> __clk_get_hw() in SoC specific drivers
> (that will be solved by subsequent commits).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to use parent_data.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---


[...]

> @@ -1020,9 +1020,9 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>  	if (IS_ERR(main_osc_hw))
>  		goto err_free;
>  
> -	parent_hws[0] = main_rc_hw;
> -	parent_hws[1] = main_osc_hw;
> -	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
> +	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
> +	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);

You missed to convert parent data to an array and adjust use it accordingly
in this file.

> +	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> @@ -1057,7 +1057,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>  
>  				hw = sam9x60_clk_register_frac_pll(regmap,
>  					&pmc_pll_lock, sama7g5_plls[i][j].n,
> -					&parent_data, parent_rate, i,
> +					parent_data, parent_rate, i,
>  					sama7g5_plls[i][j].c,
>  					sama7g5_plls[i][j].l,
>  					sama7g5_plls[i][j].f);


