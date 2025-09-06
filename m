Return-Path: <linux-kernel+bounces-804421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EFFB4764C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B463A3667
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F8278172;
	Sat,  6 Sep 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e2HEwgp3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CF14A8E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184597; cv=none; b=IEkIPXD1kAlxF2lMt5hwNhHilYn/wxTKXyUku1vV1TAkiZ5H5DdiNvGEAzP6h3Gwzfouo6LEthJ4iLdrVqqQSFqe1CsB6P4XR4U7E+3Q1s4gHA1KGYk65gQ998aAHR3DZ95arA3tZS+pZYHU6DzCJMazfoSN/sJrSHCPDH4iD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184597; c=relaxed/simple;
	bh=ags8ApmD1oguZ7lNJsYYUASpAjmjVWGGaS/SCa7S8QY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qFtnYED4u99CWGrANbKN1Q/GHT51mM7422EsgR3+4Nejc/qgK5QgNkYa27a3HW6jCMw+94NSkoXZs0Sb04Ei5WEMGUAlANfXU9olJHoN/9a1P5mRoL/uVW/uu1BOG2A+89EY5/v9B57gwlrnkqsrnV3oPzt06U1Chu81i1mPdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e2HEwgp3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso27547845e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757184594; x=1757789394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1duALMFYguAwGoCUAj68KdsYk8MNW56WucSUt18X7Q=;
        b=e2HEwgp3Jr/4BqWo6nwSa1gnsy4wakiLpLRd8giOEc3yQ0lzD/idE/IeN8vRn8K/Ym
         erw/p8QfRIAOhnOAzD100rEQ7Gp+nwaUZlvE1suTuJ0WUFaKhcocR7vMPVDuMecxMuPD
         UNNVUFxPJIH82wPT6UK0BjC9U7OMbTMeVt+57HY4gYorfw6Cx5UIgLF1J6DLgClvoaJ8
         krG/KS2yyGnWbbrXhJ/hJlD6lEo9TI7Z6DDNrGOgaclDZdDEKqpQIX9EaGMXdA3k0P6z
         a5EOm3VJfaeb9/yhhLOicBAezPDRPR2+JROtg/BOto8SvRXlVJUK6ghUwdwtX1ozzk3o
         iVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184594; x=1757789394;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1duALMFYguAwGoCUAj68KdsYk8MNW56WucSUt18X7Q=;
        b=pqHx0ZcMxyJt9urTo8L6EWeZ6Xm/9UVxmWqriKebx/g+FAJYQeGE+yysC5KOqU4eg0
         VcOQTSIoioj9yjL29XHwtrIU3eSh/C8pthxVPWYA6RrC80g4g5r43qSE1Muz7C6i4aWp
         J66CSDBNNPIPwlva0Zju+YGIhBNkrWKAbgzEXHnkV4NfGzu+ciH7WRDy/5kKa3kX4nYz
         p79AVXZzNFktjB+Ood/hBv8SxJ47ywXZwFMDplPEvmjDP0bMZCcPPaTXYFQaJvgOReA0
         97HCNVI9/cu5w1uGQSL36GOnIQlBIkUCiulCONNvKY10Ml8p01mmfXWI4iUXuTABj/EA
         k5iw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jz+muNFVDijGs0ZPIehkwklf6LEBZaMP/2M8P5kylbTuK9rOyKpzFVoLVO1rAdQDxxz4yrQRDuvI508=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChfzfDjZjbSr6MrxBJjJtbCJllK3Dgz09pRZISyfl1/iQhDfH
	4pbbN76uuRFju343oX5LHRg4jjlsb/CJJsMd96MbGnFM45wHzLUV7reILCWX6Cfnisc=
X-Gm-Gg: ASbGncsFT+vGC22SVnxbS0WPGqMzL+tTJqKU7HuY1FyWaPnPtKv7LedbRvBPtWnKYH2
	WD3XtcPD9Rb/qNuTf1rRFWITw9PcnBppxQ4QeyxneLN2NWPGBCqnX4K8kwEoFVUeSgYX65lxAa6
	Qfmh9xG09vy5Y0jqpvo68c4wxgD0D1E2SbASDaLF/Y6gxjPQm3bC7vcpvUsBrwcp1rxknT3RapE
	Lax9zmeVEMEjnZjNgMK+cwjRWy3APBZt/hIavf9YHPuHwEDAD+RHfVscJIgovvWkdk1moGuJYlU
	IkRjlskvwWT/jMnep4RJWGFZAS4v4WJmPNv3TlRC3LK0HRN8G2cC8LRlg0tk7BJdCxNGgIRwG42
	GgEx2wS7ONY2yfV+lMTNYv310w53vZbA=
X-Google-Smtp-Source: AGHT+IHZFDMtmYlvXENzg7IersllDvAME69Aa+eYY71GR9KeI6KFHf2HfcJV0/Y9VxN/J7hUF8lrdg==
X-Received: by 2002:a05:600c:1d16:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45ddde89897mr29808885e9.3.1757184593820;
        Sat, 06 Sep 2025 11:49:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2ebb9sm25918131f8f.20.2025.09.06.11.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:49:53 -0700 (PDT)
Message-ID: <30806f24-b038-4785-8787-25229541136b@tuxon.dev>
Date: Sat, 6 Sep 2025 21:49:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 24/32] clk: at91: sama5d3: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <8b9b4447d93f048bc95ab083c9fbe1d5ccd8acd1.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <8b9b4447d93f048bc95ab083c9fbe1d5ccd8acd1.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch SAMA5D3 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/sama5d3.c | 122 +++++++++++++++++++------------------
>   1 file changed, 63 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 8326bb6a291c..e5b061783b09 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -37,9 +37,9 @@ static const struct clk_pcr_layout sama5d3_pcr_layout = {
>   	.div_mask = GENMASK(17, 16),
>   };
>   
> -static const struct {
> +static struct {
>   	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>   	unsigned long flags;
>   	u8 id;
>   } sama5d3_systemck[] = {
> @@ -47,14 +47,14 @@ static const struct {
>   	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>   	 * to keep it enabled in case there is no Linux consumer for it.
>   	 */
> -	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
> -	{ .n = "smdck", .p = "smdclk",       .id = 4 },
> -	{ .n = "uhpck", .p = "usbck",        .id = 6 },
> -	{ .n = "udpck", .p = "usbck",        .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",        .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",        .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",        .id = 10 },
> +	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "lcdck", .id = 3 },
> +	{ .n = "smdck", .id = 4 },
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
>   };
>   
>   static const struct {
> @@ -114,24 +114,15 @@ static const struct {
>   
>   static void __init sama5d3_pmc_setup(struct device_node *np)
>   {
> -	const char *slck_name, *mainxtal_name;
> +	const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
> +	struct clk_hw *main_rc_hw, *main_osc_hw, *mainck_hw;
> +	u8 slow_clk_index = 0, main_xtal_index = 1;
> +	struct clk_hw *smdck_hw, *usbck_hw, *hw;
> +	struct clk_parent_data parent_data[5];
>   	struct pmc_data *sama5d3_pmc;
> -	const char *parent_names[5];
>   	struct regmap *regmap;
> -	struct clk_hw *hw;
> -	int i;
>   	bool bypass;
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

Same here. Keep the name retrieval method and use it with AT91_CLK_PD_NAME()

Thank you,
Claudiu

