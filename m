Return-Path: <linux-kernel+bounces-861654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE458BF343C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C993A5EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E632F74D;
	Mon, 20 Oct 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FdNHWhoF"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D9219E0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989530; cv=none; b=lELMipbthvxMo6xu8HbwOnlBczE+NAcq8dD+oS7ZnbnBGrah6BRcMp9vBQmdUrBzjGkypNAi6eqxF9syFdJCRppNmeQycdT/K6tImrIfhghSXZQpJTuhO05QhlQ/yFRSkugv/fGcUeO24j8ajeKvIqLn8tE7RDHtLw+837pR0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989530; c=relaxed/simple;
	bh=p2sWbK/i6wPHhukAdzgNJbGHi8CFyvayEux3Moga6Ko=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iITe4UhcWBnAsqezx6iebnLkrqEOS3k1oF2MWuE1JMeeNLSRAUOHRoB1sMdTLL0Nk7BbgdfLWmNwP/3af1djr1UzOqRR+xCBs77PKFaAdM428H9jDfPtyHNlCzPP3baFsJ9I4GrH7x6zvstrbh7BrOnVQxIvgti63LBIJSA/9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FdNHWhoF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3c2db014easo1045987566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989527; x=1761594327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qz5TY9x2mwFP+v6DHBmNs5rDoED1VITmKzDSzUIYHws=;
        b=FdNHWhoFU/7zcce7misiCY9YQE9FDJ56k7r5OAXc9qNZSmAMu4iwNKF7OTEThW8NVj
         jC8pbkiYy3eZMs6ADoZnKME5Q76io19a/JpeqGvC7xRNp+6pJvjIrHM68+mgDbY4sqiv
         dXj6pnXsnI47Ve3VcXWW3a//6LiPOpU05crPmkujSxJyv+ry45s3TEdwdTzNjJFVnPHZ
         87JMxe0Ts53XC6KpiGHHJcStiulkh4AjZJ0SzTYrshzKQV8ZhHozFSkN++/64u2hlS1r
         v38QGvKbP1ZNcrCLBA2vX+209F0pJdflgUiDOn2Te1VjrtGUU9RBkoY0yDLRyTfiWSyK
         omjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989527; x=1761594327;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz5TY9x2mwFP+v6DHBmNs5rDoED1VITmKzDSzUIYHws=;
        b=k29AvDeKiX3pilU38Yvom/6+Nu7UH/AcUFvKZifKPFfvB3QxGgtkXPQ7m+qXSLBDc8
         LrUwNACdgh5YCqoyCXPhUCF2feNyFGWHK4BVhC9pZS7t2afT77AHouOl3u8+hXbgE1sp
         +ERFGkYL89CxjHGcYJNNmkkSlGd9fZ93UhuB2hhezktMbgWXqAzXKuxtkg6wX4KTt5hj
         X3zviEtoeWm3CY+qhZIIpUh+AuawFNC0cZK/xakGBLhVLmQvCp2CGJp4kXveFxPoYiV8
         JbdE4ChP1C6BDh98AeKXaBaa4sbek5QnrTzSxkzntESP9Z4o8Sc8SxjQ1BcK+uzNwa9h
         VLpw==
X-Forwarded-Encrypted: i=1; AJvYcCWAwrZotFB8EAp2N2PEMI6pqF7VVteIAisNgwCzT5FFUqRrKDu/TpYx7Yo10fwMIXsT7jgoCdcD5/WtwEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqBX0zkf95nDy2TSw785kWkPpgAaaf4VPfvHKK78arpeuLLr+
	LjhT9F/AENF316Vc7ai3s2f7nB9I5vIXxY1RsoDnDbz8EmksgZMYHBxxze7k2FL5NSI=
X-Gm-Gg: ASbGncuuv2MzqJQtGI/Vsy40pPiF01AIUmJGaR/8DRYj6qc62GGJnt1bZIFMYtUfyVT
	VjO8NumqOf87uCP6y4by/niONsl76B054hE95KLvpTbDsPGSYOeDviP1cPCz99O5YmU06Us78cd
	z0DiW2CykrKsJvm77V9wfcHpBlzZA9WE/z0s0/a1V70vj/aOHe+01F/gBFAtGFC8dDep3Rl/drq
	hD48XLemGyzbN+cjfEMqaNga5CbOnsFXN5gUXo1z4JpoaUBbUM7P97JctNmx9JSwe4s+uNrt2nx
	TnTR79KMlYUixCeQLJCr1+xYZOdxciD3PVbEM1rPqZpBExhCykTO6cG8PYTFBbjonI5SPp5OiOr
	Bx0cbaWX2kZ2MSzecT+Qh64/9Xk6AZ92LjMGhfIg8kceFfnWs5wU3pqr60VPaoF1zFZico+kwCS
	u3x1WYCCPxdWpxcPxsnbY=
X-Google-Smtp-Source: AGHT+IGCob6piujm3PcDzGeduTMgTD25Owlac554+NOU9vrtDAhPuhqkFthuXzRSWnHKOtAXcaqOWQ==
X-Received: by 2002:a17:907:9482:b0:b2e:9926:3919 with SMTP id a640c23a62f3a-b647314166dmr1286907066b.22.1760989526706;
        Mon, 20 Oct 2025 12:45:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725d80sm874107566b.67.2025.10.20.12.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:45:26 -0700 (PDT)
Message-ID: <b9f50783-6313-4c40-bbf2-c8474ddc2f59@tuxon.dev>
Date: Mon, 20 Oct 2025 22:45:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 10/31] clk: at91: clk-generated: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <645beaecf4b81c7e08f8adf3b9c74fa4b0176993.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <645beaecf4b81c7e08f8adf3b9c74fa4b0176993.1758226719.git.Ryan.Wanner@microchip.com>
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
> Remove the last of the usage of __clk_get_hw().
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Added SAMA7D65 and SAM9X75 SoCs to the
> clk-generated changes. Adjust clk name variable order.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

[...]

>  static void __init sama7g5_pmc_setup(struct device_node *np)
>  {
> -	const char *main_xtal_name;
> +	const char *main_xtal_name, *md_slck_name, *td_slck_name;
>  	struct pmc_data *sama7g5_pmc;
>  	void **alloc_mem = NULL;
>  	int alloc_mem_size = 0;
>  	struct regmap *regmap;
>  	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
> -	struct clk_hw *td_slck_hw, *md_slck_hw;
>  	struct clk_parent_data parent_data[10];
> -	struct clk_hw *parent_hws[10];
>  	struct clk *main_xtal;
>  	bool bypass;
>  	int i, j;
>  
> -	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
> -	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> +	i = of_property_match_string(np, "clock-names", "td_slck");
> +	if (i < 0)
> +		return;
> +	td_slck_name = of_clk_get_parent_name(np, i);
> +
> +	i = of_property_match_string(np, "clock-names", "md_slck");
> +	if (i < 0)
> +		return;
> +	md_slck_name = of_clk_get_parent_name(np, i);
> +
>  	i = of_property_match_string(np, "clock-names", "main_xtal");
>  
Please drop the resulting empty line here.

