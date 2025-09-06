Return-Path: <linux-kernel+bounces-804416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA4B47637
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3457018834B6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C327E05A;
	Sat,  6 Sep 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Zhsocsv6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2591E5B88
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183985; cv=none; b=qZNGsBhhB1Ok8Yj8mPkXSyYJODzaLFthrgQP9v3ByU6elwtvHUSg3O6x4f3vGKT0ufYqLs2WfSiGhzrREFBNAvsrVlleFnnfUnrZAIOSDuV57BNPo1kMiBHzXQkb8Nnw1rG3QuWjWeMg3o0MxfXib9D6ntpLaSZyt3bSl1F3CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183985; c=relaxed/simple;
	bh=mqKzqDN5pv56Hlr8iaat2mwZNL44CqNS4/HxIZpY2wo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WFgkcpxpPC5nsx5uK5nHbAr9c5YsFChdFaEGlyTnC0VfGHJPTogZvNhezueMEyZkDSuL1pEDXpx2s5DfMgQ7MOb/zveZIVqfQjwnfh5ECS4PYBscG+QhY0hfdMgElJ2ioJ3v08uxuKvi5c8KU+NY/tWZlDW0Bze7ztcH0Hspc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Zhsocsv6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so7301625e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183982; x=1757788782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzYoPBV1TwgFlHltcxFw4KPza8jbsfJi3V/Uo8JU8Kc=;
        b=Zhsocsv6NX6c+sMLbV4dUBjyRObeKbJmc+CVLlkMm3SdAYDj340AMf2kpP83YoL1m2
         ciRXxY4GcsbobnwCfojKLu+mVZ5DIEM2wxtYAJf50j04W0sYG+HjLK/LvY1W7f6ZLeJG
         K5G97GbNHtLmwT3nAHEkiLK/6r2yzLvaucQZRMbQM6LPKug6kucOBDO+lsaWMZOA7tcb
         r9uHuTcYghUypGLXfknq0WbyGKgSDeGBLjc+VhFrjBGUi031Xrgd88IyhSx6VNXAV60p
         YqWSVXCQBFqDURpP0uC5v/4UJt1EQanATjhGMqfDknWf3tnhIotIHPc2XUGn6zfSHRJ9
         zDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183982; x=1757788782;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzYoPBV1TwgFlHltcxFw4KPza8jbsfJi3V/Uo8JU8Kc=;
        b=RAdeVf46HRDQelwcbr3dhaLOOHa9a94WMyzlzDK2B5agUPIsUa1bizLvSyET/bI+es
         FrzcULkR4al/Zu99Jw74xw9mDRnQNeHfZbZ6qapr7kvn3aG2oRB22RAvz4h20kNNdXR9
         ElLhUPr+43uNFOl/riDB+q3kxrkCyz+YWXich2aEOYmgv6zFINF01tF0kst2Azqty94M
         rdOUfrka0fN0KpKmY+HJe9bMtK8rzSt1BT8ZZxXnXzXhipYbNR9mO5ENlYZiLS3vQ/Sq
         5zJDiHMEDmWVqs4QAELCxS8Qby5CyPZ1fUPaDKwmZwW16u1STpMvNq9uCcfy54mtsrcQ
         5ILw==
X-Forwarded-Encrypted: i=1; AJvYcCX22/qbSOZ0oByjlkwptoJg57qd0QN+5xZh53KvLG1HAi+TQl0wmq6lb5650YyPfXX/x+ESAdOfLSVLP7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RANzxR7PnFkgNpHFyxDZVARpMNyMdiePdNsZf11Il2nRJwnm
	j6xTmwvfMCeLtskyAIBi70wqMw+W1o8pCF1WdsXwnncAMqgp/VM0+B4awL7BnIaPMmE=
X-Gm-Gg: ASbGncthe0bjacrImSAM9U7fKo57adZVOb04lx4+MMthBMrARJNdO9sw7CyiIGqV9w7
	+Q2SQ68xJskpddN5ccLwSL9xyvMmIC77V2gz19201jRk5CBRuhsZrVDTX2EQoVTvzEXzT98dpc+
	hcLkKJdFJZSVeTqhR4XTtsKEzl0vFyihcF8cQzwfBHsgBxppVgAkuBeg53gRhpBqk86lItHn2xi
	WsXwN31yq6yjkrQ8Mfod3tUFl8m6lr4ZO3mu3FVPhfUEc/U/ShtERPMpzOZzeDAiVjhthhfzUjP
	HQdekpqo/gSKwdF33VLS0vKYxcUQ4AhVHVEipghgABgGFO0+myzWAHENJSopaxrVKblKXTkUqL+
	TrTBVQe1Yqw94nB8TPn0gjardtKWIR/4=
X-Google-Smtp-Source: AGHT+IEok3JkRuMAdY7AX3j0CwwrHcGk5yIN66Gyo2mCztRV7/vmj7BLBPHvxLpcqnHCDGsjiMhyVg==
X-Received: by 2002:a05:600c:1d07:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-45ddded6ef0mr31784415e9.30.1757183981627;
        Sat, 06 Sep 2025 11:39:41 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab832sm373687575e9.23.2025.09.06.11.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:39:41 -0700 (PDT)
Message-ID: <2377eaff-6142-45ef-a966-0176c147c094@tuxon.dev>
Date: Sat, 6 Sep 2025 21:39:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 13/32] clk: at91: sama7d65: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <676e618850df0db8dd880c36cd9b6dcef7b17b8b.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <676e618850df0db8dd880c36cd9b6dcef7b17b8b.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
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
>   drivers/clk/at91/sama7d65.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
> index f10faabc7ffe..1553dc3152a4 100644
> --- a/drivers/clk/at91/sama7d65.c
> +++ b/drivers/clk/at91/sama7d65.c
> @@ -533,23 +533,23 @@ static struct {
>   /*
>    * System clock description
>    * @n:	clock name
> - * @p:	clock parent name
> + * @p:	clock parent hw
>    * @id: clock id
>    */
> -static const struct {
> +static struct {
>   	const char *n;
> -	const char *p;
> +	struct clk_hw *parent_hw;
>   	u8 id;
>   } sama7d65_systemck[] = {
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
>   };
>   
>   /* Mux table for programmable clocks. */
> @@ -1283,10 +1283,19 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
>   
>   		sama7d65_pmc->pchws[i] = hw;
>   	}
> -

Worth keeping this blank line.

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
>   	for (i = 0; i < ARRAY_SIZE(sama7d65_systemck); i++) {
>   		hw = at91_clk_register_system(regmap, sama7d65_systemck[i].n,
> -					      sama7d65_systemck[i].p, NULL,
> +					      NULL, &AT91_CLK_PD_HW(sama7d65_systemck[i].parent_hw),
>   					      sama7d65_systemck[i].id, 0);
>   		if (IS_ERR(hw))
>   			goto err_free;


