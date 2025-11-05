Return-Path: <linux-kernel+bounces-886532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2FC35D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1EAC345E19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73E320393;
	Wed,  5 Nov 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luapqlGx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105C313E20
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349544; cv=none; b=Atc4NxuHUNJ3Xh0grNK34oSeVZ0dYbiw/uTv0Off18Nt0MPUFL/cF4CuEecU2apRuA4l++yYHtfyTxG/XwH8a1hDpb4QvEcHxS+GEqOs6fPvWdlxT8zjUAoxZCsly+T4HUqIoIOQocrZb/7vfsst9Sfbf+AziQry5x1EQrVHpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349544; c=relaxed/simple;
	bh=WZqTjb689EoWjujrHonKsIfRrwGoZauuvVV3zjdR5KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAeVVeyGht8NO4nXK6kajyy/5y895eP00ZtDtvUPpN8wCFAFu+w7v+sicowWOjqQwF+9+YEx0o6ezLD6orzVN3KEl0X3O0gZOWPDXKuEWWXw2AQwWKzax7y8cDSRwskABTnzValF94kgINXNmjazum7o8gQS0wPJnQRoJVq8xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luapqlGx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so36562555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762349541; x=1762954341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfYKsCgYtXAFMzfAlzEUUGBJt44vMEyp53EFHMiQJao=;
        b=luapqlGxuGVnE7WvwlaxwNS5LZoFyPxjx66LWE1SKMr8TipUOr4oKRXEEDdJ8pVyUm
         XJNo9luTEnnT9nrUnFzV1nYhFBQsfd8ruQeN3NjlbvZ1ns3DOl0AfbtElGnrYVQchfhV
         UD7gtadXVinzGp7NivmcgEnnAYeCGjyCUr1xWyeMp2pDrzmQUOuxbQ+T7ZtYrcPE20mk
         8IJ48/2U1Fm2IkYt+LKOs5qrNJX1xC10nyHv1sgSvtRLSUcDXqblV/7B7gFlT9rIR4Cw
         CTPWJXALPBU6AV67A36yjNq9ZrFr3ASzxhrTJhQ51y9QHfSKffybsOhjU54tQw25bjk2
         SzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349541; x=1762954341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfYKsCgYtXAFMzfAlzEUUGBJt44vMEyp53EFHMiQJao=;
        b=IYir3VF7rFajaQeY2KFNJ9KpKCdASlHT+HZWTwZT8cEGtrNDAuqqt5c70ujNrm4l/j
         7ZmOO7xliLqUR4FWCATFX0s2Apu8diQzdI5zHDYKN97srzjwMTjwo1qqLuEZoJatZyqM
         mLU3X+iftEXXZeIwVSWTopkatmMHGgHmqxJpt1vse/0DzSFgWfAKuHWaymb5zgmSMUkq
         eH8xeQL0tIQb4XyWSqmVLhItoWgyJFk98OV+gIqnmVFdzZSnyFbr/2vmpNbbT9OQ1pvp
         ChXEg3BezOf/pSOs7cqRrfr8a6ZagxOHF/C/4aNt135qroyE7nEgwK/L0jaoT/dY/INS
         FD1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0iacRtYJPadnssH2BZl9i0BN/azlNYsX9MxYgEb5wMgrYANiyZlQgwMEMCY/XqX407ROVaycov74FThU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkNlWJbjeB+FLNeqKMNfCqUun+3apg+GNr9MzCSkc4CkhRml7
	/S/7YspsqxcWfsHtTkFw+qSpscEl4H0zsAHAcP4UEVf90os5+NSgrQv5Pm7PXg069IA=
X-Gm-Gg: ASbGncvehfAUN+tzRiWRjREQVHv0+mA6Eqne2oK/LKqv/zQ/Z1U3PB3JbOITDGy/fLa
	XMdUsEFg//lSvBgIHriSuhS+rp+6IT0ux0PkuGHYZO3eIIIldp8AYkwskufZia5PVF9xP3AlT7K
	twaM60gztKCFFmuTy3fubAXLVenRoAUitTrtemSs+sNGX1OqH6YZNvj3PB/MBMjBO5ECvasjIBZ
	PPKN48l1nHX+OjraCq5QEK+/I3GrUSg+eF11Ox3Z55MZmYSBPfrB8H9T7X4RJzeJ9+ZWuhICo9r
	0VpY5LidaoVrD47sb/SYrV95btCjYaNrHS3+UddHvoUCHxNEeQcnTBgzna7bIDNnd/RX/f+yCdw
	k1ZDHBKuXEJ58/mjHXPLUO1gwymSAGULuCjP539Zmxluz5LP/nRVlqgzO9RwE0Wovd8sQVk0Geb
	3JpCoZjAEfQaIcPRuRYJMgokX+w+iWvzYbi/mf
X-Google-Smtp-Source: AGHT+IHrQ5Ca/eXvqCH81m3o/jUTceHdPdQQWNSE7M8rzMniM4TuBgB5grmgh+HwfHdWHibHeGh8dg==
X-Received: by 2002:a05:600c:5252:b0:475:dd9d:297b with SMTP id 5b1f17b1804b1-4775cdf46f0mr23240645e9.33.1762349540607;
        Wed, 05 Nov 2025 05:32:20 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm49078345e9.1.2025.11.05.05.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:32:20 -0800 (PST)
Message-ID: <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>
Date: Wed, 5 Nov 2025 14:32:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251017054943.7195-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Johan,

thanks for your fix.

You should replace __init by __init_or_module


On 10/17/25 07:49, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function must not live in init. Device managed resource actions
> similarly cannot be discarded.
> 
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about this so replace it to catch any similar future issues.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/clocksource/timer-nxp-stm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
> index bbc40623728f..ce10bdcfc76b 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -177,15 +177,15 @@ static void nxp_stm_clocksource_resume(struct clocksource *cs)
>   	nxp_stm_clocksource_enable(cs);
>   }
>   
> -static void __init devm_clocksource_unregister(void *data)
> +static void devm_clocksource_unregister(void *data)
>   {
>   	struct stm_timer *stm_timer = data;
>   
>   	clocksource_unregister(&stm_timer->cs);
>   }
>   
> -static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
> -					   const char *name, void __iomem *base, struct clk *clk)
> +static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
> +				    const char *name, void __iomem *base, struct clk *clk)
>   {
>   	int ret;
>   
> @@ -298,9 +298,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
>   	nxp_stm_module_get(stm_timer);
>   }
>   
> -static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
> -						  const char *name, void __iomem *base, int irq,
> -						  struct clk *clk, int cpu)
> +static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
> +					   const char *name, void __iomem *base, int irq,
> +					   struct clk *clk, int cpu)
>   {
>   	stm_timer->base = base;
>   	stm_timer->rate = clk_get_rate(clk);
> @@ -388,7 +388,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static int __init nxp_stm_timer_probe(struct platform_device *pdev)
> +static int nxp_stm_timer_probe(struct platform_device *pdev)
>   {
>   	struct stm_timer *stm_timer;
>   	struct device *dev = &pdev->dev;
> @@ -484,14 +484,14 @@ static const struct of_device_id nxp_stm_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
>   
> -static struct platform_driver nxp_stm_probe = {
> +static struct platform_driver nxp_stm_driver = {
>   	.probe	= nxp_stm_timer_probe,
>   	.driver	= {
>   		.name		= "nxp-stm",
>   		.of_match_table	= nxp_stm_of_match,
>   	},
>   };
> -module_platform_driver(nxp_stm_probe);
> +module_platform_driver(nxp_stm_driver);
>   
>   MODULE_DESCRIPTION("NXP System Timer Module driver");
>   MODULE_LICENSE("GPL");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

