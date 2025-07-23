Return-Path: <linux-kernel+bounces-742380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F20B0F0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E151AA1C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED9289810;
	Wed, 23 Jul 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJdXaofc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A8289E33
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269126; cv=none; b=diI5BvdLDdWSFngKuN094bjSd+OR836DKxvKXMU09NCozJnykcAaFHiDir2Td9Q425jvnVP6AV7Amz6PkZ/fDAqb0akyL2/JEOPEATK9PpMUrAXM/cNi5kHFRYtfa7BOgvGZLoBX/sonPCIqxho3Aa3FYRpPjVDxr3g0cM4igZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269126; c=relaxed/simple;
	bh=hkdvBYSna1oG7Wdu8iY66NJUXKxJm4xL6CepgrPl/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq9Gc5fl2dcBMIxYf6dGkzxfYXgYjkUq2boJyGMLEQviqlb3WcsJyb6CDpz7eaxWLRbm+hROPPF1XAplrQRwDemWpKcI1wYmvSEj8jjCKMiicpQAzNFZJOAPpZgZ3P2t8gRRqm0LQWcSWZ89CRIxeCz+fbdYlrTYHa6E9HSYJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJdXaofc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9LhMP001765
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0VjeMPx+hhfBKfjETGJRw+SMh95RYSVHKRWrlXnn5U=; b=UJdXaofcZgDwAeKu
	407OxHvK8Hn4sEdJ/xm62+w+A/vqZJjj7WeKbRoDIKYBpH6yrBJ79INmCWRN/80H
	ZQiKvYfq7RnY9QSNnZpOSflOEXo85aHY/SxxUFxIIhsbUHhs8MOumIhNgU8JWR9h
	1K6fjbW9z4jH3vmktzwu61nA0KuCMCb+HxDbySZm4BcMVFWi04/zmBv0IDmKYY3z
	Nlrr1Zolhc610X7RjsFzLV+N7ph+fU4cQGUCai/dvfVeHiTJTi/ax9A3mMWH8Cd4
	bFU3MtqYgZPIxTDfJRI9pVGmpl71uwXOjBMiyxyQky6B/go1jjYinFO4R7eNdgTq
	FGgpXg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w62gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:11:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-706edda34f6so28088246d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269116; x=1753873916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0VjeMPx+hhfBKfjETGJRw+SMh95RYSVHKRWrlXnn5U=;
        b=p75Q1dBbcE4Gj9ZVeoX4+8tkQCi3E45BlpHumdSkRx+qlg92BKPI5C3ycFyfjuO5Wj
         wrYMxoOqVgejcyRtMlKbdRaX+GDbe4v1ABIhAax8HLzgreiA760oe22jczMD0/6UJL+M
         gHH0lOxbya6tWgS5dCv3rI+bD71UdqUaunVanMvcAnUEcYSAKsnBmq6KB5dgCd5pgxOW
         6mVe3xMcdhL+HwQyh3KmHQOY+Ww914F0JznTLgC2TCcTxdoqZKoNuHLukDwrkL3dzq+Y
         ruGil8ZeYa6AMaxaj2MviJgbzM4Sv+wTARMDpOePEqp9WV0+f8XPhDaiXqXH+r1NBN9N
         ld9A==
X-Forwarded-Encrypted: i=1; AJvYcCWiB+a4KBaTc3c10ViZF6jC1ZWpib/39ERa/KLDrHxej+ZBdnlnOJmZmLrNMHIbc1GLVBKxC/flab6pmzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqXwfExVRReK/OVdmljE+Ul3SzxuFNl4nCfDRXjWi5YPj/Wef
	gsPmaL4qzIfiP8A4MZut9U/9xBTXAH+SG3bewq1NGaILrba0AmsjlmtOVDSknpXWtEgu+tNfRfn
	YuURUPG8+PkRS5EkXuqn0ciIDBAl3Kl49SxgVbEOjcjCb+zzQD8CqyRh3RYpBp3e+Jbg=
X-Gm-Gg: ASbGncsK9zvHPScZneSCy+y6F9KjJ4roTOVOO+h2mW/InXdICOIuSpx4x5Zm0VWLTML
	k0o9eauZdJgQbsfBQzxe1rwwP6/5uGEvNBwml/RV0YYtgipsmYXjSO+LlUapeKqBiSELZPa/o0Q
	Oue/gbewYysGtwFlW7HS2gpPJia0js0vxuVhldpvPITkatvplFnlS4N4dMV1MNVeTjKG4cDBdYR
	JcZRMzKVFsq2LaJlIg0Kf1Qk5WeB1dpVIrrvdQSlxAFy03yJZklko4pCHEwGr4anzk0VFuFG4LV
	kAyMBH6C/1EhaFuU4zsmvPpkG+EAc2nF0+auaXCAdKW6Dom1MQBuxfZbgBTunL3Eo2oU2Mxgb20
	+RPIsvIi9aiKTZehX6rXdPWTkow6yMgbu9Qm9RirKRymF8IcakRhJ
X-Received: by 2002:a05:6214:202e:b0:6fa:d9de:a3fc with SMTP id 6a1803df08f44-70700722b9bmr33142966d6.34.1753269116172;
        Wed, 23 Jul 2025 04:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAliv5sNvk+3b+28VgVbpH434Z10+GwNfxjx4Yw8Dl6zlfkQH4ukDRejh6Shv9GMsLPiMb9Q==
X-Received: by 2002:a05:6214:202e:b0:6fa:d9de:a3fc with SMTP id 6a1803df08f44-70700722b9bmr33142086d6.34.1753269115418;
        Wed, 23 Jul 2025 04:11:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c54asm2285330e87.100.2025.07.23.04.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:11:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:11:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
Message-ID: <rr6zxamm5oqebfc3zq7qzfjt327owlsjvh3todjzfzkqn6cd2b@sgsrdg7kfqa4>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
 <avni4utnzdmmafc2mf7aqgva3osbhuiqtia7gdngqswk5cmtn6@zo65ir7gyj6y>
 <CACSVV0346j2y-1Jkj=wasekYy5syax_E495AQZv0bvrrqwCSRw@mail.gmail.com>
 <f1070069-7220-4351-845a-2929d1e65a71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1070069-7220-4351-845a-2929d1e65a71@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6880c37d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wNNrqZBiHP9T-vZZJccA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfXzYAwly7R/amM
 rlY7vqJzg3+GoGGm2xq+9dcF1YRTGoox5P9forelv0570BNjEynmdXlwnh2ltfZNcQyM9Tc49TT
 bTmjQiwTc+xmLFrcQ/VnJe4L+BpmpL4I2w2vcYq+0bZAxReM3AH72vq6/uQImpndQSkePeeqmav
 U8LA49urLuD6H3ES26Tod6kjXtMMjj5GUHrgRKPXaXEPnX/+cJkml9Zxv2E+Qy7Qv4zFjmLSoY7
 3abEeASpHosQD6sXp1VwNnypllqV+dyGytRhUXGBUGPg6RUcYZhW2PW4voFdhhxC4522CeOXo7f
 DVAiS0l/B1sRmaO1cuhqG8M9oi02VnseL7kPhRLFcyqs0knBZADfwp59MVqVPqcXAn/aR23uzlO
 Ava4HJ0iGAxPdlKHCtqHFZ/jD5GiMwNZsS4UaEVVz85sHWCOfRsP30+jcVqXGrFFIboHztMk
X-Proofpoint-ORIG-GUID: -2Ek8bVG-Bz_NMErr7uCM2VA2Ze2PDeu
X-Proofpoint-GUID: -2Ek8bVG-Bz_NMErr7uCM2VA2Ze2PDeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230094

On Wed, Jul 23, 2025 at 02:35:31AM +0530, Akhil P Oommen wrote:
> On 7/22/2025 10:56 PM, Rob Clark wrote:
> > On Tue, Jul 22, 2025 at 6:33 AM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Sun, Jul 20, 2025 at 05:46:06PM +0530, Akhil P Oommen wrote:
> >>> Since the PDC resides out of the GPU subsystem and cannot be reset in
> >>> case it enters bad state, utmost care must be taken to trigger the PDC
> >>> wake/sleep routines in the correct order.
> >>>
> >>> The PDC wake sequence can be exercised only after a PDC sleep sequence.
> >>> Additionally, GMU firmware should initialize a few registers before the
> >>> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
> >>
> >> s/KMD/the driver/
> > 
> > IMHO for gpu things "KMD" makes sense, to differentiate between kernel
> > and user mode (UMD).. this is perhaps different from other areas where
> > there isn't a userspace component to the driver stack
> 
> Ack
> 
> > 
> > BR,
> > -R
> > 
> >>> GMU firmware has not initialized. Track these dependencies using a new
> >>> status variable and trigger PDC sleep/wake sequences appropriately.
> >>
> >> Again, it looks like there should be a Fixes tag here.
> 
> Ack. I guess it is not a bad idea to backport this one too.

Please add cc:stable to the patches that need to be backported and make
sure that all Fixes are at the start of the series.

> 
> >>
> >>>
> >>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>> ---
> >>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 30 +++++++++++++++++++-----------
> >>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 ++++++
> >>>  2 files changed, 25 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> >>> index 3bebb6dd7059782ceca29f2efd2acee24d3fc930..4d6c70735e0892ed87d6a68d64f24bda844e5e16 100644
> >>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> >>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> >>> @@ -279,6 +279,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
> >>>       if (ret)
> >>>               DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
> >>>
> >>> +     set_bit(GMU_STATUS_FW_START, &gmu->status);
> >>> +
> >>>       return ret;
> >>>  }
> >>>
> >>> @@ -528,6 +530,9 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
> >>>       int ret;
> >>>       u32 val;
> >>>
> >>> +     if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
> >>> +             return 0;
> >>> +
> >>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
> >>>
> >>>       ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
> >>> @@ -555,6 +560,11 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
> >>>       int ret;
> >>>       u32 val;
> >>>
> >>> +     if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
> >>> +             return;
> >>> +
> >>> +     /* TODO: should we skip if IFPC is not enabled */
> >>
> >> Is this a question or a statement?
> 
> It was a reminder to myself which I forgot to revisit later. Will
> addresss this in the next revision.
> 
> -Akhil.
> 
> >>
> >>> +
> >>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
> >>>
> >>>       ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
> >>> @@ -563,6 +573,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
> >>>               DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
> >>>
> >>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
> >>> +
> >>> +     set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
> >>>  }
> >>>
> >>>  static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
> >>> @@ -691,8 +703,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
> >>>       /* ensure no writes happen before the uCode is fully written */
> >>>       wmb();
> >>>
> >>> -     a6xx_rpmh_stop(gmu);
> >>> -
> >>>  err:
> >>>       if (!IS_ERR_OR_NULL(pdcptr))
> >>>               iounmap(pdcptr);
> >>> @@ -852,19 +862,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
> >>>       else
> >>>               gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
> >>>
> >>> -     if (state == GMU_WARM_BOOT) {
> >>> -             ret = a6xx_rpmh_start(gmu);
> >>> -             if (ret)
> >>> -                     return ret;
> >>> -     } else {
> >>> +     ret = a6xx_rpmh_start(gmu);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     if (state == GMU_COLD_BOOT) {
> >>>               if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
> >>>                       "GMU firmware is not loaded\n"))
> >>>                       return -ENOENT;
> >>>
> >>> -             ret = a6xx_rpmh_start(gmu);
> >>> -             if (ret)
> >>> -                     return ret;
> >>> -
> >>>               ret = a6xx_gmu_fw_load(gmu);
> >>>               if (ret)
> >>>                       return ret;
> >>> @@ -1046,6 +1052,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
> >>>
> >>>       /* Reset GPU core blocks */
> >>>       a6xx_gpu_sw_reset(gpu, true);
> >>> +
> >>> +     a6xx_rpmh_stop(gmu);
> >>>  }
> >>>
> >>>  static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
> >>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> index b2d4489b40249b1916ab4a42c89e3f4bdc5c4af9..034f1b4e5a3fb9cd601bfbe6d06d64e5ace3b6e7 100644
> >>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >>> @@ -117,6 +117,12 @@ struct a6xx_gmu {
> >>>
> >>>       struct qmp *qmp;
> >>>       struct a6xx_hfi_msg_bw_table *bw_table;
> >>> +
> >>> +/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
> >>> +#define GMU_STATUS_FW_START  0
> >>> +/* To track if PDC sleep seq was done */
> >>> +#define GMU_STATUS_PDC_SLEEP 1
> >>> +     unsigned long status;
> >>>  };
> >>>
> >>>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
> >>>
> >>> --
> >>> 2.50.1
> >>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
> 

-- 
With best wishes
Dmitry

