Return-Path: <linux-kernel+bounces-896924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F97C51893
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD4C18833AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF73009D9;
	Wed, 12 Nov 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnS32Jw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ka8U+l/t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2042FF673
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941602; cv=none; b=HWziuavCvLjR0zkAq9g+p0DQW7TNkVQPmd9WKTZCm+8ARr7Wg5v+6ergBgnrFSQQvakWBA05t43k1+uRaWeQTXFhSEGKKUZcFl6RwYSFovklFS3xKU0Fhpl80s73S75x92Z+b1WGXRkdiSnV3q4BM1hl5+n0z/dXSKTvGBUMtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941602; c=relaxed/simple;
	bh=vaafyOM4EBmmr8Xr/75zkct+KElawHFwIAMtB5jypSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDNC7gbXPMqaL2jawa/saKNcumTa8KJGy9o4s7V48zPuemf1v0IlE9XeCNPkZ3Pk3BePwma6q56d6JadnI3ezvGcwFxR7tKF7wuYO+dqR0WoLYSMJGL4bWfHz91hW8ZWz/Tl6sHq3JozmwxAJ6OhL9E/A+DmqnV5trSefB/anww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnS32Jw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ka8U+l/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9Ck4E510766
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/c8M8R+TWpXRQ5e1+bQrBnPfd6et7TV4rbqupFG9SIs=; b=AnS32Jw0ui6C8JOY
	hiPKBk1G4+knA0yFTPdpEN1SZwfHaZFz4tFVcbsVQ9IJ5pY7s0a42fBtGJkaNhZn
	dIrOr48Vx48OTdnNHvTLezT+eYp2723P/NsAd9bkiuCdYsUldX2xwlu8KLiAILmt
	zzeKMU2LLcMYA3fzCWYnr3iWf0zNVUKDMrrV4DHhs8bMFEaeX3m8Z9+smhLgubRc
	PeOJ0ydOcuZaeHnNI8dPpGdS9hl0h2r7hYJdIGgoetwxgmlfdSFPnQuHQnODFHmI
	SJ0BlK4q2Equkaba5vjiU0N1ltD3uoe1CxBCAZeNMs0nel/le8dcemsABbpQ161j
	FAB8kw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqdgg89k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:00:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b23452ec2bso21815685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762941599; x=1763546399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/c8M8R+TWpXRQ5e1+bQrBnPfd6et7TV4rbqupFG9SIs=;
        b=ka8U+l/tNcEuKdiP67oc7URggc0551Rel7sn3erK2L0DGabgp3f64HX2/FPOTOSEqZ
         GciIOxjwWsOhZCAV5E7kYN3j8WSVfBy9wekz1iHhH4tMhr018UacO9iMVV6m9aXag00F
         eHeoi8zZeqTMUK6FMXNloSaYvQynAe6exfIxa6V7rzr9pQ3HD8ozOB4HEDmR7zAEF7JV
         GpDKBYJjfDqfZNd+3PBw+VVSTSWb2qwwL5AA4p8qYW5UFucjljmhysoMphHIvXE+w3bI
         dIDKDE5uG4nUtMSt6cg8gqAvOb6DvL5l0OykEdYTr9kWL/j2+n1Dn0P8zJVl9sbFGzbJ
         79aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941599; x=1763546399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c8M8R+TWpXRQ5e1+bQrBnPfd6et7TV4rbqupFG9SIs=;
        b=pdNiPCE7hvmdrGdw/0HpB1GN739v78boCxtgLft/KXAVx/B3jni37QvUwkbAAE6Urt
         1dtI2MQYRmmqPwL9SNMte5X1WmptkkYIIZ34vUtsDTdNct0z5P8t0s/8XvSBzNs/3hw8
         b1Nqxpjn0b/gHdnTfCIMuaGpTpxMaEcHN3CFSiGM3/cgcCNfCX2uaJu7uJLow8VY3uIW
         vYF0EWVqWCzvGP59SZFLGeuEG67cPMnE9Hivb2MqmQZYrL7z5qbo6i0JcSrl3YYBY2ng
         pDO6ZN4sljBVl92ex21vePS6UUfGW8+irXC9pMmWSLLm/qg5sBfAO1nHQQq9HMLrxMFg
         maUg==
X-Forwarded-Encrypted: i=1; AJvYcCX093I8X1GM9KB2bbBTa2ScQGpmMFv8Qmm0T3yoNwIuxMzipxvKEU+p4GTqcM/gpNqBoP75xJ3pCUJcG2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgnVDOhZfKTVEzEDQj+D11peUZc+DUI99XYvhl3R8LT/l9Yjj
	W1KTgYCcB3TzDyXqi1kcTV8oRzsLsFGK/cOc5LxL0prY4DUZfMkiC/PGLILB/0ddGSk9jreIeDA
	lIKDp4XxIJ+tNymUKRvngxnSQ/qSjxDLzlKtTaSbUldGkRqjsHu4o1Mj9PkhSawUN9ko=
X-Gm-Gg: ASbGncu1IheeazO02MhQZgaKFTIaPQCRhyyV+UFLqs5UxJRlNft56P54XidLOQDk2R9
	C47KDNBSZs4HmMwpuMNpUAJPNpFz68Uvrp/6f577Y3uK1NSnFLp4V0C2yOmw+DbRFRJuOKj1+7M
	D2qAebDu8fuN4MfuIHGCUtVq5jgigJgHqdD21ehG5MPrQ7EoYY8H1q6AY3aLXKj/8bCilpLcfDY
	QgpZvYWeiVH0IlOs54OAig3BbppcticZEoTPlfvmVi8jSxUhPV3AKLyzdKCv9bM2rSuj8OkPiUd
	BcPP6x+ZpvEEh5VHLJOM3aD8/9Jt04fmba1vlo0A4+tYQ4CLIfdnuZy/ToJ1NPKjlgUe39u6po2
	J2jV9hf6MZ/tKUY7v8VNFwf0FdAc7hbYeAGqFxQ0jtZAVBdvAoVrtNXRb
X-Received: by 2002:a05:620a:4047:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b29b7c1df7mr186053585a.9.1762941599132;
        Wed, 12 Nov 2025 01:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeACvtEsXBDBf86oFt1CCQ2CtTgxFZLUvN151CpNKDu+hMJHO80+bcfR0KyKS8bfTOd2+bww==
X-Received: by 2002:a05:620a:4047:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b29b7c1df7mr186050985a.9.1762941598464;
        Wed, 12 Nov 2025 01:59:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f37csm1552008366b.64.2025.11.12.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:59:58 -0800 (PST)
Message-ID: <2b10f34e-ab3c-4329-9034-8666b252ac49@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/msm/a6xx: Add support for Adreno 612
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
 <20251107-qcs615-spin-2-v2-1-a2d7c4fbf6e6@oss.qualcomm.com>
 <abf79d96-72c2-453b-aa2d-0626be584baa@oss.qualcomm.com>
 <65714302-3b71-4a15-8647-ad707e056302@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <65714302-3b71-4a15-8647-ad707e056302@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=69145aa0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yXIK2swZwOVbrSwllKgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hu_XheRpCvV-_aQHIRnqfkmCFKEzTb1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3OSBTYWx0ZWRfXwQnwCxDBPIB8
 BHKH+4I+GorM2dhKqQ4H4QJDr+n+EL/xik1u9W06vLXYL4PWaLML2jZDK60/sweGemHX1OJCHTL
 pjEJHMDQhezPHL23yqdrPqQ3LuaAVo/0OliQCfTQiRHE0Q1KI2OAAHdkjO9tgeK1SwcU7sAMS4Y
 MlIUSn6hLngd1XGs+hQGwGzbPD9d2x2hHSWNNFfFLDpy9pRNTeN8facFnlYV3HJHrijQsbX58W5
 yTJNtVu6bufyNc4pJCd5qcYFWw2a5Wuz/FCaEHENPdlPS4mikvXre2gYn7DO4caze+IxuBPkAk9
 n3KeTmtJdMoCVL6SzzgLtjUqg+1Mt5kuaI4u0RMR2JiJCsWt4d74i0aqYOfwT6P6lcqQ5NhjRhl
 ykwfbm8eQlLv/JVXPeGv0H6nRDvMcQ==
X-Proofpoint-ORIG-GUID: hu_XheRpCvV-_aQHIRnqfkmCFKEzTb1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120079

On 11/11/25 4:10 PM, Akhil P Oommen wrote:
> On 11/7/2025 2:28 PM, Konrad Dybcio wrote:
>> On 11/6/25 9:50 PM, Akhil P Oommen wrote:
>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>
>>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>>> of A615 GPU.
>>>
>>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>>> which is a small state machine which helps to toggle GX GDSC
>>> (connected to CX rail) to implement IFPC feature. It doesn't support
>>> any other features of a full fledged GMU like clock control, resource
>>> voting to rpmh etc. So we need linux clock driver support like other
>>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>>> This patch skips RGMU core initialization and act more like a
>>> gmu-wrapper case.
>>>
>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>>  	/* Enable fault detection */
>>> -	if (adreno_is_a730(adreno_gpu) ||
>>> +	if (adreno_is_a612(adreno_gpu) ||
>>> +	    adreno_is_a730(adreno_gpu) ||
>>>  	    adreno_is_a740_family(adreno_gpu))
>>>  		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0xcfffff);
>>
>> Downstream sets this to 0x3fffff, but IDK if having a timeout too
>> large is an issue
> 
> I reviewed this. It should be 0xcfffff. It looks like the latest tip of
> kgsl has an incorrect value for a612 gpu.

Thanks for confirming. This patch looks good to me then!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

