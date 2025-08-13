Return-Path: <linux-kernel+bounces-766635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8AB2494D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C51588441
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70E2FF153;
	Wed, 13 Aug 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8VrFzic"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D92FE577
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087274; cv=none; b=aLOfEkknEs+98IXV+T4DTj3a7jk1hrSLbO/XVDCWH2vM0aWqwvuIUzP0Fw5MGCBrQe57pJH41cAi3GwHAFFSVUECFI4iU2lik+XMZqB+oroW+iNnyNXkHu9uczxj2iwdR8IiT6tLE01FV1aNP0eFJ3dNJLWQqUsdzES+r7j0iD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087274; c=relaxed/simple;
	bh=E+nYtUgvkEArHsW/dU2G+LfJN2FbpyML8f1ME6KvyzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXyHOK3SefClo+1jdIEx44/Yr1Glq8t1VJnX818VhV/Krw39NYD11PLFs9OwMImdJAJz3xg2hJpAzbHRH2nbSbHqtBPB62M+2wi7s5fq4Je/pz7Fb+myI11Joxa0NH9ct0Nux9ePkrYy60JBf00x8h+0vvNvCzV5LJk30h3+mrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8VrFzic; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so6655804f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755087270; x=1755692070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeq4CBdJ33eLGBPTAe/oKglbRxjRK0CysJMq7Q73p2c=;
        b=j8VrFzicFRxsgvv9gLzFDpEehap5s/Odi/7tMwmkdsY/lDoIkr/jYPoVRvRmyGY4tq
         LBGQICT65LSCQCcdz9WtofphSGmmvyIEjUVcHQzrtcLSOBoNuK5m0fQdC91g0n/qhdya
         gZzuHpfFoC5yEO/vAEfFs0+Tlgq9etUsiAwUR1NBWK8eAEKtCOfTFfl0KGdoPx8i95lp
         T6HAmrEbk6qPD8OApmygFWpHUdVZNRTw/ODOhoaicCYhuVjRVHwV7jRw/Y57jUiJ7kPX
         t89fRw/gO3VvhMZ3chxvrgVuCHcMnAvNYmfQBYbGg5RBAXxHfFI48n+L/EEtBDVZ0hKn
         0esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087270; x=1755692070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeq4CBdJ33eLGBPTAe/oKglbRxjRK0CysJMq7Q73p2c=;
        b=jJmUa2jfQwYAVPofYwbHISHZnvjhnJTZsVHeP3AuogQp81X5sA5A1BiPTxEC3hVzxD
         gLQOc1cxagwCKsJJMXrSubH9vIklPl1Y2DZRizeYWzS7ZtyHaafIJbZ3fwKtxcFFVuEC
         PoUZOJCDqscY0nwUg2JYTQafh6MB3RXIRTZ9vRzNsy3aSZSnidzhNbHU1993HFcrJJKy
         6gYDR/VgW2eKjYX823q8ggU7MEG7Gt2jGmloZ9T/8XULGG//C+/IiTNGM1wsSGHMqbSN
         8PakviEj/Uq2Ol8B2cE313/6zI82cAy3wFItHEMMg+8M8KjCAcC9k0sDLImIpMKsoQef
         zFJg==
X-Gm-Message-State: AOJu0Yx4voBXnBdDic+u3kB7oKE34xP6KnvFRq4aH2iTsdA/5fSGSBo4
	2HUhmtc9E0MMZCIdsS2gK3ZgsZSs8vXdUw5kIiyB2QueqyR6JS0/ezyT5JEi3NFcEnQ=
X-Gm-Gg: ASbGnctfHVzYZoV2fUnzKOvlI6pNU8AsJxvWPI7+JrH6amVXaoeoxnFViYICn8xSDgp
	twV6wdnNGpSk5jp0oNXdHK3f8tWRVpbIgY01zSMQuGyn1yaQUd4+6tgOf1hOyJMsPfBNReNFuYs
	yuH5JPziccZa8LAthuVAL56SIEcFJY4R/NHxVfXf+L1awBMRN9ZSsFUlm3838fTCwLjUsfs3DrI
	D7/IpQgK0rGwStmMAST7NILqbArvNyuvcDLAJmQKplmYxrwJqBUlQECUlTXYMcZonoBHpwgl6xy
	ZOw1zsKRwXL7fKO24aNBKzlrnqlQ55gOYuUExyQ1Sj9SEhRX44oLhsSXSRUuW87HwORxr30mJiD
	5yHgucTSnBmt/5TB7LnvE0R7z/vIa0KN4mK6zsB2uvQ5QlQ9Jc9FatPX+a0TBcQ==
X-Google-Smtp-Source: AGHT+IHyp5XaCkuQeKAOWVK1H9tvy5xzJIEf5fUFD7JJ1dWWbo0bB0dFlilKV9z5VjkTyX2ZutLksA==
X-Received: by 2002:a5d:5c84:0:b0:3b7:88f5:eaae with SMTP id ffacd0b85a97d-3b917ec375cmr2297214f8f.39.1755087270033;
        Wed, 13 Aug 2025 05:14:30 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48090940f8f.68.2025.08.13.05.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:14:29 -0700 (PDT)
Message-ID: <395ffd35-65ef-44e7-82ee-25cd64ea4111@linaro.org>
Date: Wed, 13 Aug 2025 14:14:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: clps711x: Fix resource leaks in error
 paths
To: Zhen Ni <zhen.ni@easystack.cn>, Markus.Elfring@web.de, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250804123619.78282-1-zhen.ni@easystack.cn>
 <20250805035637.169422-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250805035637.169422-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

this patch does not seem to have reached lkml@, making impossible to 
extract via git b4 neither adding the Link tag.



On 05/08/2025 05:56, Zhen Ni wrote:
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
>   
>   	if (!base)
>   		return -ENOMEM;
> -	if (!irq)
> -		return -EINVAL;
> -	if (IS_ERR(clock))
> -		return PTR_ERR(clock);
> +	if (!irq) {
> +		ret = -EINVAL;
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

