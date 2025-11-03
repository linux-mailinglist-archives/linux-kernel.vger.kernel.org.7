Return-Path: <linux-kernel+bounces-882793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B8C2B842
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E534F8E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971E303A15;
	Mon,  3 Nov 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/J1m/Im";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/FeOeax"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299A1494CC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170289; cv=none; b=qACEb9oQNuEXmkZqkUwkNg1GsXi3QXcxpaD+TB7SCOqTwl5jv0NQs42gFclmwY+2OmWkkFk7fl/jGRkbHnvNcYa5/XkIMvs7mcWXKRX/gXdv9081UlExBNObpWgDlB0uGG+tT+EJsKPIC/piK/WYBNh3jdVZtsWNc2Dv7g/g/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170289; c=relaxed/simple;
	bh=78couzGyGlQWvfkwHhJwUIZfTijNdF4uPcd0+FmU9EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ld8M8hOmCAwnrIJC/cYj5L3tNlLpWF3LG0hUViegMOry7KrZr4rfxHaYpVm3NKOTPjBdsrNTWxSdTLxOqf1RsLN3v7V/6EvQbizx7F9Bw/gKW0iwtlPrrBbuP+ll68Zi8rSlJhFd/vjdTWZE5ygkUfCRwLwvFa+DqBWoCg/I4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/J1m/Im; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R/FeOeax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3A5ntf1941372
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 11:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MGzSna7Z/0B1jw6cXgA4Dygu5B4WwM9yg+V4B8uyOFw=; b=k/J1m/ImlB9cCQ+6
	+Zx/PgZAw1e3i7vHCdFl9/4d4licSm+zsOjG1QwjJBURgVfMRtrKRIAjjDy7AB8a
	7DuQzVNORWJl7NsZsoCXNhWY+iLEaNHVhityKe8jgqHTRDuQusLeYfFBB9RwRmfg
	tU5x9eF+VBr75+J9Im20Weza9EwpnO0iClIt2rllD+Z/4xRJZsAgcpuHagIMU2CJ
	nfR58M1yWWRKKgWe281wVJBJ12otuktl4/csA7v3oIqeRQGW5CpgA4c96EhvOnnw
	nQmSD75YdS9XvxC6mW9aY0wa5ogkyckLuibOnaF2FSBEsBbBCJPTWJENggEGALHs
	0EII0Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w9bqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:44:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-880447fc88eso1573156d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762170286; x=1762775086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGzSna7Z/0B1jw6cXgA4Dygu5B4WwM9yg+V4B8uyOFw=;
        b=R/FeOeaxWMPv5G0kXJynoYtOkHW5RZZ0Y+gGeacWpyylBwbim2Ag0MmGD6gH8zXos0
         1/dNLxAReCP5Nc8W36Ej4Apfjo6c8a7sSIkQW1vGTzG82AzDTp15s3NJeVBLu1S2nG4G
         SposjV/WM3l/6DyNQ5oiYByH6ZlFKN4ukwlB17iVaDn870socyqFzNdmb2MBnCf8OWth
         7nUOL3YInBUVLEld7mA9wtClwGVrJNlKvvc7QV7Vqlye3K9whvoigRKTsEFGDsUJA5G5
         usq80Ny5ETJ7Qo7JBP3T3NYaNw8KW96P+MplQKdHf7IEEgVGUwNM3trFwxkwKhB+AHZD
         KErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762170286; x=1762775086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGzSna7Z/0B1jw6cXgA4Dygu5B4WwM9yg+V4B8uyOFw=;
        b=OHmOKZ1kweZXdpk7M4ZULhl8PVRfOzzVrZNcUI062uVm9rLt1QFTcGEITgpJUI25Iy
         5C76jO/Ll+k3pjysI9HaYTzs3gTrg60L82FNyfqLzce4fVNWMlWWyiijzy01Jj8vnK6r
         wNADOWaamp7sbDotvTpjK+QIuECXO+WKJ/YR1ajfE2fm+w7p5HwAQUX8/J4831k6Amwd
         P+6Df20kd1GyYKsXPEE2CZVDOyF101R3eQ8lPoN/8Mh3SKOBOcfD7gsdDgqd60dHVET5
         zcoUoWqUY/oX5ojy9Crou7SkslKSb1cVc71/+hmbPJi6n6RhjpzlxZ/Zad4jYc7eRgHI
         heNg==
X-Forwarded-Encrypted: i=1; AJvYcCXB1SNr8yeDmsF7fS4o+AyWMDtFEG1vQu+oPVJKJWjz6svUljlxpw4Mcl7uAkHidmQ2TfXQhyzFtZIZ8DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9sX1FATPw9pwChLT3Mmf1LZxIxhXCiGBG418LrXsIENihfic
	QtINniJ3zreIi0Oxm2ki+U/x7GhWEj0jvyveAtlc/DCgzpktu7r6xWfRxPoq3WJe0C3AxCk3W5n
	eYuG6fPb8GvrvUxjjC/3dOvCkwjKpFF+Q/f6Fu4oYvgkK3zi948g+TGZMiehhHbBXc4E=
X-Gm-Gg: ASbGncu4BcF2zMrCGvSOPY8JU91eUA98HXuHmR6emXDQOviMRriiP44Sr7TXVlp1yMr
	Vs+mTueoDiHRr9u7KUpZmbTKSwIyCvnGpW31FN4eR/eWFw8MEhGWg3rTTvihuACH6itEzHrKcw+
	VB2TRSS6DkcvadguD61tJ4mq6Zi2S5SaRYsY+FkNpXE2TeH2fAwpsq1U2wxiDCcnECfhrUVFPt4
	KKDsD51KslkhiEQjpJwlPGIrpbK752olrC+NneEYU0K1Md96FTcZk+/0sHTJO+BcALDXhaUWGHc
	9dU5uO7J6SwNnwuYXu0fGONhr2V5kWhCwyzJzuw8iihZiFujXcauszAU6RdCw2QBZ1J1BRNILoe
	44Xj1sNra3htUUw0bYo8ROxF8HpIQnyMb1eRwgx+YUfUbKnfCk+vAxXc/
X-Received: by 2002:a05:6214:2b08:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-8802f26f50fmr113779736d6.2.1762170286433;
        Mon, 03 Nov 2025 03:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7HDR4oGKE7YvjUNK4SfxIARE+xpgeOD3N+t+XaeA+ttAVIE8suSRw89bGxUKlp/o0DJTuMw==
X-Received: by 2002:a05:6214:2b08:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-8802f26f50fmr113779286d6.2.1762170285777;
        Mon, 03 Nov 2025 03:44:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64092e1a405sm7542470a12.31.2025.11.03.03.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:44:45 -0800 (PST)
Message-ID: <0ab3c556-8876-4598-a7d5-ba7f9eb33391@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 12:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, rob.clark@oss.qualcomm.com
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>
 <44ff81bf-8970-475c-a4f5-c03220bc8c3f@oss.qualcomm.com>
 <97aeb6a1-fda2-440f-b14b-2f3dbc2d7e8e@oss.qualcomm.com>
 <5e64c246-a424-42c9-b102-e1a2af579936@oss.qualcomm.com>
 <CACSVV00vwbNtH47S_BVet7uP7u9t4RY=xTBn_r3u4sS91Y7Muw@mail.gmail.com>
 <7c563e83-031c-445c-bcfa-c04f4729622d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7c563e83-031c-445c-bcfa-c04f4729622d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=690895af cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=IwubUePDlzt84yfe0skA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ILgNC6aecqeT5011JKaxC0uuxCmiR-0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNiBTYWx0ZWRfXx/s1NeXdzgl7
 6uybqo+ABVKnLI7XBizt/tcDWKC/2dTF0i3hq3ujNiOHn0iqyU/m240xvmERIvpnU9j9E1BeUQm
 P9UxYBxmdp15IPEKXKNb9JCyza8K2UrjGoQvkxhrin6U5XdYk2jRttpUQBQefsgzMLxaFAy7MYt
 3x77ciiPfaJug0eH4Q0B5eDsZoZoxxWFLtQj+UpYmqrd6CWHhWI1ysVXPfoSdwO5sZn+GfWU3La
 x1Oh0oshZExPmcvs5Tl/zWAn/EG4d/Z1fLd/SiTN/XL7R0cBl+n0qzTe1opso+QuLhtkP1cbHqn
 xNeM9UnCp38TkgqatLuZGkyOZI1Gl/N7SdcLzaPLwtmnWVOdLbUPFA6Op8u/8mwLR92JF09hjGp
 H5N+O7NEmbuxvPXXvas6dKnV2MeurQ==
X-Proofpoint-ORIG-GUID: ILgNC6aecqeT5011JKaxC0uuxCmiR-0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030106

On 10/24/25 4:23 PM, Akhil P Oommen wrote:
> On 10/24/2025 6:46 PM, Rob Clark wrote:
>> On Fri, Oct 24, 2025 at 12:55 AM Konrad Dybcio
>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> On 10/24/25 12:57 AM, Akhil P Oommen wrote:
>>>> On 10/22/2025 8:43 PM, Konrad Dybcio wrote:
>>>>> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>>>>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>>>>
>>>>>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>>>>>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>>>>>> of A615 GPU.
>>>>>>
>>>>>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>>>>>> which is a small state machine which helps to toggle GX GDSC
>>>>>> (connected to CX rail) to implement IFPC feature. It doesn't support
>>>>>> any other features of a full fledged GMU like clock control, resource
>>>>>> voting to rpmh etc. So we need linux clock driver support like other
>>>>>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>>>>>> This patch skips RGMU core initialization and act more like a
>>>>>> gmu-wrapper case.
>>>>>>
>>>>>> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -350,12 +350,18 @@ static const struct a6xx_gmu_oob_bits a6xx_gmu_oob_bits[] = {
>>>>>>  /* Trigger a OOB (out of band) request to the GMU */
>>>>>>  int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
>>>>>>  {
>>>>>> +   struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>>>> +   struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>>>>     int ret;
>>>>>>     u32 val;
>>>>>>     int request, ack;
>>>>>>
>>>>>>     WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>>>>>>
>>>>>> +   /* Skip OOB calls since RGMU is not enabled */
>>>>>
>>>>> "RGMU doesn't handle OOB calls"
>>>>
>>>> Technically RGMU can handle OOB calls. But we are not initializing rgmu.
>>>
>>> Oh, I glossed over that..
>>>
>>> IIRC the reason we delayed 612 support in the past was to make sure
>>> that the RGMU FW is consumed, so that runtime requirements don't
>>> suddenly change one day.
>>>
>>> If you have no interest/way in getting it wholly supported right now,
>>> can you at least make sure that the driver requests the firmware and
>>> exits if it's absent?
>>
>> adreno_load_gpu() calls adreno_load_fw() first thing, and will bail if
>> gmu fw is missing.  (zap fw is a bit more awkward since that could
>> come from dt or device table.)
> 
> Correct. And RGMU firmware is available in linux-firmware repo.

Thanks!

Konrad

