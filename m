Return-Path: <linux-kernel+bounces-742382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE64B0F0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA4A1630C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D02E0B6C;
	Wed, 23 Jul 2025 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j86+FYuJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89F2DA749
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269187; cv=none; b=edOb2IE511RpegP+4EgR70xMyl3HDTWGU47Iv8EmpUQwj4vWma8lFjuXTIwkUkYRNKzEIn/MgThXXVtVDRHRUASGr86e0OgvIKDCCtLRwcaJG//eI/ugyP8sdDjSCR778pPi0+LPnbVIxA1FSApOZAsoBEycuwJW1arSfgn8yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269187; c=relaxed/simple;
	bh=lnzxNBd27lteRys8/UL84a5N9ZO3GwFpFozQUhELwOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pspAvGr8szmIjLXiMeUEdhTvm3dET3n0B0eo2JI19jPy9kU+kWaWeBfvSltGYOKbfaM01zcLwPYEX1EFYBvxN9nZtZWmia1SEZ2DsFEmKdNsxheCglOdX+DoZcLx3NqNAp1XQVJ5WE9OUF2GsnKdH79n3b1nYdtgIwCxTxBReQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j86+FYuJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N92gc8024471
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hdZZZ21a0qm1WSRcAHWFGr2d
	/0HAGcq2qAHNRmdLWJY=; b=j86+FYuJEhj9z/SI4nMt5/bu9aCDS/4QXeXYBJRH
	by3pRQpSTlel9Gw1rodhsP2Yqy2WdwxWF1ep9fPJKJGoontnffgmG1T1XvigdHbg
	Lpc/RBwfw2eWltPSJE1bxeDlbCMipOymcVHU+U7KaZUaeg57J9Bz7UfZ3dUxsoMj
	x4wgaIqHTc04GPMxIQBXglCVcYXwGEqdIo5JnjhvgWqT3mwfX2irVbfPdbe+3jwz
	VIGPngYh9k1NKJ8KzbTKvbxaXOU/JvD7Bm/IkcIN4lm4SsiD9BnOqB7DVy5pEWOs
	rHCMIYav4zNtceBH+M+euZfHd6Pjvjt3WxPsZNT5LZyOpw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3eqr2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:13:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-704817522b9so94801386d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269183; x=1753873983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdZZZ21a0qm1WSRcAHWFGr2d/0HAGcq2qAHNRmdLWJY=;
        b=n+1nAN4PY+OttiITiWTnnFI65RzQOGB41CNnKuwxsaoB4dFh3W1BMdeyvIqSGAcTum
         qXP7pAPpbYMuYNBw8kYLQXCRqeUuCyh6FFY3zINZNWwB6tGFgUOnrRceGJDopvrciK0l
         sdPE1AV/i7SIZs2xuNQx+H9gMZUT4n89uC57ucTYCgU8K1Q+K/28rBvG+YgHONlXAipv
         mjPU6PqaQ5hErCfmnViH4+UlHTmIU50UX+mXszRaMZthxTmvUIh/muz2roBF6K/RkLUN
         oBqkWtqJO0DXWh4EjbLGljbSJN++SY+uWguaKuEZQd83KQJiyNTtIVheLqA4Dn1ZB+Sg
         sZig==
X-Forwarded-Encrypted: i=1; AJvYcCWvb6BvIIm54+y5Ztgfo0gCbryq1CJY92LlPUMdWAvYcTWOJUcgpbdlvaNiShBZZnFH1vQHeWXli3YlGac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9f/Zaqe6nlB7eI73OGCsZscimCrI37QNNgLLQmOvXF9pATKir
	+pO3J7PXI5yj69JyrL9o/hIngH2d0p31Moz5mVjO5Xl3HbXCNXPZruUF4vVN9MzhjJToah3N13K
	z8N81us/NDulu/vkGSHzXLq1+5haNyjWIQCD6+9tRNKvzhyTGZTNmXxgrtr5U7oUAaVo=
X-Gm-Gg: ASbGnctHuxXJp5pj7Pa2vORfTtMwJR6f0BNniVCdeD5RpCVk4PA/eV+HMiiIMm2sgzr
	vyn9QaZ4J/pQSPJOkDjq6N09eFieW9uqBe86epmoy3DprcHCghKnUFjHfZ5H3ZAaaNDE/KA+x9G
	7otRgTtVMxZWJPnr6oYFllJBKQgm2+iFMiERwtzlPqCGnVHraAXLzFjvYK+5VIQGvYuJAbyVplr
	Cvst/KxOcnfiAzl10h45uVClt449LU3MYMAvlWWjNUmLnC+nhr/2d8/FyJhNizwIFwLdwl1sa1+
	8Lhv+ReSk7KsoM4v049KrukOXQLw0Jzjrc7lEPFlwZOctmIQryGAMbITPuUbGWF2vz4X4+rQJJ+
	xmUqlNogE5zTeruR1WONfwmsBOnEzIH1FtCXFjWHH9A3/VNLKW2g1
X-Received: by 2002:a05:6214:2387:b0:702:c15f:3291 with SMTP id 6a1803df08f44-7070077456dmr34745486d6.22.1753269183358;
        Wed, 23 Jul 2025 04:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyDLDuy3HyepZYFtPliTkOxZ5Xsf6vDUIcCInt6v8XfdgRXS9LLj6MWS8GTPYKlkNSKOxtvQ==
X-Received: by 2002:a05:6214:2387:b0:702:c15f:3291 with SMTP id 6a1803df08f44-7070077456dmr34744846d6.22.1753269182815;
        Wed, 23 Jul 2025 04:13:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a9103744sm20182351fa.24.2025.07.23.04.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:13:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:13:00 +0300
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
Message-ID: <vqncxeag7jqmtxmeezvwqdtneoavs5kazpcgweuw52knqbiukl@3iifyfkgkw52>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
 <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
 <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: sW3rH29pEqN1QyT-ka7aI8ww8lcX4wRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NSBTYWx0ZWRfX3+81VvSGTHW1
 eS0lYbBJCojfGwAM3imamPSfXekLD3RuWqeuUHA9WWY9FOnYWVeOH2JgCE9mo5xseE9xvV0to/T
 BfhKFvRFZDyG5Edijc1Hnng8RvX2uowrKcKdAwTkhpdj1ORMOhgQSofMkHHPB1E6SlCBMSFxaM6
 L4N7Q6+XZbUKozhcDzy1t/7R+H5sDDlNybG37JOSOJhESOeRoNi5GJ5bkVGO4E6t3qPo/h4T875
 dkVxGMRwV+uh7N7b7LuntFFJxrWtz1Fu9cehx6GP0YbUyj59lQ1buEL3knV+oVjA1754lulUIOY
 GroRYfu7SX4HxXoDV/dVC4j3rRV0ioxXywYTBydBPbAQYUGb3v4gvnipmPH83nOZXRH1yvNE/mj
 9bOMUWpWvhUFwUDCNZAhriJWFv+yzj3SY31cEzu3F6EJNtp6x7DLMN8EXHhNKiOVSfZSqgkS
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=6880c3c0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=OfcbPBCFm4ewgWsImK0A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: sW3rH29pEqN1QyT-ka7aI8ww8lcX4wRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=943 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230095

On Wed, Jul 23, 2025 at 02:54:59AM +0530, Akhil P Oommen wrote:
> On 7/22/2025 7:14 PM, Dmitry Baryshkov wrote:
> > On Sun, Jul 20, 2025 at 05:46:09PM +0530, Akhil P Oommen wrote:
> >> Set Keepalive votes at appropriate places to block IFPC power collapse
> >> until we access all the required registers. This is required during gpu
> >> IRQ handling and also during preemption.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 26 +++++++++++++++++---------
> >>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++++++++++++++++++
> >>  2 files changed, 37 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> index 8c004fc3abd2896d467a9728b34e99e4ed944dc4..6770f0363e7284e4596b1188637a4615d2c0779b 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -1752,8 +1752,6 @@ static void a6xx_cp_hw_err_irq(struct msm_gpu *gpu)
> >>  
> >>  static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
> >>  {
> >> -	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >> -	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> >>  	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
> >>  
> >>  	/*
> >> @@ -1765,13 +1763,6 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
> >>  	if (gpu_read(gpu, REG_A6XX_RBBM_STATUS3) & A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT)
> >>  		return;
> >>  
> >> -	/*
> >> -	 * Force the GPU to stay on until after we finish
> >> -	 * collecting information
> >> -	 */
> >> -	if (!adreno_has_gmu_wrapper(adreno_gpu))
> >> -		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 1);
> >> -
> >>  	DRM_DEV_ERROR(&gpu->pdev->dev,
> >>  		"gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
> >>  		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
> >> @@ -1810,9 +1801,24 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
> >>  	}
> >>  }
> >>  
> >> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
> > 
> > a6xx_set_keepalive_vote()
> 
> static fn! Why do we need prefix here?

It's really a good custom. Also, note that I suggested two different
names to your functions (otherwise it's too easy to get confused).

> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> >> index 5b0fd510ff58d989ab285f1a2497f6f522a6b187..1c8ec1911010c00a000d195116fc950c4d947cac 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> >> @@ -136,6 +136,21 @@ static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
> >>  	a6xx_gpu->postamble_enabled = false;
> >>  }
> >>  
> >> +/*
> >> + * Set preemption keepalive vote. Please note that this vote is different from the one used in
> >> + * a6xx_irq()
> >> + */
> >> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
> > 
> > a6xx_set_preempt_keepalive_vote();
> > 

-- 
With best wishes
Dmitry

