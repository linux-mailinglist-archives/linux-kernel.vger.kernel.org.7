Return-Path: <linux-kernel+bounces-871630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D7C0DDC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E842007A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01D2C11D6;
	Mon, 27 Oct 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Mrdusd4/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC12957C2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570080; cv=none; b=uGBxSU3u0mglUjDeD/0fyW/+LgTwzNA0SjkBFSBKHCK1mFybVNIprQaPICMncfvpSOMa5GuThw8vX9q8WSTj4pPCRMEnZRf1LyyVF51pHTcWAE205q6xXmhepm0o2j/CXsCGMt4GW5m1szaJpNCPjyHybEuk5+SpLUBSgTuGYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570080; c=relaxed/simple;
	bh=986YysIn8Fe1HXmKjFlWdhnJPvdFAuoGinhshsvQYEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgwIDatxE7Mcv4vRzIqSuO7mTXZ0+tBnSV8lpy+v9sJ3o6nNEI7qhbM7d+O5n+YW/0mcwzvVZTeJUdLXv0oF3tNXTWXjIX6fRrs+9gKbq5muyDxfV7uFoagipJFyK8IX0aJjFk0h1JW9WcNVJeQ0k8wO6TEo9R/QWl3zXb28SOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Mrdusd4/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7810289cd4bso4596716b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1761570077; x=1762174877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jhqQbXCqzrcL3E+XppIF1w4lMrJvn7tFwhW0pKGsNs=;
        b=Mrdusd4/UrHujgfIM3r9y+6fHUre8j/Vk6SV+/p1jSR893iCoGBRnKgKAAw97QS6Qo
         Sq0LS5AQzWrHZYRCw+vxwpxeu1PnH9q9sXs6vx9TUbLQqovrBd73ac4abA03sI68fd5V
         1plCq2miZezlAPOnSFNWn5upPFO4KtPHs4XVEvXMkZfCAuP9vZq6s54Y25iIdc4iERKh
         6nvxfXDfy0rrvoOE61czW+p53S93Ixltx1YxVlZESLMlHQ/jZqpBV1mi+Yzq9oHCfazs
         jAOtdvu/+gX0qxJ/esm511fMTkFd9GNTWb5o6p8EykNOe06EibYxrYLpJkTzYbFAxJ9q
         RzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570077; x=1762174877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jhqQbXCqzrcL3E+XppIF1w4lMrJvn7tFwhW0pKGsNs=;
        b=vj9AM7T18ZhWWyuasAZPSm4Nvt9NZ7Oqw2yPuCpm0KNzr8K/4U/DogWRltunrorMVI
         59P6n6V04mY1LRCQn2lWEctmozLnE7XOAxZ8yNmUavhlhsqeUGYIIVYs5AZu4WoNUkZe
         sVZs/e2pfp95ve3xXmPoFfuBccfge4kh28bkO5DOUEn1k7Iy6VAKEneFpbpyyMOx6CZo
         sEDj+QYiHBFfVCKqzzka5j4T5am24uk5kiW/eX6s95TKHbScH63xk1+6MZhz2prC6Jhh
         Gmu5hVc327bRTzaLzqEGTrCr1sLndxvWqD+UYP71LNqeK4UZAymj1CaBZkUIHIkaMTJI
         9Mgg==
X-Forwarded-Encrypted: i=1; AJvYcCXlduPgqyanUNGqX/lQQ5B2LMDQYeSoHXn6sFCrRGvMyBXOqRkerKND74JYGD88sXgSzHS4EukrcL+HSoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbDO9OphaVA53qOkFQXQjCII+LAymTnkrgwkkQBs22bjHSH/h
	xZuzOy+gcY65dcIT7n/EKY3NVd4pPrPQJj6HSWkOi91+IpAesVjETLT/l5B99RiBR5A=
X-Gm-Gg: ASbGncufHC7DKXqKqxqFLPfQnlV3EzF44ZA3FPIvkwyw0zkcd0gNTWpIKxEgX22js5o
	L9n3Det+Maux4CP97qbj2Z/tnUoa0lfu+Yxxv3AskFJAhAoaO4DZilDgzP7/JyZJy8Km+1LcYeC
	G5ltxTJeF58mcYnmC0bOL+fj1hm2BF9WEFxEClRroBgD0+VUe4i0JcID4UF8n7AWEY8ZnOl1U12
	vvUzU+4L/uW7QceDhQZ0eNJiYOgS4NVMxnK3llRsyn4e88MOncmY5KK2MSRR/Omm0ratXtmh38l
	fv6HbNctQceTgen1czNWqo5b8J+Ip0jsD4+JIBzoaVKA3yXsPWZXZuHfuiRnV6YQPFYbg9DClNv
	A7Ii9+05PhW3CN0isoyAlvSba/VcSU2BPOGqnVOsQ6gcSHIj9Ya0xsPWmwWgRjyFtY5FdhjZxcE
	hsCaLhZ+KrZq8TplQbM3hJeLLhxNSPAj98ikPq08I2iX9Ulgi//HVB/T+IJTcYaWjZJm4=
X-Google-Smtp-Source: AGHT+IFz597Y7d5Kn0G6bkVUP3oCOfoggvomYjxgDPnOcMBnKIl/JIfYJkpaxyKj8FEWIIYpt3UWbg==
X-Received: by 2002:a05:6a00:8c5:b0:7a2:8853:28f6 with SMTP id d2e1a72fcca58-7a2885329f8mr12142180b3a.22.1761570076019;
        Mon, 27 Oct 2025 06:01:16 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm8034589b3a.35.2025.10.27.06.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:01:15 -0700 (PDT)
Message-ID: <301aff96-5565-47cf-b519-27234ea53ea8@tweaklogic.com>
Date: Mon, 27 Oct 2025 23:36:32 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: light: apds9306: convert to use maple tree
 register cache
To: Chu Guangqing <chuguangqing@inspur.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, javier.carrasco.cruz@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024073823.35122-1-chuguangqing@inspur.com>
 <20251024073823.35122-4-chuguangqing@inspur.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20251024073823.35122-4-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/25 18:08, Chu Guangqing wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>   drivers/iio/light/apds9306.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 389125675caa..7e68cca0edfa 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -350,7 +350,7 @@ static const struct regmap_config apds9306_regmap = {
>   	.volatile_table = &apds9306_volatile_table,
>   	.precious_table = &apds9306_precious_table,
>   	.max_register = APDS9306_ALS_THRES_VAR_REG,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   static const struct reg_field apds9306_rf_sw_reset =
Looks good. I will test it on a real hardware soon. Thank you.
Jonathan will know more about regmap internal implementations.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh

