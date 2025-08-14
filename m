Return-Path: <linux-kernel+bounces-769304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003AB26CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31211C82200
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE56288C39;
	Thu, 14 Aug 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgD3YFgW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8A22DA06
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189516; cv=none; b=t+rPVNPQbpf6VJZUASXFO7sm6D/poImGWv5JFkP5F3twbOK3wI4jz4yw6RDRVjEQLmBguqm7uh0qzp1hIplCaF3RLVAPiFSdQ95Kd7E9iL2QlE5UKY7zihGJREU83kk3TJQ5IbAG8wZsTEY2ePzQqUUnEsSGMWgV1dkbnmZXXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189516; c=relaxed/simple;
	bh=9ANSziEU7LiyMu+M2PSkJh95p9gLb+UL9MxA+IfBKBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPcZFx3V+t2n/Dm0KMRNjhyjOLLoNn+s54JGDkjAU1IVkggTcy2hfVN2QOQRtfyHuWZtTB9Ss9pyVdLVRcavVjSrkkIJFGyxRIf+lt27t2uB7eBE9MAnaf8JGtC6Xr8/sv2Z1UNJnZ819CqS4BAilzgUetZFvosObzYiqJSbR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgD3YFgW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E93AmE027018
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jaTQfIJ1yVIsO9S61XfkZRmWT+mBRLlhDRy6dXJpoxk=; b=DgD3YFgWJFQFRh1m
	hGf1+FIo04Co6vUTW+fhtdIbSuyhnAGxW33sLBlzoDM7UglZcHUvJOG9+3DmxE9/
	8WKWrvmWg60Q17oFHxtnY9Wvqm98uZnTDd7/IFscWIwC9Mv67pqmfNKMocrL1MhT
	DDSFiZAOLvv3nPg/OMRJJlVqaHhOLZ0XC09/Z1WrWrXdQPb8h6T+9XxKkOBl71s5
	ASLQPsYfyMZdbGIeGJSyy/5Ksc7dvyNsatzr6cRVqr3hJ6ZeSvn2ndrWF1uEUh6p
	O27e9tRl4i/oTTApczcM1e3J4c33c/iw+/GXyK5F45RmtpAaTIrXOLmatCmftUUN
	V82GWQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjv93f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:38:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2430c37d06aso16845365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189513; x=1755794313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaTQfIJ1yVIsO9S61XfkZRmWT+mBRLlhDRy6dXJpoxk=;
        b=D2bQKyqPdDyMpExg+c6M8zV9HDXyJj3LatAw0iUKA5oA35q84nBqDQm8BgPDtD3Qjx
         p9cpyWyHayhwtbYrWfAOIzYtOeXThKeuCivxPy5oWDpKiuNkhlIfImj6ufg5ShqV2wxa
         Qp/sw/wm981FDMP1vnWzijX2Bu0Y/lysgItXnrshqIZFaC2xtlkd8GGgOdbacd+/zrLn
         JXXzreAU5rY7H6kmHd6fcaG6sahntt8jUkX0QND/Dhne2CuOFlZCPMHHxiy3nayGwllL
         q2GGdTsZY/PKaGudJLChR/Q8f+GmEUrU0+VLqP6iY0FwvjS+KMOF7Mfrect7B/RmU41m
         mitw==
X-Forwarded-Encrypted: i=1; AJvYcCUot0PUQxl1XEYa56DZJtwjBZbB/Tg04yKRrV8sJ64Be0SCyLp2B8mhoO+8KiJ1X5HtW5vPrfWfXw06O60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDCiOseCbptxT817aj/rY7SQJZzCJW36E/n1g/3p5ftpzFbgl
	ZAHYvGbx0x4yifH5Ro6AFgGlPK/clMGMcX9JJqUXGRzcwX4iRvLXzv4/poHcSRDLmlBvV7wzoxq
	0W3xhz9nCaYTln3js++uLUcY8HiAxtkg09JsRLcgbTYZTjFgXiGg+5cY6HyTAbeGPyTs=
X-Gm-Gg: ASbGnctJjh/62a+tGjsY6tj0rePR8b80osz/Z4Md3JafTilqWw12qmg345cwm3OkSAE
	1vTW6ptcdZmaJWtO8UOhvYbphB7yREnKAtjg84pGI7gbda6aMx2bJ6CduINMLowqdcmfPkHPY+3
	2KuweAPkE6Ajrz8N1sBg7GVOQEVMP3MudLk0XNCNqnLnW92/wsrNijZ44UncRujGeWZxolDcwnq
	5WnuulL02SGvewzCiVhIDsEJXBXR+6h15Xl4YrXppV0iCw+ioqymlo3Y0VshJ6Br5dQC8TlBQBq
	tGP/+1uIQbazW8mPU4sH4iKgHrk5eM/XKNWcCuOnL6PDQFvTWIlOGpsAobA2l/I=
X-Received: by 2002:a17:902:d483:b0:234:1e11:95a3 with SMTP id d9443c01a7336-2445978c8ccmr56761355ad.13.1755189512843;
        Thu, 14 Aug 2025 09:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA5KjhREwZxocKHlp81qbREqS5IgYM2U1497mlRdma3ow5tbSm83x7BFjlpFu8sePsAp2J/g==
X-Received: by 2002:a17:902:d483:b0:234:1e11:95a3 with SMTP id d9443c01a7336-2445978c8ccmr56760915ad.13.1755189512299;
        Thu, 14 Aug 2025 09:38:32 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24300f8c9d1sm71788655ad.129.2025.08.14.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 09:38:31 -0700 (PDT)
Message-ID: <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 22:08:26 +0530
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX0IzZjA08/bIb
 ljx2BO9lFsskNat2K2GeUIrrtjytdeGLxtu8D+TvMPRxoVsNQs5YSpqlkmkWAhiNm/S7EEm0lMY
 IpIKuSMjgXcvnxXhZXZhyee6i7eQk+O73WcAD7EPd7D8Ea7lxVkdYr4IrUWLKhzBNi4GvpLJ823
 FSwFFAO2t5i0gamRo4fr7VHAo85sBSHvaYudlH69kd/bGN4M8yPSGRwME6OfhqfeWB/KFgnH4BI
 FQHxB+BRSZ6BalKjNtFzkpUFYYknyIL5WVv8v217opdeW26b/fQKvG1PxM/9ntH2dmhAbTTHApl
 5GiuXX0wtnxKPT7SYHjB2HJl5mx6qpi7vZNAJq0b5dD69OAg6w0o3Btvdf4KghzUbWulEgUJRhl
 Vci/Zvvv
X-Proofpoint-GUID: 6a8C-PWOTUmhRrs0h3j0kNMziBu1F2sq
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689e110a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=geSN8yY6MFID4zSGlH7RRw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=7lXMnOvvf2IE2kTxY-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6a8C-PWOTUmhRrs0h3j0kNMziBu1F2sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/14/2025 7:56 PM, Neil Armstrong wrote:
> Hi,
> 
> On 14/08/2025 13:22, Konrad Dybcio wrote:
>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
>>>>> along
>>>>> the Frequency and Power Domain level, but by default we leave the
>>>>> OPP core scale the interconnect ddr path.
>>>>>
>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>> parameters
>>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>>>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Used proper ACV perfmode bit/freq
>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>> ---
>>>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>> index
>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>               .gmu_chipid = 0x7050001,
>>>>>               .gmu_cgc_mode = 0x00020202,
>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>> +                {
>>>>> +                    .name = "ACV",
>>>>> +                    .fixed = true,
>>>>> +                    .perfmode = BIT(3),
>>>>> +                    .perfmode_bw = 16500000,
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>
>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)

You are right that BIT(2) is GPU specific, but that support was
commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
use that in Linux too.

I know some docs show BIT(2) support, but lets not bring in untested
configurations.

-Akhil.

>>
>> This is *very* platform-dependent, goes without saying..
>>
>> I see BIT(2) is also valid for X1P4
> 
> 
> I'm confused, Akhil can you confirm ?
> 
> Neil>
>>
>> Konrad
> 


