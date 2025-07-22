Return-Path: <linux-kernel+bounces-741533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62710B0E565
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EEA3A5F41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284BB286409;
	Tue, 22 Jul 2025 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fl1N3gdF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DD27FD56
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219509; cv=none; b=PpiGBuLu1XwGLxNdPg5WtH3plgL7pQsUQgBP5ICTAE/GZLaOX5CEQLJKVj1l3y0/UZ73Qj0bXarbIYL9NuIw+AUwvUzGNn/2Ax72YZ0/Mzdr7x6O+nJw2TKsA4p1I0YBxm5TZjKuqG4iWqYO7I48OccLeAMVBAEVArDW5jtdPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219509; c=relaxed/simple;
	bh=d8wE+Gd4VtxWp/t9KIB2BMTuDrtaRYD3N8rVvy96Bas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqO4fADY02sT/3DdhpmpmFIB8r+3dNaxOnpFPDBX+YZhcASZP07Ae0hAmlbGlqZd+f9L7i86Tuy3P9Bhk5IDRKI3FeQD4YsLhfI/Xh05usvKb18tjwNsVfJ0zcZ4ThNk4hSXXeWhL1nNxoOjBls5FnqzvU/ehEwoHgQtK32/MnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fl1N3gdF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MKTspc008012
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bx6AND6qIidWf5n32E4fzkLDfQp167XjFiENx1umcI8=; b=fl1N3gdFbnbW6zs3
	xthlnmmIcSvU+LS0IMa6qXorJtBVRpZb82HziDrZHY0Vjv0f3K14l1g+zxiCZ6hm
	BEB//nuFQI2n9o7/I1MEBSn6efFU7sfSeI4aTzTM/vCI0ux5KAFWChrSx0+JR2l6
	SJGkHOQJ6YdfiAdcp8AL6y6qPuPJF3eVq0JrD9YI/6c6cBrSbACDOnyF3TjHxpSZ
	z5w7OENt8aK/hXWans789scPyLlC7dhT5+Xs0uXCmeZJV8wqJM+3ED1L939p/awg
	Vb2byiVFQmvDuZ4Al+UDUmbDdl+zOxRQuDLtfphP7nYd5F7WRJAI2cpnMR+H5Xvv
	fS5Nrw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1u9f5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:25:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso4495893a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219505; x=1753824305;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx6AND6qIidWf5n32E4fzkLDfQp167XjFiENx1umcI8=;
        b=OAmWLcHQtdg2Q5AXb1p/Yzeqme7Vic9JRVMKt7vwSS/wrTZERNbSTF+NvmgVrVugRd
         o4lYqa+s6HeTisuWYvYrFp+sRvIriTPWuHQkN56bTTLIrgdkMzWClejSktvjRCwbME21
         Lsst4Ig8/ZUVFIzp9Kngdx6W8QGHdnQ1zpBa1wVRZ+IXvNN+aAi2th/ccR5DHzMqTfiH
         ZPlTTLkIPRxDSHjEzKsa0fDssKxYM3b6mQR+kfbr6rFTYli600Yo8RzAUdWNYc59T3Z2
         sL9XFs5ehMfZfWYjxeg0yMJnx0hEeIbqf+o3FUKn1Ksn+ouG6ZOerURJeSnsw/4Seg/Z
         MH2w==
X-Forwarded-Encrypted: i=1; AJvYcCVGqakbyBHyGi9SohFUcM3n+A5kEqvftKkEDPHJqfbJu0Mf3gWZlTMe6FlyJI2U1Bvv/5PainAltbjbb5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLVKG7yyF7/diYeqpBBg60rQFim3j4pgExizBw24+8xJd1BfI
	RwkSWLvME8rVCOZOasUbgPVIFcEf+H2MhD7cmAbM0+VQnm0zUk2FohS82mZk85Z/uHbaOXiRG2M
	uhEJ6THkG1QtKUQl+FaYVXQQT0+4LXDX+vR7zMSPsVAgYOr45m2W0xJpyfHQWKU86FXA=
X-Gm-Gg: ASbGnctO62ZC2ruA9gt7PBmT/QRKRy1kPKrSN/BBJS7ndxFC4ri8+g3tPY3y6C9/c17
	blVWxB0kmeecnLRtJr6gOB7GP0tPy1vpZjPkTxrvDAJF7RXuTcNkw0ldrIKmtsONaJFRI5s/XAY
	jZ2wuqgSIl7AfqEAJPfZrzZ33qcZhDJ5IHbjzVN9ALWaYA6bvT4d+B4Th17TdeaHo4usdxFXP71
	h8bcyJ4GiXBsSwzDGgGjuehPcnmjyx542ur+gB0sZ6x8YEcS+k42x+6JOuchFvZhfygXMcZyuRo
	9hnXPeMI9HystEeCdUqlMqsPgwYWVDlOPzk4PxpjuDyiKWHVjtagvz57k66KCBlj
X-Received: by 2002:a17:903:fa6:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23f98087878mr6681875ad.0.1753219505450;
        Tue, 22 Jul 2025 14:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFps9jaK7xU+IcaPx+PU7yuB+q3TWSjyxzOi5zTDgaE+nkIXF7XgkGNIc87COjEka46a4qGHw==
X-Received: by 2002:a17:903:fa6:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23f98087878mr6681445ad.0.1753219504988;
        Tue, 22 Jul 2025 14:25:04 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef82esm82325845ad.209.2025.07.22.14.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:25:04 -0700 (PDT)
Message-ID: <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 02:54:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] drm/msm/a6xx: Set Keep-alive votes to block IFPC
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
 <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
 <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688001b2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=54dI5dBpyKhlXk0ovUwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4NSBTYWx0ZWRfX6UJhS5wGLZuG
 gVnL3lewK7t5Gig0lUoyUIsdje6/mAXX2Ihdc2MHzO1wWMRK4DKbAj9y5JfigiKouhdNFOQXYSl
 y8+c9JFeZeVk40aUU5BjidhLgEIcX0jhz2bctBg/FsStrj40/VTFl+py2LFcDVCZmyp0CdVxnwq
 5P40eHTsHVETyCL92+2g7W3sZxjs/1k+OflD1OkK5/8szSm+16D2pWOvEGX+Txd1bxHoV9mlPlK
 Uy01gsbza3WRuf1vhAm+ERZN/+lEkEP+7gfeL37PrjFNOZjoTipPCaoQRVtrxK3Y8N9EQaSclhG
 qEDs0mGeO8FggN22i5q4iHBc83AkN/IMPwdCaDBDFmd5fSi17X0U/5pf/bBip71/RqT+8xDNXaR
 BiCklaECTpkG7RhAlYxnVSmFEinRkXvV/QIEVEy9SqBbU+tg89uV2IodG6e1O20gOfsIeKdp
X-Proofpoint-ORIG-GUID: ZgDK0XxznA5k_dChaHQpCKyOGzRzRITY
X-Proofpoint-GUID: ZgDK0XxznA5k_dChaHQpCKyOGzRzRITY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220185

On 7/22/2025 7:14 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 20, 2025 at 05:46:09PM +0530, Akhil P Oommen wrote:
>> Set Keepalive votes at appropriate places to block IFPC power collapse
>> until we access all the required registers. This is required during gpu
>> IRQ handling and also during preemption.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 26 +++++++++++++++++---------
>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++++++++++++++++++
>>  2 files changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 8c004fc3abd2896d467a9728b34e99e4ed944dc4..6770f0363e7284e4596b1188637a4615d2c0779b 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1752,8 +1752,6 @@ static void a6xx_cp_hw_err_irq(struct msm_gpu *gpu)
>>  
>>  static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>>  {
>> -	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> -	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>>  	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
>>  
>>  	/*
>> @@ -1765,13 +1763,6 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>>  	if (gpu_read(gpu, REG_A6XX_RBBM_STATUS3) & A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT)
>>  		return;
>>  
>> -	/*
>> -	 * Force the GPU to stay on until after we finish
>> -	 * collecting information
>> -	 */
>> -	if (!adreno_has_gmu_wrapper(adreno_gpu))
>> -		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 1);
>> -
>>  	DRM_DEV_ERROR(&gpu->pdev->dev,
>>  		"gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
>>  		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
>> @@ -1810,9 +1801,24 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
>>  	}
>>  }
>>  
>> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
> 
> a6xx_set_keepalive_vote()

static fn! Why do we need prefix here?

-Akhil

> 
>> +{
>> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>> +
>> +	if (adreno_has_gmu_wrapper(adreno_gpu))
>> +		return;
>> +
>> +	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, on);
>> +}
>> +
>>  static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>>  {
>>  	struct msm_drm_private *priv = gpu->dev->dev_private;
>> +
>> +	/* Set keepalive vote to avoid power collapse after RBBM_INT_0_STATUS is read */
>> +	set_keepalive_vote(gpu, true);
>> +
>>  	u32 status = gpu_read(gpu, REG_A6XX_RBBM_INT_0_STATUS);
>>  
>>  	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
>> @@ -1849,6 +1855,8 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>>  	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
>>  		a6xx_preempt_irq(gpu);
>>  
>> +	set_keepalive_vote(gpu, false);
>> +
>>  	return IRQ_HANDLED;
>>  }
>>  
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> index 5b0fd510ff58d989ab285f1a2497f6f522a6b187..1c8ec1911010c00a000d195116fc950c4d947cac 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
>> @@ -136,6 +136,21 @@ static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
>>  	a6xx_gpu->postamble_enabled = false;
>>  }
>>  
>> +/*
>> + * Set preemption keepalive vote. Please note that this vote is different from the one used in
>> + * a6xx_irq()
>> + */
>> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
> 
> a6xx_set_preempt_keepalive_vote();
> 
>> +{
>> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>> +
>> +	if (adreno_has_gmu_wrapper(adreno_gpu))
>> +		return;
>> +
>> +	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_PWR_COL_PREEMPT_KEEPALIVE, on);
>> +}
>> +
>>  void a6xx_preempt_irq(struct msm_gpu *gpu)
>>  {
>>  	uint32_t status;
>> @@ -176,6 +191,8 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
>>  
>>  	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>>  
>> +	set_keepalive_vote(gpu, false);
>> +
>>  	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
>>  
>>  	/*
>> @@ -302,6 +319,9 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>>  
>>  	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>>  
>> +	/* Set the keepalive bit to keep the GPU ON until preemption is complete */
>> +	set_keepalive_vote(gpu, true);
>> +
>>  	a6xx_fenced_write(a6xx_gpu,
>>  		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
>>  		BIT(1), true);
>>
>> -- 
>> 2.50.1
>>
> 


