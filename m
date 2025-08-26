Return-Path: <linux-kernel+bounces-786418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9FB35990
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF5685CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788D338F32;
	Tue, 26 Aug 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvIwaiB3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D1322557
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202091; cv=none; b=TTooNx4G7RSHbMhVlCZgDwVlR2revwZvbZ8Myb4BiXMZJlLZH7ZQe4ZpbP5c40cOtjdnGEp/2MH7m1Xu4M8WgJkDpt05y2aUM4Y8f/kWdads+sd/kBDa6JInoNSk1+t0bOsIdKeOJzqqTBJZObhYH3SeIYmFZson/G+mfA8+fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202091; c=relaxed/simple;
	bh=v7/kKb/3aDjXYCuij46PTFlucQHPMuyf1vHAbBKqwlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4S2WYFrgyB/CAKR2tw+Q/MORzR0wbRYHKBMwdREMA5vguc6MfvVzcn9/GnI6EpI3fMj4OlcGtr7BDv4PJLEUz2Cp/SrWD9LbMK0Rf8L9QnLxro4rkmYiwquVhxfpcXSBslBZaH18knFCVEiN265W4m/5FlXfm48iRfFeQuj8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BvIwaiB3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso31362665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756202087; x=1756806887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUhR3N3wo9t0MMX9pMVCs5MuCLAFXYwayYcG32x3UPw=;
        b=BvIwaiB3ApraeEUVeqXAIpyuyBFeYNj86TAYXtwqr78zxhohzsfIJkkIC6IXIH6jhn
         zni831BZ8yaXlIiolqDxggqhv4qSOmSXnJ32a8GGB9A+6z6KbB6W7EM0z7OiXSl3ra6I
         gFnqvXy1e8dyEpZ9nwgsMG0GanBPLnoAcMUbZfvOu64gtezOJ1aqgxfnedMIEE9uX73k
         krDFpWjpUBNV6NoCxpFwrKU95QPLLIfnS+nQbJB1oCytzPFHitSTtthXU9I+OpPwwHwe
         VFNOEysSaLIaDOvFe8VStOfH6Ul6kRhJHm9tI8OSQ4oiaY6IEbcSnTHfhfHKXAcHqGOQ
         2NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202087; x=1756806887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUhR3N3wo9t0MMX9pMVCs5MuCLAFXYwayYcG32x3UPw=;
        b=FFdK04KOxgIc8lJFvWUnjRGP3C50DbBZMpXZl9LHb4j8YevjpbJLhm8l+KZAioNV12
         kWKj4L1PvkAJxx9e7iq3q5zZspzhz0J4Eo2DqzzTt2Abt75UlYk8Mug4JS+vHLb0Lj9G
         m/CCh9ilCol71cKX0Di38n6A2RMGf4IY87fH3ChH3afLZu9RkyHwV3kQxGYPsbFb4MX5
         lOoMXdEXDzfL1iNm2TA8vaB8aUbIv1vNFzXlPRuHbZAgf2J97ZI64jaXKGRS5KZDhnyT
         GkhR9cO+csvj8cS+TPJJYOjRLr2gzpDTxjNe6KymUSmuRnemle53lSTnf6j7R0GNaAQU
         8Knw==
X-Forwarded-Encrypted: i=1; AJvYcCVhQWucVfRlbxLxgIycGspYEwJGqL1eDVRctY06inIgwzWQdjlFon5V1CT8j7xzS+mS/W/fdjc77zpe2+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8A98koC5OsU6qArMocUtPCRkd3hSP/b/Gs+xlEuLEAG2IRZF
	aFgdNolxeN8zqqoPjzt2genMWSHlpUV6zBmxkzYseehb2SyWuU9zIHr96+keDC2NEY4=
X-Gm-Gg: ASbGncvlSuDKVGRGpXX0oH9AXLEEjclO8+4ug2jfm2pb5OH5IO5cEeffhQ9g2w5YkoD
	AywRL9lXJf5bmN3VGylPQIuQL5zybl/yLoVxlocLPtWGMcX2sYmOiZwGGpCtsaKwpPCsWuClOLo
	Q6rqiC4z7ma3LKCaT2nu28oAiQ2/Ocy7T+c6+8zn5t/b38dsszsuZIFvKRF6DZsA+t0l43A+zF5
	S1dP1HiPkpVCbxH614XZCNBxIqnTXTz35uURNaWN4EukdFjwFTVRSiRX6ux9M72kG+pTBXGxHp5
	iLdKxu/KnZBwbWlt3Fg1UDWOA9YwUHbkMi1MCJ2g226bfHEvu1oKKFChG3mNf9b52lXW9SMCcfp
	uIvEFggxJQ8bXZ1/b7pDligqtpyo=
X-Google-Smtp-Source: AGHT+IG5d6hpblOKT6s7Wm3ZNawcMOjmqDBLGNn2fTe92R0dESnXpKCTH6m7G2x/JchotdGo9PM5Cw==
X-Received: by 2002:a05:600c:1c0f:b0:45b:6365:7957 with SMTP id 5b1f17b1804b1-45b68bc7a0bmr7707245e9.33.1756202086662;
        Tue, 26 Aug 2025 02:54:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5744a587sm145919205e9.9.2025.08.26.02.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:54:46 -0700 (PDT)
Message-ID: <939eb45c-f48e-40ce-86e8-710afa2b5c9b@linaro.org>
Date: Tue, 26 Aug 2025 10:54:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] coresight: tpda: add sysfs node to flush specific
 port
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-4-jie.gan@oss.qualcomm.com>
 <3ac2954e-5663-4ea0-bc1d-a09e1992af5b@linaro.org>
 <a6be4d7b-d163-47df-9ab3-ca410f703555@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <a6be4d7b-d163-47df-9ab3-ca410f703555@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/08/2025 10:39 am, Jie Gan wrote:
> 
> 
> On 8/26/2025 5:27 PM, James Clark wrote:
>>
>>
>> On 26/08/2025 8:01 am, Jie Gan wrote:
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
>>>   .../testing/sysfs-bus-coresight-devices-tpda  |  7 +++
>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 45 +++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  1 +
>>>   3 files changed, 53 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>>> tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>> index e827396a0fa1..8803158ba42f 100644
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
>>> index 9e623732d1e7..c5f169facc51 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -509,6 +509,50 @@ static ssize_t cmbchan_mode_store(struct device 
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
>>> +    guard(spinlock)(&drvdata->spinlock);
>>> +    if (!drvdata->csdev->refcnt)
>>> +        return -EPERM;
>>> +
>>> +    val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
>>> +    return sysfs_emit(buf, "%lx\n", val);
>>
>> Decimal would be better for a port number that goes from 0 - 127. If 
>> you really want to use hex then don't you need to prefix it with 0x? 
>> Otherwise you can't tell the difference between decimal 10 and hex 10, 
>> and it's not documented that it's hex either.
>>
> 
> Got it. I will fix the code here, and update the description in document.
> 
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
>>> +    /* The valid value ranges from 0 to 127 */
>>> +    if (val > 127)
>>> +        return -EINVAL;
>>> +
>>> +    guard(spinlock)(&drvdata->spinlock);
>>> +    if (!drvdata->csdev->refcnt)
>>> +        return -EPERM;
>>> +
>>> +    if (val) {
>>
>> If 0 - 127 are valid don't you want to write 0 too?
> 
> It's 1-127 here. 0 may leads to an unexpected issue here.
> 
> Thanks,
> Jie
> 

Then can't the above be this:

   /* The valid value ranges from 1 to 127 */
   if (val < 1 || val > 127)
     return -EINVAL;

But I'm wondering how you flush port 0?

Isn't the default value 0? So if you never write to port_flush_req then 
you'd flush port 0, but why can't you change it back to 0 after writing 
a different value?

>>
>>> +        CS_UNLOCK(drvdata->base);
>>> +        writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
>>> +        CS_LOCK(drvdata->base);
>>> +    }
>>> +
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_RW(port_flush_req);
>>> +
>>>   static struct attribute *tpda_attrs[] = {
>>>       &dev_attr_trig_async_enable.attr,
>>>       &dev_attr_trig_flag_ts_enable.attr,
>>> @@ -516,6 +560,7 @@ static struct attribute *tpda_attrs[] = {
>>>       &dev_attr_freq_ts_enable.attr,
>>>       &dev_attr_global_flush_req.attr,
>>>       &dev_attr_cmbchan_mode.attr,
>>> +    &dev_attr_port_flush_req.attr,
>>>       NULL,
>>>   };
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/ 
>>> hwtracing/coresight/coresight-tpda.h
>>> index 00d146960d81..55a18d718357 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>>> @@ -10,6 +10,7 @@
>>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>>   #define TPDA_FPID_CR        (0x084)
>>>   #define TPDA_SYNCR        (0x08C)
>>> +#define TPDA_FLUSH_CR        (0x090)
>>>   /* Cross trigger FREQ packets timestamp bit */
>>>   #define TPDA_CR_FREQTS        BIT(2)
>>
>>
> 


