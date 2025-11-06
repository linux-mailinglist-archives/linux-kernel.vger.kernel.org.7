Return-Path: <linux-kernel+bounces-888722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A5C3BC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD941567FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBA32C93A;
	Thu,  6 Nov 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZi/m8mf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E530C343
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439052; cv=none; b=lPLItYa2xHHcrXmEqFTf7AH1pXuU/W2T3V++MTSE9PvVOZhOEXAvjvEtbw6xaNsGLKnY0W6A5Gf0HFumGjvwjYRm5xVwohNSz4U1wscEig+NchdinLsddFxTR4Wz4jMqhg+AwfnptJ3G8hOqJobVQcHEPMhOAUAfg3tEou11/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439052; c=relaxed/simple;
	bh=Ve2Cua6Y5x7JZiN/l0mkL2+le072jA+6HmVmFg2sMaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtdkxSGQCKq/fKBfAIJhb7BuHCBGIVp23VfWdsRwdLO9LslTknYJnO5RNd7tlIyFJV+xdO+YgmhlHhvUSwJgcbJ8u3k2fSSA12N0Q96Zd7g28xy7n6FDKNCUsMc9/+9vhQ2collE72qcsE8NjtFo60g8jxYjDDp4FVXwNKKUV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZi/m8mf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1142331a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762439049; x=1763043849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBGZoHNjV7rP3ZwyXMhZHV9qS2bMMg3F8+53EMom6ek=;
        b=lZi/m8mffnFBeO+dCMgynIiMynn+1qOrh0940Vz6Vjzmrx6xhd0CnKa+Pc46ifIz7N
         TldHB9x7QArw9BiFWNBKkbkFw86qfGW7YfXQjaU28cr5j5tsPZzurAh5g4Epr6F4Mz4m
         2yVQB11ZLFe6gPaKxMp2TqPQxQXpG/JFe6s3vszMZKXBeE/94cswixUyL3GLWft0LZ07
         hbeQFpUOnLH7QEw+1c6x5FJZUNKwoOroP9WsWlw2cJtduKvICdQHTzXPL9atZUTGy5Nt
         +T0jMep3eeQeljg+UxiQM0qps1sqGSUkLjPD9wWo5RbF+3x1R7xZM11TXtS8qf2DEZfe
         UvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439049; x=1763043849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBGZoHNjV7rP3ZwyXMhZHV9qS2bMMg3F8+53EMom6ek=;
        b=OCrV2l9AN6YDvmRhd043DbHD8lMjpc+f+C4GCtQZ8NzFNyqXbHUensCT9536+jlPkH
         D/aEQscarg+XgVPJG+tcaHTOPbb1KT/6EJjUm3j8aY8wJYqthSHgU/PDJ/eRTmCB4A42
         DglZs8HENLs0hwexwnoFF5NOan9m95Y6M1hent0QEeUFBmcc2g6KzbRzZq/F1H8dt39m
         jrtQK+NB+1rRPGSTVlxw7ModHeLubclczlmpX+8zhH2ChLg+bFcMmFABmXBe/6fYo7vV
         xBbiHYT3sgd+3r0EZwN6T9i9VTQqjlh68ii39r0hS42Db32hB+dYZpc+mGiJhmR7gjrp
         FuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVPGINfIwiSXrti4mIdWDFnwyrARZbnYwVvXpRws4vPLqbTe7SdtFBqKkKjcs+KE0/wlgHx6a3goJ0hC0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdUIi4UrPmDxgqAG4B38u7otCei8CQQA+6UFVdIH5qqeM3eL2
	mNYMT9B0VghGwEEz9OG2m5u8FSDouzwRjo8R+eOxyVsSq6vbKOkYvjXGeJE7UrgSxgss6s0eWUK
	hbu/GpmNGcg==
X-Gm-Gg: ASbGncv8UnbkSyx+92KGNmcd9B/EUiFoVC/8mi6vMmX9bOAE6FyS54QNQiyZ7tW+5xe
	w3pKmwE4FMGafWWfZrij3/4Q84KV/jhhxwHiwYICBnFJubQJz1yRfk/baPdCW5JaT/d3KkLHF/5
	5+8uoVAfMGrivU5LlFIqjyOl4e+ZgMBivlt1OhZsxk3Qf4XEqOGaoEQFHHAI5cgXaplCOwQm5/V
	qfMyuLkkj3XsK6RwhfJaZ4WHjftG6vGFVtlP38oozsxaIplgUEWoVtiJ7tO76txFomo2FbOIZeQ
	3r1JOp/lb15dJMgCF9aja5qeaa0yjfZB5TCqjeZfGCAaaIBEsK2ERV6p3Qv6s2cr6d5Y5r9MgUh
	B8pDVrKrewwaID01ABHZWLO7vwj9kq7UmkjSHyyKGBGuNk1EU2XdgTBO3Bc7mQuuk3OBfKheUyr
	xbTqxIsXOw4OswDVRWs5Cz
X-Google-Smtp-Source: AGHT+IFJQwc5igxE+SGlKDBP9k3w+n4h+84+Jq8CqIZHXI6J7F5RLEKhdKuk9mv4aoUzLxdAQAwT1A==
X-Received: by 2002:a05:6402:13c8:b0:640:fb1f:e95c with SMTP id 4fb4d7f45d1cf-64105a44b72mr6838423a12.20.1762439049121;
        Thu, 06 Nov 2025 06:24:09 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578dfsm1936167a12.24.2025.11.06.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:24:08 -0800 (PST)
Message-ID: <cbd2f040-9377-4862-ae52-aac35adb1b9d@linaro.org>
Date: Thu, 6 Nov 2025 16:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: Fix potential
 use-after-free in sama5d2_adc driver
To: Jonathan Cameron <jic23@kernel.org>, Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <90dec520a9537af2feab9d56b22d99878fba9e2a.1761705396.git.xiaopei01@kylinos.cn>
 <20251102115458.4d37556a@jic23-huawei>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251102115458.4d37556a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 13:54, Jonathan Cameron wrote:
> On Wed, 29 Oct 2025 10:40:16 +0800
> Pei Xiao <xiaopei01@kylinos.cn> wrote:
> 
>> at91_adc_interrupt can call at91_adc_touch_data_handler function
>> to start the work by schedule_work(&st->touch_st.workq).
>>
>> If we remove the module which will call at91_adc_remove to
>> make cleanup, it will free indio_dev through iio_device_unregister but
>> quite a bit later. While the work mentioned above will be used. The
>> sequence of operations that may lead to a UAF bug is as follows:
>>
>> CPU0                                      CPU1
>>
>>                                      | at91_adc_workq_handler
>> at91_adc_remove                      |
>> iio_device_unregister(indio_dev)     |
>> //free indio_dev a bit later         |
>>                                      | iio_push_to_buffers(indio_dev)
>>                                      | //use indio_dev
>>
>> Fix it by ensuring that the work is canceled before proceeding with
>> the cleanup in at91_adc_remove.
>>
>> Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> This ID doesn't exist in my history  it should be
> 23ec2774f1cc
> 
> I'll fix that up whilst applying.  Ideally I'd like Eugen to take a look
> but I'm fairly confident so I'll queue this up on the fixes-togreg branch
> of iio.git and mark it for stable.
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>> changlog in v3: move cancel_work_sync after iio_device_unregister
>> changlog in v2: use correct Fix id
>> ---
>>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index b4c36e6a7490..aa4ba3f5a506 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -2481,6 +2481,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>>  	struct at91_adc_state *st = iio_priv(indio_dev);
>>  
>>  	iio_device_unregister(indio_dev);
>> +	cancel_work_sync(&st->touch_st.workq);

Hi Jonathan,

Can we push to buffers *after* device was unregistered with
iio_device_unregister() ? Is that right ? Both Pei and I considered it's
not.

Eugen



>>  
>>  	at91_adc_dma_disable(st);
>>  
> 



