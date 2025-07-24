Return-Path: <linux-kernel+bounces-744701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040FB10FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A58564D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC42EB5BC;
	Thu, 24 Jul 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsrEFfPD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD114274FED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376105; cv=none; b=sq1vREHnt7JBeXkrBGev4mPqSbZbhI4Z7TzDDYPHIXdj6UM1ype/cSZdKH68BGzHecXSs3JMzfn3kf8vXMMfENQ+4JGFcB7MIZH0rB2Q3ZCxTuxJ1yCJyHAL/LwN0bISzfY2IjBDicv0pcO2bBY9QqVIkOZ1JZRtoTqqAEcQ4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376105; c=relaxed/simple;
	bh=O2W248CaccP07A8DSRtvVrSXZqqTMGLZbh7bR0BGEgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFg+lqRmq7obMA85LvEEqahK8h5ZhgaskXVg3KyOJy70J4Hxio96jE+b5YAcrjuDeFbj+SYdV0pGgyg0kQJ55vGWLJQZJ5/HfaqGNmlCbI6QT4OJsvEYM3UkG4h2XIaLQXtDk3fSzER2fbzioWOxFvr3lI8tgHNlgofQsReUqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsrEFfPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9Ztjd018150
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkvO3HWuwnO10CopnTi1wToI7EW9iwYWQA6wYcR0+jQ=; b=WsrEFfPDaBoP+9qj
	4Q3M/prEdlMGBq4s0KXkhYo/u8PN/QuqfKpPpApeD/RJ1Wev+rmTbnbi37lxMvMh
	SwMjck/yeJUpRscVsyHPgsUbqm6iIFakKak17vhAjWH15yZTAgpwdiBVv1QPfFyU
	Mu23QuqHsK2qYxBi6gr9I9nf/u2W16jUNXyu+k5h8wJL51/S+/RFTswY0FnxKfy1
	oPsJNnoiQWLhAhh7JIYFC/SzYSJkgwrSwdBMvcN5Y6K5Yzyut8A9HYPPLQexOGhg
	pDG3hLmyXLI9jq+BDyMoHYcGqAyvEp5j9b757WWhZda/7C1LGPsXrbJjgsq4Z18X
	v03xag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6ukyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:55:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2356ce66d7cso18310805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376101; x=1753980901;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkvO3HWuwnO10CopnTi1wToI7EW9iwYWQA6wYcR0+jQ=;
        b=h4Enj/1IRP44NquUjNqr78v9OQbmSHKjWJisZN+lnmo0FXtQaDekclsO+uOFHDqdDD
         I58Vq0jySCD4wLFklZzCTLbXJloJrWkH4WOne+MYOSKLLzhHCtrJhsU0zl/MvHOHa4Rr
         2wcq8RCC1M9tqXI2mYQ7KJIX7cdaiK8TMnhJFxGAFHP/bsRa4e0YKSWFRAWEMso2rCzU
         ws+7BaSVTOoIatgo/fybuYtF+MfYa6GafQWnA51Cp5ryM7GMJ+lANJPVfw9fd5gx7HRO
         h1kHn6OrN3uksBBacqrCpqCYXydlRkCItHWabKBpxbKqN3AG4UureQJWcuu516HEvjLj
         VMWw==
X-Forwarded-Encrypted: i=1; AJvYcCXSVJMdMvf5cUJyipzFPMP6d9ziqqDyV0WSxlcCyRhY++eu27cegE9PInB3NYiMNXZySAWGunNam8nZ8nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31mPADf6DALL5JH6yx/ePRdWzMC424aDhYzu6jEUpH/Af2JPN
	PUpMPWW9ioX52g6e5in0YS1PQOEGdp2gs9yNSN36XEnO5lfriemMMhwNLfefUwxul6dSLoBmSz5
	19H16WVQLTcnls5qxSEGnZT8N75dqo7xiSE4FA4X6RUMSKvxHfzaRTGWtSRInjLvS180=
X-Gm-Gg: ASbGnctMz32V4XZIJLCAZZSjhhNXo9/g10Ffu4y9xRz/8K1XcLBjeeVB98JIAD9Sur0
	OUW2jFUT8mCjAPHg3sK6QA0fyTzVy3giUJjuCDZOayZHPkzWV1S8/tUatPF7OrWlBPw7lmc0vOj
	8yXaMciQDf/0kE3qN9Kxk9YYhpWN/GMLjek5rWGlf9QQ8jzaVWO+2pXY7RgAxGsZUTJ6+DucdeJ
	UunAjzqEMVu1WlEI3GeQq6aKce9zDphmHR9RuO30GFyHEW6K/sEjrqetoYnTr7DGPKLKc1xGLra
	w03lvBER+O2mOW34qDaxlPJ8RlpWStBPUTvpLspkYeFJM5CUa2FOEWU76Y8E/Q==
X-Received: by 2002:a17:902:f693:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23f9812b40emr105598875ad.1.1753376101298;
        Thu, 24 Jul 2025 09:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyvLqO0p8DE/R/ENYjSnXqR13kGXRv8iVQZndC6b9Kh2sUCELYpa5iV7vJ24tGDfXy+ZJh2g==
X-Received: by 2002:a17:902:f693:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23f9812b40emr105598655ad.1.1753376100869;
        Thu, 24 Jul 2025 09:55:00 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4924a8fsm19330245ad.210.2025.07.24.09.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 09:55:00 -0700 (PDT)
Message-ID: <3f58451a-9b5f-4697-9679-d549104e8312@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 22:24:54 +0530
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1d320aac-e928-4fd0-812c-268a3a943575@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68826566 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Dh8trrp802kbo3xzQFwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: CLGuVMOc0kf7KnTrdtLDPxSQMhpV6lJr
X-Proofpoint-GUID: CLGuVMOc0kf7KnTrdtLDPxSQMhpV6lJr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyOSBTYWx0ZWRfX0PTuknASQd2K
 v6NQFCpXbS+8Hyb7D7AmEoTPxpb84yNSD582++OGnuF4WqpfpFT0w9TOdFSAs/W7xWCW/oZywyT
 JQREYd1WuHCIi0j6smEhLv85wf3+qgc2N8Ni8y4HPdPjyjHvDdIgNXvcY22MGmDddsk1/2+7KuC
 ThyF/BDJmd66Sgr+qFvBTkyBAB1fo7wZO8KIUXvBwCYc4wH1IXiVNUrFTqSxCvVXt19mr1ctis3
 sicYEASOmSMsggSVhr4dbwtML6akJmWDwuEjXWYkaVg7SI21mklPL2rN07pzREi8JJx7d8iruPV
 EOYFdWe9wiHNxJJiLoTw34OZAdRAw/k9zHAW6UjqEkonplvD9/isTO4VN5y3gBbFl8FBmyyh6vU
 hFAb4WEVfm9gv9s9JhSJBssy84qHdShiZMZGf9KS2eitBm31pInm9EANCJAyeduW/3tOHTe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240129

On 7/24/2025 5:16 PM, Konrad Dybcio wrote:
> On 7/23/25 11:06 PM, Akhil P Oommen wrote:
>> On 7/22/2025 8:22 PM, Konrad Dybcio wrote:
>>> On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
>>>> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>>>>> There are some special registers which are accessible even when GX power
>>>>> domain is collapsed during an IFPC sleep. Accessing these registers
>>>>> wakes up GPU from power collapse and allow programming these registers
>>>>> without additional handshake with GMU. This patch adds support for this
>>>>> special register write sequence.
>>>>>
>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>>>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> @@ -16,6 +16,67 @@
>>>>>  
>>>>>  #define GPU_PAS_ID 13
>>>>>  
>>>>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>>>>> +{
>>>>> +	/* Success if !writedropped0/1 */
>>>>> +	if (!(status & mask))
>>>>> +		return true;
>>>>> +
>>>>> +	udelay(10);
>>>>
>>>> Why do we need udelay() here? Why can't we use interval setting inside
>>>> gmu_poll_timeout()?
>>>
>>> Similarly here:
>>>
>>> [...]
>>>
>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>> +		return 0;
>>>>> +
>>>>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>>>>> +			offset);
>>>>> +
>>>>> +	/* Try again for another 1ms before failing */
>>>>> +	gpu_write(gpu, offset, value);
>>>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>>>> +		return 0;
>>>>> +
>>>>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>>>>> +			offset);
>>>
>>> We may want to combine the two, so as not to worry the user too much..
>>>
>>> If it's going to fail, I would assume it's going to fail both checks
>>> (unless e.g. the bus is so congested a single write can't go through
>>> to a sleepy GPU across 2 miliseconds, but that's another issue)
>>
>> In case of success, we cannot be sure if the first write went through.
>> So we should poll separately.
> 
> You're writing to it 2 (outside fence_status_check) + 2*1000/10 (inside)
> == 202 times, it really better go through..

For the following sequence:
1. write reg1 <- suppose this is dropped
2. write reg2 <- and this went through
3. Check fence status <- This will show success

> 
> If it's just about the write reaching the GPU, you can write it once and
> read back the register you've written to, this way you're sure that the
> GPU can observe the write

This is a very unique hw behavior. We can't do posted write.

-Akhil

> 
> Konrad


