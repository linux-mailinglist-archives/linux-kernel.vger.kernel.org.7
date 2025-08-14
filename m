Return-Path: <linux-kernel+bounces-769402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D73B26DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1333B7152
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1136310773;
	Thu, 14 Aug 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMPkh4oK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00630E848
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193941; cv=none; b=aUlujAmbLIqWuGMbZ8mYCiWSMhBG5rM+7XxmTJOoM9tJk6XuQQ2xgPSIfTiUp3LHbDggppY/fPDMXMFGJ5iYCnLGFLs0toKzixf7t9jiar1VnreE7Xu4nusLQB7ux52jWqKUDYw/0rx6R/5CRjJmcgrKTXBWloBsZv56tv4GOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193941; c=relaxed/simple;
	bh=AdeW0M9x6hlf8EJEHi1iljsXA5eJV8IK5H5QGQIhK2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twjYVWy4RzjTb8rdlDS+gAWPZ1LKDkToH3sCu3qw9Wdaxbb1BwMpet0rXEmgekf2lGlhH1xFvzPTKa5uTEMpTQLI2+lfPAxM64/KChLOdhSMJGDWbbjAMS0LkLQAFf2SBkGX1T8EKVGwgEByt9JMpe/3Yi8C4/T4C77vlVDf7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMPkh4oK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9bdDg012991
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf1KNla6dRvfydP3rOxmCpoNvWjKiR17gEq81Ru/7Mk=; b=AMPkh4oKUw7tc07r
	34OjQkKiwy94XH8TppZ8C0lknz/11zIT/IR0EFDCgRTD3PvdsFAR3xGHJQdyiPRE
	iAgUFqASufFQRS4qPJ/XvxEkt355x48vQjd/p1sCOgMnGRqzY/Zp+OVhTXupdNVX
	EGdm4jUfq5pjyO701DXBcLGIxqXdcELfLRGa12K+Lgm+Jc6okDLmvFNFPMeNLegZ
	t7ZRsE5ALL+zSNoStzyy6tmgCgK8Bd8iL/vRKAvsbSo0/15nZ3mHreNK1KKGklmd
	2MW9Vildv2eHkJ3TEPR16aoZo/RJOGVnJUCb32IVFrRNObQgtIaexOOJnVY+MmwZ
	I1URnQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6vjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:52:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109adce15so4253821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755193938; x=1755798738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kf1KNla6dRvfydP3rOxmCpoNvWjKiR17gEq81Ru/7Mk=;
        b=P6x+4FBZnF6yH3zolka7UrqrGs8LG65572m7R7XKg4mA81g6kcSJ7ShhfFmNH7elWw
         TK5qDndIVuXaoGcQH9WIvWHqrEe14rQOP0qygCw6qqbDdF21sD6DaumOIa2BMtX/EqXj
         NG9d3sJT8k4aGxUMYV1fH5P5KeZk9D5N0JMyfr1Fw1TM1i1BC0rCyTfw+YPgjMwV8lKu
         xaVu5s0qkamazTWPOjTUaOUHSX34IgoO+hInUQFIybdJiolhkR7+VGJPYI+5v9aEd/jn
         7mx2neDWUSYYQslEVtC06e4OiD8n9VV2hpVbRi4FUSdP5nwZ6bA59EHvGHYl/cho+zwe
         zYcg==
X-Forwarded-Encrypted: i=1; AJvYcCWGSii3k2YSSYcpP/sdaa91H2KEEAsZnuKpnlaRbcy5+6cbfGtnruEddZIfMTqPKVVkNfU1wliGwCQJbQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqikR2hfrNjuHTFoygjJu2Pu3p3PW9qW3FjKeQN91dfATCJZBb
	Gu5RhrmSXPP5Jb3dksrSJxqOAV8FgEkKpRUyJsyiAxwGRccXW7gXQ8eKwY81zcgGjC6QerR0T+c
	H2VmIW0gZCQox59ANrRSs5K/cAMhFNzLc7jm35QYYeh8DTlLZkoskVcVIS3rM8WIU4PQ=
X-Gm-Gg: ASbGncu5eo9BEW9QzN+2347q8WyQQ1ukmHauwYPbAiI4yI2NeosEvhgB2ygC8p838HF
	Z7ndcgQgeVOWQ9zVQ2omURpmnibfGKVVCj+abXQVfIcBwUXgOtyMvgyFVw/LwDdBeGSJGa2TS9F
	/lpCEMFu5HnpCp+/iEbdunmOH/giZbYbnNuQLnIhlU39vdUAr91a+AJFzKR9DY8s7wK/CILaXey
	QNTCRcGhArx1kZeBAE+6xO3IwSy83RWSGmO9QZm52ESJrmyRYxNXrIvOYBeAYCv9OnxODGNRc+Y
	OreM2151Q14A/LZV9qePU0MN1GSKCD/0BnEH+lSffrK4RK3xhyveVi9JkUZ1cbUrgOy1/Ph8ttH
	FnQlmE90GDk3OOCrAnw==
X-Received: by 2002:ac8:7d12:0:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b10a98ac48mr29607251cf.2.1755193937999;
        Thu, 14 Aug 2025 10:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnts5b3T3oPwnRC47gGDR5vru1FmCBJm2j7CtF+T0NTcUjDzn2U3ZeqG7szkJIlGQBWfi7zA==
X-Received: by 2002:ac8:7d12:0:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b10a98ac48mr29606861cf.2.1755193937163;
        Thu, 14 Aug 2025 10:52:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766d1sm2630993066b.18.2025.08.14.10.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:52:16 -0700 (PDT)
Message-ID: <df007b41-5c3d-4c69-81b9-27155485ccf9@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 19:52:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
 <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
 <b4f283ce-5be1-4d2f-82e2-e9c3be22a37f@oss.qualcomm.com>
 <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
 <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX719I2MqaIPRD
 +ZHII6Zd2XFVs2poxXwqQex2peV0mmgkOQbhJnA0mM4d7gPObP4U1gvwq7uZR68J3yefKBruYVX
 KXFTmqzIDZFqLZwyYbHeaM8+XuXwdp1BxznmsgBAap9gUdlPARhCPfy2a34y7EtD6Xzoli9kx5A
 h/6hn9T0HKpTKak62TTBTHIRBpNibVlIQFmXcC8JfSCz7ka14YsrI+61c2H5eT/fnFUMBWQ4E49
 85uFLS6eul5KifSLHVq4aX7HVRGOuXfRNzV4jKb7LrXi+HZKpE32V6CiaOG3NUprjoCq3Ltt0UB
 xONNW+3Sxn08mVQ0MBOQK13E39Qm3pdZjKr4WBzXO0NOzxYbueeBHoQKqiYGSgPD42KMj+Dy3SF
 RISZJiOr
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689e2253 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=06jlRiaS0U7peylTb-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sxgzODXPLM6qYy8QHK-F-mIF2AZRA9Mm
X-Proofpoint-ORIG-GUID: sxgzODXPLM6qYy8QHK-F-mIF2AZRA9Mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/14/25 6:38 PM, Akhil P Oommen wrote:
> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 14/08/2025 13:22, Konrad Dybcio wrote:
>>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
>>>>>> along
>>>>>> the Frequency and Power Domain level, but by default we leave the
>>>>>> OPP core scale the interconnect ddr path.
>>>>>>
>>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>>> parameters
>>>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>>>>
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Used proper ACV perfmode bit/freq
>>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
>>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>>> ---
>>>>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>>   1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
>>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> index
>>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>>               .gmu_chipid = 0x7050001,
>>>>>>               .gmu_cgc_mode = 0x00020202,
>>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>>> +                {
>>>>>> +                    .name = "ACV",
>>>>>> +                    .fixed = true,
>>>>>> +                    .perfmode = BIT(3),
>>>>>> +                    .perfmode_bw = 16500000,
>>>>>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
> 
> You are right that BIT(2) is GPU specific, but that support was
> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
> use that in Linux too.
> 
> I know some docs show BIT(2) support, but lets not bring in untested
> configurations.

Eh, then let's get the docs fixed if you don't trust them because we can't
work like that..

FWIW this is information from per-platform RPMh cmd-db data

Konrad

