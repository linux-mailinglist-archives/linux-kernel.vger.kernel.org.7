Return-Path: <linux-kernel+bounces-886237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F31C350FC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A1A560483
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666E2FDC24;
	Wed,  5 Nov 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnl0NJRv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZ3pBvl5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4212FB997
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337632; cv=none; b=fbDs9JrPSExCDOROhZHoK33SpGndd18UUwUPImKLPoStQT/t1SM2k+mPCcuqUUvPkQAYWbbQD2NV5+6sxloS2v2QTugmgWaQWz9NsshtIDcXrHTEn4NgKT+ctrZIOA5/iS3VBYRU4GS/YzHxGwXH9jq/Nyjw5lQCmr5YRV3N2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337632; c=relaxed/simple;
	bh=nChZR/x9bvDwwZq8+OEin6Cql+RWf/f6OJWvgg6cyLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs1XVSazg7VIyxBMK3tYF/+fRb24xH+oi3rWNzK5iwnpyCP/ZUay/vHTIK+ICcnhcHPcFRewcO0M1QJVsxOxrzmKAw+JatcopVeyuqelUsCfn2+0uUj+60rzdgiWYtjLtcLssxa3adW4OE38hjdXzp7MKgDuupGROy60dgLFnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnl0NJRv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZ3pBvl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58YqSN2904345
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xIyszpi0pIw8uGzv6WLAp+HN2hkaZFeJK0RVS9Ooiaw=; b=hnl0NJRv/ccB3R8Q
	JK5PNfqza1NJIGD1I9l0N27BcKOkpTZddllhLmeAcqvtvSjZXq5SNQmF9ABLsZQC
	VhRM+9zBxLxNR35VvWKQI7K8u7RT0l9rnGH1kV3M+6sedhMYE4wTf+rUGNshra6f
	01AwLAMLAPKYndlhbzqHlG+Zx4HyMIg32bbf65cCgb1vkHX8OXM0Pg1wZ8vOhi1c
	b5vASl40nhTRQZqAxAaTCRD6Rsiitg/T8j2HQtXahU7Dq64VgTdtwjNgWIuAWOZK
	cKiNGo4vVHYLpJBaxGLPBgOfzpjlqikKYJeODxelsshaYJ/ugERALpC2qYM9E7Ec
	A0d/6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbtwm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:13:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed73c9e3aaso1307721cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762337629; x=1762942429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIyszpi0pIw8uGzv6WLAp+HN2hkaZFeJK0RVS9Ooiaw=;
        b=NZ3pBvl5JZNR94xe1gYyaTiYcILm+pojon3ZP1lppTNWldP03u/Rj0G2/l4r82Ewgx
         9Ew8KwzaZ2N42War9PVrd8jIDlCBv+m1EooCI4HxrttflAGNqbhr8h1juRo/gSUwg5Wk
         +SLuhI3hecv7xv/TJNdmYxsf9dMqTJkt94Rab3T0WKNuXTcahBp/FJboCY1U5DDYKWJF
         G7acVnr7dlxxsaUp9R3801p08EkpmfnxfqoSDv3XvHHDxT/zIPDv/Nhpgx4cvyiirHQk
         +wpzVSRpnZla/ym/yPi2bEW+KZqnGglxbceqvVd5ce6sTyIB+3QNSa+c+4a+kNvK+dac
         erfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337629; x=1762942429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIyszpi0pIw8uGzv6WLAp+HN2hkaZFeJK0RVS9Ooiaw=;
        b=jAG3YCaZVZi81OWNu10KjGpE/YOO8RaPD8P88CeZhlp/JQ2HApPezqh4UQQCNA0yU0
         o1nPu7+e+QtFzuaBPSFa8bQuEPha8m+V+WDltz6zZf7JX0Gt6x73M/HCx3JlsDSAviVH
         PkXIQTRSiwL+85L9jk3OCAJlUjhyQ9kYW9ojjNeQXBLbAPQLjRVudj85kGlK7y63tSZz
         LEarb+DK944U0kSV2XXKP28eI9IqCRCMRtkx/DxYjjvhQZRFOQwX4tyHg1lOlp1J4i2A
         JB3I6fNb5JwdO0cPf2ufElZ2To32Xhzo9jtA/dCoujCj7wmP04IT7djRzjaShtJeyt80
         VnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5jT/fK1WV/JJ0GGGvUsm4af/8brLlf2esmluzw9uWzvFvuLfJImE8QBBWrtpNafHWoAMm+rIzH89N3Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKX2CjyTDHE8sKVKOpphRgDDqOwQdAe4SIvUX1SFhHFcBPStcA
	JPQ1yYWyt2nPkHJh5FJi5zWWoP1LNHgD1499Pwf1urMbyY5bACjhXMHPtzf7exstoYGFncAroHW
	66F1P+MfG8RSKk2ZEuDMbgcXK2x++mPv6jg7lXeISRziBSWJX0/Vu4Gx6MX4nVPMXARE=
X-Gm-Gg: ASbGncsM6luxuGcTw5J1hXOX8s+rSrbVle0yGvMYbaK6mlYzalh4td+oD5e3YcwbA9r
	BUkT6n8Y/BQ1jleGmU7FjrfogP/MROFAmURLqv6ndfTyZxKRbpd83PUvwb7aq8wTgFIsMnURsx1
	MtgK5xmVbuneVgeQJQzW/k9NZpuClRGC1uWfcPsaDopV2MksKyriMNBkJdQtlBMgWYttzVk/41p
	wqIbChm5sp7AorV7SJZ6NTsjfaXewudV/fnmJEVYNL87R6CNhz50fvLLVmweOlek3Kw+t5BkCF4
	nebVQR9KW5gih5H29uivsOl2NP5ZYFN485GFyoi1mnd0hEzA7NQLrFI8P5Lptpd441vYY6Qxwba
	hoR6Z1wQq2VlKVfHks/ta7g/9KWNJsof6giQNPGE3hQy6j7Dt18fAdmuL
X-Received: by 2002:ac8:7f47:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ed7261795emr21371141cf.12.1762337628796;
        Wed, 05 Nov 2025 02:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFED2E6yXArBO4TiArU5U6TCAiMaOhAarYcTmI1Eu/HcBrhy5Litd4H6o6IEFPy6nojl2YmQg==
X-Received: by 2002:ac8:7f47:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ed7261795emr21370891cf.12.1762337628181;
        Wed, 05 Nov 2025 02:13:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5c7e5sm4225776a12.24.2025.11.05.02.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:13:47 -0800 (PST)
Message-ID: <1d1cd6eb-6004-47e4-b6e6-006928e79578@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 11:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
 <36fcea98-06a6-4ca7-a378-77b44b196a9d@oss.qualcomm.com>
 <7fc6ab09-44c9-434c-ab19-764c74b1176b@oss.qualcomm.com>
 <7f8aa7b5-40b6-456d-8b33-0cd505a6bc3c@oss.qualcomm.com>
 <a8586851-7f71-43f8-a1e6-6f8510c2985a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a8586851-7f71-43f8-a1e6-6f8510c2985a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kh0HdPFFeK6uCWgZ_vvfTmn2hTnHiW_x
X-Proofpoint-GUID: kh0HdPFFeK6uCWgZ_vvfTmn2hTnHiW_x
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690b235e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=1xuCUfFpP9sfGznx14oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3NSBTYWx0ZWRfX19S9nf8cFg/k
 Cr7Xp4CSjXI8c/Zp5kFTaIHxlP8D/LZ0j8oj68eqV9oDdVkqh7IG62WqhLYGCxyI46hi3Nhe9Kj
 Wei9qiA8A8UWaoo4LNjLFbEFnBwMncLGn/WUdfaV09lfF8kKwXF0qGAwtdjszyc8TzfJpuKcgNG
 SG1ec87gVL2dBCBFS18/LIw+r46a6h0kwWYwFve4tc6aWa50/55pyaEtG1Q27BctyU+8kQI0U6Z
 10kN64oafV7yO2rOKWNBG7DNt568AXUU67X7f7bvIxT9d2I4EJX4V71JFbSyMHcI2GUpPtA3hlt
 /c8DUko/qOfq2K/3Ey4ft/zGbF3m60gOWqFq7YmAQ+7vEcDaVe2+KhpbwufzK/d5+DN2bcBE2Vu
 V1PLSuFOcZr3jyTFCVDyOicK+69Bdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050075

On 11/5/25 8:30 AM, Jingyi Wang wrote:
> 
> 
> On 11/4/2025 8:54 PM, Konrad Dybcio wrote:
>> On 11/4/25 10:04 AM, Jingyi Wang wrote:
>>>
>>>
>>> On 10/14/2025 7:46 PM, Akhil P Oommen wrote:
>>>>
>>>>
>>>> On 9/25/2025 5:47 AM, Jingyi Wang wrote:
>>>>> Kaanapali is Snapdragon SoC from Qualcomm.
>>>>>
>>> <...>
>>>>> +
>>>>> +    reserved-memory {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <2>;
>>>>> +        ranges;
>>>>> +
>>>>
>>>> This is missing a bunch of reserved regions which causes device crash when you stress memory allocation.
>>>>
>>>> -Akhil.
>>>>
>>>
>>> Hi Akhil,
>>>
>>> We will not add all the reserved-memory in dts, other regions are designed to
>>> be added in bootloader.
>>
>> If what Akhil says is true and Linux is crashing, something must be
>> wrong..
>>
>> Konrad
> 
> Hi Konrad,
> 
> There was discussion about the reserved memory in QCS8550 change.
> And the conclusion is that reserved memory regions which aren't relevant to
> the kernel(like the hypervisor region) don't need to be described in DT to avoid
> memory map change and update frequently. These regions will be runtime added
> through bootloader.
> 
> ref:https://lore.kernel.org/all/20240618072202.2516025-3-quic_tengfan@quicinc.com/
> 
> The bootloader we currently use for Kaanapali has not supported this, and we have
> solutions like add temp change to add these in DTS until the final bootloader is
> provided.

I think we're well past that date though? OnePlus website says I can order
their new flagship next week..

Konrad

