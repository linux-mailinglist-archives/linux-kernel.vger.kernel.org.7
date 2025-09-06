Return-Path: <linux-kernel+bounces-804419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDFAB47646
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29797AD980
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63D225A3B;
	Sat,  6 Sep 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZqWQuqRk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603271C6FFA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184416; cv=none; b=dxIvs7S6jgzDNB45fa2Q3PklexlF6XHmIKjGvhrp9tsZ1KS7wCBVYVhaxeXEjaWQSxgB+Jv9sReqkh2hMY/ANC3JCvoZdRqjg6iyaiXOrRDDbT1HQ0gsZbWVkUCP9KzGCBIyH76UFPtLftNzOd19YO24wVf1H5UCfCrglfoTHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184416; c=relaxed/simple;
	bh=0AuUmYDGUgWr6NLQHAXspt1nlUrnwqxucWAtvtA4Wi4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eYnDQU7eWGsm5PKfVZlPyN2ygi0lftpo0tl+DMKG+iiuXMbCnx44IhXbyrl/7WuKnnjQ2NG+xcySOhXapLD6bf4uwU0GUERxPh2m2TB3r0Zl+WGst6C6rz9ibaelfH7RnkMSDO5durvnAuQLNaFq2xBiS3cz+DA/55GL4dRsSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZqWQuqRk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45de1084868so1650675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757184412; x=1757789212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXIBvGz2QRYZ2c6J6+fuJIBALqm9W64iJQz3FvyRluM=;
        b=ZqWQuqRkKpxRazFqonBdLMgsNt/Br9wtPuEPo9UY+uy1sKx/UVbYhu8mtdWA8nq8vQ
         jWRhnL1BVXgsAEc3+13nlaFESKz4eNi+yxG8W/KQw+dgJ0VHS/vlLD8xoBdQKV2P+748
         8na+T6SiB7NwjLFBw+uqpXE/Dhpi6v2eKBZ3JnHLXdtVqLdlXxxhDTB5JOImAaDv/i9B
         jwUCHVh7HmijfCjx+vRhRe7XtArQWvHD743CwRgCB/Ax/ek962Krl2RlTVEo2L/0Zs0u
         4Bi8QLuY/oC+8QBjJSL5755glRCgfy/0SzKf3BDdTxzAr4gm264O1W8812b7Y15jww9l
         OFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184412; x=1757789212;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXIBvGz2QRYZ2c6J6+fuJIBALqm9W64iJQz3FvyRluM=;
        b=oqW/+KYU2w2YUSE7Me1iPWCHKzgzOeCQlk2Xx+/u73tUYTMUUmsPBw2oYGpH9wRyDT
         yHKobfqLgN7pZsjDPsKH4p+J1flGpIai6qcnqkMLTQPdSdhkwlog8XCYalanA8NsPCqc
         3dI6HArlF2NLRqeaaQ0Mp+fNHe6l8fqKjL3YoOcBjV2NtjMRv7U0Fe5fppP7Xflgec8W
         scAbcV8Veh63m6BJR7XY0mrs3JYPZUrFxg4MpCKnf44R1tZKT4UZuuAC3kyQWtHAGve8
         b7jns/fBcOg+traF3L33xcgGOyaozqkW1tS+kuPNw4KKvVFG5yM3tFP8RNfusrQ2Vdx0
         MLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4nX+I5E72K96uLoveqwOtGu2b33gOfmQzo+UBp71rHCWu27ruDUMV18+g8jH3iwVPsfSN+ROi0QXM/aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7U1i9x9zfja5IZSiXJA8ZmCgW6yB5gC+g1BOUq+YCXxXfOyu
	OZmMZL+xR3QJjpXc4JS6YSWIn3/v6dNw6aRIjjMETOekLCnWiPshKqsLlb0k5sgpaEaF8/H5S0j
	eYYri
X-Gm-Gg: ASbGncsLQZUJ4NJUODOf6YpoKQ7HZHfWzGDr2JIPvF3zUIlWESx04nLZdlDz4rrVKCZ
	k+v1ZZCZKsxt56tBXhpVfsgougRifo5Tx18mKdlb5vOsP6rNJWf1bBiDpNndfN4/nLatPd0TAum
	9OTbdAKIIVLoQWCV39mnpUWMb8xmrn+zegFcNPJFyvaSAQIBc5V8JFzJQo1PP4Th0JZ2pfQJWAd
	n+Nc7xvgQT7XtQYSkNOPNnODNo12X2rD8Fa7sJGzvjohy1rzIOnJlUzwZ/jyaTDKysyJgUYd0gN
	06ib75gj/gH1CoTqbV3pcGiuCxJaWCUSzjw5AmkT5fNvlVlylVcB7jelJtiGZI76pmS/+kX/6Uj
	UTL0UaM9dUJxOEaUJlVLHdIX1nBmnQaQ=
X-Google-Smtp-Source: AGHT+IELO4WCYtXnWgGHZ+m3e/fCm3/0gRjeizrA1xDQ2eHBYPWbZicD4ZFELLra/Cwi94VouYjN2Q==
X-Received: by 2002:a05:600c:8b22:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-45dddec82fdmr28142265e9.17.1757184411619;
        Sat, 06 Sep 2025 11:46:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm202054845e9.12.2025.09.06.11.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:46:51 -0700 (PDT)
Message-ID: <4754b656-6168-417e-8fc8-450d1b0a3293@tuxon.dev>
Date: Sat, 6 Sep 2025 21:46:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 22/32] clk: at91: sam9x60: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <7f90312300d24617c51f63aa0a1c7bbb4a0212cc.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <7f90312300d24617c51f63aa0a1c7bbb4a0212cc.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch SAM9X60 clocks to use modern parent_hw and parent_data.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/sam9x60.c | 109 +++++++++++++++++--------------------
>   1 file changed, 51 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index eb38da77d69a..b2e86e600a9f 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -79,9 +79,9 @@ static const struct clk_pcr_layout sam9x60_pcr_layout = {
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
>   } sam9x60_systemck[] = {
> @@ -89,11 +89,11 @@ static const struct {
>   	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>   	 * to keep it enabled in case there is no Linux consumer for it.
>   	 */
> -	{ .n = "ddrck",  .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "uhpck",  .p = "usbck",    .id = 6 },
> -	{ .n = "pck0",   .p = "prog0",    .id = 8 },
> -	{ .n = "pck1",   .p = "prog1",    .id = 9 },
> -	{ .n = "qspick", .p = "masterck_div", .id = 19 },
> +	{ .n = "ddrck",  .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "uhpck",  .id = 6 },
> +	{ .n = "pck0",   .id = 8 },
> +	{ .n = "pck1",   .id = 9 },
> +	{ .n = "qspick", .id = 19 },
>   };
>   
>   static const struct {
> @@ -184,32 +184,17 @@ static const struct {
>   
>   static void __init sam9x60_pmc_setup(struct device_node *np)
>   {
> +	const char *td_slck_name = "td_slck", *md_slck_name = "md_slck";
> +	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
> +	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
> +	const char *main_xtal_name = "main_xtal";
>   	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *td_slck_name, *md_slck_name, *mainxtal_name;
> +	struct clk_parent_data parent_data[6];
>   	struct pmc_data *sam9x60_pmc;
> -	const char *parent_names[6];
> -	struct clk_hw *main_osc_hw;
> +	struct clk_hw *usbck_hw;
>   	struct regmap *regmap;
> -	struct clk_hw *hw;
>   	int i;
>   

Please keep this starting here:

> -	i = of_property_match_string(np, "clock-names", "td_slck");
> -	if (i < 0)
> -		return;
> -
> -	td_slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "md_slck");
> -	if (i < 0)
> -		return;
> -
> -	md_slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "main_xtal");
> -	if (i < 0)
> -		return;
> -	mainxtal_name = of_clk_get_parent_name(np, i);
> -

ending here and use the retrieved name with AT91_CLK_PD_NAME()


