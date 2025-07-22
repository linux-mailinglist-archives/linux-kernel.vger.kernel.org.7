Return-Path: <linux-kernel+bounces-740921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFAB0DB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C47C1AA1C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548152EA15A;
	Tue, 22 Jul 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Of93aJyQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA4185E4A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191864; cv=none; b=TIMkuE4IM5KEjE6utsr3ZEV66imZvCUAFc+NCmpYtqOrRSctAqwfjaQDP2RcpE6lGNuKaOjiNuGdD5Qqhs81th76tFusFg3YqJ2oKoi0iqmWv7zG4Wc8UOm22zvWslIjHkek9BjboPQviFZAuYGQKaBRyiayf+crh1h5+irX+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191864; c=relaxed/simple;
	bh=dTywX+BFLFdP4+hIWj9tRp0IJ9gnnMfS5H4sld7dZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrF7FJchxUp3VdOfDxfM3907+xRBQ+7ISO4x4te6fJR1YYhDWtz6brYB9NqD9dkDdiWNiMjVqGHNr3gZ5H4Y+XEbygTEukbXNAqabAXbGdEHkoJSe466vhd47FYga3uk48+IDT4mvbajRdMduj767V1gDBebxvje0xqbsd0kq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Of93aJyQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8hZ3M012572
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/PlvjBmBNhRqz0BnasHFhjw6
	BKLI8rWtueB1348TmAU=; b=Of93aJyQ8B2IXq//kHIuNs5oNAeHAckqmlzzEHin
	JB0jbnxK3HwqmVrHsXdArPWFtS5InJJECABp1JqgOORgL/j51qy9VArRt/ZqegY7
	SRXubWmx6w4Ca6cx60eifdX/A6beIlp2D9WPZSHC3R9A0aI0KRADO8OF3K/uGbg6
	xnelwe9XrpQ1rA1wqz8L2sclzfUaBBp1hNSBcvmZdzz8PcxkT+6dD9iJfze8djQt
	chkRh1WJpqmcvOdijECtCl+fHhCvFt7+BgcAVx6TcFLsC2z40n14TNybb1T7L7y4
	0Eu76qghAovYfV294L5ZFHuqm1ERp1Dc82PxjHmIcW20Dg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6kvdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:44:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e34399a08fso1270208285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753191861; x=1753796661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PlvjBmBNhRqz0BnasHFhjw6BKLI8rWtueB1348TmAU=;
        b=wTmDtal8Yq6mjIL5AfAvGXRycSlL4gyTVpoVJZmZVAfFHZBJBsZiWNep2RtyzgyNEp
         75wOFZG61jJV820FBZzPa6Uwf/oqpQ/Bpv6n22SZWtm6jPh3f4HuJ1K04152m9dLT4b6
         SJt8RNEXlfoEr5rWSuSMXqgk79yCHwf2emRNg2+waVm6wnYBshEHSXmAdupl0oQD/lxF
         m7eKyshV1adz8pJsuUnIdlZGARKe9E0/CeyIimSlcTJ4Hd+WinvLYhSbVQCWQzPTpMaY
         ph3ShrUiwdjPIb4x8+TzJuK7dSopuAleK3DRySxVQtKw48Na21ScrlCJmMiwxWoQKK+L
         bFBg==
X-Forwarded-Encrypted: i=1; AJvYcCWR61ouqJza/Bww/7af6X5yeIVjQafnTdkXEv+fkAqpg38Z2pCkaRPEUxJ1HNPbR1shAx37Ehfw/4Z2yGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZC24t51ONAYVGkM0lLHYHiu0wbX4lfjK7r7ncZa93IuP4ZqOQ
	SDcFDPuNXA0bsZLWRt6fxyymQs3yeVveFA6qgxi6EmGsWjgy4wtvpl/osjvpkLzzBVIgItBuPfG
	o/XiY+ENlnb/GA/lA5FHCg6jYg6UxcnU4JQU/Ocp4tb7OnEj49BxHJNlMuPN84PH08t4=
X-Gm-Gg: ASbGncvqRFLYNkwd5NiEnt9bP8ed1vHtrGPQZhHwtvc5y0jyGAW4spaJe+Fm6UkQNdW
	+z15wVBnYJw1sv+aCpFq7XEaWmf0B6mRzExoOu8hoaH3/aj92sivpH3SidRLRRbu1XxM1RNtpTz
	HmjIM2So1vPYpYydaSTJOVr2JvzJKxbksbtJcMott7fHx1sG5aCdQEF278bitKovE6pihCMxXhA
	f88uPqe2Z8Uxtrxi2dP66tPUz+UInuH+kS5Xc7Ycsow5VuT7Yc9DiBKAbQ3QHWuC4TpvC1mbz5k
	wbreUZ6CFvjj5uJl9H+jUPGDDjP5t3AwNCgU1Vw5GPuzBdtyJUxjWucvhIHZ4wiJBgTkDVX0yew
	43pqR5LdRrYwwWzS5V49ILZ2Fg7E+o8g5xQ5fn/VKNlVcY/HTUWUg
X-Received: by 2002:a05:620a:d96:b0:7e6:2167:6fb with SMTP id af79cd13be357-7e6216707e1mr450346385a.57.1753191860656;
        Tue, 22 Jul 2025 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJYjfAd2lPvfeopVnQTvfIiKF4FZMT25Jj8QNn5OT3bmUYHUVmlPAwFf/7JubdQINFF9syIw==
X-Received: by 2002:a05:620a:d96:b0:7e6:2167:6fb with SMTP id af79cd13be357-7e6216707e1mr450339985a.57.1753191859973;
        Tue, 22 Jul 2025 06:44:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a9109c31sm16373981fa.43.2025.07.22.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:44:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:44:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] drm/msm/a6xx: Set Keep-alive votes to block IFPC
Message-ID: <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687f95b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kzfAnjQGA3Um0d4qlLMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 59ezrU1YLJgUAD8EOBxSGMoy195n_udw
X-Proofpoint-GUID: 59ezrU1YLJgUAD8EOBxSGMoy195n_udw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMiBTYWx0ZWRfX92bNQKwbmi/g
 ywcXPAmIt4Hnt//E0b8AJjD3j74ztwg8NdPEB0LtE+FiCWAhNI+KBZF/iK4cbJ4S9AbcI9XknIF
 M6VyJNPFVx+MYDzBHGi/aN3Cz0EMqDAQLSHBbeRlWaoiH2t+CIUiXRAQhI6TixMLvT8bpTwKG8K
 t9+dMJBnF96NaEpEtH54ECynKYRe4XSYidc3iBLBqLKWh0icew+/zJY6D+qeSoGMb/MCOLxIPS2
 5JCCnQQksBmDO8kBPzr79rFDm2frol1NX5ZYuqieLzVRfcWnxoxY3h7Ti/hTwloeNSPLj1qNEv/
 BLh7J5zxB/wosuBfRYyY+BAuBDw+KyhU2tGeIeBawyu9DZMR2y3W94Mh+stdGlqGU9Xe+6d2p7E
 m8L1jdjvJDLIV0tzhuVubqaO/fgLA1WoXR0ADcnTcAXxxB+IXNloSR/IPMSmEjjPdt6YgcuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220112

On Sun, Jul 20, 2025 at 05:46:09PM +0530, Akhil P Oommen wrote:
> Set Keepalive votes at appropriate places to block IFPC power collapse
> until we access all the required registers. This is required during gpu
> IRQ handling and also during preemption.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 26 +++++++++++++++++---------
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++++++++++++++++++
>  2 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 8c004fc3abd2896d467a9728b34e99e4ed944dc4..6770f0363e7284e4596b1188637a4615d2c0779b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1752,8 +1752,6 @@ static void a6xx_cp_hw_err_irq(struct msm_gpu *gpu)
>  
>  static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>  {
> -	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> -	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
>  
>  	/*
> @@ -1765,13 +1763,6 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>  	if (gpu_read(gpu, REG_A6XX_RBBM_STATUS3) & A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT)
>  		return;
>  
> -	/*
> -	 * Force the GPU to stay on until after we finish
> -	 * collecting information
> -	 */
> -	if (!adreno_has_gmu_wrapper(adreno_gpu))
> -		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 1);
> -
>  	DRM_DEV_ERROR(&gpu->pdev->dev,
>  		"gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
>  		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
> @@ -1810,9 +1801,24 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
>  	}
>  }
>  
> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)

a6xx_set_keepalive_vote()

> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	if (adreno_has_gmu_wrapper(adreno_gpu))
> +		return;
> +
> +	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, on);
> +}
> +
>  static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>  {
>  	struct msm_drm_private *priv = gpu->dev->dev_private;
> +
> +	/* Set keepalive vote to avoid power collapse after RBBM_INT_0_STATUS is read */
> +	set_keepalive_vote(gpu, true);
> +
>  	u32 status = gpu_read(gpu, REG_A6XX_RBBM_INT_0_STATUS);
>  
>  	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
> @@ -1849,6 +1855,8 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
>  	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
>  		a6xx_preempt_irq(gpu);
>  
> +	set_keepalive_vote(gpu, false);
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> index 5b0fd510ff58d989ab285f1a2497f6f522a6b187..1c8ec1911010c00a000d195116fc950c4d947cac 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -136,6 +136,21 @@ static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
>  	a6xx_gpu->postamble_enabled = false;
>  }
>  
> +/*
> + * Set preemption keepalive vote. Please note that this vote is different from the one used in
> + * a6xx_irq()
> + */
> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)

a6xx_set_preempt_keepalive_vote();

> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	if (adreno_has_gmu_wrapper(adreno_gpu))
> +		return;
> +
> +	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_PWR_COL_PREEMPT_KEEPALIVE, on);
> +}
> +
>  void a6xx_preempt_irq(struct msm_gpu *gpu)
>  {
>  	uint32_t status;
> @@ -176,6 +191,8 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
>  
>  	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>  
> +	set_keepalive_vote(gpu, false);
> +
>  	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
>  
>  	/*
> @@ -302,6 +319,9 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>  
>  	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
> +	/* Set the keepalive bit to keep the GPU ON until preemption is complete */
> +	set_keepalive_vote(gpu, true);
> +
>  	a6xx_fenced_write(a6xx_gpu,
>  		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
>  		BIT(1), true);
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

