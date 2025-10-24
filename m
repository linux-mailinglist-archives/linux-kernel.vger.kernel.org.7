Return-Path: <linux-kernel+bounces-868999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98346C06AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A24E545522
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999721885A;
	Fri, 24 Oct 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nY5OaQve"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFD20DD52
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315794; cv=none; b=LQPO1xB7h+HWEhelyOnhTTa6hYhjIKhrOssXtPvL+fqJk4L1DLgnzbAtqGjZjawdQxcq9OqSQlELiqT3S4vLTQ7obTuSgex6C9TzHrWi25VpfdaCsfgltix5xI6xKhrsgVqU7qBgmxhqg5+nD4rf+od023n2Z6e8RkxxPhi72LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315794; c=relaxed/simple;
	bh=uGP8+TkU/twhasSfvPO4zLh4G5FjfHNqrowAz9ksh3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tj+iXzyX7OQU3NYDWK9DLsyEFgLXHX/4gAkTi8Fp3Zx2krZT6aL2N3n4ZAzIYmOVsymcZWydYAIllTHjyIjya4AwO4TrAjWi6IKlyPlKSdjFiq0t3SilxL2eoNCWyitTrfqu6ad8GPjIdxMncxLqY6zjuaesT8WVi9FbM5NIqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nY5OaQve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OCDqjv016081
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/EgZaEEAtQpIr/mZaxCGpC9Z/zSaRdUrKgdMD6X3vlY=; b=nY5OaQve8G5EIpFm
	rYPkwyaycSFwxx9VkYXWvNsPm0D7qWqt5lxOmbkwJxRqm5BIs5wf9GSTl6yW6xPv
	NgpidjM2fE4dnlVVnL0N5f/Pu12FQFJheeMVvhB8H5OlFfA4nQSjAwc9R3aXRRR6
	xY/hZqCgsskE2TLmOtII7ASb1aM1mdVlNM/p4KlBYXyXzkaDOCZvcU0McgMRHali
	BBhlCsHAsXXO+5cLj0J2XtSbAkhcbb7KW/hpmGdl7mDwBvg+YNxOekORtu3Q7sYc
	GtMEaPm5/PBFNFMzkpeJBZp5skCOFZwaQcTy7v39PSsIM75esnudy+wLI+dtVBPV
	MrhtgQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpshvcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:23:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290c07feb72so18468525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315791; x=1761920591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EgZaEEAtQpIr/mZaxCGpC9Z/zSaRdUrKgdMD6X3vlY=;
        b=kH0fEz8KB5oE6HBoAmcJavwo80bFXyBlYN2a1kRvmRnQlyhh50IFNTniJLygn07Gsp
         XiXdsgGETGuXrV2Q6ZcJ+WacPhfdfwnFYyUI6b6SZWac4iCbN6NdN0QKLeqvQGQaPXwU
         0rXeRvCrxoBhpvjb4q5UJIDtfBjkeS7/hxw1YpzzZUk8WwxF7gJPcojhvxz5UEyfz+jR
         P1P8Prn04/mUTUJJiGZyE3UgfvUnOxRReR2cuY0OUxgexUXdf/rL8QuqnEo3dLqvfajq
         FIN4icWo1PDJCcUWSvgFb/6IsLsPD046dvLK1Jwu+41mtnxVfyJNNqGLJF2gT+po1PvC
         eFUg==
X-Forwarded-Encrypted: i=1; AJvYcCXiL5QID47JUhLnCR8uoW0lbL+Ag9x/blCIumwLyZN0cw4rt7UXSuCxkmYokw/uIwHcKWTnBq17Xrty1e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk451baq74XMxdn96HL4jMswQcJPhxhgrMD1JFYZ24H9HcoELP
	+q0fzkqmDtP6M9if6L7YYK1ZfZ45G4JWDwqpjhE6WEUnSp9aFmAPXtph8kF1fUjH4f5MUQOA1j7
	f8pdgIEXS4xHFrJIjIpP5WKPo/TzvvyvrfuyCU0+4FKdG9pR/4la27kTpssZqO5C1ooI=
X-Gm-Gg: ASbGncsOrLatQrwtIKb9CiBVtqATMmxLRrx6o4XfuEaqEPypvG9GA7umq1wKI/kqRIn
	JRGWkqXewM6dxxFGwYQn7ahMP+EWL4PVwowwAqjcNQbwq7x4K0iQ7LpbaImYfRlubTffRb87O4a
	WmML3xpz43WpJDniMmOxHREj/lKP229bnluq5vNn3LAuXLl7LR4t/jHQXCCs1imeLrrK/QVgSvs
	0Wwkv4tLQvrnncPGVec+O6mp750Exscw2xfoCYc91yAzAqGmovwXlZj+eFSK0mckARvcwQC5NwI
	eU9beuPQvqZwBcLCm28RMFzAFK//cKg/mUgM8D+VFOWhKfN4EvIwZ0HLTfLvJ0MaEt/ITLnMmbN
	Fzl42J8MDLh68wi59PjddBQ==
X-Received: by 2002:a17:902:f64a:b0:294:7048:643 with SMTP id d9443c01a7336-29470480f8fmr67499765ad.15.1761315790772;
        Fri, 24 Oct 2025 07:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4MPeSwFhzPTKvaKRf1XESN9sP6R6a1VjFKBw7Sdaagyby5CvwLmehW1f6noOGu/6x8AKqOA==
X-Received: by 2002:a17:902:f64a:b0:294:7048:643 with SMTP id d9443c01a7336-29470480f8fmr67499295ad.15.1761315790217;
        Fri, 24 Oct 2025 07:23:10 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e1ed68869sm5129253a91.0.2025.10.24.07.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:23:09 -0700 (PDT)
Message-ID: <7c563e83-031c-445c-bcfa-c04f4729622d@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 19:53:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
To: rob.clark@oss.qualcomm.com, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACSVV00vwbNtH47S_BVet7uP7u9t4RY=xTBn_r3u4sS91Y7Muw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX35YioKJ7oVmv
 Sy8CtqPVhm4ogf/Z9x46lQY/1w8vrTa8JLOIS75rSpu/h0y3HlWOrKNGLDR6DUUzV+2blHXIgx5
 SwjF0Pw8H4vbtySRTWuaNTyTW0Wi0utipC9HLWwdFI++HpzJc2vfRBDmObmZlBkDEey3lud34n2
 OaxqUncJSNEE0DNrMv+N33rzaTJDHzYatrR+sPn0e2VIdQfqDRUAZBlPrQh5jQjvmC/5mnLeMjJ
 ITLhisnmmumeWt7r2SVXJhnijkmP5YUtLmqYXYbnIGC1x8iKXD7wilGbx3x1AR0LskpqppILbR0
 /Rg4+mC+puuv7/Je0PGLa4DJ0abLMqMBlcW8GVo+oWqL+mRBsovJ7X0/GpCr/kMOtHkLwIBqXOt
 1M6PXTGFKjX5RH29Bn3O00om/zykkA==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fb8bcf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Kgau_Mukr_2Uqyo6pRUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Wfh4m7N1KS5W2T-PfGfhRfI3BhZeZeOZ
X-Proofpoint-ORIG-GUID: Wfh4m7N1KS5W2T-PfGfhRfI3BhZeZeOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/24/2025 6:46 PM, Rob Clark wrote:
> On Fri, Oct 24, 2025 at 12:55 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 10/24/25 12:57 AM, Akhil P Oommen wrote:
>>> On 10/22/2025 8:43 PM, Konrad Dybcio wrote:
>>>> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>>>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>>>
>>>>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>>>>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>>>>> of A615 GPU.
>>>>>
>>>>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>>>>> which is a small state machine which helps to toggle GX GDSC
>>>>> (connected to CX rail) to implement IFPC feature. It doesn't support
>>>>> any other features of a full fledged GMU like clock control, resource
>>>>> voting to rpmh etc. So we need linux clock driver support like other
>>>>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>>>>> This patch skips RGMU core initialization and act more like a
>>>>> gmu-wrapper case.
>>>>>
>>>>> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> @@ -350,12 +350,18 @@ static const struct a6xx_gmu_oob_bits a6xx_gmu_oob_bits[] = {
>>>>>  /* Trigger a OOB (out of band) request to the GMU */
>>>>>  int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
>>>>>  {
>>>>> +   struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>>> +   struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>>>     int ret;
>>>>>     u32 val;
>>>>>     int request, ack;
>>>>>
>>>>>     WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>>>>>
>>>>> +   /* Skip OOB calls since RGMU is not enabled */
>>>>
>>>> "RGMU doesn't handle OOB calls"
>>>
>>> Technically RGMU can handle OOB calls. But we are not initializing rgmu.
>>
>> Oh, I glossed over that..
>>
>> IIRC the reason we delayed 612 support in the past was to make sure
>> that the RGMU FW is consumed, so that runtime requirements don't
>> suddenly change one day.
>>
>> If you have no interest/way in getting it wholly supported right now,
>> can you at least make sure that the driver requests the firmware and
>> exits if it's absent?
> 
> adreno_load_gpu() calls adreno_load_fw() first thing, and will bail if
> gmu fw is missing.  (zap fw is a bit more awkward since that could
> come from dt or device table.)

Correct. And RGMU firmware is available in linux-firmware repo.

-Akhil.

> 
> BR,
> -R


