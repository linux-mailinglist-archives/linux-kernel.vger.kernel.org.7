Return-Path: <linux-kernel+bounces-788098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61FB37FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273285E1281
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD11322774;
	Wed, 27 Aug 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ir2shk5D"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6552877DA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289767; cv=none; b=K3yWatp5LjxR5QN/1cnlxDQ3M1tUPzLxroBApAHVSypW8Y/Rjt8df66WDEmhHziLbO8q8fJI42RaFgwsICLgs1BAHsRHqE3r5DYO9Q+qfiLObO2c1Bx3rTVcpA+A45vXQhaksDYc2RMAF1GyES7wSINijsnJvxrCBmCgdP35GNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289767; c=relaxed/simple;
	bh=p3f+mzSQvuTAA6R9g1jc8HAhyKZCEh6wbqX6AbTopoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaLO0+9FLUmA+2ZwrVeibP2rDe6FRG7ykKTUwRiqhbfZC7zpcKoZZgHMZPBtshNtIS/vnQObAQTA07s+13Gqe7yB8BCltBE9K6VKxdW/SbLf6v46qRBlVMi9OP2YfUUPlEfJWZmCug6bwiTQ21qraZ3UP1sds/iqH9K4W1fjjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ir2shk5D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so36798995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756289762; x=1756894562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1Dw90QlXeLsOzAEqypsdzJHvGAD420d9Q1/z4Sh4TQ=;
        b=Ir2shk5DnE+4oG+zVjCO/nLW1lDjE7d5ZsoH3XyJNmyfrs8IHA96UOb39NLtWzRHqs
         eiuyptJ0j5yluaI+/vsZkkEcCShUBFjLZjzwFRy1WTeEmB/H0v38UBY/VzCPN6fIYsvC
         yqE4AOooyc519mF33tDhJQulvUjGi/bqkcnGYRYYzy+wMYW8/8kaMLLKE0WZYY7N719C
         lm0RtuDsuxCC/RpM3/2m08zEDpKP7TooA885s8BH9594gvBHDrVnoh8w5OcJ5R/i2E5e
         hAtGHIZJ39RCG6YQ0bOzVaZLQQzfPkjwZ/b++ixY51BTAjJSILzK1rdHtc00rOyO4tM4
         SYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289762; x=1756894562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Dw90QlXeLsOzAEqypsdzJHvGAD420d9Q1/z4Sh4TQ=;
        b=ma8e0QCu7AeyW403rDc5vIObvyY43Id6baKg73kERNqHtqe+aSKWvWvoAV7N+KVHcm
         33xFf1RLYZ4G0x/MwR+xEPCP0nv0DJWgjZ9dgG71geA1AiDBnEWD7Cof0ZHNjnWQhFkh
         XaB0oPMxFVKyqHj/8f3VhQKGD43mlsW7ab9ml3iu7YLF0SImGByJ3e5mObKUqEas7jm5
         +x/UwHgPH2kqUF77ogFI+OuHuXnMBX5/CNV5U99R8YtCndSckf/e53ZRaSubtQfYFPcD
         pi7Pvojx92m/YXDXSZOqlW83MjSugjV91vLCRPA6zy87DKUD+a40lZHBWjIB0FPNFcgB
         /how==
X-Forwarded-Encrypted: i=1; AJvYcCXqTgBQycKgYl+ineuCBVfb44ofQb27algH5P+K6n1v38I24Updh4zQvrf2mL9ndWLG7ETjUqM4pKedjSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6iANZdPRTXF6IA4/KtnipfxjmzvXs9j6LnK+aYh4sqwi0YSF
	oROfSXhPVV4qXJWeVZJ+KD8hAjS3HPVb8deVNOJ3M88HzOgp+xWjXXn342cTlTxn+0M=
X-Gm-Gg: ASbGncs/X343CuNUhCdISTqqc4w2rDpCKWMtSR/qNcssmdFGlG2iGk4QE/CMNbdDgAL
	/eok42HM0IkJH70pcYqKd7iQ8zNvC7YHThHWu0SaA6SavyXBKdecWeLgGWGQbOObw5T4sYJ401e
	suGqegFozt8NkPiiTizpli5mJ3pd/aYDGSYQqhtMcbF3oDK5UVT7+DP6XkQ17pAxqEe+JrpuF3N
	/aV3d9ax877Kas1eNKWUn9e5FTTmBBC8KzphAHuktkZp/ciY9U3KjZRT3iAljSCwJ4Q8Yk3T8zP
	8gtQ3+xECAiVfh8/s2HlpAmBo7M4wrrbFdx4EqowfpHSVC4XJBsQ7wHfAmzJ/voZ525+LnYVUV7
	JqqHvHlghZoBadrS3eG51eWo4fnVfR2Hbihacyw==
X-Google-Smtp-Source: AGHT+IGsDBxLcBzPHHU2PS5TGpLgmGzal6Fc/PpQk1ENqWTdXvkIRY9ehvzlf+vR27NlOBpNheomEw==
X-Received: by 2002:a05:600c:3149:b0:456:28f4:a576 with SMTP id 5b1f17b1804b1-45b517dd9a3mr143701635e9.27.1756289762374;
        Wed, 27 Aug 2025 03:16:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f4aa8a0sm24318175e9.12.2025.08.27.03.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 03:16:01 -0700 (PDT)
Message-ID: <bc337e7c-42e7-4e2d-8b2d-c39174d1ddd5@linaro.org>
Date: Wed, 27 Aug 2025 11:16:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] coresight: tpda: add sysfs node to flush specific
 port
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
 <20250827042042.6786-4-jie.gan@oss.qualcomm.com>
 <b1f79a26-97e1-40f4-b076-51d5c2abe736@linaro.org>
 <78d2ab99-f304-4fab-bc7b-859c8aa781d6@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <78d2ab99-f304-4fab-bc7b-859c8aa781d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/08/2025 10:48 am, Jie Gan wrote:
> 
> 
> On 8/27/2025 5:17 PM, James Clark wrote:
>>
>>
>> On 27/08/2025 5:20 am, Jie Gan wrote:
>>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>>
>>> Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
>>> for port i, forcing the data to synchronize and be transmitted to the
>>> sink device.
>>>
>>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>> ---
>>>   .../testing/sysfs-bus-coresight-devices-tpda  |  7 ++++
>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 42 +++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  2 +
>>>   3 files changed, 51 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>>> tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>> index fb651aebeb31..2cf2dcfc13c8 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>> @@ -41,3 +41,10 @@ Contact:    Jinlong Mao 
>>> <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
>>>   Description:
>>>           (RW) Configure the CMB/MCMB channel mode for all enabled 
>>> ports.
>>>           Value 0 means raw channel mapping mode. Value 1 means 
>>> channel pair marking mode.
>>> +
>>> +What:        /sys/bus/coresight/devices/<tpda-name>/port_flush_req
>>> +Date:        August 2025
>>> +KernelVersion:    6.17
>>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>>> +Description:
>>> +        (RW) Configure the bit i to requests a flush operation of 
>>> port i on the TPDA.
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>>> hwtracing/coresight/coresight-tpda.c
>>> index 430f76c559f2..8b1fe128881d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -487,6 +487,47 @@ static ssize_t cmbchan_mode_store(struct device 
>>> *dev,
>>>   }
>>>   static DEVICE_ATTR_RW(cmbchan_mode);
>>> +static ssize_t port_flush_req_show(struct device *dev,
>>> +                   struct device_attribute *attr,
>>> +                   char *buf)
>>> +{
>>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    unsigned long val;
>>> +
>>> +    if (!drvdata->csdev->refcnt)
>>> +        return -EINVAL;
>>> +
>>> +    guard(spinlock)(&drvdata->spinlock);
>>> +    CS_UNLOCK(drvdata->base);
>>> +    val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
>>> +    CS_LOCK(drvdata->base);
>>> +    return sysfs_emit(buf, "%lx\n", val);
>>
>> Still missing the 0x prefix
> 
> Will re-check rest of the codes and add prefix. Sorry I missed it during 
> the review process.
> 
>>
>>> +}
>>> +
>>> +static ssize_t port_flush_req_store(struct device *dev,
>>> +                    struct device_attribute *attr,
>>> +                    const char *buf,
>>> +                    size_t size)
>>> +{
>>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    unsigned long val;
>>> +
>>> +    if (kstrtoul(buf, 0, &val))
>>> +        return -EINVAL;
>>> +
>>> +    if (!drvdata->csdev->refcnt || !val)
>>> +        return -EINVAL;
>>> +
>>> +    val |= FIELD_PREP(TPDA_MAX_INPORTS_MASK, val);
>>
>> Using FIELD_PREP() now that it's the full width of the register makes 
>> less sense. Especially when there is no corresponding FIELD_FIT() 
>> check,   which is fine because everything always fits. But if you 
>> didn't know the mask was the full width you'd wonder if the check is 
>> missing.
>>
>> I would just write val directly to TPDA_FLUSH_CR so it's simpler.
>>
>> It should also have been val = FIELD_PREP(...)
> 
> Yeah, it should have been val = FIELD_PREP(...) here... sorry for the 
> mistake here..
> 
> I was thinking the unsigned long here could be 64 or 32 bits and we only 
> need the value of the lower 32 bits. So that's why I am using val = 
> FIELD_PREP(...) here. We shouldn't write a value greater than UINT32_MAX 
> to the register.
> 
> Thanks,
> Jie
> 

writel_relaxed() is always 32 bits though so it is a bit confusing if 
you truncate the user value without an error. Also a reason to use u32 
instead of unsigned long types.

Are you trying to support arm and arm64 with tpda? Or just arm64? For it 
to be consistent you can use kstrtou32(), or use kstrtoull() and then 
FIELD_FIT() to error on truncation. kstrtou32() is probably the cleanest.

>>
>>> +    guard(spinlock)(&drvdata->spinlock);
>>> +    CS_UNLOCK(drvdata->base);
>>> +    writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
>>> +    CS_LOCK(drvdata->base);
>>> +
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_RW(port_flush_req);
>>> +
>>>   static struct attribute *tpda_attrs[] = {
>>>       &dev_attr_trig_async_enable.attr,
>>>       &dev_attr_trig_flag_ts_enable.attr,
>>> @@ -494,6 +535,7 @@ static struct attribute *tpda_attrs[] = {
>>>       &dev_attr_freq_ts_enable.attr,
>>>       &dev_attr_global_flush_req.attr,
>>>       &dev_attr_cmbchan_mode.attr,
>>> +    &dev_attr_port_flush_req.attr,
>>>       NULL,
>>>   };
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/ 
>>> hwtracing/coresight/coresight-tpda.h
>>> index 8e1b66115ad1..56d3ad293e46 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>>> @@ -10,6 +10,7 @@
>>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>>   #define TPDA_FPID_CR        (0x084)
>>>   #define TPDA_SYNCR        (0x08C)
>>> +#define TPDA_FLUSH_CR        (0x090)
>>>   /* Cross trigger FREQ packets timestamp bit */
>>>   #define TPDA_CR_FREQTS        BIT(2)
>>> @@ -35,6 +36,7 @@
>>>   #define TPDA_SYNCR_MAX_COUNTER_VAL    (0xFFF)
>>>   #define TPDA_MAX_INPORTS    32
>>> +#define TPDA_MAX_INPORTS_MASK    GENMASK(31, 0)
>>>   /* Bits 6 ~ 12 is for atid value */
>>>   #define TPDA_CR_ATID        GENMASK(12, 6)
>>
>>
> 


