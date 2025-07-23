Return-Path: <linux-kernel+bounces-742287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A274B0EF85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BAE188E1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247328A73F;
	Wed, 23 Jul 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBbMXJPl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292C28C2AA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265635; cv=none; b=cKUmjkncAvwUeGukd8eb87ft11EDIIVeS25V0UuWGSlVgeZxl+aFAmH75dfEKMvkksSGlWkSpyWbFAXYox5MD+zca2Q9qdDqvV/WQtf26LIwwSlJbd7eDPyGOYS63X/+AO/9CH9jnXgh4nGux+m+GvNRaEJ58Zuk3NAZsd1u4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265635; c=relaxed/simple;
	bh=4CWH2IkKNZr6mIG/SESwyL6j4iF5W70knw1kd4FBpoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0l8juhvW8MGxpMq7xbu4JHKaaHBtN8Not2TqiwZkuZNWLdovqENPq/bE+SevLIoEP3xO19bzo1dZdn5Y+FuhffUfMhNnaqlheEQYo5FLJ+T9YTbflz3hzJzmg0NAxA5Js9R2KQ0DCSeMNlUjeJ5+kXnnvq+x/1yb+kMlkjZEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBbMXJPl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9XmnR030815
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A1Fp0VrKpCniXZvPKeA5q3E1PK5THOcusTjUp11AbC8=; b=IBbMXJPlWbhzanWP
	XHSwCHLB+a3ijQ/iwEMi9BNvVwvjFRrt0AYV5+kaD4xenJ8MrjCAj7aL4bhrECfF
	tzkTgkiWNn7/wqt/2E2Ip0oCqZgjRLOZfotcswi8JLB6fXlm5heivGKezvzLxmEx
	msw2ProNf7Yg6hO1eFoeWXTP0TOtClm5ucQ4wJ57SzmjhPWDuKAzhBFFZ0hm38WC
	mzYoUHE0eEZj8j83zO41NBWHDcIKNb4cyMb5KL5n620gafyb9tXN1O/UghBFSUYZ
	0Of7YxeJG3+IG3q4K6bL8/MUg07olclUdKE/oRg4a7aumM+1m4H+vIRZbE5dSTDX
	xAQlvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s4sag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:13:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7de3c682919so95054085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265630; x=1753870430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1Fp0VrKpCniXZvPKeA5q3E1PK5THOcusTjUp11AbC8=;
        b=fvV99vVq3SAv5k0othUUzAHLgoDtQiNcNB7avjLAsADbn6/fxg1r6lqi/ZmQAU+XFY
         RUxQtuEYOVXGoxX6HbhpS/0sSYflZpE29Ypstfw0aGBA3s3v9fc0QB8zZ0yPuNJDyK6K
         tyWIKDj2DM6/DXql5EEAdPS0gblAX+Pw0w30BcEA3CdE7NhxQihULVQL6txVgf4PE7Sy
         QHkVzPR5OH9Gk7jOfVivcAoOCc62XXWcIneafNfD6Q9IxArgSGBTAm4/HREv8MzXwUON
         vpGO2euw/OsvJTBHHeTTUDM/UCoCQuJRZr5QwWlgdwXuF+z/yf/XQbtuKuYz6bq1Pacs
         tJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnV4P4IN8l1CFobRk0ElQ1iYGygCYjYdOqXd/sKOEGCf+KiYfBtmJa7YBORceAI35qLfyKR8M0zHFjF9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQJPl/ATL0ltFWsGdOZmyXfPaYdL7vSt/SZfV8VRiVGCALSkF
	LpA9U9j8/FGZSfi7iNn09ci/4tFtx93aGNBqu16PS86YEcHx4Yh8yww3lgpEMujebYrXPALegfr
	+izr4sKbKNPx5aqWX9TPYRwUe31cA4WGRNEkbQZrFGVON3GkHRcEflbMJiKlEaFfkfCQ=
X-Gm-Gg: ASbGncvYbV1dDb1fcc8it6WUYGxo7glTY7G/rNtsYkveyYyZ+gVeHXQ6JxA5B3e0k27
	W4IdqmSS5OJF4yyBviCkNDDqOFu9ulYLHRtTh/pbWQ0WUClVfCXFTepqpHF16L2B+AvEA72vws0
	Fe/H35e4lr/1EZbZvrD66lIEdb1bO6Ig6U45j/EmzAtk8TjI7wgssLYNSC3VD+qZT0H1hU24Cug
	9cxN/Lrb5t15LNDtGy51TdkjhUUhArF18AywdiTu49ux9DTJYY/Ub9P+uPUA6pP1smeHX6Q4wW6
	b3Dil7m/P4LZDMzGWl6awOCSv8JVXS/bpdnokXo7X+FEtsqzQesOd4SruPZ1ww/Wmv3Prf+P2MG
	g8yw/L6KELpSmQ2nKlA==
X-Received: by 2002:a05:620a:318a:b0:7df:d668:22ff with SMTP id af79cd13be357-7e62a0c1347mr135520585a.4.1753265630558;
        Wed, 23 Jul 2025 03:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj3f1wr8H3E8T0jx6NxR/LC1BEZKnxCKVi6DM0FYNiWA0IcAlD7hCgXo8SM37cDFvPxE/gAg==
X-Received: by 2002:a05:620a:318a:b0:7df:d668:22ff with SMTP id af79cd13be357-7e62a0c1347mr135518985a.4.1753265629973;
        Wed, 23 Jul 2025 03:13:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f543ddsm8186317a12.30.2025.07.23.03.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:13:49 -0700 (PDT)
Message-ID: <02b9de9b-36c8-4db8-a1dd-65a82aee0eaf@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-2-9347aa5bcbd6@oss.qualcomm.com>
 <d4b46652-c4d0-44b4-aef5-e8bcf606de06@oss.qualcomm.com>
 <4832a160-344a-4140-a115-d4742f95825b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4832a160-344a-4140-a115-d4742f95825b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NSBTYWx0ZWRfX3/DlEq6KTl+t
 06ezrLV2FcWQivIpgJ4YCYaAYYBXanP4N+6x3FnlApdwU7hZUpbyHzbBQDeOAhLhT7mCvOIT9Be
 R3KCoMlZb9McOQusIxn4m6bcHDrq8eLtiCsXGE7AUpZqNMEsA1+2GXiM6A0RXwwzV9NN76bTXzr
 lV6xJsvfuFvGMS1NE38jXHH8p5WXJ0K7r14R/TNA+ZZ0vrp5EXYoaDlPrQpYkpKv9/lEDFTSMvc
 5unKQaYamX1nNkIEB4dOz+bJbc3k1MD6vT5qMgMri3fxH9K/EQzTTLygLLUE0UqoFl5m35xBVdj
 A/NXO8rQH9XmNuHzVK/O0n9b3FMS7DNht5oI7hzogGg3byoMpRM2CTj07HaS0p2LPoRHfEs+j/k
 Q5Chp8INrUJL5fBRN/ZDuSIf2RKSjlA+54slAmCfIJs1WF2ADHGIkTYyKhq3p12+f/X/Gei9
X-Proofpoint-ORIG-GUID: X_FF4BBYSvDUGlIj7GHTB8WQqEeN3FzW
X-Proofpoint-GUID: X_FF4BBYSvDUGlIj7GHTB8WQqEeN3FzW
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880b5df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=3Acu8AJWO6yBlTze4eEA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=965 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230085

On 7/22/25 9:47 PM, Akhil P Oommen wrote:
> On 7/22/2025 8:00 PM, Konrad Dybcio wrote:
>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>> A minor refactor to combine the subroutines for legacy a6xx GMUs under
>>> a single check. This helps to avoid an unnecessary check and return
>>> early from the subroutine for majority of a6xx gpus.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index 38c0f8ef85c3d260864541d83abe43e49c772c52..41129692d127b70e9293b82bea5ccb6b911b0bfb 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -403,7 +403,10 @@ int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
>>>  	int ret;
>>>  	u32 val;
>>>  
>>> -	if (!gmu->legacy)
>>> +	WARN_ON(!gmu->legacy);
>>> +
>>> +	/* Nothing to do if GMU does the power management */
>>> +	if (gmu->idle_level > GMU_IDLE_STATE_ACTIVE)
>>
>> This isn't quite a no-op, but I can't seem to find what the '1' value
>> would map to, even in 845 kernel sources. Do we have to worry about it?
> 
> This is fine. '1' seems to be a low power state that was removed very
> early in the gmu firmware development stage. We can ignore that.

Ok, good - could you also add a define for it, perhaps something like:

#define GMU_IDLE_STATE_RESERVED 1 /* Cancelled feature, never exposed by fw */

Konrad

