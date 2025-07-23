Return-Path: <linux-kernel+bounces-743209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8BB0FBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BC11CC0F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182651F4703;
	Wed, 23 Jul 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPOnbaRs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534F1D6DB6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304663; cv=none; b=s2aMxtQ0vRVoYLNLiFvTUN/YsPzD+Gdf9P56BuZ5pSjMJfm2Ompr9Feaf0m5Hd+Vig1PQNsiESTkop75UF498LuKB6ZKOsVhZtGaMzWqRYL2vm9ht1GkOhCEN0SmlNM9kPTiQbVWg+KiWfASoS7uTIDPsA/XLS9E8iMh1x/JkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304663; c=relaxed/simple;
	bh=mj2mx4CM2Kd2l3r6KGu2UdLa05q8fDPCVFHs+h/eumY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyqHcOwmYQHZvbE+BcNHmxz/p6U3Ol5Dfxh6CayXgnEql6wT9LFA/KNBWhy2I4UTzTez+Z2tOU2Tf22qKPGENZJZqNRkg1yhGVpO4mn72qNTodevPnV08AYME4Hu1YqJFEXuA/xNnQVMbfknmc6OHgI2hJes8nDahEqIGgAQUG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NPOnbaRs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NI2JVM007900
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6fyD5TTBTHkrV0molZvO6dBRaZdnGMvqf+oQp9IyFr4=; b=NPOnbaRswi89EQCw
	Hw2aynvUNyjylcXEcFdz8mx5ciXfybYUlGpnPoIw0pE6yhshmFBvQ27n0H9Ltv7p
	fDjDF54OVK/uXfgR/Ui14fu3MLwmzVXHhaZiKUSVdNHc+mE0Wgn7oUZAEQbtcacT
	Ru8HDX7gi9/5ReUZ+eppqieCdj1R6MGZLf6rHa24QMdOjtXMS3ji0X9+s1jCapnD
	dBo61/o0SqLVu/3G+hOQsjPFesH7stfMqyqDlBsTQ/BtLckltQQxd4tg0YWFlRoq
	cOrvjPmhwc0JI1iiQQae7xp+DvR4/1bZAlvQ9tLuyVXzSd09R1pXtx3BOMwU7Hjr
	YEMHbQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hvjd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:04:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso274779a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753304659; x=1753909459;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fyD5TTBTHkrV0molZvO6dBRaZdnGMvqf+oQp9IyFr4=;
        b=jOuiNyIRYZGoaomwwNhLq7y/7/i1SFg1f7EPoDLRBMAa8YAIMHSwEvAeT21JDsFeQK
         EpZ3Pt9GtdugeU/UOdgEwR3Fka+qvaCAGcVBf7/vdME4KQKu4yTm7mp58YIchj2Vjz6x
         wu3R3Pz1RnO0v6KRMAcwS+QZl0i0zEKwl1NpFY7cD75waLOoOZ24eMx0bmkSTlPhe1TO
         b/R0C2B8eeJ6+Blasv2WQ5NPDOJ3x+UMxnjmfpdQ1wpy6jgGtIaTtbSna2ZcNSW5mupa
         e+xaGZarnImKXzEWANBQ5rvZk6VvB4Bb/rjAKDE5VUgimAmtxAbU4B3I/Nud46GAaX09
         vU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXrA4X5Dn5gJGEtc42hspmEHtoRX79p7O0Mwr4OqAwUzXDnG9wo6Ar4sTXOfnH7SDM9S6tUpbG2G6IFtE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+q8By5HA04I/YumAuwPZ4+HGGmDoq6mWEL+ukqV6EgQWscqD
	iI3dxDKzAiHDPafS6+JxLOCnhoBheI/PsCry0gxU/L9jH2kqvO5tKUC62Y5VuHCfEiJj/beidL5
	m6CfSdnJhYI8t5rt7STWt6Fx50zTkd7zpBRxljJGY2TfEK1MvzuQ0HwXmcsjW9cIIQbs=
X-Gm-Gg: ASbGncvL9nd2/jLsHZMjMrwP18MHOomWFjnalzCxMsPDvB63TolFajrZRZ2O5Kphgtq
	njOLqXLBjHVr0thVqaz0bFv1obK3zP/qbkIJ0xMD86utVdp/J2+4skJEykCxox/2V5iekydlRaK
	7T2auVfHnN9pM3OOlgHr00SHwvZS3trWqwI8vSP5S4I7+PLAtu94sSXw4+i+1MVnhwFFeTX9Uva
	51aOs6GXs5zPY6m/r/y/ZybujYdWWvFFz88Z433p3UwJSosbobP9knx3LcIriPQYMlI/G34QSdq
	KoYWHKg6I0seh2DRAVy/Pr7RVD8isohSe4gYQjUoqvpJMg8AWyJvL3ZYQKp+XQ==
X-Received: by 2002:a17:90b:3806:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e5075a8f8mr6064270a91.15.1753304658812;
        Wed, 23 Jul 2025 14:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmMuWi4F83IxGpcEnoVwzzK6oG1GENyQo1ep+36IbjUn+xg+EHXFrSFnGx2+tCKQH77dEfRQ==
X-Received: by 2002:a17:90b:3806:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e5075a8f8mr6064233a91.15.1753304658282;
        Wed, 23 Jul 2025 14:04:18 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6249f7dbsm120158a91.22.2025.07.23.14.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:04:17 -0700 (PDT)
Message-ID: <1f176511-b80a-40ac-9c49-41c4f439d932@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 02:34:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tyjkwrdmsj7k7tkqqxdd65l5v5jxugr5me3ivg5onn3hbffkwp@7uhsbzolqiyd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68814e54 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=o07XWn_cYb3aPEy9CtAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3OSBTYWx0ZWRfX/jiXfcZ9QolW
 iLaeYl4XET4OyqauETpw/Bz31HYG4OaconN75PvBuMrY35le0uySGf/EwJd/GQWqz6M2E1s2XwX
 CQk5p3bYO+C7qzMYjDhyAkG7tAOIV63v2SdX5xL8ONiGG+W1eoUoAbjVyOu4WD5ZidXSvXVw9UJ
 do1PUcYYIyR9ngt1WCmJqVNGa2K5jLZksRZzcN+O4IApv1Qz9C/RpsrGR7aU+FZeRYSUjatiOfQ
 /dMYxD8vGVKMjz6oV0bGMP1GGMFhaEexu7VgK803qXW8IuqJ94Zsr0Doxbrwypbnb0V5oJvPvjZ
 XcQ9sW2OSAqRJAIpGCt78uzZnoBRQVhQn8yehsEElCbePeV69VVxie9XSvYlwYxI4CTiSyNCcXu
 lY27QK84xeqT7tbIjPTqN/49N7hsXDhspzjm54QVcLP257anStu7q6/UoULCX4qssl8LLPKe
X-Proofpoint-GUID: k5jni7M9dd0UyGgL8nxBUAfwuWhl_XWZ
X-Proofpoint-ORIG-GUID: k5jni7M9dd0UyGgL8nxBUAfwuWhl_XWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230179

On 7/22/2025 7:09 PM, Dmitry Baryshkov wrote:
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
>> +	/* Success if !writedropped0/1 */>> +	if (!(status & mask))
>> +		return true;
>> +
>> +	udelay(10);
> 
> Why do we need udelay() here? Why can't we use interval setting inside
> gmu_poll_timeout()?

Then the delay won't be at the right place when we use gmu_poll_timeout.
We need the below sequence:
1. reg write
2. check for status
	2.1 Done if success
3. wait
4. reg write again
5. goto 2

Another option is to avoid gmu_poll_timeout and just open code the loop
here.

> 
>> +
>> +	/* Try to update fenced register again */
>> +	gpu_write(gpu, offset, value);
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

I think we should add an mb() here like downstream just to be cautious.

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
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +int a6xx_fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u64 value, u32 mask, bool is_64b)
>> +{
>> +	int ret;
>> +
>> +	ret = fenced_write(a6xx_gpu, offset, lower_32_bits(value), mask);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!is_64b)
>> +		return 0;
>> +
>> +	ret = fenced_write(a6xx_gpu, offset + 1, upper_32_bits(value), mask);
> 
> no need for a separate ret assignment.

Ack

> 
>> +
>> +	return ret;
>> +}
>> +
>>  static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
>>  {
>>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> @@ -86,7 +147,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>  	/* Update HW if this is the current ring and we are not in preempt*/
>>  	if (!a6xx_in_preempt(a6xx_gpu)) {
>>  		if (a6xx_gpu->cur_ring == ring)
>> -			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
>> +			a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
> 
> I can't stop but notice that we don't handle a6xx_fenced_write() errors.
> Is it fine? Or will it result in some sort of crash / reset?

Recover_worker will kick in indirectly, for eg: due to hangcheck timeout
here. Chances of failure here production devices are low though.

-Akhil

> 
>>  		else
>>  			ring->restore_wptr = true;
>>  	} else {
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 9201a53dd341bf432923ffb44947e015208a3d02..2be036a3faca58b4b559c30881e4b31d5929592a 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -291,5 +291,6 @@ int a6xx_gpu_state_put(struct msm_gpu_state *state);
>>  
>>  void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
>>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
>> +int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
>>  
>>  #endif /* __A6XX_GPU_H__ */
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> index 3b17fd2dba89115a8e48ba9469e52e4305b0cdbb..5b0fd510ff58d989ab285f1a2497f6f522a6b187 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> @@ -41,7 +41,7 @@ static inline void set_preempt_state(struct a6xx_gpu *gpu,
>>  }
>>  
>>  /* Write the most recent wptr for the given ring into the hardware */
>> -static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>> +static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
>>  {
>>  	unsigned long flags;
>>  	uint32_t wptr;
>> @@ -51,7 +51,7 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>  	if (ring->restore_wptr) {
>>  		wptr = get_wptr(ring);
>>  
>> -		gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
>> +		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
>>  
>>  		ring->restore_wptr = false;
>>  	}
>> @@ -172,7 +172,7 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
>>  
>>  	set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
>>  
>> -	update_wptr(gpu, a6xx_gpu->cur_ring);
>> +	update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
>>  
>>  	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>>  
>> @@ -268,7 +268,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>>  	 */
>>  	if (!ring || (a6xx_gpu->cur_ring == ring)) {
>>  		set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
>> -		update_wptr(gpu, a6xx_gpu->cur_ring);
>> +		update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
>>  		set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>>  		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
>>  		return;
>> @@ -302,13 +302,13 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>>  
>>  	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>>  
>> -	gpu_write64(gpu,
>> -		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO,
>> -		a6xx_gpu->preempt_smmu_iova[ring->id]);
>> +	a6xx_fenced_write(a6xx_gpu,
>> +		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
>> +		BIT(1), true);
>>  
>> -	gpu_write64(gpu,
>> +	a6xx_fenced_write(a6xx_gpu,
>>  		REG_A6XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
>> -		a6xx_gpu->preempt_iova[ring->id]);
>> +		a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
>>  
>>  	a6xx_gpu->next_ring = ring;
>>  
>> @@ -328,7 +328,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>>  	set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
>>  
>>  	/* Trigger the preemption */
>> -	gpu_write(gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl);
>> +	a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl, BIT(1), false);
>>  }
>>  
>>  static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
>>
>> -- 
>> 2.50.1
>>
> 


