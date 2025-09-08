Return-Path: <linux-kernel+bounces-806308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74DB494E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDEF7AAA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924018BC3B;
	Mon,  8 Sep 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YGR+v37m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619E1DC994
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348144; cv=none; b=nLC1D4DtDjioYpa/QeOXTTgCTD+U4hBkv8meddi2iOvw4QTw5CXjwINdNDcEYN2KBQtrbJSAR96aCXxOwBPrGTvLuu/AEUWbbe6TseEX7AZ6TPzQmFpHo1ddqgwDumjGukzTFRBuxzLUKkDdObRRV2Xk957+BsUHlVePku9AqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348144; c=relaxed/simple;
	bh=xaBTExoLEEC3Z0CeEI/YNIxNhKmmVGkaAy8PfnXaN+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmFpSs+ZGfLf2OaXO/rOcG+XtBbbaFAhxiiefAgVtGKHHyeTXv1BEEbByUbacaE+ccVXpo9ZmL75aprQJ3TUl+VsukOI4YtizxfAQoadAz9aaVh2X36evA3xSlACZeWVvCtPKrFkmoHgbFbDEqHaESNX/rMy5ZLe6nUWBkRRQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YGR+v37m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889OSBA004353
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W+lj6aPfl5dZoF2x7IkapYfFT13SWsFtQnlB9wrJWSQ=; b=YGR+v37mAwfyFLEH
	Q83puvX9IsZF23SzkmHh9E+TQPhJU0gl1gbDB8JchzRVG19xB1z2u9kEBwbhBqdP
	DiKdmftSYEPBSdwiMtFdv4WduYNk/KNwqdZRqns3oqAr49I2maswNVw3HXKYtuJc
	3A7A50ZUpoVni/CqgeutrJ7RLj0J48pHKlJVLKzk8a4OiqXKcQUfmrZDkhtUPH+J
	yeOlFB8k5UGhOw7XmbpTM43WChS/ESBav/5YEa+PbVQvDDiR9yA+CbSPMfFxKHkI
	tzU6NIDmTFSPuG731azwV5UDqGAyesSyn3v7M98pUcJeJ7Ikj4udPOX9dIa0xbJn
	vvRXUw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kw2jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:15:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32b698861d8so4344100a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348142; x=1757952942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+lj6aPfl5dZoF2x7IkapYfFT13SWsFtQnlB9wrJWSQ=;
        b=CTbi2mxXY+r9st1zonZEpGdb4f9O4xCPkpUcJQpi78mUB9rXoGVyeuGztbWztp9tfx
         eFtZJUXcpQecWghyhgrqXUEk/lUOpBbTRKM6fiv6atuTAz5b36uZ+/F2yUN7RXCs6crW
         l+nxcPK2Q2yyxChHbw2AnfOjLoITNZNxwdOEQJFwc3ugXEs5YStzjPRGP1qbCF2LpIuG
         BugCW05X+H6AnplyllHsr4P7YsajpAYx0tKv0TVCX9WqRHJ9ynWixsqAXfwR9nhrDFLh
         6uJb8G2Dc7NwWe5+Vt52+GduybSChKHTtAITigRFYYCZtZLW6Vk91coy7a/PhWLOH+hZ
         z1vw==
X-Forwarded-Encrypted: i=1; AJvYcCV/B6gEAZiIe6ZL/OdSI+FP7e5Wp9oR8yaRHb4MTDVxq4ZZ/TlfWqLTN892cXrZWNGb3Sz33zGHWJi+8nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxnxWSdwmMcm75IcyASMs7rmhSaIsrV+sDHvre/HWz7Aqrlig
	NivmUaKaVgnJUGH8YZNUox1SWgH9Gq5Rg0pQ0ktVXC/UFAIQuYblbllAcQ+cOM7e6tmEHsERolH
	3+7s3dMHJuvEFgBQlULGc0b7IuOgxjBfLd2wsIhNkcJJFXZlnuM7X+c/9QWhQYlG22BI=
X-Gm-Gg: ASbGnctP/W1+lAk97MdBm3bHC8yFjRZ6n/iG3bBhcpVuWQqIBI5tJOoabqVLQ9PtZYq
	r2/uIhhlnX0Z4znIhM4DTcvBX+mFzeFcZhKlHlGmDCLYq5vAL37i7EfIsH6m1Sian8TrmI0GUa4
	ORDU/oKrJRT4+NVBpMPakot/mbSUvKlvhXAAdH7eKcz8tSI6gfybnwYPfnyKmz11iQbaqf9tbBI
	ZG1G+XQm9RPr9WgNaIC/jMdjZpq7S9fz1jA6rtDP6a67WQLvAvOOz3+Bk7SsXT+5MrZOFp3u6wf
	pFWaTTwI3JTzaHKzVG4Xvh8237n3QQfJeZtOsawsDCuupie8JiD+Wu3+eRmOzQ==
X-Received: by 2002:a17:90b:48d2:b0:32b:cba3:6361 with SMTP id 98e67ed59e1d1-32d43f76b78mr10340172a91.26.1757348141354;
        Mon, 08 Sep 2025 09:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZF1OPxZnSURBZkaB/X4pj0b/Fs/TUocy/fiORRAwfDENjJPxq3DAYNP2im4uK6ps4zcHOGQ==
X-Received: by 2002:a17:90b:48d2:b0:32b:cba3:6361 with SMTP id 98e67ed59e1d1-32d43f76b78mr10340134a91.26.1757348140791;
        Mon, 08 Sep 2025 09:15:40 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b948d5471sm6213558a91.3.2025.09.08.09.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:15:40 -0700 (PDT)
Message-ID: <ae32a704-025d-443f-bc03-fd8c6e5d3acd@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 21:45:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] drm/msm/adreno: Add fenced regwrite support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
 <59ac7827-6258-4268-8b71-4cbcbad859db@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <59ac7827-6258-4268-8b71-4cbcbad859db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXxkiNaNfIGqRl
 MyMP1RlwK321M2vF1sz0DyIx/5qkcx32SSvl1efwzLex7oKj2XyVd5I10m4De+U8cbaR1njcMtL
 1eZRxhSsZI3wmBplpYRiXgzbFLNuF3dk7ryXxEziMBEp0TiJ+vpXsmiiJgS7e2vMzRR+0Ya8yiM
 LQd8DAuVK/W0a5G3NWzoVH7CTkxJ+j74xJYKWClcUXUFZF+RiukEmft+TUdph8Q4v7NXJURqR4x
 VMzQxCanWxpmKs2zVsl2/j14weAjMyrMyYy+4oWgec3nNCq00AqS6m9p6nYdyL96Xz8GQ9Bkgmg
 XLgMHNQ2yBhJIMk3ekA+puhuYxA5GF8v5w5dEnZdEtrWclSxsTriGqZcGFxTmUKvQhiUuYejOAi
 eIVkvw3O
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf012e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Npwa9MXoYRiG9O3kBDcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: mO2rynJYHY2km7DYCSSC157CXrelUyQa
X-Proofpoint-ORIG-GUID: mO2rynJYHY2km7DYCSSC157CXrelUyQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/8/2025 9:07 PM, Konrad Dybcio wrote:
> On 9/8/25 10:27 AM, Akhil P Oommen wrote:
>> There are some special registers which are accessible even when GX power
>> domain is collapsed during an IFPC sleep. Accessing these registers
>> wakes up GPU from power collapse and allow programming these registers
>> without additional handshake with GMU. This patch adds support for this
>> special register write sequence.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 80 ++++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++----
>>  3 files changed, 90 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 45dd5fd1c2bfcb0a01b71a326c7d95b0f9496d99..a63dad80ef461da45d5c41a042ed4f19d8282ef5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -16,6 +16,84 @@
>>  
>>  #define GPU_PAS_ID 13
>>  
>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>> +{
>> +	/* Success if !writedropped0/1 */
>> +	if (!(status & mask))
>> +		return true;
>> +
>> +	udelay(10);
>> +
>> +	/* Try to update fenced register again */
>> +	gpu_write(gpu, offset, value);
>> +
>> +	/* We can't do a posted write here because the power domain could be
>> +	 * in collapse state. So use the heaviest barrier instead
>> +	 */
>> +	mb();
>> +	return false;
>> +}
>> +
>> +static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value, u32 mask)
>> +{
>> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>> +	struct msm_gpu *gpu = &adreno_gpu->base;
>> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>> +	u32 status;
>> +
>> +	gpu_write(gpu, offset, value);
>> +
>> +	/* Nothing else to be done in the case of no-GMU */
>> +	if (adreno_has_gmu_wrapper(adreno_gpu))
>> +		return 0;
>> +
>> +	/* We can't do a posted write here because the power domain could be
>> +	 * in collapse state. So use the heaviest barrier instead
>> +	 */
> 
> I'm not sure I follow - what's the relationship between the write being
> posted and the power domain being collapsed (i.e. the hw not being
> powered on)?
> 
> Are you trying to get rid of the delay that could happen between this
> write leaving the CPU and arriving at the GPU (which would then be
> woken up), so that the 1ms poll below has greater chance to succeed
> because of how these "special registers" work?

We should strictly ensure that the GX register write is posted first (it
could be posted to the hw or dropped by the fence hw). Otherwise the
fence status register (in CX domain) might incorrectly report that the
register write went through. Ideally, we should do a posted write here,
but we can't do that due to IFPC. A full barrier (DSB SY) will ensure
this ordering requirement.

Another motivation here is to align closely with the downstream sequence
which uses a similar barrier. It will be a super painful debug if this
sequence miss a register write.

-Akhil.

> 
> Konrad


