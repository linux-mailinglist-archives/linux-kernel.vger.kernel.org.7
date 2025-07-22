Return-Path: <linux-kernel+bounces-740935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86089B0DBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF39D3B6D07
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503302EA737;
	Tue, 22 Jul 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Onz7x3Pe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398472E4271
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192338; cv=none; b=FnIPVKSb+wy86Kz5MsSh4K3WGqngdasIf2iiKuEpbo7oZIK26qdOzbkq6D/cXRqUNZF7RjIjHsov3SlmvhpJYKkQAudjVdMF4fx1PBLXS2Vfzpn0accSIQJOU2VmVxIIgch01XlIMVWwOKUrpbcWnrGBlJYcwkX1pqNlXw07xOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192338; c=relaxed/simple;
	bh=QQpHzlcpW2+Y1Jjb8mCrgKam8W9z5/cTRPpSANu4kTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDrm3SFyAqs0Tkd2bjc02A9gD2Uo76JHpBVk1hxZsZKJRj5IDsIqAGaU/6OHFnI0FLfeNl79AIXwgW76+aWxFoty4cvBw9d/GGsytXxbfZ1KD5uZqcFNGGRg3R5YSWfvX0u2LxbF4s8UV3tqdfIk3bGSnw2hO4yixXSN/CCr1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Onz7x3Pe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6vlts020539
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Kw9ZzSYekP4jnMMDcD6u6zPA
	55Dkfs0wyd2ey7LJ+D8=; b=Onz7x3Pedf5elMf/z6wd1xlgRL/J1CJ9BxfEi9Do
	FS3EDeFEgiu2i06HRNNfzJNeNjNkeTCk+AEUm1vmMa3ci/IoMf/1IGmQ90qcARy0
	SWrh9BhIo7i0+otRHvLZhsxk3ti/7DL+PvQEhfqRMrOaEw/HSPcPgoy7P3BE2od5
	2r6PRKjy2/M0/ch9+iavqkIqieKBSQ70McWiirrNSA0Zy5W5LRhOplyIOTjaoL0N
	bzrnmCCezGcoL6XsVegZqsklNiFAvlC0l1aRgjfhXNh8zn4m38l+hm+dBDf3qT6R
	oph5hjbnFFznkQSfOzoxuwP0BJMJGOaM7NDwiyJq+ZMPRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na00h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:52:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e32b9398e4so692747285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192335; x=1753797135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw9ZzSYekP4jnMMDcD6u6zPA55Dkfs0wyd2ey7LJ+D8=;
        b=wISG18vxcePSd+u4vzKENFT49c8uKQDziGGPVp0kCkrHpXTQ9p5mEIoAbCxMPdSt04
         763E0c48UUW2YQ5kpih74xvjc4k+t0JhNYVK/zyKuHJtgV7Y1wNvvrlpp3cEr8o9+bIb
         wAxYK/GeuRMtXmTQjIAfw53QQMLtwfpiyrujguCmRU6hBS+aj1mhFrZ8uG/biaWN55wE
         cdde9cem7IzCpRVuwhF9w9bUwQa2LSBIcZ2qoy1pk8vJ9Ar5EAB7WpjsyBoLipM919Pf
         gCWzR4JEp26TWcq+IWi10SwPCo2Vh4CyX0YDuZytaaRHGqi7tOeIwbp0uXVE4BttiMbP
         J+bg==
X-Forwarded-Encrypted: i=1; AJvYcCVT9p5d09T5fa0L4eXXle276MZN29ClIb61Jf1+hoDOFDLj4id1jGwF3vatxSqdaEEzbfp2xCTM6W85MXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlvu43m0+EmSrrVL/Yv+rDQl4PErMvU22YOmE4DR5CK75VYD3
	Hw0I02cxT/offTgrW7UBN0SdKQcy/neLjzNvTIKOsM3iFQwSTC29MG8t3wq8Lb2/W7r/EzRaduf
	r4q6J1uZys0ft0q7Mupa7W3R8RXpXqmEztw9sYDgsTuBViDulCKRZS8sbk6DbLiGDQD4=
X-Gm-Gg: ASbGncuoCMbF7E06AYyvCB6IORL+WvOg6v4VbJRGg3pECspqeG++FVnm/ipPtn7sRqL
	37a55t8NzzYnoMbDm3ov9WBtgbN8lIXLRhIUsrzi3Tkdi4/FKP5xBm5n0qi2PWacFM3oNhDoq3X
	rKhILzmAAHdGCPUhUUFoTqub5VG2CWvHNr4OSlnHp3ZdFkbrhaH8yZvgjoHH1pA85tNdwkQ8Bvs
	CACh5sbmpZbk3PhazeNRfRr1Z2cDStCFfomuU3RQPyHGtrTbJfo3yrVKmQ9fvZU2Ph2MniF2apv
	STAaHfZUdvNazvR+WFgQvZJMaau8Tq1dtk8c20bZhJPsIZaA4iR5XjFkeUhpnXeTkVmHvbaDEwW
	DC8kebQxcmly3S9j18IWJKT/PGYMuw6LA8rcuFA39rbvbo5nPeezn
X-Received: by 2002:a05:620a:4088:b0:7e1:872a:50fc with SMTP id af79cd13be357-7e34356cb7bmr3600633985a.15.1753192334837;
        Tue, 22 Jul 2025 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcOEKfXjfbMZ69Gm3WsZ5DAtXxY4VO7zJgh6a1vFVgcI9uk4+0wZ083YoYs+e4/Wgr2kP+A==
X-Received: by 2002:a05:620a:4088:b0:7e1:872a:50fc with SMTP id af79cd13be357-7e34356cb7bmr3600630485a.15.1753192334345;
        Tue, 22 Jul 2025 06:52:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91f1f4bsm17890721fa.105.2025.07.22.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:52:13 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:52:12 +0300
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
Subject: Re: [PATCH 13/17] drm/msm/a6xx: Fix hangcheck for IFPC
Message-ID: <i4o3ivearks7gwg37ywyqyl4jpmbwnuczac6h7dscrmlepawag@jhedlyj2hzps>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-13-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-13-9347aa5bcbd6@oss.qualcomm.com>
X-Proofpoint-GUID: NS5vQzxXqu4Fkvodnps9qD5VFBTdS8Zh
X-Proofpoint-ORIG-GUID: NS5vQzxXqu4Fkvodnps9qD5VFBTdS8Zh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMyBTYWx0ZWRfX0AB+QULROOUo
 61ZLPeE8QA2+4IzeylhXqSu8t0pKJzji/gYT7Z8AspNPNxo0eoisxflQxoHOHa3qEvGFZwIkbJI
 rxrQx50kaG9AMp8g6yW3ldXmcA+cLw8N4UsCnEfcggNeq+SIm6EOU9qMHKNA7NuORSKZVANKOV/
 YLAaLFN3Q+4RCPfYmd0qOSAiDi8j7yiJeNAxhYguZcXBehxw1B23NvdmxX9j7Jd8Nk4HFgmWv2i
 Us/HMAmQAhNUAA5xOPs1ovQ0TX9KDGjpp/aaY3cYbYz+eaoaTVHnySGhV7QQgur/nbxG7ItW+BP
 cJY7lFoZrd9UPB+HAQVHjoVkeNJlzCgB0zjFPm0tIhrHwJwioZ9wepLysMxVN1uxQk5F2Pj1h6Y
 BASi8+RGIR0aFisp8le31G/arVOWQxszon2xSWaSwAJuPzhjix591q5izUUD/uaKZ72Jg7v+
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f9790 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=eWe-OnA97Zcb8zRWG70A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=893
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220113

On Sun, Jul 20, 2025 at 05:46:14PM +0530, Akhil P Oommen wrote:
> From the hangcheck handler, KMD checks a few registers in GX
> domain to see if the GPU made any progress. But it cannot access
> those registers when IFPC is enabled. Since HW based hang detection
> is pretty decent, lets rely on it instead of these registers when
> IFPC is enabled.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index e331cbdb117df6cfa8ae0e4c44a5aa91ba93f8eb..b3becb230a94163cccff4eaffb8eed44f1c29ad0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2399,13 +2399,23 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  
>  static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  {
> -	struct msm_cp_state cp_state = {
> +	struct msm_cp_state cp_state;
> +	bool progress;
> +
> +	/*
> +	 * With IFPC, KMD doesn't know whether GX power domain is collapsed or not. So, we can't
> +	 * blindly read the below registers in GX domain. Lets trust the hang detection in HW and
> +	 * lie to the caller that there was progress.

I know that we've relaxed code line width to 100 chars. Would it be
possible to reformat the comment to 72-75 chars?

> +	 */
> +	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
> +		return true;
> +
> +	cp_state = (struct msm_cp_state) {
>  		.ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
>  		.ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
>  		.ib1_rem  = gpu_read(gpu, REG_A6XX_CP_IB1_REM_SIZE),
>  		.ib2_rem  = gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE),
>  	};
> -	bool progress;
>  
>  	/*
>  	 * Adjust the remaining data to account for what has already been
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

