Return-Path: <linux-kernel+bounces-878391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926A6C20802
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF65189171D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0623EA8A;
	Thu, 30 Oct 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWuor9Yx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jX4WnwsO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584801EEA49
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833076; cv=none; b=V15Sw9uMPPxRtG4kih1Z7Fo9S/bWX/FAaLCqSU5ekG+OUTkvx95UGCEOksdmUhvh8Jm47InDrW7WeqXa1gZ1oMHge4KmyAHMUYJUN5Q489m3NiprXw1/oAF5JYhsISm3cIrNqGTeOtpI0WEMye9Eryt5abcj6UHi6uUIqt9UFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833076; c=relaxed/simple;
	bh=LTWQBjn0CZ8QqR6dlwlS/KcTfG6d9CFl7mBgOcL6lD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcG58JU+0Ee96ccpL2fQFacqxIwttfsN6zJOOET/svwIP83U0h0S2/G8fcJYpbTP5X7WtP4Z2xnMWRBs/zx9IW3Kj4JNCEvQSNVTN0PTQCWx2HDSprAuqWRvZi4IM0PNRqaW/7jxt8aSjXwqUzTPEJdSmX5+X/DUuaUCyn8AJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWuor9Yx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jX4WnwsO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7Ant31501800
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=; b=AWuor9Yxkz6K2wy3
	IiPbM7oYI158WOrYLTN7eMPnu70Uu3AuuCOcn+C2w4weR3T6rH0AVFAd8haAFv/H
	pNOTpocnKQbzDT9i+zu+/tXr0ZhoFM9AL3KPw8cFanSHVtw7MGl/3zpSrFwgl/q2
	0znrD3KNsyRnHMYKTFNSXUOSvUj7qrbSCBsPrJd28y8iFdv9h5hgmwvolEKYfvyW
	KmBmsjWOrA6rN7696+mrUhXbV7d89iJz9P3oZmHddxBMxy08Kh/Pcxii9D+xnwb2
	+Mlze/ikiy/UbwTVNSOmrQ0jJVssydVZuXIblCFlRmYMGdkiJ7zrRwy7oAp1LC8y
	R045iw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1jtpdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:04:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810289cd5eso2862422b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761833072; x=1762437872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=;
        b=jX4WnwsOdv7FkLdndJmHdOBBDg8fSFHXrdYoHVlj57Ba9hJIbyO+O6R81BHzGrce/+
         Fj+YCpRPeOqMxk8k2N3veMWSuJ+10KXxn4bJBGEJ1pDIvgc/wcCaH91pwd2M0mqqdcom
         s0HLAWaIagL4+bnZGLelwTgn9N04bJTop6z2jcZOfcRmquiqb9cdfdGRKZjEyY197784
         J57SS7hXQj6yRZA3Qu8vyQF7BruJ1CfUq/qRhLmgGZ+9NF14An1P9pafkPcW06fRB/+f
         HjfgfCsOceehwlDzZGpOlF5zg0LvPtH1izPPDtOXnS7/lznj7mzccuK3d8HrAsArZJQL
         R1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833072; x=1762437872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=;
        b=nGPmi33Xt+qjnZ8JYK5tkBxn2ckxP+rkXNeB+EUYu2KJHMKjLy9rLZSLdq6l4TPhId
         ErFYRZd34FPiABJfQyGW6l/sF6RxNTD4VYEiheg7mVSUxGbYQvDs7hPV/sbqNXpL14O1
         PCQrlNvdW7S55ZQpCYKoLuloN936yds6HtSGY3p8P3W6YVGlOEwqY5p/hAZGDFNdvgYU
         5NaYSccArAAyX7tHIsPNmNpADrxTzGJZGxSNkyRZ3iExfTO0PYC+iEWf6wvGlg52QMZ2
         eSFJ1UZApPVGhJv9cArXRshJoGLCrxbYXCoX28zxcrNNeNoI8bLaQukfR3NhBunAXLVx
         OmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKOxgpyc1bDnYNs3NWOEpObe1wrLJeEun+BLPvS+nTbduv3jFiPuroO+qm6v9zFyma5Xj2CNM+t8ttg1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNy2XU3I+mVb5mQwOw25RMer1Sc+sRJ16jEg3l58mp2w8PofF
	KFi62s8gmSZwSsjdatw0KvFrvGCIdvwf5joHZRvLa/PxdVW8GSfy1zuj154zwGH8VYRQMw8r7iC
	XV8q92HljgbZKDFKyZuq383bEix6oBh9YbuPXpSsRdHWknMVO6dXiQP9361RCiadqjU0=
X-Gm-Gg: ASbGncvPiU5oELA/XaFXPnJZqY5UTjIriQf4gKOAd0IPYklSxtEEPQ6NiWa7YfbFwV6
	RCZI3R0iMy+iX8E2I8rfr/0XzqPEASyzCqxJ8jOnuWx07aShQ3A2ilDvE5WL8ZSe0xJlM9U7HEk
	dGXsYXbsav5RURKkXUlsf+jv6NTcECPlLgLwtj3wKKf44ePbNSsLZBw0CPBQ2zbaWbiO4/mclVf
	X3GHDYXbYNl80edV9og2oonW7yXC7YpOwrxXZf4EcVu09zSjtOmDd40J9VjGAN7r+eBcDz59a2p
	RQRqjXBhsNDVKQHVTBEBQiUNRcKD3fZzXcj4G82b7exBRtuIt/UpynFbv8h1Q3d0JCUDSrSx9NQ
	annId6YxzW+R9myPts/1K2Q==
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr9513753b3a.14.1761833071968;
        Thu, 30 Oct 2025 07:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOsm+Sq4JNvFojnAbXxBbvyUiQ9n1HBmXRQ7fcHIwRyOXUnsy9UNUn/WOnPgjzpqXGKHxy5w==
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr9512694b3a.14.1761833062850;
        Thu, 30 Oct 2025 07:04:22 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm18826520b3a.70.2025.10.30.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 07:04:22 -0700 (PDT)
Message-ID: <4b41cb16-858b-4fc2-8ee1-3a7171712808@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 19:34:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: rob.clark@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
 <CACSVV03HaKAvfDa5A5LqRZM4_o8g-haVU3A6GgWqfTO0QNcK2w@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACSVV03HaKAvfDa5A5LqRZM4_o8g-haVU3A6GgWqfTO0QNcK2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QWs0zGlhrJ1tDS-BPIBIRP6tuzK3eqba
X-Proofpoint-ORIG-GUID: QWs0zGlhrJ1tDS-BPIBIRP6tuzK3eqba
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=69037070 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ktRuAwBfdPNgXckAlmEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDExNCBTYWx0ZWRfX34byAIBSQFEs
 UdV6siP3omu7O+cx3jbcaWVpqw0XYcNZpcuW7v+W+7y+6/NSPCQXbO4kzOpJ3YQ/LUaq3O1iGl6
 2Y8T5kafkNB7sbMzl+2fajpYrmxshRIN/xHFt6hwRE8n/i7JnwGzZRA9zP/X5csVDXV6s2Mn01k
 5zgueZQ0xgr3nlFhhi3tmcc2hhgwF95X66qhQJc3dN6nbTCPd4rKn/SopnYUErEifhbEXMaoriO
 xYvQqxsOZ81O2tEhpuYRH//cuAbYv2r/CO7VOn40rzQzws9k9R+xrOFCbRpWbpCnDrPGpvdR0RK
 X1KoD1nH9lpEf1iS7YzJgF2Js6ox4R9XDB4b/F4ZZfYcjZQgZzZRMXRMzx6I+HWTr3JIVJHjnXP
 5NrX2PlSCwRsbybY0B5sGqnZp0gJGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300114

<< snip >>

>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 0b17d36c36a9567e6afa4269ae7783ed3578e40e..18300b12bf2a8bcd5601797df0fcc7afa8943863 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -46,6 +46,7 @@ struct a6xx_info {
>>         const struct adreno_protect *protect;
>>         const struct adreno_reglist_list *pwrup_reglist;
>>         const struct adreno_reglist_list *ifpc_reglist;
>> +       const struct adreno_reglist_pipe *nonctxt_reglist;
>>         u32 gmu_chipid;
>>         u32 gmu_cgc_mode;
>>         u32 prim_fifo_threshold;
>> @@ -101,6 +102,11 @@ struct a6xx_gpu {
>>         void *htw_llc_slice;
>>         bool have_mmu500;
>>         bool hung;
>> +
>> +       u32 cached_aperture;
>> +       spinlock_t aperture_lock;
> 
> I don't see aperture_lock used.. but seems like maybe a good idea if
> a8xx_aperture_slice_set() acquired the lock and we had an
> corresponding _release() which dropped the lock, so that we couldn't
> have race conditions between the users of the aperture.
> 

Yeah, I guess we should add a lock because the pagefault-coredump path
and gpu irq are not serialized. And both of them are users of aperture.
The other users are serialized already with gpu lock.

-Akhil

> BR,
> -R
> 

