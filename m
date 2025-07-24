Return-Path: <linux-kernel+bounces-744692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EBB10FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111D8582B69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C31F0E56;
	Thu, 24 Jul 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJrqaO4N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEA1E5B7A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375533; cv=none; b=AcHfmB+vsZN9nBHNLctPUO/rwAN3z2fdmo3TZOdTD5Snd89W/1AZe9nMeWAWn47XmYrvjHb/SCXBbr0YY1zQFfTFf3mgvv7Hh6wB706F+AuoqDOHphFL2XUcvG5OsS8Un6w2PaAB2TwWOmtbocnl1oVGL7ouE/zyux3E63N8I6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375533; c=relaxed/simple;
	bh=osb7pP1Dxnjt3QVN9AJTn9QJiwHP639Jec032gob5rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ1qWskHuYlW/4eSjmsuDPNdqWTenFqRRr7e73Tss+k3jKAxT0CygvFoS7CupOCN5AYdXBjYYAJ7OrnIefVq1MSItDmCJbV82U1BJGsbS6XwCUeQLP0GoVV0MOeqzavaSlpShLIH3qlFMK/YR/hSBlgdawfI8RXf7M50Khu60v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJrqaO4N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OA5nCd017615
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VaRb9zpC453+UAqZ78fHrEC7c8i38sw8zSJ4myj40SY=; b=DJrqaO4N52X51pv3
	sIf/AZ0g8O9a9g3sWh9QteNUucHQYbDp159CRn0BmNmlwIvEO9kVBPhQnrEPEX0A
	rtAxBfKwGPAdzkkk7qqSk7e4qEMVmgWDPMdRdgGvPJ++bgDYktprHKPyk8ONEefg
	gkLXDm9watwyPB+WR86btA9vb6WOPzFXkBhw6Tio3lbZoCCTbOA+BtH2esyD93fw
	VRv9Zs07Imu8ukGf//I8a1h/2S7wJSvlcd/p76mnADzcm17lXnlJg1mXqRfBUY2J
	cfqXsVDRv4now9TNMCzZCNsvoeEA7v7lqKfhM8THFjjicddUxFMyFlPWmTqoaSnt
	+mLydw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3eva6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:45:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23494a515e3so9609225ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753375531; x=1753980331;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaRb9zpC453+UAqZ78fHrEC7c8i38sw8zSJ4myj40SY=;
        b=Xz4Ud7j2f4vLOmB/Etsu4Me6U5b5YIKMEc/EzM3YPKgC92OZQ9/EGO/Lf9XGGp7aQK
         uzoEsKaq9uMYJzUGi17B3VwblOEWWRuBGDK54oeydKD4eGYcp9pxBB5D4kdyvt01frRo
         v46zWzL+0iApOmr+vI15/7nbF5k7c6ZZaoWU2TX/8APErRu+edS+t8/SX1Zv+OPh6YXJ
         wI2oZ0mqrCcRNl6WZiq6qVBahkScwCZxCHiOeLtbyLxjsh0KQy5+SORn/y/HZPs0uhMX
         55bJQLycgLLEGc2aTbQiHNQnDyyAhX+14JZyMh93/fK/t/NDR5TCCNtR4CuSC5VyL7oR
         9/lg==
X-Forwarded-Encrypted: i=1; AJvYcCXh19WcahUnIml7HO/49qAObpZPaPXfOGl5pPb5C8Z39af8CjB9NiFGM+j8Y1o383fku2c6Pf5UPWY1BFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYCJw3/gXqsDLlIGc/ErmSdoiRiefD+0Zix8kn8rng5YzuCp2
	MI7td8uJP/2u+oVC1xiVN4GsTno5+wWUpswRthsQ1LZ6KxClcfYZ/YLM3u9p7t6R4ljC73/qp+v
	cwtqED7byL1aSOvziQ+wJOnPgJZNslNHvYary6gTaZGTWBDgBV2D3g1qyB3ALcIheHMw=
X-Gm-Gg: ASbGncsjnZ28y5yVklvdlJEPzTZ++C1fRKEbUHWq1AOvjhpOvw3Rwg+qzqwjBVh0hTi
	PJWc2H7oFAIts9qw548YjHPHcSsCjIDb1Jh+eimoFDDFHW5EpiDpyoPGeYFXiAZTcqVoy1ImqPD
	lbWAVtTQAM3dHzYsOEpeAEj8VbXeHfUiScFa8jBGLg+qvHH0SC/ku9QSzD2bEOAXMbNBXAneQxa
	VwOaQam3I9Faosb2zTNfxGavWoZ0nVKHACJgme+QtPi2SJKbvQSdsG8d1VKT6Xczgg00ec5vsbN
	pAMDejAh8uzsyoE37H0Wp70PcXBxMTuHbwUJVOUqNhx7OTvL2LiseLAanRG1hw==
X-Received: by 2002:a17:902:db06:b0:231:e331:b7df with SMTP id d9443c01a7336-23f98204677mr132438785ad.29.1753375530651;
        Thu, 24 Jul 2025 09:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpvYX2jYW1U/FwxOyFgTM+kx5Cd2w9I9tAzBvo64AFEnqPhhsH7VtWSVH5081qu+meM2GojA==
X-Received: by 2002:a17:902:db06:b0:231:e331:b7df with SMTP id d9443c01a7336-23f98204677mr132438245ad.29.1753375530206;
        Thu, 24 Jul 2025 09:45:30 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f3bcsm19431635ad.10.2025.07.24.09.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 09:45:29 -0700 (PDT)
Message-ID: <2820a69c-6ea2-4740-9264-7413ae5be70d@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 22:15:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
 <ac476949-d0e7-4058-ad76-c3cc45691092@oss.qualcomm.com>
 <53e0ae24-c32a-4b6b-a0ea-b056540c2f3d@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <53e0ae24-c32a-4b6b-a0ea-b056540c2f3d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dXXxUyHXWwjBzGmoM1TjFRX_qOYvubw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyNyBTYWx0ZWRfX3AJIAg4521JJ
 zaBYYxkt/VeNvhDD0G5PiGZP8xfMhMnkqeypiIURii44unIacxgDb4rhLnuqcufApACFE05bL/t
 S48T0YPyx9LeVOPw+FKW2nNiUsOI1RzwfnRuyE+HWXJrY4F/4RXVG0M6UIkXK0r/wItxDLucoQ/
 /3ZFvAvQdhfYrf/AfqC+z/PPjFLhgkZfvbtLY0YmLNgjMArXjD7g1vPIhbd9LhQAmIRruJBeyR4
 1MEL9FyIfn43bcOhyUPuYeNLNh6DVHdkcArKMYvN5noqGCHpVT/FdMv1sQPEb6XYn42/Lx+rupU
 ZzcxN+iz3fTNdX8+V77Nds5b+jq0dB0u3aODzdiOOZRexVMR7K++sJHyyfHa8QxqZaW3mYgLF5G
 38Pk7jgZMTz76QJHicWw+755nHXteaMj3wFhmr/JqaRO/7tCXWhpqhESwKZvLKxbBrXGjKOi
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=6882632b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=bFu9_hsFAaDUiof9l7EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dXXxUyHXWwjBzGmoM1TjFRX_qOYvubw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240127

On 7/24/2025 8:14 PM, Neil Armstrong wrote:
> On 24/07/2025 16:35, Akhil P Oommen wrote:
>> On 7/21/2025 6:05 PM, Neil Armstrong wrote:
>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
>>> the Frequency and Power Domain level, but by default we leave the
>>> OPP core scale the interconnect ddr path.
>>>
>>> Declare the Bus Control Modules (BCMs) and the corresponding parameters
>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/
>>> drm/msm/adreno/a6xx_catalog.c
>>> index
>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..b313505e665ba50e46f2c2b7c34925b929a94c31 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>               .gmu_chipid = 0x7050001,
>>>               .gmu_cgc_mode = 0x00020202,
>>> +            .bcms = (const struct a6xx_bcm[]) {
>>> +                { .name = "SH0", .buswidth = 16 },
>>> +                { .name = "MC0", .buswidth = 4 },
>>> +                {
>>> +                    .name = "ACV",
>>> +                    .fixed = true,
>>> +                    .perfmode = BIT(2),
>>> +                    .perfmode_bw = 10687500,
>>
>> This configurations should be similar to X1-45.
> 
> Including the perfmode bit ?
> 
> +                    .perfmode = BIT(3),
> +                    .perfmode_bw = 16500000,
> 

Yes, both.

-Akhil

> 
> Neil
> 
>>
>> -Akhil
>>
>>> +                },
>>> +                { /* sentinel */ },
>>> +            },
>>>           },
>>>           .preempt_record_size = 4192 * SZ_1K,
>>>           .speedbins = ADRENO_SPEEDBINS(
>>>
>>> ---
>>> base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
>>> change-id: 20250721-topic-x1e80100-gpu-bwvote-9fc4690fe5e3
>>>
>>> Best regards,
>>
> 


