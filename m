Return-Path: <linux-kernel+bounces-741070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F6B0DF92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B128F7B55B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36B2EA478;
	Tue, 22 Jul 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fvxP2BTG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FA12CD88
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195972; cv=none; b=ipgIIMS8ETpmN68paYj/zMD4oKe91sBPMz5frLALJO/mAL7XptAFYtCQmqW1kH4ycxjoDbxaNEm01Ztq6/RQjZNkDMkIBlv3FSV54gsqvndoiR0juTDgY2JHXXjKnhdfss31zJ8fZrSVbThORqjzmu7GXVo22mwZnM0hQ5zbNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195972; c=relaxed/simple;
	bh=s0m4k4vhvlmEm6wl//KcvINRIeeEDvKsYatA7FZ8BJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlIJYfB46DZ9g3rKXH6cLs2Wc2MNHHIq8knN71sQXSEgtORQtxCc4pyBdA87jFJo5BGZyrwAb1OIJ/HVP6S2sMYf+RxUVoYj4/U6lJ6LoGPkmVcWzw+fvYrP5++7zUgrFbcOztTuNqcHzW30PRkP4ckY1BgFnVWvkgq+oWDkNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fvxP2BTG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDHSQL015762
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JKfgySS6e/EZJ9CHZwXQOHZ4Nnh1OaO/SrNWrKkQSd8=; b=fvxP2BTG2vlJvOGG
	PublOSHqG307548zzPWYE6pIZE6E79GhiPnSSxeif2V/g5SiIu9r/qyg4VQhN+o7
	+krg7HRQccZS8t/HiuOdrBT4b2ZTRv3vRPViQ83jIBGH+jLDMsofTcjknsaH0usz
	Q4xV9Bx/sEchi0sy9FZ1fFMaLFgzf1MzKyE0q3LwBkl6/VGKd+9Yw9yLkfdylxN7
	C+F4vN/cAJCciQFNNC3LG6OsyAOryVBnQzdjuA3SQC7CQ0beaOGcvamcupBZVnfz
	PeF/LAaQ7KzQXFav3XB4wqge/ks+xi/o+OYtT0BhtWeKnP4ME/nL0IAS+X5aCq8t
	OIWLYw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451hndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:52:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6facde431b2so18348886d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195950; x=1753800750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKfgySS6e/EZJ9CHZwXQOHZ4Nnh1OaO/SrNWrKkQSd8=;
        b=iDiizAd7iFPNSETdMdbPbGVpw+ooovAJMpxlBH1cJgXMqET+MK+kNslhY/qLWhElqx
         L4dv5CTnQaqMVvXmybj5XIXfIT24YlggvRqNNvHlfi6AYeS+n8WNC4UfEoDqMJFh2pi4
         0CX1EjoD5eBA+jWxdJ1Vq8m1/4gJTDHV8UjnPz3IXzTRMdRyDbMg7dR0XEtcVrcXrPjW
         woK+WPGRUQICk4ifcYH0NcEDLh2KEMsjOdpLYfUOY3J3vBjjJ5MN2dS8Yp1w093cxZL/
         k4tpgwl+duWssV09dwtJu/Uvi77hAtHaYpDE2vhppFb9XdDCYAZ/2oR8joJ0fxK19r8J
         SIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeKgBnwfZ4ceF2+3XRECWBax1Y8dsbEgQT/rquSMayUaFuxrDrIBGCBwoGXuMLt42+gnqRSB1Wi3dHJLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQ68HCSQi3ptEfSlAyQMZ/HRhj7EHbA4n4BfI7Ii4WEzS5liF
	PahCt5tszJ1GYDQFNrWbR6QoatG7TKLDHlHP8hA6P4nmbn/5nSn0Z7lhK1lWHdwcgXs8gr68jd/
	50oOa04m/XPfm+gzHgLBhrvqQjaNAADRpDbR3Yu2v3flZPFnY6xOqnz/QClOCKNlMddc=
X-Gm-Gg: ASbGncs0Bo/IZJGCGJhF3BuUsT1AtHquuZLwc+s01tYL8JR1rWir4nYDmC5x4hbmj9l
	X2oG1kEV0aS4bI02T/xoo09nHW1APsyahEDxn4+5Wj7eH7W9XpeHy2vxHn3zEEOwb2J0WUZRBHH
	X5BKHlgaRZegyHp+Z1cczjC6M/8yYJZl8rKZl4NIkl5RR80WLbgf/XCmcXKtbwY6RWaJ5EY7ruI
	6lsdJK/KAHItJS6CjE0wMYA7AugpeQaCe2x0VYTWcWTA0MnXdskY3HOzWxHEMoLK1H9uS76Ql7W
	XzcUVkMtVpKg9SSMThueSdffR7kDXBy0AM41ZOju3OBpdPze/errQ7HIYYo166ruJVbclgPgCLO
	Ax2l1sc0ZPk+BaRuyhhwR
X-Received: by 2002:a05:620a:2714:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7e342a5dc6amr1310279685a.2.1753195949439;
        Tue, 22 Jul 2025 07:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuJgUU9V6/qKb7uv3smvtN8wrkQjr3Ocrb0xAp9swHWKZD9GzivTqkf1QkinncRE8s3a+Xow==
X-Received: by 2002:a05:620a:2714:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7e342a5dc6amr1310275285a.2.1753195948053;
        Tue, 22 Jul 2025 07:52:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f5d06dsm6945128a12.33.2025.07.22.07.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:52:27 -0700 (PDT)
Message-ID: <30442713-2990-490a-b076-93c3cfc3901d@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tyjkwrdmsj7k7tkqqxdd65l5v5jxugr5me3ivg5onn3hbffkwp@7uhsbzolqiyd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687fa5be cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5dKzzWTJmYxMyaayncUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: rxUe0Tzmvv9ki9k72rV26-yn2GXI2sl3
X-Proofpoint-GUID: rxUe0Tzmvv9ki9k72rV26-yn2GXI2sl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyNCBTYWx0ZWRfX8wrMQbzJEt1L
 /aCGYSh/gxxJ3jQcT9ihc4GubEMGwmLWGnKze69ByT/vAQiYTtSyXSa8/06vEYY1hG2OTTkGHvh
 sjA3dvxik/HVCqyYxxbRtbtJskGboYx9s3i6bzlR4S1qedu5OffmklyUyxAY2ex6yAo7yXFN/E6
 4BKbKkf4cY1BZeIY0OUUZmNQMRl6/boRzv4jMHBhv9YY4xgTpIn/mJYuI3597fjoqnoD2SXbk03
 +EqOPZDQB6AYhEwIu72MMNdfC8QHV3XJ4xMBRSQSWyZdDnCIU13BMGnK9lGBLKFV+KscfQ3xlzi
 Vt8yhanPgZYCtupHG0aJPgFaJ5FaZySp9FonvHAYkzIFJgDDh8MKKFAPF5zDUz49u0/s8z9aCa9
 cKHqiCVSlQLZ4sPRU7gf/BBAolS1YAMPm9sFdqPJFvPhfF+zQEDGMBs6Gu1gkHEpH8oZ51k9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220124

On 7/22/25 3:39 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 20, 2025 at 05:46:08PM +0530, Akhil P Oommen wrote:
>> There are some special registers which are accessible even when GX power
>> domain is collapsed during an IFPC sleep. Accessing these registers
>> wakes up GPU from power collapse and allow programming these registers
>> without additional handshake with GMU. This patch adds support for this
>> special register write sequence.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
>>  3 files changed, 73 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -16,6 +16,67 @@
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
> 
> Why do we need udelay() here? Why can't we use interval setting inside
> gmu_poll_timeout()?

Similarly here:

[...]

>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>> +		return 0;
>> +
>> +	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>> +			offset);
>> +
>> +	/* Try again for another 1ms before failing */
>> +	gpu_write(gpu, offset, value);
>> +	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>> +			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>> +		return 0;
>> +
>> +	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>> +			offset);

We may want to combine the two, so as not to worry the user too much..

If it's going to fail, I would assume it's going to fail both checks
(unless e.g. the bus is so congested a single write can't go through
to a sleepy GPU across 2 miliseconds, but that's another issue)

Konrad

