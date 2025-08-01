Return-Path: <linux-kernel+bounces-753093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A17B17E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D620A1C80CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8331F1505;
	Fri,  1 Aug 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvEWBrki"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626F14F70
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038100; cv=none; b=bif6e9NXrgERqWp8V1XpNRmqzCEUZ3TQty+6jKxn8RE955Eil2Ijk5ohc1OlDeM6Li9vNqdNFPPWTjzGomHllrHGXrgHhsd865wkN8B3PPJqIY407ElQS65cwuA1mqM1O0Tv53KHq8jLNjd6UAbBKdZCxFXYWxZWnC+hWDy8ED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038100; c=relaxed/simple;
	bh=Ab/9ekGOFKhGsvoeeB81KfMj9HqllcvmGNHTsUsUQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGutDrcdEIidPtNczcCcgpZTUuWL4D7K2a/kRkkPRStFjejlWiKasLwrp9LYnLL6NzYze3ocePmEuEw67HPnrYnag+Yd0DLb9Czv7Ze7dcxPnG+yGWPshI9UMNsBYSjh0i4mm3FY5XmicSZ9V7jMCia4EWR7ygQe12nYUoXLVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CvEWBrki; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso18939535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754038097; x=1754642897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4doTruynK4hSlJayLuCs8HsdKgFMRfqRK4twIg5Cnfg=;
        b=CvEWBrki9QuKcj/qlMHjmDalTs/Uzl43vSkt+f+ifffp242KZiFKy5m2F8QGTweKOk
         /nXOoMAkl9ZEv26loo24dZQnsutICLzPUTuPV7JN8sreFyqhi9dmhTC6AnjwnOJgGcFm
         dtiei0SmEEMp4OBtSirvcwe0LONs9BzqAT7D32WF6UQ48+z3V6IXSxWBvUc9h8qeRLZC
         tI67hNdMI0oP/m3yJgo+7qu/pIi/q7KyW/eaevSPR+6YYbQUoBib1PTn397lRAt7nBrs
         p9BfX4xkyAMcW2F3vQYAtHSZ67ybGra3Gzi2xtku/8AtrfV/0VN0OlsVGeJ4+AXetLmw
         skfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038097; x=1754642897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4doTruynK4hSlJayLuCs8HsdKgFMRfqRK4twIg5Cnfg=;
        b=VrzP2k9J5yyv9NFyzMrIPXcTTM1oaAKIHm/R84I9vN7TjO+JptF/+NW6HfcYzWxylv
         EqAo1nW8K9FD9IGbBnX4Ew+siavAJpO2Fu49WzzNFL+yKwNXmRxaDQIehg3EDMAkwiyI
         OG8a+wKSAwvAm7qTGwb6/mH7lqBYc1iNXXsVpOXAoSkXBfwzQObwY2Ufm2Lb6j3Hazfr
         K+9GOG3bb9dzUyzsJVLQN9aqSU6TDCJd79InMXz17wcoM/y9gnten85AUKq/J1p5wqUU
         EXF1zE6VpfoZOQal1L9YavINTLJ+2Jdupebk35XnNHidci/RnKzWlzfLViV7FyzkCjXa
         WCjw==
X-Forwarded-Encrypted: i=1; AJvYcCVCJndeY/4/8dMc5cS1TAJ+yX/29teJslgUDQBLGt5T+JEo81TYxY7funF8f0aqZi0UvxhfRiKvoZj2L6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIO8MjBJwezzlY02aqR9GywLBfOr12FlfKDxqmdCk2nnQMjxef
	0LRtkRoFl/jTJtKL122jlBwt5jg1V3zsRO+lxd0IgOcaKeNkwtYsHChzZMDmzZgCUZo=
X-Gm-Gg: ASbGnctJW5Bt7GfjnJTnfJaK1yphwVj736PJXsS0hT2FyL2jPZG30jdgOPl6nhSs0Nw
	D+9q8X0euUOrxIKNQtL7sZVgPA3L5Tn99RC588ThtBKRkgbZqFXeLgRX69FYdRJIO6nnzTQQDyS
	ij3KZgmEgjPJ76NyfrCnT+UO2khspOo7TvZNBcqsglTmqy/Svz+dYIQx66jMVnVgl5R3BfV7qWJ
	UTfZlVZTDg37oEJSPN8ZZdcpz9gU5zHDIjNyT95LCcVEu3vTJWxljUz569+fjWZnF7PANAFHzU0
	4ehv349KqU6msUF/nswrOGu/+owj4MQ9qvS+6GTe853JAPxbNQqvqOplqH2RwY7usg8jS05q5BF
	+Ls2hU533PIGvPMwD3Obui1URYlM4AkWqcbEA9IIOfqNb6YvsPDg2Y7uuMlGGbg==
X-Google-Smtp-Source: AGHT+IF3BybuUmbZNIhWtVKXh55EqXDzDgzsuFqzEHgiJVMPrnXOE0/NSrVCweHbAPXZ6FYLoZ/1lw==
X-Received: by 2002:a05:600c:4f12:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-458b01c1d09mr7712995e9.8.1754038097141;
        Fri, 01 Aug 2025 01:48:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589ee57a95sm57131685e9.23.2025.08.01.01.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:48:16 -0700 (PDT)
Message-ID: <16ef6d7b-127f-4d68-b1bf-ea9051751036@linaro.org>
Date: Fri, 1 Aug 2025 10:48:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] clocksource/drivers/vf-pit: Rename the VF PIT to
 NXP PIT
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-19-daniel.lezcano@linaro.org>
 <1aaf4a2d-ee3c-40c9-b808-204ee61a2335@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1aaf4a2d-ee3c-40c9-b808-204ee61a2335@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 09:35, Ghennadi Procopciuc wrote:
> On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
>> The PIT acronym stands for Periodic Interrupt Timer which is found on
>> different NXP platforms not only on the Vybrid Family. Change the name
>> to be more generic for the NXP platforms in general. That will be
>> consistent with the NXP STM driver naming convention.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/clocksource/Kconfig                             | 9 ++++++---
>>   drivers/clocksource/Makefile                            | 2 +-
>>   drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} | 0
>>   3 files changed, 7 insertions(+), 4 deletions(-)
>>   rename drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} (100%)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 6f7d371904df..0fd662f67d29 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -474,11 +474,14 @@ config FSL_FTM_TIMER
>>   	help
>>   	  Support for Freescale FlexTimer Module (FTM) timer.
>>   
>> -config VF_PIT_TIMER
>> -	bool "Vybrid Family Programmable timer" if COMPILE_TEST
>> +config NXP_PIT_TIMER
>> +	bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
>>   	select CLKSRC_MMIO
>>   	help
>> -	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
>> +	  Support for Periodic Interrupt Timer on Freescale / NXP
>> +	  SoCs. This periodic timer is found on the Vybrid Family and
>> +	  the Automotive S32G2/3 platforms. It contains 4 channels
>> +	  where two can be coupled to form a 64 bits channel.
> 
> Checkpatch:
> WARNING: please write a help paragraph that fully describes the config
> symbol with at least 4 lines

Sounds like a false positive.

> #29: FILE: drivers/clocksource/Kconfig:477:
> +config NXP_PIT_TIMER
> +       bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
>          select CLKSRC_MMIO
>          help
> +         Support for Periodic Interrupt Timer on Freescale / NXP
> +         Support for Periodic Interrupt Timer on Freescale / NXP
> +         SoCs. This periodic timer is found on the Vybrid Family and
> +         the Automotive S32G2/3 platforms. It contains 4 channels
> +         where two can be coupled to form a 64 bits channel.
> 
> 
> total: 0 errors, 2 warnings, 0 checks, 25 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or
> --fix-inplace.
> 
> Commit 1e9876740925 ("clocksource/drivers/vf-pit: Rename the VF PIT to
> NXP PIT") has style problems, please review.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

