Return-Path: <linux-kernel+bounces-899026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F910C56985
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1833B93DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCB2D63EF;
	Thu, 13 Nov 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ2znY/d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+ZADLDT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2272D77FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026039; cv=none; b=WsR9GE0T3KwAPvVAivZg0kGgg9xBk51aWucB9Ew3XJDGTE7wzcw/lmGZR5K8pXVODfHxLyQqLxAtGLwUNHKn1OG1E13nJwKdOnAq2DdwZRuqVo2s67JpCzo8CIcDjNlC1PxRHUJpgufdoPdcf1Phb7zII7ejq58VT82F6Svd+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026039; c=relaxed/simple;
	bh=/iePmsUVjvQOSeWCJzhMKiUEulix7/M1KSmizMWl2jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPgfMcgOSO0MMvPGjcCs2OvK09MMUtg43yvEhmNR/m2EXKb2qe2Wd43W1a42iXWmxbeLVyu15FIII4YSyfrH2aBlF8WOzCzoRGJ3Igzna1Wlm2boSjl2ZBU3gJXMrk5UehhpyOnyZ/DrlmdlS3K1Za13B4rnE3UwxVs0jZjc7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ2znY/d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+ZADLDT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8w1oj3035353
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=; b=DZ2znY/dexHHqMHq
	9UkWyfkyA6sxniXfSVzQ3mjIGhqO9rwCQKTW75wPB3nlkpUsS0OtYu8UxJQXenRk
	pcC/7jHqrzkDz1W3+4SVTQy5RvEhR1a1BLews3b1dTMnuu5k0dQ020YVVJy2DVN5
	sZMi3oF9NrfocKv5ItoZdY74rweVMQxLL2DnVYQHV/b9nofgv98w5BqsQjFYHz4L
	iDylQbuQi84kF6BdGMY6P+BalSzQ5+T0zJ6ubsI91moQLfbQiSMla/AmjbyqcdGf
	5NG/PtPFaRkLM+oxZm3TV4c2B5cWISuXHS5uwwv0W++sQfpde37Bk9ymdiBQgomD
	05IFsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad4ju9hqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:27:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8adc67e5340so19974485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763026035; x=1763630835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=;
        b=H+ZADLDTi+48Lldbn/91t+pC5T2Dtzc0Z4wUNTF5h9HVEiCqEgTgr1WOPIGmRf/A8S
         zw+ipSNh4CvQnuQ1sEHZJkwN50tLF4u2QLmsw7AZDtQ0Ke+eA0/bPVUMtBwkL1AiWtuF
         nJeqAF5qtUlp5MepZIdEDXfpuL5iYkYcKN3WLPStXtWeFwTL/oIU6eUGJPORGMpTa7ls
         rqakzabFV+DUbiM4uCn7Bns6ti6i4ILGZMyXldg2snD8xSNtx129cHeIsb47/Q5oYMSN
         Pazi1jZHTq9yclnWWEUhVuf6EhAh6JwsJQvW0LZEk1PSad3WJVvv94/rKtX6atmpefjX
         GHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026035; x=1763630835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBQHZTyCsz2E3OEb1ZqiRZ3GGm1s7VIXPos3wQ/Oo+o=;
        b=xKaFGTOnSBpq205T2SWuRg6WdJw3CpYbl6p7hDSPDaqg2/1F05cvQwpFqC7t55n45N
         hx9XHylIo1xOpu1bMzf0YL4q9Bgj+n4NXv00oGTBBb7nGjnkfl4/hCeh5d8xx/qJ32Xz
         R5SJ48q3Q2vTGsWBdp0m2E3bucFup4b1MmnQLtcDMOES0kG1/HCsWKVaQSqDpqoreb7F
         jXk4ALZLhYhXSXhcycwT6j4KP65FboNSbqXI2hhk2Jh5/9HDOmN6PUMlFZMvO56Yzkwz
         7nNva2PnxsOrr5fVeCN/QqTGbsUHbkmqlAD7eDKdW5zQkpg3ZfXBcAzObZXvb12oeYYM
         G3aw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsN+ScQyc8uuOlqJC1VimI0bbYkJyQl2YdlZp1ISvoLCgT8ws9rhB5lb82quSZBFy0CBaTFNo97sPPhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO34HF40H+TrSzKdALjme+DVkHRTKVdoFU/j7fXzLhVTHSa0HP
	HyDCTqy1zV1q1bG4ZvJYzREggd6bgOQBL5OEclH5XOm2xteesXkgDsk7ixPxaqnKcTODVbVRVyM
	wLfwUi2gNjgRqGbg+ZUDH1tUACaovSVDvNGmnwRupfDgz8pgi3aUJhEo7i9bBmKc8fIM=
X-Gm-Gg: ASbGncuQ6ztYYVBHivBLacly1sF1BkwiPo02fEcU4VE92GITSeysmwGh9gxD5JV1sq+
	+JGzg7DaC21HEd11riD9ZhzQWp/Xt44yxxKRFOIbRV8WFI78Z1juouDu91LRQlOIk5oAHtPycsi
	OqdzNFHPi49NHPOdjbsx736+wtgb6UhL7QeZLm7E4JSVIx8fLRIv0l84zWgaxlcpCK5L0BJYjy9
	2DJa4oMaFVsasb3JWAi++xXLIoiJTr1QfK4ZB35C8Xtz1vaeV2aX+byUl0TtCI4+hbtaPlWPYbI
	OHCK6ZsCLCypoXMgGKYkyWFgcp2aylNEZe2ohjqwx1VzZ982e7lDNSdk/9gYiZ/GchsjcKGKPzt
	WwnhBxEZY7/pCaOoGzpfjExJLbeVWqI0QQ53HwIOKjvu22JxrFNRlUFnA
X-Received: by 2002:ac8:57d6:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4eddbd957bemr55093281cf.11.1763026034631;
        Thu, 13 Nov 2025 01:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoZxoEy/JmKlmxIOPZpqL8nflJ1JnawU4oD4ovv9bKA6hPgIGxSwD69qSzkbCaaUf89Ywfyg==
X-Received: by 2002:ac8:57d6:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4eddbd957bemr55092921cf.11.1763026034164;
        Thu, 13 Nov 2025 01:27:14 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4ce83dsm1028106a12.34.2025.11.13.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:27:13 -0800 (PST)
Message-ID: <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
 <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: stmpNejo8TikOvTMbOHrqEY6fD6WrzCS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfX6NXgrUPLRTFr
 KjHilEDFMflJSWK+Q6psxLBNrUBOD73gX2YXaiSE1XPtTRlx8RBxL4xqZSFNejw+sdYtzJkfLOQ
 IooH0GYsVTNgFh6oHDkZRu1ihKAi/YVWJhWdxmXAtZhEBSCGvfNzttgzeArl3HUvcj7pWywZXK7
 6C+8LWRNQ/+V138GL+lCzAkdiCsEgjM4B0JcY51iLvIivYUjKAzf5L/CvW0GznoeEShVxgx/eqZ
 OCXGAMsstQ9b7qA6klA61CXJkxuvlKiJNURnSHYiRfp1YaihenLhe9JVdhZoTENQAktjKGLZr6j
 5KpNs2xDZ5THFTXAeTuH2qlHuDcW61ZVqKArTUIzn3PmYk/OxYsGvHkoxmbIlKwmIgMqW+XHxwP
 QsEQp6mwbSJRGEh8CdWoqmXmxMr53w==
X-Authority-Analysis: v=2.4 cv=BdnVE7t2 c=1 sm=1 tr=0 ts=6915a473 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pBDOg7y053Z06RvWvLkA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: stmpNejo8TikOvTMbOHrqEY6fD6WrzCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130068

On 11/13/25 4:38 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
>> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
>>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>>> In A6x family (which is a pretty big one), there are separate
>>>> adreno_func definitions for each sub-generations. To streamline the
>>>> identification of the correct struct for a gpu, move it to the
>>>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> index 44df6410bce1..9007a0e82a59 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
>>>
>>> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
>>
>> Could you point me to the holi's devicetree? Currently I see only a610
>> (sm6115) and a702 (qcm2290) uses gmu_wrapper.
> 
> I don't think upstream was ported to SM4350. SM6375 should need the same
> hook, but I don't know why Konrad didn't enable GPU on that platform.

I'll try to fire up -next and confirm it hasn't bitrotten.

Konrad

