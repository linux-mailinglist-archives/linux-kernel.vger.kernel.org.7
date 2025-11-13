Return-Path: <linux-kernel+bounces-899035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFABC569EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203543BFB03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90E23F42D;
	Thu, 13 Nov 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTwEa0O0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GLRQIUer"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001E2D839C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026156; cv=none; b=NRqkQjIzm88y2eEVCWYiBetswswQ1M5ujFHCqiNTvvh07xysXqGeISgjpzmDc0zp0loJd7DGcIzF5UXqP86dhR9JekU/013OyrstuMEQzAjPWYWif30jaXmwZgSXJJNkbVKLp8u+mMkqZNmIrvIQogALv3LOUPAFTmy6Ng2C6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026156; c=relaxed/simple;
	bh=8MJNIVzao8j2hrbn+0QUZMXmV+Ny6jHql9vsW3ffK/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj5pBXUsHXZxJjQAvHr1DmfpjHacbWiaOAYprtYYtxpPFT9ioarH6hh/4nJQEYYhAvAEURt7mmoeuCm5dvlj0hzm49YG0Gi7Q7WITMZEKs1d+wKX8I+qUXiIgCejK4aTUqgaXIObJoZN6SX/fFAfMDKOW9yuqzDVjyQOyptpTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTwEa0O0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GLRQIUer; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD5qbBw3768358
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=; b=pTwEa0O01ggQkmZ+
	aheH+/m17sgjioEGYcDKKAHqaOCVf9Ch/1rOlFiqgbN8wMlMEssOojpkhNjULEA3
	bmifele/wxUqi/ey7vdSZTQ+OWlIFhL32vvnyzt0SVXs2F63ljSbPcaEJ85OG5Zz
	vNnUQa0Pyj3BkfD4FoQx3nnB9Dih/8AGkiZIHqlitAfWYroWhJvMagRXnaVglk64
	QaA1Ywc8LWOb2r7zDljj5Yxq2VdZyMJWSeVNZTNDIjNKqv3bmDD5++hxbp7H69+g
	CCcJjvk/IIqNDt94IWpVbfYjDlcoZuIONdBk1PG5k9ihEPhCbcBkFK2wAQ+eU+Ue
	Y5HoGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9jn0n9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:29:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edace8bc76so2263231cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763026153; x=1763630953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=;
        b=GLRQIUerqk5nEXwzxrVOzGCuNxpnZBRPM2OW0t3+a1CWh7yhtKU3GkX0/Mq7cOlvLq
         WBzW7BFdLlpMVFiLe0vSBvwZxghSKMCqHfPajJzjWkpq3lrqCEZIjirXmuSzZsYIkMVD
         EbfA93y4JaqM/6i/VfleVmvLhPuKwRiXspue4/IgqIfvlogRmURyzqTw7nxFtK76473+
         U6lnwErPVqPwXizthMQQ2j6CtDLUxcQuscjec4ojnjYZzfufVWmNWyRRw8cq0p8JcJSR
         B2EFY0GQ60EDiwIbujJq/9tQimYzbo9/9K82dr5UoDaG5QZ2jFNrDJwnXOkbGSDiRvJD
         Gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026153; x=1763630953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dk2V+f97R7FIH+RWhnR8qR74s5z0Cna6ABS6uSkhx9Y=;
        b=Wczf6NM/CePsMQm4hf3HrYdEuuX9TWtfAQnMIA+SJZJ6CID7XwsDKhb12EDZBJk9TE
         GAdAk0b9ycdr6v+SXNhWHK2yaPSoMsJd8PBfZuujjpd5Tk4493GBzorqZyW20q4Icyf7
         1eXz0J9gCSG+HOEQDLL9gYqJ+oxzI9wjpiPF9lic5uWMfXmOiFphJNLe0k0KGk3Q0FxO
         b6xDdMjyqibayDy5noFkHJ2T7/unR5YcKnLc1jzzrlnQ3ftsdZjUyDGzi8iYejoDl280
         xixc8t+EbcHyIbr3/ayvh/UtpHPibEri7qpqs5uLv3EyjVwfzoQwAYPSUSVNlkygFRe4
         XGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVecf02B/KcdnsKPmIp2nNAWxf3oVViddctQ2LNIeDRJls4mUWl22qsIvO2nW72oFezd8k6R5A0nx36Hic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftWo+l6/Ih3SRmKJyPQAEJQoC9lxHGwr194yLRJG4DqYtKVq/
	ni6kQbV5NjXxOVubQ66itF/DCMdgGM0RfwUWD91IBfPEga8KsLWWpXZGKHYNDQvb5V5xJblMopY
	qXi+8GXqqP31xBeqN2UiY5z0Wxh71HalR1AL5NwrelQpc1y8y+vgwl5RPiuT9VD5N4tA=
X-Gm-Gg: ASbGncsTWt6wHedljYkMjXQ/HjUQdiNNV3Yog0spjrj/fRvsxHt8o7wWDYwLRSb8f5z
	2XZiKXSPn2Z+WBG6nWaqXe6mPR1HVXqV/bc8C71V50GTgQ4cfMLgsRWK+sv9adiPb3G+hLPZdw6
	RZ4OMM+9kfBZoS9KOFzqAG2ywYN3fd3MJdVPngcmY/EeCxk1ZCyPa1k6XQi9V9ZURrNyWvC02kB
	yqxefimp1zRX6Z26NcLMU6lrsrvIhXXDUAWahR763Ak1it6NgGMXYJiuRbw3tVHzi1+sUVlNh0O
	l6G7rcXLdZDDpIYMw6eneaxekAEl/FyePybcAZ+Bhcyn+rzbRDbYcWAzIUXXqmRBqevqIqZbhDF
	+uD/whtJu9Mpk3dX7gzgg/hMo4sVERexb8JmryroPi0T2p0oGH53cpBjo
X-Received: by 2002:a05:622a:16:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4eddbd65318mr52613321cf.8.1763026152882;
        Thu, 13 Nov 2025 01:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBKglDPCuRYE0ZGVzuJPGPVwQT3YRBKzTtOU5WmAoz7l8pjecUcIWj985OWak6SKf5r+bgQw==
X-Received: by 2002:a05:622a:16:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4eddbd65318mr52613171cf.8.1763026152358;
        Thu, 13 Nov 2025 01:29:12 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a2d746bsm1057796a12.0.2025.11.13.01.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:29:11 -0800 (PST)
Message-ID: <f76b51e0-43de-40c6-8be9-cad2bd2613ce@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] drm/msm/adreno: Support AQE engine
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-14-bef18acd5e94@oss.qualcomm.com>
 <1202b66c-6d4f-4909-a010-7e5e3ec7f0c7@oss.qualcomm.com>
 <cc4ff1c7-3158-402d-b746-5aa57b4a855f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cc4ff1c7-3158-402d-b746-5aa57b4a855f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BvmQAIX5 c=1 sm=1 tr=0 ts=6915a4e9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=CPo_bn1fJaELX20lIFIA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: A9gCDpONAQ1-hvzH5TBY0JoEunrWWgId
X-Proofpoint-GUID: A9gCDpONAQ1-hvzH5TBY0JoEunrWWgId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfX/aZe7hqWyLDZ
 F2VFQpAvp7g/aXBfrJFdLopWCxele9p2I6EcA31BF8fnWJm/M9aFJWFk59WePydrS5BJzrP4ErU
 0GYyB6NPSpuV4YglWvAv551EG9Y8pZLhAd5VrKGfA7Fj+1PsNTx5dloRmD1mV94+EDiFYqd4Fvp
 5lzT2uDgYNQfDLhyzMdWsrFMUJalZec0MuBz/dImKYiqlLwUXtYY1S04kb9Vkc5qHGnnnBB77fE
 3xySUCyA5qVKfqKLlNDnRF8yTPtI5cLp3qLabYOzVYyizMA2w6kc0hg3S8aLpUEwPgxfOw2FBNJ
 S6GuA6u73tRb4BtN8THvDg/24Sjumu9/oD/dwABUYMZfdR5uDz6LQ2GBbME+snfRZudT0bzJfgj
 6NNnmDPGMiWl8Oi7tKMl0gzSm4jmJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130068

On 11/12/25 10:16 PM, Akhil P Oommen wrote:
> On 11/12/2025 4:37 PM, Konrad Dybcio wrote:
>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
>>> in Raytracing related workloads. Add support for loading the AQE firmware
>>> and initialize the necessary registers.
>>>
>>> Since AQE engine has dependency on preemption context records, expose
>>> Raytracing support to userspace only when preemption is enabled.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---

[...]

>>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>>> @@ -616,6 +616,9 @@ static int hw_init(struct msm_gpu *gpu)
>>>  		goto out;
>>>  
>>>  	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
>>> +	if (a6xx_gpu->aqe_iova)
>>> +		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
>>
>> I believe you should also set CP_AQE_APRIV_CNTL per-pipe
> 
> We already configure CP_APRIV_CNTL_PIPE for this.

Aaaah right the register I mentioned is separate on gen7

>> Should we also enable AQE1 while at it, to reduce potential backwards
>> compatibility issues? Would that require solving the iommu woes?
> Yeah, AQE1 is strictly for LPAC workloads. So lets wait for LPAC support
> first.

Sounds good, thanks

Konrad

