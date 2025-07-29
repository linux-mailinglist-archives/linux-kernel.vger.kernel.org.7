Return-Path: <linux-kernel+bounces-749920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD5B154C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EC94E3138
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F209237180;
	Tue, 29 Jul 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pLhoMbso"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAF227E95
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825239; cv=none; b=ILe2Ne23+XAwNavbkI+BoV753BWyWrZf7HnBy6+rv7VbgqfBjA10Nq0lDQs9DBn0mV9xZa8aWxL+C0e5u5ksf3ALRAVifZlWGSnYdgXHma7NJ8YFjjKOQe590cUXGaUbOum1gcrIkmqCmehsex4pe1+H6JUB702iS8Do6yrj+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825239; c=relaxed/simple;
	bh=1s2C5NLMm5STpMWhuT2DRE7VuG+76Zwd6y7eFrgoy64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WooE5Vmtu7lSOWjWZXFRnTJZ5uagGTPZRM19UfDUwWpEAJxVde0+jtJYR3n8jcFHzQBjEsBS54DOza40qRhjnM2WGwQQmVECJn8rOOegzTQK7+HpBi92rlK9YsjNjBfDuY2YocCyDMVFCT95HkuGcye1OXeVSq+Z5taqE3hppSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLhoMbso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TK73fd016216
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQGazUCFnz3W6AC4AtQi0R1LPe8Tk7TrQs4pGUNhc7A=; b=pLhoMbsoPVixRGYP
	8Wa8bAGjawrMAcfh6cS/s2ykrjgZcXj+Pq2hclywNWd+ZEgQ0xHWIiiVsCNVS9Vg
	Q8dZ0FzCrDbrnKuju2BLNMAUP5BQ4nOntq2EgEuePwSGgymJadSCxSXVhNuYhHHo
	04EfL2W7Xf8uAEd/G8D49tLF0Z6t02N46AqlyJWpt3jES+PaZSmFvt+ZFIpuGpMo
	NyseJGlXraM70KobOgp6DpY/5SusLNjK305f26RtlpN47nlFnvQ6ZNG2QnGnj22Z
	zdRu+nSx4Tw8F6vBAtPeUG3j38m8TAm8/+HeY7wQD1ZTUl5bIkB4y76PlzHMtOPY
	CIHp9g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 486v6y1xxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:40:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31f112c90aso226626a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753825230; x=1754430030;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQGazUCFnz3W6AC4AtQi0R1LPe8Tk7TrQs4pGUNhc7A=;
        b=gMbr1m5igDv9dIze1nscnF+NSFTD0n5+hPtpCvAxwSYelKAbaRuZrQqdaku2T0oryP
         C4Lf/cakcja54L1oWCMQko/E/nIkf70P6TusW7VAclYJtRXKMJU6eyXEADBMgZ4YILAe
         lHGRwwQIet9AWGk1YBAofR9zsDJOUua8ef8Fk4ha4CgUFSm1udBONs9n5tWMW45O/p7d
         nUe/SieDOBHBYoZfFHQ9ts9fwfk6XZIwAAcZVFpnnlT5EqgaWXj0fgPl4iS/mdWfdXYG
         5bnB3kNZagChxIQA47WFSqIX2c1oox68EI4DB6BoAti2lUz4e5BDeGvL0t2zlL7rdWFM
         jw4A==
X-Forwarded-Encrypted: i=1; AJvYcCVB1KZUMcIns9p4odsGDwWtQ5MAfZt4J3X6JhTQ5/QvQzx8ZttQIykmjmIrKBcaJ8fmcoXMUgSCXkOSJf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxpHelTU3nmyZ9s58Yg9Dzn/8zVRikM8FbtWmqGe9cj3dscul
	8L1AECyMco4jn7XlqI5pIC2e+Xid0u3KKozeNY6PnjYvrsUdx8NL8JycxIVOdxsKM65Qnwvn20C
	HaKHGoY5Lz3cZ01Tn6eknFLUzHaVuRubjf2Gs2e/AZl//TYhjGoV00tpZz6zKYNCGJe4=
X-Gm-Gg: ASbGnct843LJ2Xw4Fp5cZo9nGLVMr9BITx01IlbvtwLcuYB7R3ZX9mO3qcth+c9SXTQ
	37MEBkfeRIMrjXvf8SkC/+l8kjn7+B+J8VSkwqtJi0pDj0Soijm62cmmM3JofIOGaAHtUfbbLf+
	VvBdjT4h6bFuilv/8xnwwbLaOJXSbIEfHMDQuvanAKwCOX3tXNjjy9Cbx51/k6fGs8zxEBcM1Zu
	uUL9JJ4H+0HYEb86wCpJDL2FKAhNWyFsZrs2ouXVHZfGI3/J0F9VT7imv5FmOOGFAtZBls56BLw
	Djz3grEdIVRK4TEMtMrowHuuvLP2ZOLjgVaZZHW4xCBCGmOS9ZgQB2WXpvv8kDmF
X-Received: by 2002:a05:6a21:3e04:b0:220:1843:3b7b with SMTP id adf61e73a8af0-23dc37f92d3mr324705637.4.1753825230234;
        Tue, 29 Jul 2025 14:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVlgY3u4zexg+eEceCSWMsg/EHdyVJS0PVYhJEmiMBniSzidqzlG0GWYEezlewSXjjY5DuQ==
X-Received: by 2002:a05:6a21:3e04:b0:220:1843:3b7b with SMTP id adf61e73a8af0-23dc37f92d3mr324667637.4.1753825229723;
        Tue, 29 Jul 2025 14:40:29 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.231.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420df76dd8sm2262382a12.19.2025.07.29.14.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:40:29 -0700 (PDT)
Message-ID: <bd6076a5-f888-4044-8a5d-ea6e6fea28e8@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 03:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <9e48ea8e-b59b-4620-9781-211cc1f7cc07@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9e48ea8e-b59b-4620-9781-211cc1f7cc07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE2NyBTYWx0ZWRfXymOv0YS0VjCJ
 o6pm4+icktC/z/ybYIUtlP4w06pQ9JvGn3gC05cQ7AlsaNS7RzXdHbeWPnCJh2SzdkVAHjDksvk
 0v1AGaM9OGs3/PAC+abBsyzkHHXILqv28PecrkgAvank3OdwEqWzWEAu/WbJXP8kN4fHJ3r6BXP
 xJpvz3gt1yMLOstwayquXJR2yqo8h/SyUD/F285cn6bSlFHhkIlFPbMXlBLSER0F9cBsTajaybQ
 0U/NCW8Qvk+E1AX7/7e1KK1QTJ+ygy46Fg8l7Sxgam9wVhSI3jOmN/JqLD3VzdaRjuecCcrYiEv
 sGzubqWMSlEWQEmLIv1ucnEzrlC5NiUFB/qppfBfFDypie3SSRdbPkFfLuXwyCU7zsAq7DNuQf9
 s699k2ApClp4Z+P513VxtpDZ31vWzH3tsnYFM5sWsq4GfGVMTaTRyozbWmSZcr69iRbGFtrL
X-Proofpoint-GUID: 6jOhaHWFZz-1bYQoEZPBvvLRXo-FTi0e
X-Proofpoint-ORIG-GUID: 6jOhaHWFZz-1bYQoEZPBvvLRXo-FTi0e
X-Authority-Analysis: v=2.4 cv=QYlmvtbv c=1 sm=1 tr=0 ts=68893fcf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9XpMM9ZEX5jLuhR58p3+Fw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UL6EBj8_IJHJ2Owmy10A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290167

On 7/29/2025 6:31 PM, Konrad Dybcio wrote:
> On 7/24/25 6:54 PM, Akhil P Oommen wrote:
>> On 7/24/2025 5:16 PM, Konrad Dybcio wrote:
>>> On 7/23/25 11:06 PM, Akhil P Oommen wrote:
>>>> On 7/22/2025 8:22 PM, Konrad Dybcio wrote:
>>>>> On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
>>>>>> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>>>>>>> There are some special registers which are accessible even when GX power
>>>>>>> domain is collapsed during an IFPC sleep. Accessing these registers
>>>>>>> wakes up GPU from power collapse and allow programming these registers
>>>>>>> without additional handshake with GMU. This patch adds support for this
>>>>>>> special register write sequence.
>>>>>>>
>>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>>>>>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>> @@ -16,6 +16,67 @@
>>>>>>>  
>>>>>>>  #define GPU_PAS_ID 13
>>>>>>>  
>>>>>>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>>>>>>> +{
>>>>>>> +	/* Success if !writedropped0/1 */
>>>>>>> +	if (!(status & mask))
>>>>>>> +		return true;
>>>>>>> +
>>>>>>> +	udelay(10);
>>>>>>
>>>>>> Why do we need udelay() here? Why can't we use interval setting inside
>>>>>> gmu_poll_timeout()?
>>>>>
>>>>> Similarly here:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>>>>>>> +			offset);

This print should be after the 2nd polling. Otherwise the delay due to
this may allow GPU to go back to IFPC.

>>>>>>> +
>>>>>>> +	/* Try again for another 1ms before failing */
>>>>>>> +	gpu_write(gpu, offset, value);
>>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>>>>>>> +			offset);
>>>>>
>>>>> We may want to combine the two, so as not to worry the user too much..
>>>>>
>>>>> If it's going to fail, I would assume it's going to fail both checks
>>>>> (unless e.g. the bus is so congested a single write can't go through
>>>>> to a sleepy GPU across 2 miliseconds, but that's another issue)
>>>>
>>>> In case of success, we cannot be sure if the first write went through.
>>>> So we should poll separately.
>>>
>>> You're writing to it 2 (outside fence_status_check) + 2*1000/10 (inside)
>>> == 202 times, it really better go through..
>>
>> For the following sequence:
>> 1. write reg1 <- suppose this is dropped
>> 2. write reg2 <- and this went through
>> 3. Check fence status <- This will show success
> 
> What I'm saying is that fence_status_check() does the same write you
> execute inbetween the polling calls

On a second thought I think it is simpler to just use a single polling
of 2ms and measure the time taken using ktime to print a warning if it
took more that 1ms.

-Akhil.

> 
> Konrad
>>
>>>
>>> If it's just about the write reaching the GPU, you can write it once and
>>> read back the register you've written to, this way you're sure that the
>>> GPU can observe the write
>>
>> This is a very unique hw behavior. We can't do posted write.
>>
>> -Akhil
>>
>>>
>>> Konrad
>>


