Return-Path: <linux-kernel+bounces-767488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C7B2550D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D0E5A5D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0A2877C2;
	Wed, 13 Aug 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aC3fyS+B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD912BF3F4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119751; cv=none; b=FixNuJqbgxXbQL2xUqyf7eIzABInBYaCoKVp5r/aXvGgkKa8Kz6FJ5F2Xv0iymfgcSxwStJXUwzsYL1FkYXNGOqLj1JeWbI3KgSjEHf+cg0YcU+psBGOPR7UbPoWisdh/k8Hj12goaQeYaLq9/PblwzZkcLIQqOElua+PYPL3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119751; c=relaxed/simple;
	bh=BAggC82hGGSdIe9GlhBLjSGUQl6CuSPTgyoW7qrBemY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpn5OXXpkISp3cxzDttDROQApA6LVXwuB65qzXHOuox5nVCEO+TVzgLtWl/U6mClGlVzkPStn+5IwNKgID9utOyT2LrXpvT/c1FXzSNkHRZOTQ1NKeqe0C5wPMeVkpeGzfIQSD6Q29p046bOQfThpapb4iFlJUDRvyLuD5u4wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aC3fyS+B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLkSJ031164
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BU4jpzKtkDsQFKXYvRi5iZOPZy6N+odqXW/8kLMUFwI=; b=aC3fyS+B86oBIXic
	Z6Vt+HYCZPSUECqGjyQ98u5u1kEDjjXC7moR8Y7Yw+bZGjA66tZYmfwzxGcyn/Ql
	FpMxKo3y9W0/vwJpZJQ4Fufg93/rag9jkTrDNJLQ88qiZfAb3X/NoROAxgOcBvEE
	0tYh9M3Vk87BANWvYK+P0nj3kaRiLiDBg73XlHHyJglLd1BRNC9I6iHM+ldJb8WF
	BG97PbBS0cijCZUwWdT31bwKWY6Af4pGkACAjJx3pvS60D26zE9s81fmwPWeVw78
	9Vs7K0R6AWqLzrw7gH2VKqIldvtzTkWHMbOYT44g610ExtqHIlmL26XdYcwFpHsY
	X1vYHQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vr6jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:15:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f59889so2173955ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119747; x=1755724547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BU4jpzKtkDsQFKXYvRi5iZOPZy6N+odqXW/8kLMUFwI=;
        b=FdJm99x8M4b5nRL5U0meudyCFCozIW6NtHl/E/aYvKD0AC5D6IMEDJAwrijnsI/36e
         9J/CAEjfGHtZ86OsFYMBFqFALYtrdA6zjeUMAFnyBf1aETOp0z2vSIPSArp9ZJc5fUjC
         OfSt+sC1zj5aB49q7zrYW9oX7urDXV05csBWvBEB05JlkMPe4EFHKuBzdZfPIwxTU2pz
         BFZh6wkEwnEWWsLQIFrk1NARO3YJ2t4E/MQ2YZE81fX0gQ8STvwZez39Wwgol3eKOs7l
         Bv85+Wbb40EtY/Xq9smmra64/EXkKgTq6ORsOuOm0Ijqba2dEpkEuXDh3VXAK6EkBLdP
         MgVg==
X-Forwarded-Encrypted: i=1; AJvYcCUj7NYo6/k2JpALc45KEReUN9t2iG7tcC3Lw+ob8FZDFqqCMeQE7NixxmRG+TuJFoj8A7RzVZk02bojC6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZt4sgr5UMz6KjM1vdALV0NpaIO6b2pePLVDtu3htR+KdAVMz8
	d6b5qmY1P4GFcl+Dam/nLF5Cx8Z8MIv6l9jrpi5eaB+h3Eb5WSub5sndaz6W8WU/ZtcuOK65R1U
	y4A8Jab1r9Pil7rpNQ03KwNZl/hXpTY48kOGYSDog2mhgd4NYrYcd3SlOnvb/izX8b/0=
X-Gm-Gg: ASbGncuMutohg78SdAMEw+CMfb+f76NzHadiPtbENpNl46rTSmVGOY8k32M+X8+1Qjk
	nG4OhtTpbJBcFvw1ED2YnExlD6zPJ2d893fixAZhBJk0apWovBJWACLw7TudhKzr+xTiRka9ZB1
	WJm8N0jBeZc0UUFSDC4lGl7B95qsmqslE/zSlaTv5acBafVfTGFFlv4g1LgJSnRlAu0aQQHsjG3
	wzirGgAN7i2yzhu8qDCv8OmpRgDrJyoR3Xyn8zYMI4ywuxlurnFyvYF9j+fUIF3hvVV4yY2/OKa
	cob1uO+NagaX4Rt8WhJbEjFycuyvlV5wFFsN6GS/1kbtKspnB/IWSntDGWGKLIo=
X-Received: by 2002:a17:902:f612:b0:240:22af:91c7 with SMTP id d9443c01a7336-244584edfd6mr5554985ad.14.1755119746933;
        Wed, 13 Aug 2025 14:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHegHtK3Ax/E8VqCoX3HqLC7R/eeYh4Ddkvi7u9xQ5U8sonAzBwOxUTAIwSh2fBoqSbuDCrcw==
X-Received: by 2002:a17:902:f612:b0:240:22af:91c7 with SMTP id d9443c01a7336-244584edfd6mr5554695ad.14.1755119746464;
        Wed, 13 Aug 2025 14:15:46 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef595esm331895325ad.13.2025.08.13.14.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:15:46 -0700 (PDT)
Message-ID: <5e862a36-8384-4098-b22a-9bbad1205965@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 02:45:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
 <937197e9-09dd-4f3c-bdb4-4001f5217c07@oss.qualcomm.com>
 <ba1d97d0-3420-4cca-8823-4d27cbe7bae6@oss.qualcomm.com>
 <d9357f4a-6f26-4570-bcb5-62fe39c78a70@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d9357f4a-6f26-4570-bcb5-62fe39c78a70@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX/MdDVCxQveX0
 1W+uWWM2mJb6dE+8Pvpl1cqAZ4FT3LBEJqE0kltxlMBmz6eSr2ZcC8qsRpBVIjDykUYDcQR2phs
 k52tIJnQJsuzHVVHaWGgO8SWjXQ8k63KUjUgVisr5wNl5KjD8GpookVozTkhnwXrtqilrCJ3eGm
 WzlBdn+BEmwm6r32PpxA+sd9nATmKIGD+3Y0I+Kp+qCrMTl2QJNfN+joNBbxDOh2F+mZfJkTpMc
 pvFSbGPhAItQJqj9hptH5+f2vkv5ycfzALht5HFwJe7yPdi49mAqCLP1NLPtwqkuG2hdyOEzsJF
 mgV+JLluZRfLlwawk1OwDAXvemWYL3zRJ2JqwL29RPX83z+YNHr8JdiG2d464qeslMN9CvSj6QW
 JoRVSxwF
X-Proofpoint-GUID: Adb6_t7LpZMPZEWzz3E6aib_nplrTyqb
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689d0084 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=geSN8yY6MFID4zSGlH7RRw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=svzdbv4JTWmE8afvHjAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Adb6_t7LpZMPZEWzz3E6aib_nplrTyqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On 8/11/2025 2:10 PM, Konrad Dybcio wrote:
> On 8/8/25 7:22 PM, Akhil P Oommen wrote:
>> On 8/7/2025 7:21 PM, Konrad Dybcio wrote:
>>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>>> Since the PDC resides out of the GPU subsystem and cannot be reset in
>>>> case it enters bad state, utmost care must be taken to trigger the PDC
>>>> wake/sleep routines in the correct order.
>>>>
>>>> The PDC wake sequence can be exercised only after a PDC sleep sequence.
>>>> Additionally, GMU firmware should initialize a few registers before the
>>>> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
>>>> GMU firmware has not initialized. Track these dependencies using a new
>>>> status variable and trigger PDC sleep/wake sequences appropriately.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> FWIW some time ago I made this patch, which tackles a similar issue,
>>> perhaps it's a good idea to merge both:
>>>
>>> From 7d6441fc6ec5ee7fe723e1ad86d11fdd17bee922 Mon Sep 17 00:00:00 2001
>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Date: Thu, 20 Feb 2025 10:28:51 +0100
>>> Subject: [PATCH] drm/msm/adreno: Delay the Adreno RPMh startup to HFI init
>>>
>>> There's no use in trying to power up the GX logic before we're almost
>>> ready to fire up the GPU. In fact, with A8xx the PDC and RSC uCode are
>>> loaded by the GMU firmware, so we *must* wait for the GMU to fully
>>> initialize before trying to do so.
>>>
>>
>> iirc, this wake up sequence should be done before fw start. That aligns
>> with downstream sequence order too.
> 
> FWIW techpack/graphics adreno_gen7_gmu.c @ gfx-kernel.lnx.15.0.r3-rel
> adb0a9da173e ("kgsl: rgmu: corrected pm suspend flag check on resume")
> 
> // load gmu fw, enable clocks, irq, set up chipid etc.
> [...]
> 
> // unmask CM3_SYSRESET
> ret = gen7_gmu_device_start(adreno_dev);
> if (ret)
>         goto err;
> 
> if (!test_bit(GMU_PRIV_PDC_RSC_LOADED, &gmu->flags)) {
> 	// set PDC_GPU_ENABLE_PDC & seq_start_addr
>         ret = gen7_load_pdc_ucode(adreno_dev);
>         if (ret)
>                 goto err;
> 
> 	// disable hwcg, sleep/wake handshake setup, pdc ucode
>         gen7_load_rsc_ucode(adreno_dev);
>         set_bit(GMU_PRIV_PDC_RSC_LOADED, &gmu->flags);
> }
> 
> // set HFI_CTRL_INIT
> ret = gen7_gmu_hfi_start(adreno_dev);
> if (ret)
>         goto err;
> 
> // continue booting the gpus, send out feature messages
> 
> on a830, the patch is observably necessary (gmu doesn't start otherwise)

I am confused actually, why are we mixing ucode load and PDC trigger
sequence?

-Akhil.

> 
> Konrad


