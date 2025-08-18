Return-Path: <linux-kernel+bounces-773031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1BB29AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5EC3BE1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB18279904;
	Mon, 18 Aug 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2yIIDLh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038C277038
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501447; cv=none; b=NFYRNxy4fcC2jxT4758uMZJ/EFB8AV6e4wkfgsLPPgePr8pTc91XkyHBvqhKVlDRNDCbmiWxGtUMq8PSDCElClmrzTOMAqXiRn/d5GQ41HuO22FV+zY9B6VK5Mo4fYFJjsOIZJbdCDqbsVNmYKZKxjGsvlx5iEvX/hDkDMD4C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501447; c=relaxed/simple;
	bh=mskqzcwXUEQssLCCogFV+cQAjdH2yJSOJeltUxuqDyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snJHvUENDCLwR/SN4Ykd1UHDVtzdEQOKJAYQO/vU2IxXrEo3jpOX4eub0iFWZInCQBjlzEWCivYQNOk1AL+jdP2+gvRBhw6Xq7nj3+mbMyVTa58Xfy8ekz9bqreO+AD9u13N2dpowztILk9OAM0raCxniyyby8lNbAjTQrA2FSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2yIIDLh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMbgnJ026772
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/qhnVhx2Ak6MmVxTVAge6g/u9xCi1sPaDT0gtIzKOTs=; b=i2yIIDLh60u3/pai
	iGEyQnRONS5vyvdznnmZ17Vjr8DHLxqUR1N7EJ6hPHyGbexWjXrpr7collEmvexA
	UK1xkUgQW7fh4QBbYauWbS+ljauo10SBwRlZjV42PtgglcZ1VqRzmI5bTmofvQ4i
	HMQExpzLy5lJXFwTAEXIF+8GGwRzAlbQslOhQDYdVGf3ZpkIzYgfzJnf9caY+RyN
	kgF6JlMYfDxp3xM+E8Li5D9RfwHzeaju+x3Thr3kPmaMNMQpYoTX7AL519FV8Ylg
	89AdsOLKi/+bxn8I7YRg5ZCS7PMOB/M4wBXQsktVcJExxqQYpHnf6XWirxmurj4v
	IzZw3A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ubre3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:17:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so44977055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501444; x=1756106244;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qhnVhx2Ak6MmVxTVAge6g/u9xCi1sPaDT0gtIzKOTs=;
        b=IHAD/f5xU5NWswC59Gc5tqCjXrs8YX7t1qnd1LzH8QkjFIbxu+J4oJOmGoyJzRI7UI
         V+lqDEorSTvWWykGYA88Oaen40VamxO5aY/AHmxkY2KsH+GxyRIRB+/5OtOl7cwytrFM
         F5/gfi8gq8QEcHCd5krhYdr7VX6O3jrNstXQ4qTOvTneaPCnI/8ZSKzyaVvkTgQdJARC
         qltSUiZpQlvVw+nW2UvyTFhmf1fhrIWpqEF6WlIts/4E0Pnr4EVqgoeOya8DqNoF207q
         uiv29qlBIYzsoRKOvebKXJgrq0P5Fps6nJ0RsEH1mQk81rwWB+iEm4IoIGyKNY9FJVMH
         ItLA==
X-Forwarded-Encrypted: i=1; AJvYcCVZaRBWvxvWf8RqzNxxpKxN3aHOp1pNOC+hjXtewxZy0I3I53Pp7TGMGk5N2Utr42waEDMSs2Up9dlYy2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zwlbjrb1D3zxx6R+BhBJF5JQjqTRcuNJ5zms7GHU7XgqT1pH
	ibu6U4VOf7YrEYn1ddhe8ODX6rjK8nDqlx6VAYImXWpIEt6Ord44FlszApGkBk4mweOpcS8S6hP
	692s+FqWrzMr+fVKukMRfb6u9/WcGlYN9meW+jRFEPn99u5WUNb+kC6ZZkRd+bCsiNeg=
X-Gm-Gg: ASbGncvpktrED36qZcOsbKx97LnItk4sXZNEZGpYxuT8fa0CSEtPEPgVb6Gz/hyMyak
	kFZhij6tqnkKXuoNKsHpWkKy86Y+B7bottB1edPiS4IE/SydQo4oRZnnatRnREoaKaKV18kgTKN
	TB14Q4gbj/HfS34wwm7ibqGZzP0wUtZGOqjvIQid0uB0F07zN0e4loLtuZ7ABZ2hn9IPyUpEBtB
	qDAiVw3EaOReYCZipLzlWIiPtXDTqkHG8u+4Zhizmu7GFPbkQF997ywOT+aYA6gKDSQBvO5kuQ7
	7Wlu29DCx090jYRgS7pLdqA7Lfkg2ix1nknY9VLpytSajFChq98UMOSmqHgoSAbD
X-Received: by 2002:a17:902:f645:b0:240:86b2:ae9c with SMTP id d9443c01a7336-2446bdad87bmr122769625ad.14.1755501443892;
        Mon, 18 Aug 2025 00:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQzDZnDrRPt9e9ar4NcGlKQx/v15yiS7nW8hWVOCiahtj0oNaVAIJtchO0QDQCqoEqEh/UUQ==
X-Received: by 2002:a17:902:f645:b0:240:86b2:ae9c with SMTP id d9443c01a7336-2446bdad87bmr122769485ad.14.1755501443427;
        Mon, 18 Aug 2025 00:17:23 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.229.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9dbfdsm71325165ad.19.2025.08.18.00.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:17:23 -0700 (PDT)
Message-ID: <77db4861-4868-4110-8c31-eb2045ddbf4b@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:47:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <pxigrjxtizcrhn4l25ph4yh4runebintfp4swqfiewfq5hqceo@g5cy3mdgjir5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a2d385 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9Q8gPALlkHEzzDxkdHlyxw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=tT0-4YtFDMztOtjXKeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ITkovWhpHZqXfLm7_zWqTx6p269y09mi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX5ri4BfLE8Vy0
 hX4EIaxqbmmgqfEhd/s/ffkFKas5HDSGld0ad8r2VM/g8PaSnxLp4cLviEUyyOECcwhXik7i6D0
 niQNQedbL0lWu4AwPjKAJ3HpjC1jv5I8N3lHy9YrDcMi/VLIcqkSXHTbQNcDfvps2APFmzMzfDR
 i+j66Q/izCApzJmzOyAh4LKb4rI9E4nKFtUJtTsnFwGWqssHFSJ4M2Rxc2edf541uQqjQXlJrwl
 nE/fmNiTvZHybIOd0KRwz31xJDxT5EsWN2wrkhIEhCPL6CW4fTZkAMWevECSWDJ5KhxFRUAUTdZ
 cjd0exGz/kgVh4skcfbM6hsp8AUaQQEvJTqF7XpLgOWkrPGkKGSmziDIvOZFwjh2O6vhlJfC9fJ
 dHVdXGWv
X-Proofpoint-GUID: ITkovWhpHZqXfLm7_zWqTx6p269y09mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

On 8/16/2025 3:45 AM, Dmitry Baryshkov wrote:
> On Thu, Aug 14, 2025 at 07:52:13PM +0200, Konrad Dybcio wrote:
>> On 8/14/25 6:38 PM, Akhil P Oommen wrote:
>>> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 14/08/2025 13:22, Konrad Dybcio wrote:
>>>>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>>>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
>>>>>>>> along
>>>>>>>> the Frequency and Power Domain level, but by default we leave the
>>>>>>>> OPP core scale the interconnect ddr path.
>>>>>>>>
>>>>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>>>>> parameters
>>>>>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>>>>>>
>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>> ---
>>>>>>>> Changes in v2:
>>>>>>>> - Used proper ACV perfmode bit/freq
>>>>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
>>>>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>>>>   1 file changed, 11 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
>>>>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>> index
>>>>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>>>>               .gmu_chipid = 0x7050001,
>>>>>>>>               .gmu_cgc_mode = 0x00020202,
>>>>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>>>>> +                {
>>>>>>>> +                    .name = "ACV",
>>>>>>>> +                    .fixed = true,
>>>>>>>> +                    .perfmode = BIT(3),
>>>>>>>> +                    .perfmode_bw = 16500000,
>>>>>>>
>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
>>>
>>> You are right that BIT(2) is GPU specific, but that support was
>>> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
>>> use that in Linux too.
>>>
>>> I know some docs show BIT(2) support, but lets not bring in untested
>>> configurations.
>>
>> Eh, then let's get the docs fixed if you don't trust them because we can't
>> work like that..
>>
>> FWIW this is information from per-platform RPMh cmd-db data
> 
> If it comes from cmd-db, then we should be requesting it from the cmd-db
> driver rather than hardcoding it here.

Not really. This should be under the control of GPU driver.
BIT(3) is correct for X1E.

-Akhil.

> 


