Return-Path: <linux-kernel+bounces-898198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF28C548DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B1F3B8031
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DE2DBF47;
	Wed, 12 Nov 2025 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dvvDkzDV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OxeJ5iVp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF2D839E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981672; cv=none; b=PMOXBN4es96o+Myx9DWUqapCame+2q2vaWGYxqycpguDgY0DTVcddXhHXtJzg3guPGk8wwE76G5nhz9x0FHRKGL0wZZC2w+WiYVA75gHUxufp81LS8dhspp991Y1vjhsUPOQbs6pIKRF2m9UDTj1CsIZ5WlQScbssPXHtZv1HQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981672; c=relaxed/simple;
	bh=rOxruhUARVvTA3QZVS16yu6HFFcrTpuLMnk+55PNZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu5KsuTHtIBRQxm1qzo57MeInKRVTExIRvlg2ZQgglR1Yoygk4wZsOGU5hDmC5fwAzTc7HsnVElliUtDp7xKXy7ctrItMAtvR/wvw3Mj5f2fhBZLUtxy8hYtXP/Oro0KS+RqzHIFjAoJF/reCwsIXQrJwnPyWSWqtKk0l6d32bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dvvDkzDV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OxeJ5iVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACH2lpG1001741
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DWMyaNg51yAfSqWuMQm6DsWh4pCeuwKPEWjNwRpWJFc=; b=dvvDkzDVzUeQRl9f
	VrapumChgiXe5wG4wMkNAAmc2X+v0HRLKhYGwECmwLn5SDxIJ/dG/L89sSSR45qP
	ws/IZSe+6bPavyd8gMfbInM3Vv7+zndUAV5zTFh9Y6OpkBqTNSRsaRRbYP5cduFh
	CWIGmuBHr6CPR6DZ9CP5ozuz6ll0/H859hD/xnRJFd/1ZpqZYXtlIFIachq2RHSu
	sKXNp8q1MWPTPRoWierLXH2yOCmctffd4K/7zW9wQSi6Q25dXAYbl/036hXGPNTS
	6DEQYSJcnphMTKRTv5QBoptmROh+jLflb8MXJeXYwixIjZT1LANQj0T8y7PtViCw
	gIt9tw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq22468-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:07:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so45875b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762981668; x=1763586468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWMyaNg51yAfSqWuMQm6DsWh4pCeuwKPEWjNwRpWJFc=;
        b=OxeJ5iVp9pVb94bN25gOS4kd1tAYXRU/B7NjlIhi09esGsqLB5Qn1unUWcKwdpeiH6
         j8Uthd8BH3qUPmSDqop1KAD1vypP73Zvj8us1Pt21XfrjgaNfVHwOm8X6WNsFuwTrMJS
         mDmnOX7a1psVo4iFQSgHv6x/vhTJN4ZbiLz1xKkVdLyCO6NEj1Rcnyda7L1xTobqGtWw
         YtJ8QSzAEZ5sf66m7/v5ZlQYMw2d3XaEmF0CYn/naKOuar4G77a046Jj5uPw9aOSv2Sx
         5EWNt4BfCEi52GfB+wJa9n9Vg+ttVoY0202YAEj4n9qsWjaijOmvkOYFFmKSk4B8FXLk
         P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981668; x=1763586468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWMyaNg51yAfSqWuMQm6DsWh4pCeuwKPEWjNwRpWJFc=;
        b=d4hia0DYa9hZvzFoq+C5E/yz29HRfTPS31HBtqH4tlJn1PzpwdNourpSFNSR2m1gCU
         gzNMnOSfZx0iRzMhn4YLY0+6oF9439JaEDyfUhZjmOWlqo1XSM1vDU/VIXKbI4l7kRz5
         /hWTWZ2s6LcUm8JRLkOXv6X+6GUo5GvU3vu70virwBvochdAe+OERUrhuOt6xobIY0LO
         BozEvaJxpBnpMs04CTc3ZicjTqZrzIdIiRt79eVP/PL7glzEntFCRTVz4uLJxpeqXL3u
         gwz7Izxxe2hyiKNlpBiywJTVDNw4XrNIgU4H5mppVEUjTuAhktuuJyPfAaj+DCW4KfRJ
         tezA==
X-Forwarded-Encrypted: i=1; AJvYcCXPLdUsN5RTJ5/nyNvtHX5uXbo+N2/MJd/mGMYmRF6Lxu9xRhHc0rtVad1Bn57OQFca4bpUSeQOTbfPDU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAVaT7rI4KcuZmmnW5QlbC7QIVjrqi1704Tj2tBZA1EphMK1g
	iqmII8E4/vrPcGvYHlmZhCgLJsVeibjwJ9CPXOsDvkHSdg7pq+fW2gYw8l3rKiYOXVY2GxeIh+O
	5RL1ZNzwiW7t8cZdRmvEBC9d03JxobJx3b27g26XGvN04ldWOwGyCS9pGwrCWUU7xv40=
X-Gm-Gg: ASbGncs6otzveGq8YrNEYbY2vA97e1l6D8MmLrSQiqlmOuYBiZCXr6EpdWuUV8q41j/
	yoXfk5IymXMEYtZ216ajAPicuHAVzcT3elsQ2UB06Eh4+ZiN/QrtoO86CQAMGf+MQg/bArE1W3g
	DLFVGG0hHibqj8PRxR5ngxeFR9I7TmchsvvN8qR6V8VTA83nGwoIkWFOiBgJ99HVfp6SLOJsja2
	8NJzMOl3W6bSUdYXKe1K3REvRqbKdNe56ba4crEULlLfLeNjYvYks5Ml1JtNIa8YX0EvxRInzS0
	GhgGfCH7D9vWRF2OAwsmvADT7XBHFzdlWV6L+oYkYHhE9FpVEhjAdTTQcozn4MnwZVGbeJtQqvM
	1sAxbwTzPcV2eZNBQ6kuHMw==
X-Received: by 2002:a05:6a00:9508:b0:77f:416e:de8e with SMTP id d2e1a72fcca58-7b7a4edebdbmr4669567b3a.26.1762981667635;
        Wed, 12 Nov 2025 13:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKzD5r9VfuhnSBaFB/wMVsbTr573DGBz89wF4dbIOOszP4AA+4sdkCrWHfyRuslYFgh/6AuQ==
X-Received: by 2002:a05:6a00:9508:b0:77f:416e:de8e with SMTP id d2e1a72fcca58-7b7a4edebdbmr4669532b3a.26.1762981667046;
        Wed, 12 Nov 2025 13:07:47 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c0874bsm19343016b3a.16.2025.11.12.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:07:46 -0800 (PST)
Message-ID: <7ece2feb-79ab-478e-936b-607cfda22707@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 02:37:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/21] drm/msm/a8xx: Add support for Adreno X2-85 GPU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <20251110-kaana-gpu-support-v2-17-bef18acd5e94@oss.qualcomm.com>
 <f9aafd73-fe4a-4399-a0c8-0da1c109283a@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <f9aafd73-fe4a-4399-a0c8-0da1c109283a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=6914f724 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wj3I1jakp0zn3Am71_UA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: ColzbT1ox0YxT-QrF7enL5xTZcRYXYL_
X-Proofpoint-GUID: ColzbT1ox0YxT-QrF7enL5xTZcRYXYL_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MSBTYWx0ZWRfX0t4G/mx1RuYu
 bwTzQd/sC68g2d+8nMqU+yePDU7rdcKsMcIVIzFF+A+QwgVol0U2HSrBaFwNMfRE+a3w5232sm/
 WAQnf8RacxsBZPLjk8v+D5Sw3tly2jYoXv3W9I90GappQF0Z2MhcN7V5WuR2+vs4S9USLI7MUf1
 MobDg7/PrMZRzFOdLBstVpyD1tJw3FBQnqJ5CBIRUx1Zpyjd53yn8tX2xZ0KLH/r7JckrMCMWJ5
 oGTKl0U2EBj/VMGcI/fwYY3dWJtbWzbuyQxbti2AB+bcA58VodWYFWakGl4PlnF6MdD65IotjFp
 L/BV0czJ/lbBoVq8IHypA4oxf85J3FqW8uEQehGzJ9rM3mIhVZW2JPZBxhlYZ2yN6RstQXvBnB8
 CNYx2ye2sHYeGo6heGhJdd5PohfSMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120171

On 11/12/2025 8:11 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> Adreno X2-85 GPU is found in the next generation of Qualcomm's compute
>> series chipset called Snapdragon X2 Elite (a.k.a Glymur). It is based
>> on the new A8x slice architecture and features up to 4 slices. Due to
>> the wider 12 channel DDR support, there is higher DDR bandwidth available
>> than previous generation to improve performance.
>>
>> Add a new entry in the catalog along with the necessary register
>> configurations to enable support for it.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 131 ++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |   3 +
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 ++
>>  3 files changed, 139 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index fa3ae725f389..2e5b0573c212 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1625,6 +1625,108 @@ static const struct adreno_info a7xx_gpus[] = {
>>  };
>>  DECLARE_ADRENO_GPULIST(a7xx);
>>  
>> +static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
> 
> It's certainly not the same silicon, but a830 sets a bunch more regs
> here and has a lot more comments in kgsl. Could you check if any of
> these settings are required/beneficial?

This list will see more updates.

> 
> 
>> +static const u32 x285_protect_regs[] = {
>> +	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
> 
> In case anyone asks, there are simply no registers before 0x8<<2
> 
>> +	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
>> +	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
>> +	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
>> +	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
>> +	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
>> +	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
>> +	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
>> +	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
>> +	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
>> +	A6XX_PROTECT_NORDWR(0x0082c, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
>> +	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
>> +	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
>> +	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
>> +	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
>> +	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
>> +	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
> 
> 830 has start=0x03cc6 len=0x1fff but that must be a bug unless a lot of
> registers have shifted from there.. I see there's perf counters so perhaps
> perfetto-proofing?
> 
>> +	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
>> +	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
>> +	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
>> +	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
>> +	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
>> +	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
>> +	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
>> +	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
>> +	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),
> 
> 830 has len=4 here, with len=6 you can't write to GEN8_SP_NC_MODE_CNTL_2
> which I think may be useful for UMD
On A8x, all non-ctxt register configurations are moved to KMD.

> 
>> +	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
>> +	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
>> +	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
>> +	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
>> +	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
> 
> This carveout differs slightly vs 830 but I think that's mandated
> 
>> +	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
>> +	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
>> +	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
>> +	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
>> +	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
> 
> This differs vs a830 but it's kgsl that has a harmless? logic bug:
> 
> { GEN8_CP_PROTECT_REG_GLOBAL + 40, 0x1f400, 0x1f877, 1 },
> { GEN8_CP_PROTECT_REG_GLOBAL + 41, 0x1f878, 0x1ffff, 0 },
> { GEN8_CP_PROTECT_REG_GLOBAL + 42, 0x1f930, 0x1fc59, 1 },
> 
> (0x1f930 is overwritten)

I think this overlay is intentional to save a protect register.
Otherwise, we need to use 3 Protect registers to describe this range.

> 
>> +	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
>> +	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
>> +	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
>> +	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
>> +	A6XX_PROTECT_NORDWR(0x27882, 0x000a),
> 
> These 2 seem to have been changed vs 830 for counters (all good)
We are not opening up the perfcounters to UMD for A8x at the moment. We
should think about the UABI for perfcounter before that.

> 
>> +	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
>> +};
>> +
>> +DECLARE_ADRENO_PROTECT(x285_protect, 64);
>> +
>>  static const uint32_t a840_pwrup_reglist_regs[] = {
>>  	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
>>  	REG_A7XX_SP_READ_SEL,
>> @@ -1809,6 +1911,35 @@ static const struct adreno_reglist a840_gbif[] = {
>>  
>>  static const struct adreno_info a8xx_gpus[] = {
>>  	{
>> +		.chip_ids = ADRENO_CHIP_IDS(0x44070041),
>> +		.family = ADRENO_8XX_GEN1,
>> +		.fw = {
>> +			[ADRENO_FW_SQE] = "gen80100_sqe.fw",
>> +			[ADRENO_FW_GMU] = "gen80100_gmu.bin",
>> +		},
>> +		.gmem = 21 * SZ_1M,
>> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>> +			  ADRENO_QUIRK_HAS_HW_APRIV,
> 
> No preemption and IFPC - I supopose the smart thing to do before we
> know things are stable

Right.

> 
>> +		.funcs = &a8xx_gpu_funcs,
>> +		.a6xx = &(const struct a6xx_info) {
>> +			.protect = &x285_protect,
>> +			.nonctxt_reglist = x285_nonctxt_regs,
>> +			.gbif_cx = a840_gbif,
>> +			.gmu_chipid = 0x8010100,
> 
> Is this the chip id for the final revision silicon?

Yes. For v2.

> 
> [...]
> 
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index ad140b0d641d..d283d0b55623 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -175,6 +175,9 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>>  	u32 val;
>>  
>> +	if (adreno_is_x285(adreno_gpu))
>> +		gpu_write(gpu, REG_A8XX_RBBM_CGC_0_PC, 0x00000702);
> 
> kgsl sets this only when turning on hwcg (bool state in this func) and
> on a830 family - should we turn this into an A8XX_GEN1 check?

X285 is not strictly Gen1 or Gen2. HW development is not really linear.
I might update it to GEN2 in future when we add more a8x features. Not sure.

We can revisit this when we add A830 GPU.

-Akhil.
 >
> Konrad


