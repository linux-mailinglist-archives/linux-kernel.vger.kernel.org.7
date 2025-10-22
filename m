Return-Path: <linux-kernel+bounces-864625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53ABFB344
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A26580F74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532B3054C8;
	Wed, 22 Oct 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8q4d/gx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044B299924
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126254; cv=none; b=IQF5vPkNnp54M+pRsClt9WOuZtx1X8cd6aqSAWHRlfGNVJ/2qOtyrUEEbwCFkQk6eKkfKtkm72d+4MyamlgDV89l5LA6/Qff0I6dIE437zG39ii3unGASCmBtPh5keQRyg7WNBwaR+0zBXKuqmtencFJUU2l1to1P28I05DTqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126254; c=relaxed/simple;
	bh=YSsmQnBs93MkLURrGV5cmfNkALdokMBbIl5S2URZs4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNUtVv+81ZY/P3CzxFIijt6Abg9AETK+MMhW7liwn4ejxg41Q/a4+WecPEiYP6hHhWg03bhsa9nbIA8XtTcNw4Xg2ZpbYyzS1ep0yYxaaN5MAL16Q8HujIQNtV+pj5Ypoxt5GRJe4mMrWVGv+s3c8CNMq2eyIWFwx6+krp8wrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8q4d/gx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47495477241so16245435e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761126251; x=1761731051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2q2OfszUqpeadKayMdXndWnS6PaM7t8jQzEItp97vM=;
        b=E8q4d/gxobhWW49fipSD2pu/EvWAHXJ/k3jj1gk9LLCCuemvkDrgHPszwGTcpjhyfj
         5WAnKahSBraUqXjuh/LlJ29vxFP6j4z2h7BzDZDEjQnIh2jBmIBPtHyq40n0JlQl6eex
         4gOmC3Y9iy5mGOvYiz+4IM+kgTfUEisGbQUsf7n1M8Bqz5rsW45AqtUPo/4UTMKatYge
         gGWvi5a2KamaGHRV6bIWzFs8wIVscgfDskauk9gaHir0JyYd7Q3wI/2oMOaVfy0e+gSb
         dAewPaMmLVG/6QxpB8zWowN+iHZtimW2NLyTGT0vKDAVtyV4Wef0sUKNpeFTWdQUX9pD
         bwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126251; x=1761731051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2q2OfszUqpeadKayMdXndWnS6PaM7t8jQzEItp97vM=;
        b=awNtrbUKzxGzVQmCwsUXcmwd9CSiznGEHJNGvuba8Z1JWDmfmbsCr7Swe0PXWAXERk
         4gTA+rmfC82tlIFWly4/nwI8rWtq/YOFnHDxPJaLdjXiUA0oY6/KuUfRpFmfN2XM3SVN
         Zb5CSGWTwkohexfpXA2QkT89H3qxh3WLJ9PTpzdbzJeJaJupef0lDSquvfrN5x2flQc+
         4I2b6gbMKPPRtaHwdgfL1oi6gKjkoJ5bbaUjnUbaV+O1sF6kVzJk0bXceWbu1p+SP57J
         4O0UKDe1VX3ZdSBpuNbx4GwiBQ3Fy+oR5zkEhBQAhq+PvCVbR/cspTid/r4HYBIjgZOK
         /yRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXboGu7dKU8+Xa1f3NvcC8KcQ6nNx8uwy8wF4OvMeBJG+ry4VdpVEllbVY71iM4u63byb3ZQx3yEh9NM+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZKzsj2Dh7Avzv8QvwPRo215aV8ZZUyqw8YIphRJxyFPe+r0A
	KHztpkayPwWcgdZDsCXWLhR9GmJaol7ZTTx4ZgxgbmtEDrkarXu9MIWDE3X0vId6VqM=
X-Gm-Gg: ASbGnctA5rx/GW1fp+bxqwVhUL+4tzRY38KMwvWlK21mqMnV1ipJ4fTV/BKcxPhk3NX
	+ouEAsC4yLqNihxST6EQH6r7C0NcaAKY7eso2EGRPh4pTgS7lItKZK1yOarnNPjrXrlWXPtLCXb
	yyOWbz+qQN0I8vYn1ydPD5Dpy5J6IR5wZ3lISTdaoMwa2O1Hx+/x8WmnbJd3pcjOipMogAFfrwl
	oEeuusGDStAphIXZtT8X/qqkAdZYYXgiAffEbMHTb3WuMI7/AZfH9wOlOUislC93QDRggAEg7+o
	J8Jk6QjXVPw7dF5C4hcDOv+err0/rPw9ICvJnqzCRKpcr+GFSBiV8bvflpHD3uRFsjgYILeCywO
	ZBnknzgAvTaM/76V/sG7GH4vbxQDHhVY+M+Iad9kDfqnyI75pozMZ3ICe/2BMXKJYVcG9VtrF1M
	0sFSOjHXqBjJZ9xDd3
X-Google-Smtp-Source: AGHT+IHyKNaFr6+KT+wcGuk5QcgPZ2E1s+s6FjRqi/hA/8rUpJL4cF8k2yXbn4dNu2GHhIteFm2DEA==
X-Received: by 2002:a05:600c:4e93:b0:471:9da:524c with SMTP id 5b1f17b1804b1-4711789e39emr140864945e9.12.1761126250776;
        Wed, 22 Oct 2025 02:44:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d26affsm32511685e9.12.2025.10.22.02.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:44:10 -0700 (PDT)
Message-ID: <3c6b723c-d3d4-4be7-9333-9ab46d270194@linaro.org>
Date: Wed, 22 Oct 2025 10:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] coresight: Add format attribute for setting the
 timestamp interval
To: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
 <20251002-james-cs-syncfreq-v3-4-fe5df2bf91d1@linaro.org>
 <CAJ9a7Vj1NnikoJyabXnad+=3SDULKCyqoZiNb_S66SkG+HD+dw@mail.gmail.com>
 <bfce6b68-783f-4aa1-b9db-d905230be609@linaro.org>
 <20251021172224.GO281971@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251021172224.GO281971@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/10/2025 6:22 pm, Leo Yan wrote:
> On Wed, Oct 15, 2025 at 04:19:04PM +0100, James Clark wrote:
> 
> [...]
> 
>>>> -static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>>>> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>>>> +                                      struct perf_event_attr *attr)
>>>>    {
>>>>           int ctridx;
>>>>           int rselector;
>>>>           struct etmv4_config *config = &drvdata->config;
>>>> +       u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
>>>> +
>>>> +       /* Disable when ts_level == MAX */
>>>> +       if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
>>>> +               return 0;
>>>>
>>>
>>> Returning 0 from this function _enables_ the timestamps
>>>
>>
>> Returning 0 just means that etm4_parse_event_config() doesn't exit with an
>> error. For ts_level == MAX we want to disable timestamps generated by the
>> counter, but we still want the minimum periodic timestamps.
>>
>> To disable all timestamps you'd need to have attr->config & BIT(ETM_OPT_TS)
>> == false. This is set by the "timestamp" format flag which I tried to
>> explain that in the docs change.
>>
>> I could also change the comment to say "/* Disable counter generated
>> timestamps with ts_level == MAX */"
>>
>> It's unfortunate that there are now two format options for timestamps. Maybe
>> instead of adding a second option we can change "timestamp" from a 1 bit
>> field to 4 bits, with the following meanings:
>>
>>   0:     No counter timestamps or SYNC timestamps
>>   1-14:  Counter timestamps = 2 ^ x. Plus SYNC timestamps
>>   15:    Only SYNC timestamps
> 
> I am just wandering how can extend "timestamp" from 1 bit to 4 bits.
> 
>    #define ETM_OPT_TS              28
>    #define ETM_OPT_RETSTK          29
> 
>    PMU_FORMAT_ATTR(timestamp,      "config:" __stringify(ETM_OPT_TS));
>    PMU_FORMAT_ATTR(retstack,       "config:" __stringify(ETM_OPT_RETSTK));
> 
> "retstack" has occupied a higher bit, we cannot naturelly extend
> "timestamp" field?

Easy, just put it wherever there is a hole. I think there's one in 
"config:4-7", but it could be put in config3 or config4:

  /* Old enable timestamp bit for backwards compatibility */
  #define ETM_OPT_TS_old              28
  PMU_FORMAT_ATTR(timestamp,      "config:4-7");

The position of the timestamp field is published and tools read it, so 
as long as we don't change the name of it it works fine.

We only keep the old bit 28 because we know old Perf was buggy and 
didn't read the bit position, but if it wasn't we wouldn't even need to 
do that.

> 
> Even we can extend "timestamp" format to 4 bits, it will be mess when
> run the updated perf on old kernels.  Let's see an example:
> 
>    perf record -e cs_etm/timestamp=0/ -- test
>    perf record -e cs_etm/timestamp=2/ -- test
> 
> Because the lowest bit is cleared for both timestamp=0 and timestamp=2,
> the old kernel support only one bit always treats these two setting as
> timestamp disabled, or the perf tool needs to do extra checking for
> old kernel.

It won't be. Old kernels report a 1 bit field and Perf errors out if you 
try to put a 2 into 1 bit. Very old Perfs just set bit 28 which new and 
old kernels will respect.

> 
>> Now we basically have the same meanings except you also have to set the
>> timestamp bit. Seems a bit pointless.
> 
>> Previous versions of Perf were hard coding the timestamp format bit rather
>> than reading it out of
>> "/sys/bus/event_source/devices/cs_etm/format/timestamp" though:
>>
>> -       /* All good, let the kernel know */
>> -       evsel->core.attr.config |= (1 << ETM_OPT_TS);
>>
>> For that reason we'd have to leave that one where it is for backwards
>> compatibility. If it's set it would be equivalent to the new wider timestamp
>> field == 1.
> 
> Are you suggesting the timestamp field to be extended to two
> non-consecutive fields?

No, just a new 4 bit field in a new position.

> 
> For me, this is even worse than current two discrete formats. The reason
> is it is complex in implementation, and it is not directive for usage

I really don't think the implementation is complex. We just extend the 
field to 4 bits and make 0 off, max is the lowest rate possible, and 
every other value in between is in between.

> (users need to digest the field for three different semantics: on/off,
> counter, and SYNC mode only).
> 

That's like any enum, it has multiple meanings for each value. I'd argue 
that two fields for the same thing is more complicated because now this 
won't work out of the box, and it would work if we did 1 field:

   perf record -e cs_etm/ts_level=2/ -- test

There will be no warning, but no timestamps either. You have to specify 
both manually. And the only reason for that awkwardness in the API is 
that we added a new field instead of extending the existing one:

   perf record -e cs_etm/ts_level=2,timestamp/ -- test

> Thanks,
> Leo
> 
>> I don't know if there's any precedent for changing the bitfield that backs a
>> format field, but presumably that's the point of publishing them in files
>> rather than a header.
> 
> 
>>
>>>>           /* No point in trying if we don't have at least one counter */
>>>>           if (!drvdata->nr_cntr)
>>>> @@ -667,12 +674,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>>>>                   return -ENOSPC;
>>>>           }
>>>>
>>>> -       /*
>>>> -        * Initialise original and reload counter value to the smallest
>>>> -        * possible value in order to get as much precision as we can.
>>>> -        */
>>>> -       config->cntr_val[ctridx] = 1;
>>>> -       config->cntrldvr[ctridx] = 1;
>>>> +       /* Initialise original and reload counter value. */
>>>> +       config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
>>>>
>>>>           /*
>>>>            * Trace Counter Control Register TRCCNTCTLRn
>>>> @@ -762,7 +765,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>>                    * order to correlate instructions executed on different CPUs
>>>>                    * (CPU-wide trace scenarios).
>>>>                    */
>>>> -               ret = etm4_config_timestamp_event(drvdata);
>>>> +               ret = etm4_config_timestamp_event(drvdata, attr);
>>>>
>>>>                   /*
>>>>                    * No need to go further if timestamp intervals can't
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Regards
>>>
>>>
>>> Mike
>>>
>>> --
>>> Mike Leach
>>> Principal Engineer, ARM Ltd.
>>> Manchester Design Centre. UK
>>


