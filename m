Return-Path: <linux-kernel+bounces-826340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42631B8E3A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70103A9F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3477212566;
	Sun, 21 Sep 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="GDdRC9lW"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933602BB1D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481522; cv=none; b=o12LLmFqSkOc1rahabw1VkwcGuCatez6sm2fH8gerNS+GAcMJRPFxpXCMOZScvxSuO+Bw73+hCP+K1N7VJciDIBajFYPKd3Z6MmVF+d3kLI+0NzL4hOPixIlauPysZNM5Gp/bYRlVapExXerdj//vsib6KQFd3fkCd6oLNr0RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481522; c=relaxed/simple;
	bh=w8WpeZPhF8DveCAu9nZH5IdpjTp7dXBeqPT5tY/beCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmldzoSjYo8C5byrKIukk/zmm1n0UXu0pVrvcQly+5M5c36raSjIcHLQcufWoz46ovKxv7lRNuLJ48ewRIdT7/ObXec2podaYRiyVEYKyIyoS/28aZd3Mg/8ib0otIqR1saE3Inc32ZGKF/o1lWburWW2Qlh/femxvXzVm0JKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=GDdRC9lW; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8c3414ad27dso39015039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758481519; x=1759086319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3yODI1opb0jOanIEDnISA0XED16oP9HRbOj2aYoSYs=;
        b=GDdRC9lWUFU/0r1R6xNxj/Jg18JsAWosYt7yy5ahCmRQscTTJzn9tdnnFQbtB9+s2X
         zcgEETJQoicqyyIKs32UgbvWU7sLvgDEr0aq7QYf6+egOPnxlkMx8ypFaakRsihqVHfC
         jUaqCeq7Jh2nzBuriPpC0rTbvzikQzwXS/DLQI517LOOvUoedxPRBAAXyKzrDSsGSB1p
         uKynEJPbRwpHbnytOVOExJFktXCswwnSi/9kTXEQSDzxGiVeWOGgquQd5UZYPtvrkIYX
         Rj171LSCETrt189mM7G7DY54P1J1sh35rBmgjLkU9tkvCgsDqjBOo1mbZxxooliZi/52
         dOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481519; x=1759086319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3yODI1opb0jOanIEDnISA0XED16oP9HRbOj2aYoSYs=;
        b=H2Y/OeIgO0V2puXk57TvOeDI8yhqGgg2v9a3JBbjnONDZtouyXu8Sct55E5r4Sy3PH
         zzSQXHNjguMpFjWvDJ3vsMvwF7FD1WfcNm4ejCrY63gLsFChECPH5txGYBEue6O0/SFK
         6Hr8sypMio8uuLKfkzJGV8ha/R7dvbtj3Zs2ASvyV3slDH2vI9ukdR+0iBN9SKH6U2YX
         xJyqr8OfYWY9Dj8404E1uR5plrsmqqPNFF65vumysDUI8CFAWHwSMRAfJInTkGrrEj/j
         7NmoAzNdjJuW4FQE1OnOquvFg9BBWMFpuCzN3RvTkEHXNhkmJohNtKp1nvK2UMoXZY69
         KheA==
X-Forwarded-Encrypted: i=1; AJvYcCULU8JQt6Zndv6xfRyXJfKn0VaZcZdF8Wx+Z3Y7OeY9W3vs8agU50/By88Q1UfJQYUSSq0LzcF8qi5SuME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUEdE/dkBQIJ2IJnhw0qa9acCM2A6P8WclZXwawdd+G4EUZxG
	82nNfCa3GrR3396LpVKgn9dA5EF6rYsvYz7L2eKqxV17c41PauLyT+z/w7scXlAmlR8n21d51d7
	oapPY
X-Gm-Gg: ASbGnctj6l7yJa15Ypw0s2jBySFaeQvNdPh+WzaEDP4OJSY7ApwJamwYUHsd7CO4Vtn
	zEc7nma1TrfRyhKjiJan8yzHlH4W9Cx+k0FIRsA/vOtNBKKbov00sW3pJYqLPKni3p5enyv05La
	okbfxL6ZDmRuJJFd4HLjCHxa6U4he+YNUOaX5712q0G7ZQqPP8xveEWnqlcCax96sx66RcL7uXB
	851NuZFLzXT21FrgrQIHMwAFtMpmxjiE7vXdcJiq8pKRBVlU1xSrCLxbaW5yTxKGB+lyYXRC++3
	KxoB+rcPjXwmazN+P0GtL55q2nOSHU1vrpWfGc7Pwr0qXQAO7TYp6l6gja2nET8HRV0MVpg8RVo
	DhHgvOuPImAIWVvAvCIYtQzyqzLyJaKETkOXA7caHG6+n3jKVEnZBqdl2gyzKVyta4kz1U1HAIa
	nX5Dzj+A==
X-Google-Smtp-Source: AGHT+IEFYJsSo8XIdBpCssdirvu4z8vm7oDZUP42OyCCbdIOLRYBgINTidn4zPRPHizJvfN5lbHIOQ==
X-Received: by 2002:a92:ca09:0:b0:424:ed48:9acd with SMTP id e9e14a558f8ab-424ed489bb8mr86349525ab.27.1758481132441;
        Sun, 21 Sep 2025 11:58:52 -0700 (PDT)
Received: from [10.211.55.5] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a36aa66sm49663255ab.8.2025.09.21.11.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 11:58:52 -0700 (PDT)
Message-ID: <84c77e62-93f7-4a3e-8a86-7f653076bdcd@riscstar.com>
Date: Sun, 21 Sep 2025 13:58:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Vivian Wang <wangruikang@iscas.ac.cn>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
 <a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn>
 <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
 <411ade91-3fb5-40a3-baca-e6b03c5783ae@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <411ade91-3fb5-40a3-baca-e6b03c5783ae@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/25 1:51 PM, Vivian Wang wrote:
> 
> On 9/20/25 23:59, Alex Elder wrote:
>> On 9/19/25 10:52 PM, Vivian Wang wrote:
>>>
>>> [...]
>>>
>>> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
>>> +{
>>> +    struct k1_spi_io *rx = &drv_data->rx;
>>> +    u32 bytes = drv_data->bytes;
>>> +    u32 val;
>>> +
>>> +    val = readl(drv_data->base + SSP_DATAR);
>>> +    rx->resid -= bytes;
>>> +
>>> +    if (!rx->buf)
>>> +        return;    /* Null reader: discard the data */
>>> +
>>> +    if (bytes == 1)
>>> +        *(u8 *)rx->buf = val;
>>> +    else if (bytes == 1)
>>>
>>> Typo? else if (bytes == 2)
>>
>> Wow.  Yes that is an error that I'll correct.
>>
>>>> +        *(u16 *)rx->buf = val;
>>>> +    else
>>>> +        *(u32 *)rx->buf = val;
>>>
>>> Maybe
>>>
>>>      else if (bytes == 4)
>>>          *(u32 *)rx->buf = val;
>>>      else
>>>          WARN_ON_ONCE(1);
>>
>> The value of bytes will be 1, 2, or 4, which we can tell
>> by inspection.  At one time I had a switch statement with
>> a default, but I decided to leave out the default, which
>> won't happen.
>>
>>> Just to make the pattern consistent? Same for k1_spi_write_word.
>>
>> Consistent with what?
>>
> I was just thinking it would be clearer if the code states clearly:
> 
>      1 -> u8
>      2 -> u16
>      4 -> u32
>      anything else -> shouldn't happen
> 
> As is, it wasn't obvious to me that we're just handling 4 as u32. Maybe
> we're just capping it at u32, and 8 is also handled.
> 
> Well, maybe I'm just not familiar with SPI stuff, and word size above 4
> doesn't make sense anyway.

Understood.  I only know it because I checked.  And I do want my
code to me understandable, so I'll add a comment as you suggest
below.

Thank you.

					-Alex

> 
> It could also be a comment
> 
>      else /* 4 */
> 
> Just a suggestion, no strong preference from me.
> 
> Vivian "dramforever" Wang
> 


