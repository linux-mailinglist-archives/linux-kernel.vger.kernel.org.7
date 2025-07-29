Return-Path: <linux-kernel+bounces-749925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B0B154D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D107A74B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BB279DD0;
	Tue, 29 Jul 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpeZtkJH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88177229B15
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825804; cv=none; b=WSd5mIqAh7nHUNJ994Z1XYK/PVtJDSDfCgJc5bAs1JavAvf7/rTpwSkC0a9s36FhmCbl0C0Do9AjHPMShUYK1Mcm9VeuODg2WQoUQDZX29g9RKMCr4j0QZB1MnzyHDAIXvfSCJc7qIIxjyW5TBjkui1tnHlszXd/EarMGI10GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825804; c=relaxed/simple;
	bh=QtTQukJVU2sdDRVmh2jcbWrgLFKbkH8kW0Qz/3Q70gM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R44bnaXefDQkZKn64ph15V0F77unz/tkVvFjUfda0AG2ax+nfOF5ChfmQM2i416pn2O9DiIziFzc6jjOJNzURuTbvGXEBBKiDDrch46di1OkY8tvwK/HxjGfd8GJPoaXAibdXvLMiFKMpfO/MM6F2X1uHEgoyfzxSiw9go9gD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpeZtkJH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56THRTia031251
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JspbK+7iQlUzvPH2LdAMAjZlVUU4SzJyy/Ozc29zRpc=; b=gpeZtkJHfR4ZWH/F
	KqdBuCv5LwjDgycYqm8La+lrLipEaNpFxuSuBlEmBb6ZlF/bDiz0aAcyWZz+OLy7
	zlyYlLe8cwppdEYOjaooAfbWwYZSLTBepEQ5j/bNnwBVT7GV+J5t173bvduyokb+
	T42fBT2SfXvKQJMV3hyWER35l0wZZP3gp8YVg+tGsxcEH13/V2o0YTigdbbHYYxM
	sRGO06J2Gd5SuYzWkB5BEiwYlgtaKHYGVTnfJIA8MORKcsJjz3A+g0KnBwRqMU5T
	ck8G+uPmSxLxsCUxFU9FosLxUbdMKpov/+Bw3nskC9ysQyNTewc9HCSXRqZeTIS3
	z6ANuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xf0vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:50:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31f322718faso1025904a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753825801; x=1754430601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JspbK+7iQlUzvPH2LdAMAjZlVUU4SzJyy/Ozc29zRpc=;
        b=lOWllkXxhZZHy7UdyXuTwPwls7/28i6+84pMY09bT2Lhmg2v3s0aOXK4wi16WAtbJA
         W1WB8C9pIaxseTV4vfdvFl4DyVvwPFxzxrtGPNydmzbtrDVuwq5PVAwAFafUbSYw7H7z
         ZedKijjQtKCGLQag7Tkn11yVvx0JpQIi8ILPyXuUoEfoJqgpryvPO9gT6oq1tlpSJs9e
         z17NNG40b75Yl8WMgB7qekcP+sccIyRGhrhljzSxjQxLeqAKNqO9nQ2JIW+MGy4CCg6m
         NDYtjulv9MD2BoyEbpjxQ6UN4m7dCZzKQAGZrbsUvrptSlFVTK5keNjNfQGYxajw7u+Q
         5OEA==
X-Forwarded-Encrypted: i=1; AJvYcCXitB33NLykWTQ3DDminpXTvxwkPotOZ1rqIShYE+DP3z7rJox5hM/2FeRW0aHV8TDnYrWfsTir0RrEJOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk45HXJGbBysuP0iVqx49v2Fqr0mxyALyWjmcd231gWT94FncF
	rPHqh+bahiwnf8E8mPZUFofBuCTHyBfYNJWAqxV04tZGm96qIsuMVrNTsNyiR/a8MqZdvphBrnk
	ywHUvvQG6RwQp8Bvkkflj+0M/7rlQAr3btGpQw2gLZiweM4z3cYdC1zoFA0JmnN2QkeM=
X-Gm-Gg: ASbGnculOYUaZUScSnNDY2EpfQG+CmIoDOsxhuCbHdkMND88/Pmzr7LfvG56vjqp2Bf
	YkYCETM1NH/D2XiaqS1Qk0eKYCEWuCWoFX39o8M63xjdhKoZeQhjuJUVXlVC9EL+jKfKPY7QeaB
	bLVUiiGEBqtlLy0zrj/Pp31hf7Bu9vhGhlb01Q+rUy1WwNtEJKd7kKCc8iNRbg3AB7F5OcqMtO/
	zyn50udZxXqootV08Ynuifp3E1g8xmQI/UK7E+TGRWMrn+VI+kwmBEslaAfeWfxeyfzv7pFIm7w
	LE9K9vBol+3EtkJ4jM6ztiO4tk2N0YnuG6YD9PJAWgLYslC3H8shVQ2jdJKlZNw+
X-Received: by 2002:a17:90b:3f4f:b0:31a:bc78:7fe1 with SMTP id 98e67ed59e1d1-31f5e3809efmr1403397a91.18.1753825800264;
        Tue, 29 Jul 2025 14:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWzTCdtd/O3kQ9la6eaI+9qnWjBUz18tIpGuf+RzXz+1SzG38sYAe/Va1BAoLtjsbO/VMJSg==
X-Received: by 2002:a17:90b:3f4f:b0:31a:bc78:7fe1 with SMTP id 98e67ed59e1d1-31f5e3809efmr1403372a91.18.1753825799808;
        Tue, 29 Jul 2025 14:49:59 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.231.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc5383sm111612a91.15.2025.07.29.14.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:49:59 -0700 (PDT)
Message-ID: <4226ced8-411e-4cc1-be2c-4d1452c09b14@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 03:19:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
 <bd6076a5-f888-4044-8a5d-ea6e6fea28e8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bd6076a5-f888-4044-8a5d-ea6e6fea28e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE2NyBTYWx0ZWRfXwmYAh7X+Ykti
 ZEBeXKOOVBCIBFK8jKS+V9GcB+tsOEcDq7AVp0HgOHo18koxMaP6pxn/OS1muwLB6LWOom1Ncah
 AOE7bd3YbsnmxR7KpKT2ymb1bkwQ20gz193wiUwi0h2ZKjvOcfIa4QKrh+hsu6ccfiHQ3AtWvSX
 qbX6ahQ5z5hRhPOhMvWIV1ycHrxsTGLXhLTEq5z6pjE3AsRHG1u/yiRJ384egIPW5GutqK74BVP
 L5nBhSzDgmrRu6eq51i45oKvRzUq7MTzMUm3lMRwxRB5Q459AGyq0cZCUaF0TRfS1It8byhhXSY
 2ziZ46icg7bR2Kuu+dgAT3hONRsclJqodQl1Mda4SHQqEQmeCYQjbyeaAWrLz4sX26uI+JW0gT1
 dtU6SlXo/ssCgz5MCA2MSKSLNyKjmvXGbnEfNIDtPcPRnZTGKkHKB6lhUUQwY6WCa95c7Sa5
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=68894209 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9XpMM9ZEX5jLuhR58p3+Fw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5A9ZKBTbSWANmlZxSW4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Nplix09z49A3G-68jXbBF08vYptUip3B
X-Proofpoint-GUID: Nplix09z49A3G-68jXbBF08vYptUip3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290167

On 7/30/2025 3:10 AM, Akhil P Oommen wrote:
> On 7/29/2025 6:31 PM, Konrad Dybcio wrote:
>> On 7/24/25 6:54 PM, Akhil P Oommen wrote:
>>> On 7/24/2025 5:16 PM, Konrad Dybcio wrote:
>>>> On 7/23/25 11:06 PM, Akhil P Oommen wrote:
>>>>> On 7/22/2025 8:22 PM, Konrad Dybcio wrote:
>>>>>> On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
>>>>>>> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>>>>>>>> There are some special registers which are accessible even when GX power
>>>>>>>> domain is collapsed during an IFPC sleep. Accessing these registers
>>>>>>>> wakes up GPU from power collapse and allow programming these registers
>>>>>>>> without additional handshake with GMU. This patch adds support for this
>>>>>>>> special register write sequence.
>>>>>>>>
>>>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>>>>>>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> @@ -16,6 +16,67 @@
>>>>>>>>  
>>>>>>>>  #define GPU_PAS_ID 13
>>>>>>>>  
>>>>>>>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>>>>>>>> +{
>>>>>>>> +	/* Success if !writedropped0/1 */
>>>>>>>> +	if (!(status & mask))
>>>>>>>> +		return true;
>>>>>>>> +
>>>>>>>> +	udelay(10);
>>>>>>>
>>>>>>> Why do we need udelay() here? Why can't we use interval setting inside
>>>>>>> gmu_poll_timeout()?
>>>>>>
>>>>>> Similarly here:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>>>> +		return 0;
>>>>>>>> +
>>>>>>>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>>>>>>>> +			offset);
> 
> This print should be after the 2nd polling. Otherwise the delay due to
> this may allow GPU to go back to IFPC.
> 
>>>>>>>> +
>>>>>>>> +	/* Try again for another 1ms before failing */
>>>>>>>> +	gpu_write(gpu, offset, value);
>>>>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>>>>> +		return 0;
>>>>>>>> +
>>>>>>>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>>>>>>>> +			offset);
>>>>>>
>>>>>> We may want to combine the two, so as not to worry the user too much..
>>>>>>
>>>>>> If it's going to fail, I would assume it's going to fail both checks
>>>>>> (unless e.g. the bus is so congested a single write can't go through
>>>>>> to a sleepy GPU across 2 miliseconds, but that's another issue)
>>>>>
>>>>> In case of success, we cannot be sure if the first write went through.
>>>>> So we should poll separately.
>>>>
>>>> You're writing to it 2 (outside fence_status_check) + 2*1000/10 (inside)
>>>> == 202 times, it really better go through..
>>>
>>> For the following sequence:
>>> 1. write reg1 <- suppose this is dropped
>>> 2. write reg2 <- and this went through
>>> 3. Check fence status <- This will show success
>>
>> What I'm saying is that fence_status_check() does the same write you
>> execute inbetween the polling calls
> 
> On a second thought I think it is simpler to just use a single polling
> of 2ms and measure the time taken using ktime to print a warning if it
> took more that 1ms.

But then we can't know if the higher latency measured is because this
thread got scheduled out just before we measure with ktime 2nd time. So
we should rely on gmu_poll_timeout() for accuracy.

We need a warn after 1ms because there is a 1ms timeout in VRM. We
should know if it occurs frequently enough to cause a performance issue.

I will move the the prints towards fn exit.

-Akhil.

> 
> -Akhil.
> 
>>
>> Konrad
>>>
>>>>
>>>> If it's just about the write reaching the GPU, you can write it once and
>>>> read back the register you've written to, this way you're sure that the
>>>> GPU can observe the write
>>>
>>> This is a very unique hw behavior. We can't do posted write.
>>>
>>> -Akhil
>>>
>>>>
>>>> Konrad
>>>
> 


