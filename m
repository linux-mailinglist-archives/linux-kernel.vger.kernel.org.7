Return-Path: <linux-kernel+bounces-806397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840DB4962D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241E31B23B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF13115A2;
	Mon,  8 Sep 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFkVSiPl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDF30BF70
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350288; cv=none; b=Dtm0iULOTRXUXIW3/OnHaL+goGTAEhbayoWNX7i+G1u6PPN1KEJMjC2yjPdMpEZXD7f7COaPMHrfm4prAm12lpZdBxGiBz+J/kqO6upyBK3f1B6hN0+i36zGpwlxoPKeqI2QCqdiMgwpjYQROjIwX4eY6lqXbfodrLI/uX1aqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350288; c=relaxed/simple;
	bh=jXCaVxgwA+wpwrNJLOU+dIp0qXgCheh9pPboijAc+CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXc83RAEvKNUMBVzezGOZW4ufOOeHUsHbcPNldS1JAiNHwzsgaIr6691QX/2fmIIqUVZ0CcR+3/UqP8IKNPjfb/VCRNwc+eHrxRfyR7ngOleibZN6H++JNozXSZMz8SKoL1BFfAdiy3WKyghujy36jXNkYJoE3OqGoCXoZNd8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFkVSiPl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588G5EFv001547
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S/+zeaYd116Dx15iEiK9NuMeAKSenvu/yLAwNz8B5ro=; b=FFkVSiPlnxM8h3/b
	rEEV/CO6t6tA2zW3Qil+GtG5629F+DtJu/Yde8JrJxvi6rESeWwM5mjRwvaI7E7E
	Wjae2gvABnRVJCgi6Cn/Dr2C2d3gC3EFkOzfFDwvWbT0bVIF0dViFaW3zdOvaOvC
	TgqS0EAplQFnKS+JzaVZTl7A2MSO3O7NIjtn5BR+u2yP3AU5WZJCbK196H3X1vsw
	Gk/gxaNZAptvm7HCLlaUTOV44xggH/+jni8ZWTQg3cUsYgwi6+MpRujQrN5KclDx
	ZmthR6/qaU5pKTURdNwbQXhPQA2X5qoFqG9dn/mxgkWPDUQ7Pwk6LrPjU+KTS+ns
	3cT3Jg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8dbxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:51:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471757d82fso3353119a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350284; x=1757955084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/+zeaYd116Dx15iEiK9NuMeAKSenvu/yLAwNz8B5ro=;
        b=t3CqjTetG6WSUkaEZvM1u1Y1p+LSHtRD3Vi2CG1M+y+sImNTBIHsReG6CCvdycAsVJ
         OJrkVngmd0R6pjcCv2jO1qnK9W0AWPQ6tPRn9PVrXAmXl0y7ogEe1DQRIAMbD7aAFrzM
         Bm9ZBzjryFB0gg2Yyk9AiF5oXqjc9hxFVJpyBZcL+2JWNsxTz0y3vXW1K0AA0P1M5nU8
         aSypzXPIrPaXyilMZonij2XCJBa3Y1iGk8G3MYh7JeyL8hHcPc27tTIRMqgfDYQIR89z
         oQ4rP0KwIIrgCjYVbVH39iabxY3M3WDj+PlI3pFjsWLGhLtZ26QNMttia3yWLGwvfBdS
         S++w==
X-Forwarded-Encrypted: i=1; AJvYcCVI8euZKCYVfEpOPUTzepOgqCiZaD/zEFfNfB9+8mwEBBMeYoU46N6vb+qfLULVns4yf4RCy8z8VFQwb18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVXSCpt8zr8PSYn8eNYHI2YBUB7LorR4DefUc9wIHPEVBDK8p
	OkycefObmvHXSfmCcw+jPD4Q/6aWCo7Z7U+IEV7RoYih38bpK5JpjxhyM85xPn4YKrPIEtmgxVE
	kE1ImQ4I9ch3GcsxW33ucdzNSwZRMuewMgOLiCnSAOAUHJjFbCydB47j9zbzecTLMLZE=
X-Gm-Gg: ASbGncsY1l2C7M7UZJulkOF3iLZSkaSKZus/4YHneFXAjkt0sv/k77/f7/UQmcXOTiw
	lE/n5kTg8zitM3GnPSXgGOMmImevLPmEYLEn89JEilgF7HTAVeKICFS9sPLkxy6WWvA3TiWBpir
	ADb1fvABSvfISd5KVORj1V4CxY9Rvcn2WShegZNfwJ0VcQymMruVgQy0OQ9tdF48Ymy4IRnDWIl
	W/yaZ814aM14y57SKbOguUI54I7Y5Y7xvSd0qBHozyJ27XwRisJf5Tqb9X/d4Ls3Kn2oKgyP4gF
	v8pNZYJ8gW/Tj7+MlpbeHhuCAhL2l1tUu6g9a6U4dFm3VQFL5TpQNchY2SdTww==
X-Received: by 2002:a17:90b:4ac9:b0:32c:923d:b832 with SMTP id 98e67ed59e1d1-32d43f60885mr12205938a91.23.1757350284386;
        Mon, 08 Sep 2025 09:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoTXxdRyvNWH6SrIRGKc106RSjdLehTELZS2revNCY8iV1PAXoSzB7fP1pZgGc2alNIfxrIw==
X-Received: by 2002:a17:90b:4ac9:b0:32c:923d:b832 with SMTP id 98e67ed59e1d1-32d43f60885mr12205893a91.23.1757350283756;
        Mon, 08 Sep 2025 09:51:23 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b94a3fa06sm5216758a91.9.2025.09.08.09.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:51:23 -0700 (PDT)
Message-ID: <e4d3e195-8d62-48bc-902d-b42fdbe9a3bd@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 22:21:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
 <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
 <b4f283ce-5be1-4d2f-82e2-e9c3be22a37f@oss.qualcomm.com>
 <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
 <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
 <df007b41-5c3d-4c69-81b9-27155485ccf9@oss.qualcomm.com>
 <pxigrjxtizcrhn4l25ph4yh4runebintfp4swqfiewfq5hqceo@g5cy3mdgjir5>
 <77db4861-4868-4110-8c31-eb2045ddbf4b@oss.qualcomm.com>
 <4fa44ec5-2792-45e3-af87-b3e4d2ed5d86@oss.qualcomm.com>
 <dad0a37f-38b7-48b4-983d-fba265bc66f1@oss.qualcomm.com>
 <f00dffa0-11d2-4e88-9770-c34682f770ff@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f00dffa0-11d2-4e88-9770-c34682f770ff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX8SyfQ4hr7ofU
 egO/TBGBHIQfy/L+Qjzqf3d0IbUv4MdZYgga+xGkm0qo/VEvhWHZ0dTrPKiQhT8w3WgR013PUFt
 MWWtneYWtUWoVQmu1q3WIm26tydCe+upiBTr5a4f1gCME504eDD51INuFCAskir9gxTAqcCp9xe
 sCtDLDQDS9nOmgZ1u3RK7nNbh+CUv+dVZL9WOOxQVy14GHZ2mh/bOX2OMhlFgRWEJrZ76KzJfpw
 tbJAcAwO5ST1VHxapjfLBkZl1deMUS/N0T/UqNwRKS6oMIBbvMAPY6lkCq89OVWax2NN4jRA9hW
 +lmk4etpDD75i/J4ZQ1AQZ1Hovcp+oB0oKSFKSd+QjJWM9o5CkYoVDkgINtWYlhmY0uNJOh4YP+
 PrVwc0Yn
X-Proofpoint-ORIG-GUID: A0yhMNt2J9_7Yp43d4JhUcf7nIU0X_Lv
X-Proofpoint-GUID: A0yhMNt2J9_7Yp43d4JhUcf7nIU0X_Lv
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bf098d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=tOSjwr6CXn1eiJSsW0AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/8/2025 10:03 PM, Neil Armstrong wrote:
> On 08/09/2025 18:29, Akhil P Oommen wrote:
>> On 9/8/2025 9:52 PM, Konrad Dybcio wrote:
>>> On 8/18/25 9:17 AM, Akhil P Oommen wrote:
>>>> On 8/16/2025 3:45 AM, Dmitry Baryshkov wrote:
>>>>> On Thu, Aug 14, 2025 at 07:52:13PM +0200, Konrad Dybcio wrote:
>>>>>> On 8/14/25 6:38 PM, Akhil P Oommen wrote:
>>>>>>> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 14/08/2025 13:22, Konrad Dybcio wrote:
>>>>>>>>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>>>>>>>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>>>>>>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>>>>>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR
>>>>>>>>>>>> Bandwidth
>>>>>>>>>>>> along
>>>>>>>>>>>> the Frequency and Power Domain level, but by default we
>>>>>>>>>>>> leave the
>>>>>>>>>>>> OPP core scale the interconnect ddr path.
>>>>>>>>>>>>
>>>>>>>>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>>>>>>>>> parameters
>>>>>>>>>>>> in the GPU info struct to allow the GMU to vote for the
>>>>>>>>>>>> bandwidth.
>>>>>>>>>>>>
>>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov
>>>>>>>>>>>> <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>>>>> ---
>>>>>>>>>>>> Changes in v2:
>>>>>>>>>>>> - Used proper ACV perfmode bit/freq
>>>>>>>>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-
>>>>>>>>>>>> x1e80100-
>>>>>>>>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>>>>>>>>> ---
>>>>>>>>>>>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>>>>>>>>    1 file changed, 11 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/
>>>>>>>>>>>> drivers/
>>>>>>>>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>>> index
>>>>>>>>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info
>>>>>>>>>>>> a7xx_gpus[] = {
>>>>>>>>>>>>                .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>>>>>>>>                .gmu_chipid = 0x7050001,
>>>>>>>>>>>>                .gmu_cgc_mode = 0x00020202,
>>>>>>>>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>>>>>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>>>>>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>>>>>>>>> +                {
>>>>>>>>>>>> +                    .name = "ACV",
>>>>>>>>>>>> +                    .fixed = true,
>>>>>>>>>>>> +                    .perfmode = BIT(3),
>>>>>>>>>>>> +                    .perfmode_bw = 16500000,
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>>>
>>>>>>>>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
>>>>>>>
>>>>>>> You are right that BIT(2) is GPU specific, but that support was
>>>>>>> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2),
>>>>>>> so lets
>>>>>>> use that in Linux too.
>>>>>>>
>>>>>>> I know some docs show BIT(2) support, but lets not bring in untested
>>>>>>> configurations.
>>>>>>
>>>>>> Eh, then let's get the docs fixed if you don't trust them because
>>>>>> we can't
>>>>>> work like that..
>>>>>>
>>>>>> FWIW this is information from per-platform RPMh cmd-db data
>>>>>
>>>>> If it comes from cmd-db, then we should be requesting it from the
>>>>> cmd-db
>>>>> driver rather than hardcoding it here.
>>>
>>> No, what I meant is that there is a piece of configuration that reflects
>>> what goes into cmd-db as its compiled and that's where I found that
>>> information
>>>
>>>>
>>>> Not really. This should be under the control of GPU driver.
>>>> BIT(3) is correct for X1E.
>>>
>>> BIT(3) is for APPS, see the interconnect driver which also uses it.
>>> This will create conflicts and may cause unvotes when some other
>>> driver requests perf_mode through the ICC API, but the GPU is sitting
>>> idle.
> 
> Yeah gpu will vote via it's own bcm drv interface and they will be
> agregated in the rpmh.
> 
> It's basically the whole point of this gpu bandwidth voting via gmu.
> 
>>
>> No. GPU vote goes via a different DRV. So it is independent. Anyway, I
>> checked this further earlier. X1E platform doesn't implement any
>> perfmode vote. So both BIT(3) and BIT(2) are no-op and are ignored by
>> AOSS. ICC driver's vote too should be no-op on X1E.
> 
> So I can drop the ACV bcm or it's a compat for other SoCs ?

Lets leave it as it is just to keep it consistent. There is no harm.

-Akhil
 >
> Neil
> 
>>
>> -Akhil.
>>
>>>
>>> Konrad
>>
> 
L


