Return-Path: <linux-kernel+bounces-821297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD81B80EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C146260CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2692F99B3;
	Wed, 17 Sep 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPlhM44i"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2592DC320
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125125; cv=none; b=aRnXmnCMIE2r45KtV0mv8UM/cpFDjlB1o3W3b0dYqcEsSMH56c5mUAqpPF/YtYeo1OexqlSPHaAZn+FO4UUSJ6BJN/d7wwaZCSOL5yK1pPatkR22Tz97QoWYr/BETblTPFVJVc5JYTDD3NCsmPSk18UxIvkqNY2Fq5Fo9J7x1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125125; c=relaxed/simple;
	bh=83FVdwNnxqEbYW3PgFyOSJc0vbgnfeTmYkwtMxfNscE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ/fPLRto01CbqpM0Bs2v5d9xhZizVm+YnBBAsilSZX5mBe5sG4Ei4qkHxh/Kj7r8Ey50SczhRobKzF8CPvRopoMGD3sxpHyhXR2T+K4QHXv148iJx6k+4FE4p9NDrRdHs4x8gpe58qKYqIgQ24vSQgrjTUSSBX624GEcNaqUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPlhM44i; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso625259f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758125120; x=1758729920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfZwmKXTX8HZnh5vO2cl8cRtebuw3nAGYKhbz9bcrEc=;
        b=FPlhM44izJgKtPAMIOHzlNf/52KXm3YvTZx5MIg1RJRXuSXR55CCj3MiJsbPPkbt1H
         2Yo0CqLaa5hTo9HK6X6O2ZT6G/OkUuWpv1E9iedPO5get+LXQAdxSDEP4Rq+Rh7L8U8R
         RKI/RCnmIxxWso5Db0YwApXuRLyQGg2bPruNjE2rYJIFuSQ4q18s38+sUV4enXFoDrXS
         AUiv3t5AgPl8PnehGSfBCFrnGtMRKYkNSS5Shz7bG7VS5j9sKsLRFnSwOJuVhigQJNNY
         deqCqxq6RNgwtdNDEo04/hxij5i7u5Tk2EUptSXnTqlScDn7/op7KRKCaEuVByIz+b4a
         1niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125120; x=1758729920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfZwmKXTX8HZnh5vO2cl8cRtebuw3nAGYKhbz9bcrEc=;
        b=Fp87iilvx/1L6q1uvWZuNoX+Fn06f0HyUmaukM1AnttEwsM7HHp7lHqkAtiLYhnvJu
         v/XVLtFy7+d8tYN0UcAkLn3MXsvXqMU9YjdzY1dzHpQU+I9a030JOpQUKqIjp3nBw8yG
         jnpwmpzbPAebH9kprgo8BsHpQ9tBVaDsC0+IzouYkIbk77jySL8s3t9ZKN2BNQu5QFkO
         wYMhrcvjVZfvT1HBpHlahlCdJsW/YFt1TLV5y/oVM3hHdLEcwcXPiwyB7JAGsOHg+F3S
         z/nPMdA1CiZ18uoYPTsLMuvwCDKCkrDg9qEmNyJKdamLYTshG/frlvnzSfMpzlMJaE4i
         Zuuw==
X-Gm-Message-State: AOJu0YwPQK/y6vWeng3sqpohqWmtOs9CrWd5iFQU8vOi3AG9/espJ7ap
	yM/92IDqH4pNzVAAi3f57Eq8wAeyGO50jvVfWbCMUQ4puSlMzNqfkx5j66mqR93J57M=
X-Gm-Gg: ASbGncv6byXq7hmLYnfOm/qXLs7G9DtYQnUnL0lTDBWM+QZxw82bn4lUvpLrCKptAUP
	2eGnRTetBqESl7ElgzpFQ+ACHuHrmM0r6fh5IXjV8lMANSRYbpTNspEjCtr0Kb8obMNTWjIhaAW
	wkff+M29n+4pn25qRQHJ+TJZ+r8uEuR+tGM/zuwKtav3yIMYHugO8Jfqz28G5/RqBSjYcU44w5a
	SSUSjpAtLmLS0AmBDLRiCZoJGsWpYP7m3aglIi0xRCQYgO+F5WadCp8Zw+qvNQtDuKIRb2ZAJWx
	OJHGeiyQkz0MLJingYX3vU8aWhihZbtL7Jt10XhMDkOgeVoWUM/uKfVx438toYYoum3kf8B9us5
	ygAJiBPIRoK0vE2b8xx93q5VOSxkw2Pp9oJxZnfqG4+twTF24WbPtCJlVYVRtgv3Irupun/LUfW
	873Q==
X-Google-Smtp-Source: AGHT+IG6PSOFrqglzlkWA1zO7CzKciVLMfMhjWHI8hR2vQYQuR0qyFq5Nrbski70IDPQSjM3RHc8/w==
X-Received: by 2002:a05:6000:220e:b0:3ec:98fb:d75e with SMTP id ffacd0b85a97d-3ede1b73345mr111009f8f.16.1758125120170;
        Wed, 17 Sep 2025 09:05:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4613186e5c7sm48392715e9.0.2025.09.17.09.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:05:19 -0700 (PDT)
Message-ID: <80564613-d935-4ad0-ba00-4ed23a0f9cef@linaro.org>
Date: Wed, 17 Sep 2025 18:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: clps711x: Fix resource leaks in error
 paths
To: Zhen Ni <zhen.ni@easystack.cn>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250804123619.78282-1-zhen.ni@easystack.cn>
 <20250814123324.1516495-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250814123324.1516495-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 14:33, Zhen Ni wrote:
> The current implementation of clps711x_timer_init() has multiple error
> paths that directly return without releasing the base I/O memory mapped
> via of_iomap(). Fix of_iomap leaks in error paths.
> 
> Fixes: 04410efbb6bc ("clocksource/drivers/clps711x: Convert init function to return error")
> Fixes: 2a6a8e2d9004 ("clocksource/drivers/clps711x: Remove board support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> changes in v3:
> - Change "err" to "error" in the commit message.
> changes in v2:
> - Add tags of 'Fixes' and 'Cc'
> - Reduce detailed enumeration of err paths
> - Omit a pointer check before iounmap()
> - Change goto target from out to unmap_io
> ---
>   drivers/clocksource/clps711x-timer.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
> index e95fdc49c226..bbceb0289d45 100644
> --- a/drivers/clocksource/clps711x-timer.c
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node *np)
>   	unsigned int irq = irq_of_parse_and_map(np, 0);
>   	struct clk *clock = of_clk_get(np, 0);
>   	void __iomem *base = of_iomap(np, 0);
> +	int ret = 0;

	int ret = -EINVAL;

>   	if (!base)
>   		return -ENOMEM;
> -	if (!irq)
> -		return -EINVAL;
> -	if (IS_ERR(clock))
> -		return PTR_ERR(clock);
> +	if (!irq) {
> +		ret = -EINVAL;

Remove the above

> +		goto unmap_io;
> +	}
> +	if (IS_ERR(clock)) {
> +		ret = PTR_ERR(clock);
> +		goto unmap_io;
> +	}
>   
>   	switch (of_alias_get_id(np, "timer")) {
>   	case CLPS711X_CLKSRC_CLOCKSOURCE:
>   		clps711x_clksrc_init(clock, base);
>   		break;
>   	case CLPS711X_CLKSRC_CLOCKEVENT:
> -		return _clps711x_clkevt_init(clock, base, irq);
> +		ret =  _clps711x_clkevt_init(clock, base, irq);
> +		break;
>   	default:
> -		return -EINVAL;
> +		ret = -EINVAL;

Remove the above

> +		break;
>   	}
>   
> -	return 0;
> +unmap_io:
> +	iounmap(base);
> +	return ret;
>   }
>   TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

