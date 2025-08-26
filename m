Return-Path: <linux-kernel+bounces-786372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D0B358FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8171B62444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048D2E2EFC;
	Tue, 26 Aug 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Op29AEhl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5B285061
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200832; cv=none; b=S4/9e0QI2m61GJ87lXA6n5ft8XXe03yaJZq/EZcWSasTmiKYDdlLXxxZUz+xGd/RlBleMAKaeu1D1XfkYZ78+/eZOZmOUhTCBN8C945DZ7rz6CdhS3knl3oZqeBmcVFGgNKSjjUcuxo69GCI3dm5jundt3fCikAO0RCEfZZ2RyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200832; c=relaxed/simple;
	bh=QYV5NwJ7S/Pv6MoEiV/OzrLPtIUTRn+KUFr5Afov3o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ued+nI7M0T34YmOlojGbCCahTpxk8jYI7wcGDZFF3dMpFanenjCKBUr9jwZ8YDqaiWAqIq/7bl1yxQw3QGZV/OSEPZj43ZST+iLKzcWgm/ywKUW2wPnPiqVLD4eo2PxMsOrsRPFnZHjvnUOAtO98/AblUU1/DuWEImEAXew9Uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Op29AEhl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q3xVB9005706
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7PRqUbPyyCeb0D+drQmqPy+hroCqwBFq8MUVQmpsI88=; b=Op29AEhlNe32ev8n
	pP0Xo6Se44beRsXEF6g2AX2RDuWrPBHIybbgvraTAdpH1fMA9mclyNOm97gtnaBm
	+F+ZJ1tTcrwC76TDHeP6L4bjZJwogYr6L0IxRA5U2mLp+sQnWDo349vm+Znbn0UB
	lQU/xLmzWD+8IqWoo2qQpbNy2AncVVNoo4+YjJmj9abdDqdQg04+8QHet14qeKFd
	Bh5WO8ahS5fzfx/Fuq4dY5eO+jLGc0SXfeDzE1KBNwNhQ21ZhIE0a6oRmBeQhrJi
	N0rMqgIpoUjaZ8oPMgJZP/VxTjcUPWq4PxPJglRAT8fvw/Bh7xsCYYhKlr+WIOBQ
	5sKx9w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpetma7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:33:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771f28ed113so1129321b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200829; x=1756805629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PRqUbPyyCeb0D+drQmqPy+hroCqwBFq8MUVQmpsI88=;
        b=C3GWefjd3jQxxfAfOZ+1jYW2+WQZdSOm4Px2uaYPwjbhud4GPuiF5X65WXVlLfOQrc
         7/33a6frNaCkVZbubJ5kpWqmky2FUtNz6AWQOifBJnIwXB2bsMci1fwOF7TX3WZrzHGe
         fYWmAHuUsNIih5xXdZQyGTgpqbBK5q2T9g3oz6u6M1GFMXVFbErWkpSPJ2X3HymgQEfc
         Nc/aPP7SFWa4+2/bB8TjJaS3A4kNS7DtkaL77MMuNE6QPxCGfFHqK45bUO3z6jWgfkzv
         ivUdWfhkGs5xghWB6yHrAofAmCGuNJENT/rK1zSR+/nzYydtbPj+4UU27r/jjYI9jgjB
         Fykg==
X-Forwarded-Encrypted: i=1; AJvYcCUrJOQUNOVpIVjHOQHzSUw6XPSr1eKeEfk0/YFTgq2k2ZOsmGHXSSg1hPKEh+RegwAuJG1QViAkdUcmXbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgahLMKbVWvCBtJF9uuCpBNSEJmBUv2YXOKiQ2FH3MY9lZXqC
	nsxs+vLZwOQIIKhPWEoy5BWY8Yva9sBmkZpWpFGXPthQGt04k1NemWek8WubesqYU7fI/3U8kxa
	0BZZN87omaD6NFbk6SA0UWZmLpu7vGz8rhqJr9+UFRefeqGNQzAv9qE4q1Hc8XvDAk1Q=
X-Gm-Gg: ASbGncujXutFbCH+2zkU0+Amu2quIjS5aYlXbwpT8MptxGHpwWTyU9X7+AzVV9/kkgY
	lcXwUN6W0SpzCpfVt7u2mhqw/FpUwOxmxuAIk6nIjCwBOqFczFzJdL5ZQzKM2rddYKjYK11CbTj
	1Atqn6uBucdwsdtsNTLxTs+Uzoes5s7ev0Ma+IO4WXjlXoJKr3hoy0wPJpS/Rb8KwoCgwNhqm0f
	g0U3FuIEtnJu2vYj4P7keeOc2xLTQ/biqQhj/DIdJOlOf1GqgBirWYbaOJw+lK5Gtudk4kOkZL5
	L+qmZwFUP92gTp+pMDvjg54qZ2vuj89abYFrfPQ58r3jO4CcXPNUShgLOgM4jHW6XKIFpUdKVeq
	TjljR/YX/F/l1iLC0GA==
X-Received: by 2002:a05:6a00:1953:b0:771:e4b0:4641 with SMTP id d2e1a72fcca58-771e4b04bbdmr7079022b3a.1.1756200828955;
        Tue, 26 Aug 2025 02:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsBgxQWCd0jMdTxGmaxKcluUUwbnejxoC4///CnAcNcxNaawFjaqarQErR5g1XYtLdTugzLg==
X-Received: by 2002:a05:6a00:1953:b0:771:e4b0:4641 with SMTP id d2e1a72fcca58-771e4b04bbdmr7078981b3a.1.1756200828432;
        Tue, 26 Aug 2025 02:33:48 -0700 (PDT)
Received: from [10.133.33.155] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ee83092dsm3325259b3a.100.2025.08.26.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:33:48 -0700 (PDT)
Message-ID: <c78a157f-d8d8-4647-8a2b-4409489633db@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 17:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] coresight: tpda: add function to configure
 TPDA_SYNCR register
To: James Clark <james.clark@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-3-jie.gan@oss.qualcomm.com>
 <66cfff9c-e0ec-4171-b62d-80d6139c42f3@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <66cfff9c-e0ec-4171-b62d-80d6139c42f3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5n_taNoSMu7NW2svDI8YrU92ZGpehnIf
X-Proofpoint-ORIG-GUID: 5n_taNoSMu7NW2svDI8YrU92ZGpehnIf
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ad7f7e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PWyc2w4wzOwSXG3kJUsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX22ySmDXf6csz
 pUYn2oPezd0ijQTpLII57Myv6x62SQGR9e3SiE9V2OApCkx4pjxtSuuKvzuTtvq/I+EkRh1wIY1
 qyecsebeQGzk7EW81amZhofSMd0BWYcfdvLL1NNyOQxN+8Kl0J9PsP/dlhSRKWh5Y6GszqIedK5
 sU7iGLK6+lSTQrWTCW6hnLAXM9UA7ahm8VHKuQ6IiwD/TcF5fpP2Hvw4SgM+UI1U/O5rMlOVIlc
 +vz57weGL3X09z2rErKn22sz9jsNN5p8DFVQAQ840j3zsfEAS12Ks23bGjDvARG7eUrZCLyMtoM
 gXzNmlqE6NRn/SbvGZHGU8MtRlUCYBtZsgDPwx5Ykf3lNQ8/y3H5Yrm6iGWQnqjFZLonM4Sri9H
 mm7lvp/H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142



On 8/26/2025 5:20 PM, James Clark wrote:
> 
> 
> On 26/08/2025 8:01 am, Jie Gan wrote:
>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>
>> The TPDA_SYNCR register defines the frequency at which TPDA generates
>> ASYNC packets, enabling userspace tools to accurately parse each valid
>> packet.
>>
>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 15 +++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h |  1 +
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>> hwtracing/coresight/coresight-tpda.c
>> index cc254d53b8ec..9e623732d1e7 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -189,6 +189,18 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>           writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
>>   }
>> +static void tpda_enable_post_port(struct tpda_drvdata *drvdata)
>> +{
>> +    uint32_t val;
> 
> Minor nit: this is inconsistent with u32 used elsewhere in this file.

Will fix it in next version.

> 
>> +
>> +    val = readl_relaxed(drvdata->base + TPDA_SYNCR);
>> +    /* Clear the mode */
>> +    val = val & ~TPDA_MODE_CTRL;
> 
> &=

Will fix.

> 
>> +    /* Program the counter value */
>> +    val = val | 0xFFF;
> 
> |=

Will fix.

> 
> Defining a field would be a bit nicer here. Like:
> 
> val |= FIELD_PREP(TPDA_SYNCR_COUNTER, UINT32_MAX);

That's better, forgot to use the proper Macro. I will re-check all codes 
again to update all possible fixes.

> 
> Assuming you wanted to set all bits, and 0xFFF isn't some specific value.

Yes, this field has 12 bits and we prefer the max value to prevent to 
generate too many ASYNC packets. This field indicates a count value for 
number of bytes. Once the the count reaches the number, a ASYNC packet 
will be generated.

> 
>> +    writel_relaxed(val, drvdata->base + TPDA_SYNCR);
>> +}
>> +
>>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>> @@ -227,6 +239,9 @@ static int __tpda_enable(struct tpda_drvdata 
>> *drvdata, int port)
>>           tpda_enable_pre_port(drvdata);
>>       ret = tpda_enable_port(drvdata, port);
>> +    if (!drvdata->csdev->refcnt)
>> +        tpda_enable_post_port(drvdata);
> 
> Any reason this can't be done on tpda_enable_pre_port()? It has the same 
> logic where it's only done once for the first port.
> 
> If it can't be done there you should add a comment saying why it must be 
> done after enabling the first port.

This register only affect the port which already be enabled. That's why 
we add it to enable_post_port. But as you mentioned, we can put the 
logic into enable_pre_port without side effect.

I think it's ok to move the logic to enable_pre_port to simply codes here.

Thanks,
Jie

> 
>> +
>>       CS_LOCK(drvdata->base);
>>       return ret;
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/ 
>> hwtracing/coresight/coresight-tpda.h
>> index b651372d4c88..00d146960d81 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -9,6 +9,7 @@
>>   #define TPDA_CR            (0x000)
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   #define TPDA_FPID_CR        (0x084)
>> +#define TPDA_SYNCR        (0x08C)
>>   /* Cross trigger FREQ packets timestamp bit */
>>   #define TPDA_CR_FREQTS        BIT(2)
> 
> 


