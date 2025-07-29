Return-Path: <linux-kernel+bounces-749417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA4B14E05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2067B0026
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C513B58C;
	Tue, 29 Jul 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptyRps1r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439EF510
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794125; cv=none; b=U6WujRSPcGtVHgFucbwUUyij1RwuJRdWapssxn2UzHfzpRj+PZnUOAzEaKqJA3H1A7nRn5+Um6wkCcjdFCcSpNI7yEFOZl9sTvgtgYQCK9AkUtMvk4et4h4A5Ex/dQU2vBrD9/d18Asupuvya8FG+ZYCjTJvgZqXx8j8GWftAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794125; c=relaxed/simple;
	bh=VNG4d0MTvleX4tYg5mr/JKAvLnfAPWjFKhL4Ysw/WFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqsgw+FVRLqpmfao0Z6s+Q2SDjbJxZX/15t3MbYkmci/+NSOh5ApYtlVyd27+tt3zT11NM9nm5lDuoHg/qJTjHDbyScityADgbhjcENbsdmH1McelRTfZlrgXD4SuaUgWOieqAtChpdFJidhGVqUAm0GUDVy0eeFXAFQB8cLapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ptyRps1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T91nU8023447
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	juelwFjR0xLghnG+f+9iPeOqQI/44lFNaWH/bAdlNAM=; b=ptyRps1rY0xMNoXh
	EOyXS2PpTv3+wYuRo1OUBzUHolaxzWKMLyVOlWyJcSeLFMlw2EtahowaE+jQM4KY
	qmQxb+aq8T4/gR1VKVTXhKAF35ySBOXxrDowLNNUCmdITgbaGECJ8muXnRNbdekJ
	/lzn+fPoL0s5kB5DmJYNCCwJD5sBs4+EZlXWkJIkcBQkioQntrdccK2oUfvcDUVr
	FpfLdQC/ceAZwLaZGnfzGqOnzv2fM1WRQzEgzC6X4oPEycQj0dSs0KqPlDSdtzcC
	BDSyBNqSvKQOt5JtZmC/EO/9yRwSXVgiRm6CCRUsYmwrtD4pQYrx/x48SgpJfEiS
	ohJFQw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qr310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:02:01 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4e8161c5b92so94317137.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794108; x=1754398908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juelwFjR0xLghnG+f+9iPeOqQI/44lFNaWH/bAdlNAM=;
        b=YErgfRjIQdu1u5a0zztXTovB8fskvnSQzUpQF2CDSjFW0AIA1AmYmFXF8JLugrIewm
         JfYIodnBI9Z6j9c/8t8W7FD0j7X3UyelhQO9W0abmpff1LcNXbSC0x9XFJmQfgp50fcd
         0cnZ5WWyuU+NtkjI1ccRSjgEzDyV+oSLw3iDr7vvJ0hP95el+ppPHMRgA2lU+7uui+Q7
         Ni+nSxOk1sLBpeqsCT4Y8dThVaRd9oe+JiSsXK7zFIoYVie/ghiQxtlFdczcIruNVIfu
         3rUaJ+LulktzETz1p77f815dpQyaUcxgfOdd8McVNNZIFh9DXh2sxOSq/48ji47RRI+q
         4isA==
X-Forwarded-Encrypted: i=1; AJvYcCUifyGA060UkPuwPMTFg3Us2KLZx0gxrVOmpubFqvbakXcuyENxrRbUryX+I8wplP+gXK0NGOwwC1qgTRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dPDKTLDjFD+wMh2QxIkZXU5SeIFsXD0D9aC6808QrAwuJ90k
	k6yyK34KC4XRUpBoA8o5HQiQkLgQ2JsUmIPgI2bu/gIgrlMTc49G2kPGTLGjrhm1fmJ57QrYn7A
	yO+7iOdWAbEfqmAaV/hx1DZjsdEXXy3Mp53v2kCkxBohGonGJsi+GHWYoIfSU4pxdx20=
X-Gm-Gg: ASbGnctaDRprmuMExcemY1iAlklva2xmcgO6fcD6+9UiM5YdUaIcP8E48va1pOnIuYl
	eGwDbp0LMagjvQlygP/aLgnUUkBlaXcF0HYxVpQlRqPJHc1Ss9fLW3PAQ1J42U19Ot1mOZfLGY2
	LaQlYJHAzGszfnwgakxRLDVFgJ/2d/GAbKYTSyoTawysBw3revRKGCb0cx6rUg3lJl2rDoOOQ8H
	WgLuAlDjRl4y1wBs/RyRJoQH2TbpN7I3iCSJuTpKCacbMFHKmp3bt3cUqs4iRcoILwUmO3sZBqn
	xdXoQ0X3eXbCTAsfRf37G7i9nhIriy4QgstbHyfYmqA2bepSq2dq5DEG2/tAKUnjbzv/zU5hf6w
	pTmtmZk3AetfBPRrThg==
X-Received: by 2002:a05:6122:3642:b0:537:426e:bd0 with SMTP id 71dfb90a1353d-538db607c97mr1409826e0c.1.1753794108190;
        Tue, 29 Jul 2025 06:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3XZWl+BOftPeIJVe+mX7EzNQo4NU6m5CJLOb08qSGkjUakLEtnkqZAh4Nc9Ct/8TqmnlT/w==
X-Received: by 2002:a05:6122:3642:b0:537:426e:bd0 with SMTP id 71dfb90a1353d-538db607c97mr1409759e0c.1.1753794107351;
        Tue, 29 Jul 2025 06:01:47 -0700 (PDT)
Received: from [192.168.43.17] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a0994sm585862966b.44.2025.07.29.06.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:01:45 -0700 (PDT)
Message-ID: <9e48ea8e-b59b-4620-9781-211cc1f7cc07@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-7-9347aa5bcbd6@oss.qualcomm.com>
 <tyjkwrdmsj7k7tkqqxdd65l5v5jxugr5me3ivg5onn3hbffkwp@7uhsbzolqiyd>
 <30442713-2990-490a-b076-93c3cfc3901d@oss.qualcomm.com>
 <d696e7df-7f11-4491-89ff-ba71274ae101@oss.qualcomm.com>
 <1d320aac-e928-4fd0-812c-268a3a943575@oss.qualcomm.com>
 <3f58451a-9b5f-4697-9679-d549104e8312@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3f58451a-9b5f-4697-9679-d549104e8312@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwMSBTYWx0ZWRfX3Nvb5fxlwgxw
 L5zsT3IE/9y0cT8QKQEvy/9ZSSH5Ib1jGjF1gYLD2+tlQEnFukrA5h1epXkqMMheynZ7aTe+HOZ
 jTiytLPYec1vZZ16VctQ0GoLAhJwKlpk+Iryz2HCQaZS2BYX0t00FC4+32twcw4GpN+iQXPXnZ4
 OBUlcEYAR+ljkpuO7yYkrWQk6m1MOE77SjxYuCwxJSNcbnJe3fbufq5KsBLddBkhX2IA7V2bv1p
 9mbS1iEl6Tg2BlDMD/udSzEmFY3/OE5uzB6l82yTjSEGyGG4ZGy+RIyi/fxwVj3LLg2sNF3EV/6
 AFOQwD9R606jLANQc2qJ6BJ7X2Aq2DdY8uchIXzpNTB1cpqDYuVeelVWWToM9Y+TJf6slfeQnBo
 qVm6i3/6mDbcqx8G03c6nVq+ZMGdtoEqP5SRyeafYpnIBHnUif56YX5NfN9MUTCljvIE0LLt
X-Proofpoint-ORIG-GUID: 4EVtfvaGGnh3OLacNO_cm1HkDezQKVYj
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6888c649 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9hkt72pFxozsIUrbaQoA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 4EVtfvaGGnh3OLacNO_cm1HkDezQKVYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290101

On 7/24/25 6:54 PM, Akhil P Oommen wrote:
> On 7/24/2025 5:16 PM, Konrad Dybcio wrote:
>> On 7/23/25 11:06 PM, Akhil P Oommen wrote:
>>> On 7/22/2025 8:22 PM, Konrad Dybcio wrote:
>>>> On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
>>>>> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>>>>>> There are some special registers which are accessible even when GX power
>>>>>> domain is collapsed during an IFPC sleep. Accessing these registers
>>>>>> wakes up GPU from power collapse and allow programming these registers
>>>>>> without additional handshake with GMU. This patch adds support for this
>>>>>> special register write sequence.
>>>>>>
>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>>>>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> @@ -16,6 +16,67 @@
>>>>>>  
>>>>>>  #define GPU_PAS_ID 13
>>>>>>  
>>>>>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>>>>>> +{
>>>>>> +	/* Success if !writedropped0/1 */
>>>>>> +	if (!(status & mask))
>>>>>> +		return true;
>>>>>> +
>>>>>> +	udelay(10);
>>>>>
>>>>> Why do we need udelay() here? Why can't we use interval setting inside
>>>>> gmu_poll_timeout()?
>>>>
>>>> Similarly here:
>>>>
>>>> [...]
>>>>
>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>>>>>> +			offset);
>>>>>> +
>>>>>> +	/* Try again for another 1ms before failing */
>>>>>> +	gpu_write(gpu, offset, value);
>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>>>>>> +			offset);
>>>>
>>>> We may want to combine the two, so as not to worry the user too much..
>>>>
>>>> If it's going to fail, I would assume it's going to fail both checks
>>>> (unless e.g. the bus is so congested a single write can't go through
>>>> to a sleepy GPU across 2 miliseconds, but that's another issue)
>>>
>>> In case of success, we cannot be sure if the first write went through.
>>> So we should poll separately.
>>
>> You're writing to it 2 (outside fence_status_check) + 2*1000/10 (inside)
>> == 202 times, it really better go through..
> 
> For the following sequence:
> 1. write reg1 <- suppose this is dropped
> 2. write reg2 <- and this went through
> 3. Check fence status <- This will show success

What I'm saying is that fence_status_check() does the same write you
execute inbetween the polling calls

Konrad
> 
>>
>> If it's just about the write reaching the GPU, you can write it once and
>> read back the register you've written to, this way you're sure that the
>> GPU can observe the write
> 
> This is a very unique hw behavior. We can't do posted write.
> 
> -Akhil
> 
>>
>> Konrad
> 

