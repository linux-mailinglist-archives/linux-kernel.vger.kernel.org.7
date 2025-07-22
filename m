Return-Path: <linux-kernel+bounces-740905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E969B0DAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485351C256DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553982E9728;
	Tue, 22 Jul 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPDuicZB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9B1E4A9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191228; cv=none; b=OIQ5dK/Hi7eWFvalG3+YhX3ifPjCmUqaDBI50s8zm3Qpj6ZVHhMQPG9wiSR28stF86QWHTRM4lzMFf5q47ajLzD+P7guVLquoDmvQYPCKDVyfSFiJBCl7GXbkO4K9GyDmM453XNkIX5TvgVm//tYt2GR0v4bKINT9yVQH2X1uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191228; c=relaxed/simple;
	bh=UPMq6/gjH5/nXlhHIhOBqxvqX0+PzzpUTL0oiDfcQLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4ZZQgaxJ5pRpfjI3gkxju6N2JwHsawdd27LhyrdbPgxpZ2rK8zyk4nX+eblrTktfmvqrSSSiZaZFgvbcRyACpyqCPApZaCoKGJeMmOvc5L4t+l/iMTwdxdg0+tkspFYacLsfKTzyUF32zVgKLlpl8/H/5x/QWdG3XS5OGYMmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPDuicZB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M90BpZ025565
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EfsXBdGr0ZefoEuNYobsoglk
	aaa77ZqFclUas4r8I6Q=; b=hPDuicZByTNlXa7CIkXCxdo4NPztXLE7eqKIPhCE
	SyJ6vyzlekTf7Lf8KAcsevpsdAZDvdmrkLH8sNkco2BVsvqtTc5GbIIDFGec8YVO
	myTm9y5rA+/akEelLQ9kEc0e34pxDnp55A/Q6LaRYapcFilfVnweow5PM2gxf9Yx
	xR8udUzWEznaAIp+TGZX2cFmXLsdVziXjdNmuNVao0OPhtYT3ahVKS+bWswz8dKt
	zjZBY/UxO8CGWoph8bM6hXnNSPHBsKX8I9FpBqZLnyxW0B31frq/TXPtMAb+dlBG
	c2+Px8ZrGm3yzHiG8P0fa8Zs/pgeZotuZmKu/ILqZP+Cuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dhe8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:33:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7da0850c9e5so827466385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753191225; x=1753796025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfsXBdGr0ZefoEuNYobsoglkaaa77ZqFclUas4r8I6Q=;
        b=UxntMP3kJiqgYUdLXNZKsl7CY11kE2nU6GJkGRyDRjWLq9Rim80cvQwqDJmpJnKupk
         fD18g3kWvM0oiF75Qua9jIL45iOMz+cjWBkU+FZ/zwtkS1W/SQGVL9w7gFMYU58nH7MM
         93QT9k8dLDoOkDK7/RgMA9uthVyKkAWONtRahZqxdVAYgo7d2vTc0WkIz2NXH8xpqvSP
         22mY8rZxlwa2e0UjdOrkGwlxKURj+HFHL1PbPH+egkKVlSfiKJQ4xRTmYQam+er+Zbm/
         5uZuDx2uJBwDOlBnACJhPUDK0KlMt44VPHJTy/xeDUpgKrfiFu4a2NetbZv7B61KHx9/
         rMog==
X-Forwarded-Encrypted: i=1; AJvYcCUmA8pm7bAZ+Ct4C08cXhOpD+jveu58O4tcvZB+ZoIiQpdJLKiaKNZAmBz9Eg8XnGn+Z478mU/WPAy6WFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXzusWDkhYTQFQp7FoS15D/Fd6pStoBtNLqQwLPtvVbTJ3TDn
	fHgbXVaOP1k4xIb/O7PTVs+Hnbt2RbDeFek2XCUt1LJOq7ZbLLTyHeFByN1rOYRyk3rUrpSZQ1x
	SsHeaSc2Ids4WwkSIL8s05GM46kSN/YP/YEaQ2yD4QPG54KAvx+JYInO21OHv5hkYKPQ=
X-Gm-Gg: ASbGncuHk51MPMXrqU/JeTuxyN5sqaxgqbS+Yv16Py+R+juQdQWX4TGfsY92Ds9VkgO
	OlfHdLt87SIbmlMPvKBLkVC6b+YNVLftcaR/goPFX1Y7pDx8hmeJtCeRpYNsW02MVjY+QOVD7KP
	eG2fj8/P02TSxq3o0QeLiqoVeeJ1m+kOF7g5ftMtr0eqPRLxjcraO3SRSTjLOFS7L0CpwlJJeJp
	C/bUHgB3LYVHgZxblItf5FVwdXxguSHmDzwYU14yYjsFGfdwxhirYVTEUWZSV+u50DpaUR8Kyxx
	YKklYubPGhandQ6+RYIThI0uxOolvDItQhbPwArqOsFlCFSEQDOMpVipPqs8AdxGuWl7rN19FHU
	x5NNHrAWVs8fA4l+OWIAm0M/QDbxtHDYb/DhP43tN5Qs7axbmZNUd
X-Received: by 2002:a05:620a:1a8b:b0:7e1:4b5f:3f98 with SMTP id af79cd13be357-7e342b994e7mr3254129385a.57.1753191224754;
        Tue, 22 Jul 2025 06:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP3AAsy3mbtljhMSzHmvF/WFjUN8vlpUNZFy1EG7TdKoCphtGRWA/vS7N52z+3EqqbWOMt3w==
X-Received: by 2002:a05:620a:1a8b:b0:7e1:4b5f:3f98 with SMTP id af79cd13be357-7e342b994e7mr3254124785a.57.1753191224115;
        Tue, 22 Jul 2025 06:33:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c735sm1951720e87.129.2025.07.22.06.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:33:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:33:41 +0300
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
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
Message-ID: <avni4utnzdmmafc2mf7aqgva3osbhuiqtia7gdngqswk5cmtn6@zo65ir7gyj6y>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687f9339 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mwp7AVN4ek2gjh_I9OMA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: lnI7KeSPCvLrEKa8TNRK3ceqKPuefvnX
X-Proofpoint-ORIG-GUID: lnI7KeSPCvLrEKa8TNRK3ceqKPuefvnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMSBTYWx0ZWRfX0V5rFyq1nT+R
 9pRVxM9c7VqqMyugbe47c/ITxLUlmm/7QAUBeTSe87zGSOlaYDZXMCAr++5E0/FPAS4VBdNxVn+
 aFA2sfhE/zFU70asCbGyLB1XeeSvpt2pSEeEqlKP/W0N4AbLCUcJgegGfhbOxCje67usVl5gcYj
 r1TysytZ6RgJ1XPi3U9fI1KzohKd7IPQ/JZsGOf1M17SxF4udOn6r6y6LyPUpX89B48X7Yh1/8M
 g59EwQM6Ir6mUUQFi1h+T4f39DFJzM+NGgs03m4ucyELZZ0zTIMgqWIye3W7Hd7NfhqHxCAB+MZ
 0qZBznDaMHdbtpS5/N7ukDkQ7RQwIIclcycKZ12uIwOioeLRGGpfXUInPSyUjeMgm3QO5hn15t/
 HW+LgmR099ihhow6gQ2gFFm8lIXuxh+PhEwmMujtQp+vIEJLsCk6Esrgquhm7kAQBW9PRGOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220111

On Sun, Jul 20, 2025 at 05:46:06PM +0530, Akhil P Oommen wrote:
> Since the PDC resides out of the GPU subsystem and cannot be reset in
> case it enters bad state, utmost care must be taken to trigger the PDC
> wake/sleep routines in the correct order.
> 
> The PDC wake sequence can be exercised only after a PDC sleep sequence.
> Additionally, GMU firmware should initialize a few registers before the
> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the

s/KMD/the driver/

> GMU firmware has not initialized. Track these dependencies using a new
> status variable and trigger PDC sleep/wake sequences appropriately.

Again, it looks like there should be a Fixes tag here.

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 30 +++++++++++++++++++-----------
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 ++++++
>  2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 3bebb6dd7059782ceca29f2efd2acee24d3fc930..4d6c70735e0892ed87d6a68d64f24bda844e5e16 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -279,6 +279,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
>  	if (ret)
>  		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
>  
> +	set_bit(GMU_STATUS_FW_START, &gmu->status);
> +
>  	return ret;
>  }
>  
> @@ -528,6 +530,9 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> +	if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
> +		return 0;
> +
>  	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
>  
>  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
> @@ -555,6 +560,11 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> +	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
> +		return;
> +
> +	/* TODO: should we skip if IFPC is not enabled */

Is this a question or a statement?

> +
>  	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
>  
>  	ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
> @@ -563,6 +573,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>  		DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
>  
>  	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
> +
> +	set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
>  }
>  
>  static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
> @@ -691,8 +703,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	/* ensure no writes happen before the uCode is fully written */
>  	wmb();
>  
> -	a6xx_rpmh_stop(gmu);
> -
>  err:
>  	if (!IS_ERR_OR_NULL(pdcptr))
>  		iounmap(pdcptr);
> @@ -852,19 +862,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>  	else
>  		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
>  
> -	if (state == GMU_WARM_BOOT) {
> -		ret = a6xx_rpmh_start(gmu);
> -		if (ret)
> -			return ret;
> -	} else {
> +	ret = a6xx_rpmh_start(gmu);
> +	if (ret)
> +		return ret;
> +
> +	if (state == GMU_COLD_BOOT) {
>  		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
>  			"GMU firmware is not loaded\n"))
>  			return -ENOENT;
>  
> -		ret = a6xx_rpmh_start(gmu);
> -		if (ret)
> -			return ret;
> -
>  		ret = a6xx_gmu_fw_load(gmu);
>  		if (ret)
>  			return ret;
> @@ -1046,6 +1052,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
>  
>  	/* Reset GPU core blocks */
>  	a6xx_gpu_sw_reset(gpu, true);
> +
> +	a6xx_rpmh_stop(gmu);
>  }
>  
>  static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index b2d4489b40249b1916ab4a42c89e3f4bdc5c4af9..034f1b4e5a3fb9cd601bfbe6d06d64e5ace3b6e7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -117,6 +117,12 @@ struct a6xx_gmu {
>  
>  	struct qmp *qmp;
>  	struct a6xx_hfi_msg_bw_table *bw_table;
> +
> +/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
> +#define GMU_STATUS_FW_START	0
> +/* To track if PDC sleep seq was done */
> +#define GMU_STATUS_PDC_SLEEP	1
> +	unsigned long status;
>  };
>  
>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

