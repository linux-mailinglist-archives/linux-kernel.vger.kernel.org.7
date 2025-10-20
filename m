Return-Path: <linux-kernel+bounces-861651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC7BF3427
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA004FCF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5410328B4A;
	Mon, 20 Oct 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GsiqSamx"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE11EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989466; cv=none; b=khjv5b5fJ1XNnrykd447YatKytIzVHuNE+AWKeMoEcu1s7NBCi93FPrqoyUiGPezf3/z/Uiz6bztUIwybYC0EaPevLEqY40O2FcD5aqzZTELGH2EqiyxoixlMFNYFCBgw62NNRV/3OHEcQBvWDPn8A8wgZqcrQwu6X4ldw07RAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989466; c=relaxed/simple;
	bh=th+Pf7BlNE9Ml++HbEuu+5vMDSJNkIeM3J0nT4hFNWo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vruy3yGKYGAcwx11hCdXr9WhMn2SbPklX+nVOVL0emqWE78jUN0PQ/3khy9CvuadITTv46dqSRjHadopJiE5ck6tVY8Rlqm3KnFqVXvi7cdBwoec+thG2Z1yMTkRfn+7Pct674JML8+Nvuw3/jCTpTalhASFGlKho36TdtsGC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GsiqSamx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso8595622a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989463; x=1761594263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/rHfvCGQ7vSJJOElRUDluOOr/mXgiutMeNr5c1rvEw=;
        b=GsiqSamxNymKjJ8fECISyLpNq4JnJZHJVk5uONDftuy2wMjBDSYGb/5SC34S7+Ae+6
         vnPUp8YdoUm2qEh3/d3vF01hhglg2lURNbDXa522T3yMvApaDr+1sJpGiorwFRrIqtrE
         XZ6Jiz/yC1nrw37ObPAtOYyYS9lM10n2y9IlcnqMlsYL+2yI9zUzWxCvZ8ux3657ZW1I
         g8AjRkolvDT0/gWWjMF7b0cIeeV1tf7/8K9PtDK7KmlEv6M43neGKJ6solyd5xNHOOQs
         GJcXbfzCYs4UV3Nx9I933wl5dFGhH7KLkAHzTszawFTpCpxYt2cs7sQRmxzEFxV3sVy2
         aSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989463; x=1761594263;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/rHfvCGQ7vSJJOElRUDluOOr/mXgiutMeNr5c1rvEw=;
        b=skws2awN+9dXMZj61vGzcDjQIch0C2knHNfMB8Sgt/hFiBZkjAkOcqGoM9tbhfzUmQ
         n0lZKin97IPW/OQR1oAxXTt0HlrKVNfpava9iBJrIiaKA+HT2uJNRwC4XRkhDOhsOuQz
         sOydJBVEwqTb93OEX4NhPcVb/25oC+/xPkm8ET+2C+J0tDFSxWv4+/feLRqud1FADbRR
         hplU7u6tgLjfocJKOwgq1wj/nCS2LqJKepTnt9mCNCKCEFL7jN/F4UCu+r2YICahiZkA
         LvxzhWk+RQCEQv+ObapUMg2RncUqf60HJ56fgwZiLSDZbsOzo3Xk4N+dshOSFRQED7yr
         zjTA==
X-Forwarded-Encrypted: i=1; AJvYcCXN9XzvuJvb3FbUTt++rPPvF+5Aj1c5Op6jFTB7+Oc2ImriAOblrqCVQj2gZRKTfZaHol+RsgxWdPzjdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydakU9SWDpiGW7LqsTCkFW9aH6K7Q/Okrh71vqUmL7WlO1pqKp
	Hj9yGmeJI77V3kAAYcKpYXOLm8PGxVWYcDmN7k6vUySAYblQ1iYbSv3qyTi+D/Wdz48=
X-Gm-Gg: ASbGncs9FcyLCeAShQlxRJbhH6U6t/HQ/NRITWYEpeAmfJbh4EPcFr9zlZOUvDfJGTO
	/7tcuHmzLEmwEcrGfHX2v8Ial3Inf6g3FNtVQKHh1gGj/LAuuixry+ARTNp38tdM4OqGWIIw2BB
	ymyR9jhp24cg0JEvz3gECkRzBO/gquR2fTFX1bG4LxMniFKNpa9QiRGsxMiKVJjuN989xqUPSfi
	oWILu2B1Ju/oZZi8gCKg9Hdxz/NCQEGPnfx6spmy2oZgYKgCbY6Hpmptct0vlp1BxjU9YFBfdhu
	SjdCcD3F7+AmMcNW7gNoxYLvuw8Dod35LffMgS1dCfQikPrfdjkLMmhxtWNw0InC7rH4zNMX+d3
	UN/S55H/JOuiyizj5Grq9ga/J8VSHNa4m9wGsLDej7HGpZ8IUEiuklmaD4KAphjJAjvG1VIARCT
	2rMfyKxe++
X-Google-Smtp-Source: AGHT+IHJmKY5JzYa17Wwq5eRnrHMWSM06j/Es4HUtYcSQtsu62W1SioDH4KU66ZTBqpLPBdqBNGQ5A==
X-Received: by 2002:a05:6402:2551:b0:62f:2afa:60e6 with SMTP id 4fb4d7f45d1cf-63c1f64ececmr12589171a12.7.1760989462748;
        Mon, 20 Oct 2025 12:44:22 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab54fbsm7278599a12.15.2025.10.20.12.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:44:22 -0700 (PDT)
Message-ID: <9656db91-b930-47f3-bdca-ed42f066aa8e@tuxon.dev>
Date: Mon, 20 Oct 2025 22:44:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 08/31] clk: at91: clk-master: use clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <160f139d5a5647104826c5878ca077faa26916bc.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <160f139d5a5647104826c5878ca077faa26916bc.1758226719.git.Ryan.Wanner@microchip.com>
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
> __clk_get_hw will be removed in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: Add clk-master changes to SAM9X75 and
> SAMA7D65 SoCs. As well as add md_slck commit message.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

[...]

> @@ -752,15 +752,17 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  	struct regmap *regmap;
>  	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>  	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
> -	struct clk_parent_data parent_data[2];
> +	struct clk_parent_data parent_data[9];
>  	struct clk_hw *parent_hws[9];
>  	int i, j;
>  
>  	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
>  	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
> -	i = of_property_match_string(np, "clock-names", "main_xtal");
> +	if (!td_slck_hw || !md_slck_hw)
> +		return;
>  
> -	if (!td_slck_hw || !md_slck_hw || !i)
> +	i = of_property_match_string(np, "clock-names", "main_xtal");
> +	if (i < 0)
>  		return;

The diff here should be gone from this patch if handled in previous
conversion patches.

