Return-Path: <linux-kernel+bounces-800728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA6B43B39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50BF1C81039
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D52C2361;
	Thu,  4 Sep 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYEj229U"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F12ECE9C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987902; cv=none; b=H+BkZhUEC8u0xpXs/Ax1+3dlDyyG1dj2iIWETo0rTwQ+bcOiHnmvTT0VmWZV7fsDMkn60n/m7OqjS2PxJCvrBJCcCcGV/ILK7tf9F1hEQ6CW1G9e0PMpGDpnkh/GUIagkkXHh+fAGXg+0kC4wQ3KuTtYJ6PGyIjAprGeu5jtxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987902; c=relaxed/simple;
	bh=zydhTe8gN6sFNO/q1H4Gf7hszjD67Iz9ZJKdkVlHEps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pkJpumxIzjf93kXvGY9kMQqCovXQvBeOU/9r+ejZntRkj7Ci60+tP9hv9LBM2wSTIJgPBMDo9GvNiOhiAsKlVReYbCCcJYBWjkE6/xNtf0LNQRscL5PZJDzqtS568mqP4cytbWSxhsGOZ6Ft1IvW0PIJfMGq1QqLrUpAgnF0HN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYEj229U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so6236925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756987899; x=1757592699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYoM3cK9vBeAs2c1rKLSFJjbhLQMxUGOsX7iDRX0aTM=;
        b=PYEj229U2xa4GIjKeq+/6vWxNV9Kyq+SCqkZ3V2bQdeXt9vEGbZaCPPkz0gPD6qQmZ
         8RPUoPs2AFvD/J32KBj+FL4eyN/YYeSGH/3H0zfOmX1oRlmhC0kx9ySwjwSsmaFl0tJn
         d0PdmDmngwfpzVnzktTyU2IJMwIVA6xiHdXAANshh5qRDgPgzBNX2Z99GRhxOjGulZaV
         2if/U8dw6tUriHDD+fXLVaRY9D2NE4N/dhTCX3S99QlvsQ6utmzhCjH7iXzJ+mPybDLf
         H12Y3/yj4isXlOXCOBybQBpx25V8jiYGpNx0GSESwNBqaC+KqQTelldM5ih+/ht8hTGV
         ko7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987899; x=1757592699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYoM3cK9vBeAs2c1rKLSFJjbhLQMxUGOsX7iDRX0aTM=;
        b=tRjlEjCLhjqO1nUweY8ddd5X2Rm6nrAfBwww9NT3k8q4vE/vDMKp7rHLPJEewrjArt
         58pdhTe9xeqNwhSbntOLv3CaVuf2LFM6pVe4u3ef8YG0i1Y3tg2dEvfMaul/AYiOlM40
         E8BAKc6hlYzF4aoF1Znpfrh3WfZs92UPOgGuzStIBBQLi5OagKK8DTiiPWM9ioxGbgOv
         hfmlIemnvcYo1h/Oi8wOuTboZE46Z80Wpw2P30FImkfi+CF1MnkHjlorH2DnJwp0GnT/
         vYEK1V+0JLJZRpO0ZLtXVM0lp2Rm7/wTFpt0uT7pifeyqs/p7Go0MSPHioLcZVZVK7NA
         9mcg==
X-Forwarded-Encrypted: i=1; AJvYcCWuHhtNQ7/tWYHLeZ1Ra42iQ3eIhH7Bqtg19jWrca84t0NlR8pVFMX8Ct+MQSSj31JiTFnEg3SsvzyWgN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKjvvx08DPorwhhZ1+XJIs3rPVcy/cvAkocsil7FljC2OIy9l
	lWQ4qX8qMXo+mRBOAtEQOD4/to2Ul+ZwAkaLZKJuIayMr6DKbjsLO5G+0g1W5mmhKRU=
X-Gm-Gg: ASbGncumKWjHPkcyThUbLOYf8addibg1spMeRfsQc8zXssMLo2hCHBWzxrBhc2tD3jV
	IRTMNzf4/4qqCCJxjc9m3qYYbiFtECMgLfepfP7bqCC3yL0nYbOOe/ICvOu7UCAVD/588tGxTE0
	nC26y8fO8z33vLA/OjHZ1KEdlXROUUXPNmwgUObPM4yklJyuIrIr2XG2xkMWzK61KW9fy1+CLor
	Jc5HtNsKaXYchApCqLAUE9ukhQPHYRaevQwwruldTQC8bmt/fI9Z//wAyOJfHcnlzSCpy1tMUc3
	Fx2dm1IeRQtXT/7UM46rLzsLWYt2c4WwCBnWBfHIz3Bd2wOJq24kLqYiH5GG528Kkz8UILRgPms
	yYwWxwRkpa8MPF4wXv2FbaclOUaALYXkrbdvr6A==
X-Google-Smtp-Source: AGHT+IHQdXm8jC8e/msUJOyKC0lFFG5gg0CFfpvTp2PimVT6WH5aqg4j0JgEmA/4HZ8s1gbZTUkx4Q==
X-Received: by 2002:a05:600c:4e44:b0:45b:80e4:4e1a with SMTP id 5b1f17b1804b1-45b855fe92bmr149416845e9.26.1756987898546;
        Thu, 04 Sep 2025 05:11:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm312836545e9.5.2025.09.04.05.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:11:38 -0700 (PDT)
Message-ID: <20cec516-1589-4fc5-ac07-06029f2dc143@linaro.org>
Date: Thu, 4 Sep 2025 13:11:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: perf: Fix pointer check with IS_ERR_OR_NULL()
From: James Clark <james.clark@linaro.org>
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com>
 <5f24d286-629c-404f-8e0f-aa01e27bcb80@linaro.org>
Content-Language: en-US
In-Reply-To: <5f24d286-629c-404f-8e0f-aa01e27bcb80@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/09/2025 1:00 pm, James Clark wrote:
> 
> 
> On 04/09/2025 11:53 am, Leo Yan wrote:
>> The returned pointer from .alloc_buffer() callback can be an error, if
>> only checking NULL pointer the driver cannot capture errors. The driver
>> will proceed even after failure and cause kernel panic.
>>
>> Change to use IS_ERR_OR_NULL() check for capture error cases.
>>
>> Fixes: 0bcbf2e30ff2 ("coresight: etm-perf: new PMU driver for ETM 
>> tracers")
>> Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/ 
>> drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 
>> f677c08233ba1a28b277674662c6e6db904873dd..440d967f5d0962df187a81b0dd69a7d82a8b62ba 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -198,7 +198,7 @@ static void free_sink_buffer(struct etm_event_data 
>> *event_data)
>>       cpumask_t *mask = &event_data->mask;
>>       struct coresight_device *sink;
>> -    if (!event_data->snk_config)
>> +    if (IS_ERR_OR_NULL(event_data->snk_config))
>>           return;
>>       if (WARN_ON(cpumask_empty(mask)))
>> @@ -450,7 +450,7 @@ static void *etm_setup_aux(struct perf_event 
>> *event, void **pages,
>>       event_data->snk_config =
>>               sink_ops(sink)->alloc_buffer(sink, event, pages,
>>                                nr_pages, overwrite);
>> -    if (!event_data->snk_config)
>> +    if (IS_ERR_OR_NULL(event_data->snk_config))
>>           goto err;
> 
> I think the bug is in TRBE. It's the only one that returns an error 
> pointer, but only for -ENOMEM which would normally be NULL for alloc 
> type functions anyway.
> 
> Also it's assigned to event_data->snk_config which is later NULL checked 
> rather than IS_ERR_OR_NULL in free_sink_buffer(). Maybe that path 
> doesn't happen, but all instances should be updated anyway.

Oh sorry I was only looking at the update to etm_setup_aux() so both 
functions are covered. But the other points still apply.

> 
> It's much easier to keep it as NULL and make the fix in TRBE. It also 
> wouldn't need to be backported as far.
> 
>>   out:
>>
>> ---
>> base-commit: fa71e9cb4cfa59abb196229667ec84929bdc18fe
>> change-id: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf
>>
>> Best regards,
> 


