Return-Path: <linux-kernel+bounces-743211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFAB0FBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE7C1CC0FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC717C91;
	Wed, 23 Jul 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZwFZ7Jw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58021E1DFC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304802; cv=none; b=WeJhQva2Je0kQE94EFmi116KtvGvVYaGIPZsbbO8AYAo+tmVoo/ZyC6KSEVFhymwbiHP0dOM/zrzRJnfsGANcLuL2rhGynaGrqrzEPN6eGZwhG1FEmjxLkQtsLx+wv63cUsp/0UzFsjphpbvCTlfF1Ct7u8UzqM0LKcAr+ZgWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304802; c=relaxed/simple;
	bh=KaTinh2wcVQddB/r0+o/CwQmYiGFEfjMTexn1oy0PGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMu7YHrc010VKtATHgP11Nm/2Vp6mRQiWMuhS7BnRJxTVqVYb2C2MnsRelhPYGRBDN3cKUAc8H9oJR4Cu3tZ6u7WASNvUJOCmjhkuCEEG35qxiR+sf2ZcZk9Eel0w1HrSFeoTRSMafRtscGG9/E1yL2LJ9vC1AlC5bj83M/0EZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZwFZ7Jw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHMEUX012655
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ByNsxNG/AyQvTr41MbSY4M0uuFiVWXFnX5tJOWH1zQ=; b=VZwFZ7JwlVcl5ZMS
	kGCFgDVeqNn1ZroGfszFIX+aPstI6Z44Gnx7IrDmK3EwwcwC4Z9zofg4Z92tUTYo
	BWeWOK9H0z3P3MEL3PKvUcZr373MGQ/8/L+SOjZEILn15B969HRDAbgEQ1QGpkMn
	ZnVZFjICNFnfl1tjpuKQO5zDjiY4tfdR62waN9PVkR09S2vW1wBlZn3vEZpMIE3/
	STy6zW1gla2DkMRjpxQBmDGejAEh+1eWlESMqWc4dsUG7bdAHaS/8bd/hCsEqN52
	tQwhY8zWvzs/GWJysU/SDEhXyPNbEF9e5IizupweaF4t6mjlmpesa+W97PLGK4Yg
	oesgBQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qehww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:06:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-237e6963f70so4010565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753304798; x=1753909598;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ByNsxNG/AyQvTr41MbSY4M0uuFiVWXFnX5tJOWH1zQ=;
        b=OkD/pvQqooadE1zpLUkvfnX/fWzzbRr6dEq0aOj942c6N2YZGRKdyQADy92Qra8r45
         pAoOcWOUx/46mjA9LPtYsRnMU94OImUyQTq4BXMtq9CD8m/sQY3yRQBW5Yvx/pksS9tM
         oaZSHeVuPGTRi/cJkTlmw5uHTTOvgIXcYwqzAf2WBfPBMW8FNlR00nPuOR2dYPiNzI15
         TQWCwnG9296Bk3yX2Rw0jU832uxQQZT2ApA9ut4GXy0WAxUqvMjQRob5l8sa0XRa9XFx
         IVfMHDp2XjxloS2RDrciLFy1AfLX+PkpJI6rTaao0EV+hLsuNK3MourKV3D58qmRyNxq
         uZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWnC0GhgEl+iq+6w0fz/u1FtxkcNu0/HlrAbADnHW6V4tJ+88TpIggl6+QwDJChnQjE98o9/wZxbxgQBVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYwnL/zCiGjITe3ZIqVJDhhmSUS2fS/BzvknwGei1M3YEvf6/
	NBcS2z36iv/u1xednqtq3J3E68cIWN3VB4ggdSy1Pl5o6ud/sQBfDhsZTPjk/Xm6TZQktBF0gGu
	Di2TBSyRqFKlpXNThSkyBceuhxhU2IWQ+/rlrLAHi+RLuyjRQjn/3EsZrs57l2u3HNBU=
X-Gm-Gg: ASbGncuuE68YVf8tZONwEuJwdAiBrTdYJkoVRSXrqLWakCy34Jhs0qq6G73iXSw13IO
	29ZCN+bHC0on/s7b7iTA8t537b79FGAq2aTrjC85hYFPf7Igqz8fIkdcfJcrl3tmhlgH6WLHawf
	p6V7UIydgJpzHAXNtXZCD29yOHD0hNt3i39PGXrg0xuACHdjxtjSwPf4Bwuzv+kZ6BqyhfQhJNw
	GSE2Yv2Y1/MblSgckKsi1H4gbAzg5yfpNsKPToKZAWj7sJqyYBEKTCbJqj8sNbCMwhxQ9pnrdlT
	db15A5vPBV9BVyUatHPqbBVMhC9yV89pLBBuzLF+1yxgrK8iDOirP/mT5jpoRQ==
X-Received: by 2002:a17:903:184:b0:23d:d348:4567 with SMTP id d9443c01a7336-23f9813f511mr56953325ad.19.1753304798281;
        Wed, 23 Jul 2025 14:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxu2LcuICb2xFOgDTOahLCuANW8W/4axRcHon5EQHJL5Qq3U/5Qcx8vWysqROHALSCldmkrQ==
X-Received: by 2002:a17:903:184:b0:23d:d348:4567 with SMTP id d9443c01a7336-23f9813f511mr56952995ad.19.1753304797828;
        Wed, 23 Jul 2025 14:06:37 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2fa7sm102685975ad.162.2025.07.23.14.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:06:37 -0700 (PDT)
Message-ID: <d696e7df-7f11-4491-89ff-ba71274ae101@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 02:36:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-7-9347aa5bcbd6@oss.qualcomm.com>
 <tyjkwrdmsj7k7tkqqxdd65l5v5jxugr5me3ivg5onn3hbffkwp@7uhsbzolqiyd>
 <30442713-2990-490a-b076-93c3cfc3901d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <30442713-2990-490a-b076-93c3cfc3901d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4MCBTYWx0ZWRfX3V9jZ9RH2VEB
 rwXIcGKUNH0/4omaXMkoufQOq+7LoDb342Vw7T4HWWEJ8lZkwMCminL3+C3JlCnqxPN2+qUBwaz
 igGPiLpPDD8KNXxDvzYbuRjAUoMvY6bXNSX8i/MsAaA02ANQWSzL3/ldr+Z9VpO3ibIy2YgGli4
 kVfm7mWO3UQhq32J3fxIlGlOgVFdz6PZKa7tEcoyOtF8KXjlp4I1Pl/t1iv5HTXUjFPVy3KEwYJ
 qJkR7xk8LOcZ1V5llJptbpB1tbG/MMIDtKeFR500YaEv9UrLobuAbUqQOaNQcY0gat11rgBjgf5
 2h12vro+tcpHrcAp6ke7mWbD7iz/PhE7Sv+NOoBgGcDQDB3LlojcBq7TQ8J7G+LTNOQ/zG09QaX
 TjwIxGCW95vgM+1fitlom+8wF3WDO69v6vRzdVZ3tmQyx+IP+k5h6t5/rt2G89kzWwrsbA01
X-Proofpoint-ORIG-GUID: dmH2E5hQHIyuDDY2QBXm6PhuVLilgCl2
X-Proofpoint-GUID: dmH2E5hQHIyuDDY2QBXm6PhuVLilgCl2
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68814edf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=sI7m75I2uMoaLRCfwtgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230180

On 7/22/2025 8:22 PM, Konrad Dybcio wrote:
> On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
>> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>>> There are some special registers which are accessible even when GX power
>>> domain is collapsed during an IFPC sleep. Accessing these registers
>>> wakes up GPU from power collapse and allow programming these registers
>>> without additional handshake with GMU. This patch adds support for this
>>> special register write sequence.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>> @@ -16,6 +16,67 @@
>>>  
>>>  #define GPU_PAS_ID 13
>>>  
>>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>>> +{
>>> +	/* Success if !writedropped0/1 */
>>> +	if (!(status & mask))
>>> +		return true;
>>> +
>>> +	udelay(10);
>>
>> Why do we need udelay() here? Why can't we use interval setting inside
>> gmu_poll_timeout()?
> 
> Similarly here:
> 
> [...]
> 
>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>> +		return 0;
>>> +
>>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>>> +			offset);
>>> +
>>> +	/* Try again for another 1ms before failing */
>>> +	gpu_write(gpu, offset, value);
>>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>>> +		return 0;
>>> +
>>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>>> +			offset);
> 
> We may want to combine the two, so as not to worry the user too much..
> 
> If it's going to fail, I would assume it's going to fail both checks
> (unless e.g. the bus is so congested a single write can't go through
> to a sleepy GPU across 2 miliseconds, but that's another issue)

In case of success, we cannot be sure if the first write went through.
So we should poll separately.

-Akhil.

> 
> Konrad


