Return-Path: <linux-kernel+bounces-787439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6176B37640
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0F11B61B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04A1BCA07;
	Wed, 27 Aug 2025 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QGWz+Jg9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC61C5D44
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255835; cv=none; b=aQQxHW8iMpgHvz4NK5OS3HCkx0vh5/9L7h9dNjO0RX73Uf5+xXT2x161AKXEPzfCwJauOR5pdg7bPpB1I5kFRT18Cgvox8o/5QxC7tRxj3ug23urgRw6DfH+s7yv8/pPIpKhj9leJRJEf56eVmY7zUjynBFXh/B+jh3Q7GTfh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255835; c=relaxed/simple;
	bh=jc2oRXhF62m0HmEZ4Sh6qy6cb37Rxe4E9F5U+bXM+lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F947pXjGvzMwRFfvIxXHRStBJ1VeBtdC6su7v2UYMw+CyEVOeN6wn4IaXXByX90oTQaHl4P2kPFENJ/NI4PZmvRCnzc32MpTiIW3NvcndNslfdt2IuBKN2pUWzvIxUOyAu+b5s4+o95UfpC78Wr9X0ysR6S1QvMEp8xqQpEOJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QGWz+Jg9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJjD1P010324
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	glRSAxJN2AjWW4WUDCqiAntJEGUI7+4xI5No65gXeBw=; b=QGWz+Jg9WDfLQN2c
	BExT4ziVIzeiROOd2pSbCpx3EI4kztUj681rCk8yjm8g1MHGEBW1qMrPZWpP4O0H
	cz2+UmVpzVa1WRSfpa8cUkx3Ag4brvEymHD72++v29IlHa8Qt/8LYdLwNODCTlfa
	Ffo42Xn2PD7WQOJiBsPcSKaV7IU8NdRn0zawaiprY3I53vM6m9meYkt/vfZ+H3Jg
	NzrYSEdtOWXAhYJDWUniJU3scpfXyHvBGJ7U5Ud0MBVFerfG9uQryLAwf2NGmefa
	ceFIz0Ag4peg5n2yt+nmbn9xOjRhK/iYfdkt0WOvp3o44G6395wRkKw6tuz4s/eQ
	q9hxlA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2tyev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:50:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445803f0cfso67958785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756255832; x=1756860632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glRSAxJN2AjWW4WUDCqiAntJEGUI7+4xI5No65gXeBw=;
        b=LYKb/KLz3VgeKez3jj+RRZvY5xgG+mLnpQqGOxMcTg7Nyu9+yiT6lH3P12enjpPDSU
         vg+GS9jED4j4CeZkZtwK4PQjcYFTGsLvfPNc3HR7dp3HCLlTK0Bpcpy+yiaOgQWfNZU+
         fMTQWcWRQ+bZ24Mf3OHRTRbNgcbKpZw4TAIwRVOEWzvKUO+uSDah7tyAftb0/WSXdtg7
         mgdgWJro6rdbSPX8nudttc7LodNfNYDm53VX7adIG1g7u3qMjMqLnfAwzDb+3JrDg5H5
         2tpx9n2SYAE8HzV7JN37kDw9pJuY6gIrH5/O6FRrDnCWFjpGA9KpXs3ZJgKtS8PYexlt
         DaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9cviZ9hS5aZYoAUjdtFDOgt1Sb26F8acrS2jomyS+9MRS/7Emaipo/gPhHRANbLw4m/qCAGtGOGtguiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpPYvEzjMVpzCclDFVz7ODNNX8doD14tAXweLs9PCCmFOG5X1t
	bX3b+aS68Z3qo1bsLnATuKSye3PbKuQj4NhJLaBcuEhtSxCcKYhUxQS2UUNAwFpxynrtaGUS4K+
	9PO76M77gmtNwd01VzqX96AYlhSKjIL1Nj6GQWgK+cnyTtHWpRLtWGEmI/c6vLhcHbJ0=
X-Gm-Gg: ASbGnct/VMr3yeGYLi1dxoG/t8ofrAMHrDbRaKcLTng9Gt20g9zMixt/a4C2QpZfOYN
	ChvSvavQazZHzo/tOY+rdaJyHi5PXp5b+fVLrcCReeaEKAd9iyXwCmOsIO4XQNzZh3XtKBgeX43
	NzwkxdHS+VrE6RxMPkqtmyCUricN8tjF4DsML1Vnpv2sjsPoGSBiF+gUr9RR2UcN4nr53ZWDy7x
	kmjedir6LaTJDMAzY+UcZa8E6MQ7zvHIBZBr8s1BhHTdgBVyvcLzJsDLI97ddgyMIau9uUwLGE9
	ZmMFwqAa/Zv9vd3BNNQGkGKMXVzYG3jQKk3A7oOyKesVmnIedXf3L2ga+8I9vtZSRNNsRn2+Etw
	6/csp2QuiGfqS+fhtaQ==
X-Received: by 2002:a17:902:e847:b0:246:d00b:4acb with SMTP id d9443c01a7336-246d00b54c3mr119968005ad.21.1756255831902;
        Tue, 26 Aug 2025 17:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwFC+uzN4UQKAUk+UDeEAr+1U4rJTdSanlizuzHOsK+hW/6Ls7ID3DQU9KNSI3l0wqsWk+SQ==
X-Received: by 2002:a17:902:e847:b0:246:d00b:4acb with SMTP id d9443c01a7336-246d00b54c3mr119967635ad.21.1756255831362;
        Tue, 26 Aug 2025 17:50:31 -0700 (PDT)
Received: from [10.133.33.155] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880bfbsm106922665ad.129.2025.08.26.17.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 17:50:31 -0700 (PDT)
Message-ID: <6378d925-5d99-406e-a7e2-0d2ebcb2f975@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 08:50:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] coresight: tpda: add sysfs node to flush specific
 port
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-4-jie.gan@oss.qualcomm.com>
 <3ac2954e-5663-4ea0-bc1d-a09e1992af5b@linaro.org>
 <a6be4d7b-d163-47df-9ab3-ca410f703555@oss.qualcomm.com>
 <939eb45c-f48e-40ce-86e8-710afa2b5c9b@linaro.org>
 <5df27be9-0347-49d1-ba1e-21d6a2172314@oss.qualcomm.com>
 <8f3a1f75-3476-47e9-a8d6-f396939b3240@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <8f3a1f75-3476-47e9-a8d6-f396939b3240@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ae5658 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0QyNbH6Kj7jDSduTYYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX04rJfzDc4sl6
 JzjK9JOi/aHuh6b50ADM/67bGsbxl2dpOKEVZjbKyh+WBJjZNh0VRsss4rJo9Hn/7ynRXARi3op
 ctm60bgZ0qg2tfbOFPTj4YbXnBL+7WKwH9PAkdNl76wOVOLhHnRZfyc9z+yTggg4zeUdLmGIO83
 4SH9OiuBgIgtbvDKQykULsLEe/MnbW/+c8qIIng8+yr2/RxLZp1GxpoIbz+7Cf7L0zKtmXi1Coq
 fICAFz/Wqgd/QY/Tfq201yYAoA5d6VSpd6zsDS5U2Ht7juXdVbCoxwuXvY0W1MIkPcjElwOMxqk
 snujoUVQQDPcWr4t8ASnitVeuhv0jV0oH4o+emTPDsTZRuf1qiVmRd4rb/OLNgcFugMl0wpp4D5
 ++rxjSUR
X-Proofpoint-GUID: okyc16w6R_TOHwIjPLJk5RLYgI94R_KK
X-Proofpoint-ORIG-GUID: okyc16w6R_TOHwIjPLJk5RLYgI94R_KK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/26/2025 9:29 PM, James Clark wrote:
> 
> 
> On 26/08/2025 1:11 pm, Jie Gan wrote:
>>
>>
>> On 8/26/2025 5:54 PM, James Clark wrote:
>>>
>>>
>>> On 26/08/2025 10:39 am, Jie Gan wrote:
>>>>
>>>>
>>>> On 8/26/2025 5:27 PM, James Clark wrote:
>>>>>
>>>>>
>>>>> On 26/08/2025 8:01 am, Jie Gan wrote:
>>>>>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>>>>>
>>>>>> Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
>>>>>> for port i, forcing the data to synchronize and be transmitted to the
>>>>>> sink device.
>>>>>>
>>>>>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>>>>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>>>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>>>>> ---
>>>>>>   .../testing/sysfs-bus-coresight-devices-tpda  |  7 +++
>>>>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 45 +++++++++++++ 
>>>>>> + + ++++
>>>>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  1 +
>>>>>>   3 files changed, 53 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight- 
>>>>>> devices- tpda b/Documentation/ABI/testing/sysfs-bus-coresight- 
>>>>>> devices-tpda
>>>>>> index e827396a0fa1..8803158ba42f 100644
>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>>>>>> @@ -41,3 +41,10 @@ Contact:    Jinlong Mao 
>>>>>> <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
>>>>>>   Description:
>>>>>>           (RW) Configure the CMB/MCMB channel mode for all enabled 
>>>>>> ports.
>>>>>>           Value 0 means raw channel mapping mode. Value 1 means 
>>>>>> channel pair marking mode.
>>>>>> +
>>>>>> +What:        /sys/bus/coresight/devices/<tpda-name>/port_flush_req
>>>>>> +Date:        August 2025
>>>>>> +KernelVersion:    6.17
>>>>>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>>>>>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>>>>>> +Description:
>>>>>> +        (RW) Configure the bit i to requests a flush operation of 
>>>>>> port i on the TPDA.
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/ 
>>>>>> drivers/ hwtracing/coresight/coresight-tpda.c
>>>>>> index 9e623732d1e7..c5f169facc51 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>> @@ -509,6 +509,50 @@ static ssize_t cmbchan_mode_store(struct 
>>>>>> device *dev,
>>>>>>   }
>>>>>>   static DEVICE_ATTR_RW(cmbchan_mode);
>>>>>> +static ssize_t port_flush_req_show(struct device *dev,
>>>>>> +                   struct device_attribute *attr,
>>>>>> +                   char *buf)
>>>>>> +{
>>>>>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +    unsigned long val;
>>>>>> +
>>>>>> +    guard(spinlock)(&drvdata->spinlock);
>>>>>> +    if (!drvdata->csdev->refcnt)
>>>>>> +        return -EPERM;
>>>>>> +
>>>>>> +    val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
>>>>>> +    return sysfs_emit(buf, "%lx\n", val);
>>>>>
>>>>> Decimal would be better for a port number that goes from 0 - 127. 
>>>>> If you really want to use hex then don't you need to prefix it with 
>>>>> 0x? Otherwise you can't tell the difference between decimal 10 and 
>>>>> hex 10, and it's not documented that it's hex either.
>>>>>
>>>>
>>>> Got it. I will fix the code here, and update the description in 
>>>> document.
>>>>
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t port_flush_req_store(struct device *dev,
>>>>>> +                    struct device_attribute *attr,
>>>>>> +                    const char *buf,
>>>>>> +                    size_t size)
>>>>>> +{
>>>>>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +    unsigned long val;
>>>>>> +
>>>>>> +    if (kstrtoul(buf, 0, &val))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    /* The valid value ranges from 0 to 127 */
>>>>>> +    if (val > 127)
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    guard(spinlock)(&drvdata->spinlock);
>>>>>> +    if (!drvdata->csdev->refcnt)
>>>>>> +        return -EPERM;
>>>>>> +
>>>>>> +    if (val) {
>>>>>
>>>>> If 0 - 127 are valid don't you want to write 0 too?
>>>>
>>>> It's 1-127 here. 0 may leads to an unexpected issue here.
>>>>
>>>> Thanks,
>>>> Jie
>>>>
>>>
>>> Then can't the above be this:
>>>
>>>    /* The valid value ranges from 1 to 127 */
>>>    if (val < 1 || val > 127)
>>>      return -EINVAL;
>>>
>>> But I'm wondering how you flush port 0?
>>>
>>
>> BIT(0) represents port 0 with value 1 and the default value 0 means 
>> nothing will be triggered here.
>>
>>> Isn't the default value 0? So if you never write to port_flush_req 
>>> then you'd flush port 0, but why can't you change it back to 0 after 
>>> writing a different value?
>>
>> We can change the value back to 0 but I think we shouldn't do this 
>> although I haven't suffer issue after I changed it back to 0(for bit).
>> Because the document mentioned: "Once set, the bit remains set until 
>> the flush operation on port i completes and the bit then clears to 0". 
>> So I think we should let the flush operation finish as expected and 
>> clear the bit by itself? Or may suffer unexpected error when try to 
>> interrupt the flush operation?
>>
>> Thanks,
>> Jie
> 
> Oh I see, I thought this was a port number, not a bit for each port. 
> That changes this and my other comment about changing the output to be 
> decimal then. Hex is probably better but it needs the 0x prefix.
> 
> I would also treat 0 as EINVAL. It doesn't do anything different to any 
> other out of range request so it should be treated the same way.
> 
> Then comparing to 127 isn't that obvious either. Something like 
> FIELD_FITS() more clearly states that values have to fit into a bitfield 
> rather than be less than some value:
> 
>    if (!val || !FIELD_FIT(TPDA_FLUSH_CR_PORTNUM, val))
>      return -EINVAL;

I found I made a mistake here for value range. 0-127 is for port 0 to 
port 6. But the TPDA device could support up to 32 ports, means u32 here.

So the mask here, the TPDA_FLUSH_CR_PORTNUM, should be designed for 32 
bits, like 0xffffffff.

Thanks,
Jie

> 
> 
>>   >>>
>>>>>> +        CS_UNLOCK(drvdata->base);
>>>>>> +        writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
>>>>>> +        CS_LOCK(drvdata->base);
>>>>>> +    }
>>>>>> +
>>>>>> +    return size;
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RW(port_flush_req);
>>>>>> +
>>>>>>   static struct attribute *tpda_attrs[] = {
>>>>>>       &dev_attr_trig_async_enable.attr,
>>>>>>       &dev_attr_trig_flag_ts_enable.attr,
>>>>>> @@ -516,6 +560,7 @@ static struct attribute *tpda_attrs[] = {
>>>>>>       &dev_attr_freq_ts_enable.attr,
>>>>>>       &dev_attr_global_flush_req.attr,
>>>>>>       &dev_attr_cmbchan_mode.attr,
>>>>>> +    &dev_attr_port_flush_req.attr,
>>>>>>       NULL,
>>>>>>   };
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/ 
>>>>>> drivers/ hwtracing/coresight/coresight-tpda.h
>>>>>> index 00d146960d81..55a18d718357 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>>>>>> @@ -10,6 +10,7 @@
>>>>>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>>>>>   #define TPDA_FPID_CR        (0x084)
>>>>>>   #define TPDA_SYNCR        (0x08C)
>>>>>> +#define TPDA_FLUSH_CR        (0x090)
>>>>>>   /* Cross trigger FREQ packets timestamp bit */
>>>>>>   #define TPDA_CR_FREQTS        BIT(2)
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 


