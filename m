Return-Path: <linux-kernel+bounces-743120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A46B0FAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E074E54B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96D1223DCC;
	Wed, 23 Jul 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="koS+cKhb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640421A42F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297856; cv=none; b=G4fcVmQN8iZnJfLgtgTTP9xY/vyep7y+cJCH/oXll0S50j5abaIYyAyFBdic5e3pX6P7TpzKh1X7mHlKqHi09kMZU+NHyVRDIZpnH1l3wCDLnxNWoPtGIITQTPKL8OlVCwIJcKjmqkfhd8mKwkh1GxrRkhAKVOhsjbCuE/XHUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297856; c=relaxed/simple;
	bh=XMbqwf1g/qeYxxwegoHGwxwKfx614CKpPGSZP+z8OyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHF00VFUjz2MQeHZPiN3OTGVYktTMHa3CnFjDghJVkVB0h7rt/UBzNTdRl/hQ8eneX+Saf0bU6JaoUb5/LYiDybroWW3+qtvoVisX3d4tGQiG25hxrnZgfQlyByRrIVcu8A42b2wpfE9q4w7IGWr/e6jLevTjIHxsVgj5mI9KyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=koS+cKhb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGnu9N009438
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KgSt802qmdeMVi+yTHJ1x7sZur/iyrLv9PPbtqJ0DcU=; b=koS+cKhb+lq+w662
	kXqbKfL6yTiH0OJ2FtDGxz+azvW/3i8pGhqAoAaEyfTj3y/t7BLszI3SyNZq+g+B
	OTLXxVh+07Issu4T9bMhYkgcC5g7yCp3Oh09b1i0W1W4sSHSchPWCOrA+2ZrHl5Z
	IFj3fOrGB4syUhU+SerDrUSMfG+iFsOsHuiz8VkG5l7OCV0u1L7FQGXDW8b3/Ydi
	QJzdRTA2zTOs9OVl4c/FbCaLRyXCCOhHqea8WlqH7xL3DpVTkFGpN9ceovdj+QZK
	Q5L41bzy/qZmhAGRNzzWZdTVS3ZdhcZeHHANXql9pKz/R/zvMBHoAmZmxPfHaH3K
	4Dvb+Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na4rp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:10:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235eefe6a8fso951955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297853; x=1753902653;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgSt802qmdeMVi+yTHJ1x7sZur/iyrLv9PPbtqJ0DcU=;
        b=ERz6ETj/o2GDneyy4NZIHdqVsnsietruHrebAEVTx8hLmV7QHAIenbLFdPApMGct9j
         7lL4+pcAuUyvlcky2I8wmhDNii+k4Yh2rYPlynmw9tsTONyBYpV1bYDpAYMUE74rNBvv
         linBndmh2jDB/WhtAZte+8mDO1U2+00Xt453Z/lHi2w98lT0Lv5H8JCwAcrwwIx3s4zm
         UMUIhSjxRLBx1rtXsyVNciWNCS0Sn6WIl9aGgAdGPA3KgKulU+2wS0F8ZdqNRwXf0V/d
         +7n3ZUDsjLht7nBNnrPK7xnD7CgFZYoJHedu1pi3kH8IksCT+x4amOcuGkLpl65eZGIb
         n/dg==
X-Forwarded-Encrypted: i=1; AJvYcCWQt4GpJk2vX1HaoIntHgZvZehTzDOEhdnLWel+H8fqQCubPtJ25bKFF7vtpiKHDmY8Wsx45ZQ2PrB4fSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEUlAKPH2NrZnCvJ78WBlIP9OgXEJCCzXEoP3AHej7d6KgCkE
	29C/EV1BOwVwMhoFW4k+a0FmyxZtgTOgLXMbhvHXzAzIShpcd2C570UbGJwOnSeiutLIZtOmFHa
	Z9CF5b07dla/9Ul4w6S7JIfo6b60szHLbZFi3iwOvzyqsJphGm6xVoIXniWprLsFqvFo=
X-Gm-Gg: ASbGncvGjS0wfsQNqOQxNVQIzEEC0dtw3pFYVNGvKdRX38MWcveCEMPa3F8S1XdSWR4
	iHtJNdroNeZM4B0YDHbry9XNvYoMmu71/GYXTrdpqJ7dV6SrMz5j3qMxIUuQddcVRHPho1MVJwc
	+Bca6IsqM8I1xnVj88Hsv1c6oOGq7R2m+ph8eE3mjnDFrD8B+wR/PxB9u7IgUwXFx/Sp0C5bNPY
	rmcSeyYmCpHHm2ePqXua196bZC/1CK/0zMlW8Gm0sazbx52sUvlGr0yVty2FQRJYVETlUGcHsRL
	PXHjc/teaALr49l5/RokVpzx+PRI6JJv/2FEhflu0xLyfWukgiBhvDyjFEZCJRE9
X-Received: by 2002:a17:902:e881:b0:234:8f5d:e3c0 with SMTP id d9443c01a7336-23f98161a50mr46228425ad.6.1753297852711;
        Wed, 23 Jul 2025 12:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3CHLM1wF9WJWdlUe1Sb3b2TPPZfOnw2+jdpTbeD4nUnNJuQbnaKGQAjcRTI5pJWuujuk/7w==
X-Received: by 2002:a17:902:e881:b0:234:8f5d:e3c0 with SMTP id d9443c01a7336-23f98161a50mr46228085ad.6.1753297852153;
        Wed, 23 Jul 2025 12:10:52 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3c89sm101986125ad.18.2025.07.23.12.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 12:10:51 -0700 (PDT)
Message-ID: <100ca94f-e1c1-4cc3-8282-a14066396f5a@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 00:40:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
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
 <20250720-ifpc-support-v1-2-9347aa5bcbd6@oss.qualcomm.com>
 <d4b46652-c4d0-44b4-aef5-e8bcf606de06@oss.qualcomm.com>
 <4832a160-344a-4140-a115-d4742f95825b@oss.qualcomm.com>
 <02b9de9b-36c8-4db8-a1dd-65a82aee0eaf@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <02b9de9b-36c8-4db8-a1dd-65a82aee0eaf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TBUU3acnADcRsIcunpTvt1rvQmq2VrU7
X-Proofpoint-ORIG-GUID: TBUU3acnADcRsIcunpTvt1rvQmq2VrU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MiBTYWx0ZWRfX0jJM1Ik9E3Qq
 8W5qqjOAr+uySYvyJPZA4yiSzT/XK3au/3sYac91FW8Y3vsHb4bU+20bzq/r8NLpRhoA991eMp1
 LtSJSFW1GkHumdkBuOfCz6JSvQmqY++krjtegR0QC9cJmgKVLWX/whhrVTdKRHm4qr9+gVGdXO7
 1vGMIzPdN3v0oTJiZioz/KLLzUCmO0q9EKUuG9On02calJ6E/gBdKvCXHTuLairNGcebMqQNUSZ
 OC/Bc05ZGcN5tfS2CBGF24D20dQRN/fMFrlwRGYILSSZDt6cF/g0kRgg3Fg8UcfWy7hr9yMJ1+0
 ScEVERmfMpAeimnnsobfWklNA7HsZnJq0Q0DYLS3kIqd1n9kX0iT3eY4+9I2d5W6YJQicD65kLw
 Zt2xxCLQxOCw8iJ9H3vQq4gqO6PLhh0BMhUIHSTFXW2u4YM4Asc4vwQVJQGsCssqtDN1Ek2m
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=688133bd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iAeCgxixrUXn6QA2EFgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=868
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230162

On 7/23/2025 3:43 PM, Konrad Dybcio wrote:
> On 7/22/25 9:47 PM, Akhil P Oommen wrote:
>> On 7/22/2025 8:00 PM, Konrad Dybcio wrote:
>>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>>> A minor refactor to combine the subroutines for legacy a6xx GMUs under
>>>> a single check. This helps to avoid an unnecessary check and return
>>>> early from the subroutine for majority of a6xx gpus.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>>> index 38c0f8ef85c3d260864541d83abe43e49c772c52..41129692d127b70e9293b82bea5ccb6b911b0bfb 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>>> @@ -403,7 +403,10 @@ int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
>>>>  	int ret;
>>>>  	u32 val;
>>>>  
>>>> -	if (!gmu->legacy)
>>>> +	WARN_ON(!gmu->legacy);
>>>> +
>>>> +	/* Nothing to do if GMU does the power management */
>>>> +	if (gmu->idle_level > GMU_IDLE_STATE_ACTIVE)
>>>
>>> This isn't quite a no-op, but I can't seem to find what the '1' value
>>> would map to, even in 845 kernel sources. Do we have to worry about it?
>>
>> This is fine. '1' seems to be a low power state that was removed very
>> early in the gmu firmware development stage. We can ignore that.
> 
> Ok, good - could you also add a define for it, perhaps something like:
> 
> #define GMU_IDLE_STATE_RESERVED 1 /* Cancelled feature, never exposed by fw */

Ack.

-Akhil

> 
> Konrad


