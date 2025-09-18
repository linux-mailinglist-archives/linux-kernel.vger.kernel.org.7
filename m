Return-Path: <linux-kernel+bounces-787175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648BB3727D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7B03665BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583BF2F546E;
	Tue, 26 Aug 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eX0/HKGG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F12C17A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234083; cv=none; b=Pu4XpQmzhChIUsNtu9ZYo1ZA1VLQnpjKe0WUn1+4d+293TQ4psc4w6VL/RdBTAaIe0uOudDCx+HfmayrXBLyYMOWZC+ZMRpF8ZHD4j2VtXWJFkYNZNrW+O7NiX2uiiwhaXo2JJ3ktqy3y9+T51XR7PiOxPV6Xa6PvO4DffJIC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234083; c=relaxed/simple;
	bh=vzI77wJSkWaKWMMKB/p6CDWxrsBnpMjNb2Aze+60/KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBCS+if1KVqgGpgrjbLRVea1d46fk96oHcYU1mSp1teGoFWmeQe3pkor0vTNMIBdVHfKWjcbNjSNra3rBPd6fv+TDzrqx6lF3TSY1yqSSxEtFKOcc/dV+ndPRGJ63zhd1hzLixmqcMYoC2rK+CTw1nGsz6YjuIBTacaSIvYRhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eX0/HKGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFqiuC019067
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xf6zh+YUIyDAnG5BFHyyQbBH
	caERXoO1mxLKUdCM3WQ=; b=eX0/HKGGC5ZnAJrPQniPN0S6qGHl9c/jtuHw4P5O
	VQXKS6cwWF9w+mK8UwyEOrORYR0V3AHbw0FIfl2H6U3zpQSYRpm3Uzf5izkvAQuM
	67rD7rqs8PdHFPhuI+i735wIC5McGEnTAcfg/wt10dLByjbywOn3sH6azGPpT6Kb
	ZTsulJ82Zz4s9YqcQpwTU8kH1bZTeV7wCipmjx3BdRaI99IU22r4eq8FuhubzluA
	fBXXHqUBWIrWVagz4hFeHmpRa6Rd3MeJnsrYqE1ALaIsEPX70szIpTPjtiO9Oe2X
	IjS/r/j+GXTujzVcW6TLuXn3kVCtr5NMHhzO42/Q7MUM3g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615hy9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:47:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2ec70so43163596d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234079; x=1756838879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf6zh+YUIyDAnG5BFHyyQbBHcaERXoO1mxLKUdCM3WQ=;
        b=M60pZZXzfCiWGvkDrKlkhBfaGHBCsvKkgE/K3X8UHghNFSaFSiWjCA4+vwkHVjKcJX
         FiYRRQMmYIVAkIULc/cvXrk94wWbchh1Q45dYF3Lc7jSA8R4k9fSDoYo5dWhW1XhRDp+
         mhwpmBj7QH/otx/Vrz+zQ6L8dmMdu8Yu4ZObNkGh21VkOttKiit+VI0o4w5eBFsZaZGp
         CT1tBfI0wMIxvjVeVXCqjP3I1K/EMOkICK431Yll7fO2V1VEr0lm8joB3/cbX61lpKsf
         x0tJ7LdvJEQqpY+dDvwrdSTxPk9O4niRnqtzMF5bGa5+AU4KE+9cDpzA7Sx63tGXJ1pQ
         U+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCULCRAYgXL+FPfkCfBAELxeCo24Q+wdSJCzAyGixHoy59MKpOHFv4p8yd3RyDCcDkOv4FHy22AcV2UK29w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hSdyfVIMgJmyLbJtJOVhHHsoQBDy0CktHJllFC9n6wW5FHmY
	fPwtEIxuFac1lDHvMvcQigTqAtuTFIvwKtf+1kXaN2nEkqhK3Am6MBpCFOn62nm7UQXXyGI7+4D
	Bw5YbKxXCBJ35KL6/lMGcA9GAxmTqANpzGzxqSN29Vbj6AOMPeWoKuwiYQ+XbIBNaurg=
X-Gm-Gg: ASbGncsigc47BPLQ8I/8h8mWU6kWijocUD97LUK850vUfxcdIhCFi0ZszRcM6au1oh5
	pQEKewXyvHPXTeO5yFUcmRHcbJhxfU5mxJyDHGAGSUaIYIDHhyRS3xaBHb0ziqzImsuWdkFH3Fg
	utECmjADDEI1t7UqCensLjzrZKzB+XWPBqWEoZTRhfcbWgX61nD2MNexLmhlECO267UdZ89Ysb1
	7BaH/E7nz41uB0ifvuQwGcRwv2NfUNTneZN69GWFAey8KcaL9i66prMXX+qULNo27UteWY4Pj6q
	Ni0Innbgb9gLLJ3hj0f85pPshVqfb3r2t9SV821cYD5+NKbVgEOQTK0+B3d572lRko6G6Ok2S36
	B6bkUC7LCeOw+KRi4dXKplKyIuMzHU2B26TMPjkibVzLWR0DeVAYS
X-Received: by 2002:ad4:5d6a:0:b0:70d:95a9:6042 with SMTP id 6a1803df08f44-70d972fa85dmr191563806d6.29.1756234078980;
        Tue, 26 Aug 2025 11:47:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYYuUq+/6Jzw2suyCggISeUAr69+TeoIaztg68BBBhft9Bnl7W+AOYaJVGrHe3y/GTb8mo8g==
X-Received: by 2002:ad4:5d6a:0:b0:70d:95a9:6042 with SMTP id 6a1803df08f44-70d972fa85dmr191563366d6.29.1756234078350;
        Tue, 26 Aug 2025 11:47:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35cb5764sm2431932e87.164.2025.08.26.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:47:57 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:47:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 33/38] drm/msm: add support for MST non-blocking
 commits
Message-ID: <56tbubd46myozsycduvb5ds26smzosydr5fmbvmlv6yoiqt5wr@3ib5gnspxxqa>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-33-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-33-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX4di9ja3+aGbF
 e/EBLDFlhugfaTX7T0U1rlzuih78Zyf8zgxute14MHjQi9Vme0qlz5ZQEpTWNe9JvRF+Lxg5yRC
 oCHSSVwdw8SAfZqMC2pFKtfTlsHWVGsrukyg8SZUNOCvFJUAfYWy/y5dRghgaU7EqEbwJwEcY7z
 X1gOKSkq0F3LTFdTtXqfYQedxWanYMJjfTtaNix2Q0KITqhhRDDp/U6nAC9hlOuR//v1qigV6Br
 qPADdNmCuM5cMU1AxKiGPRVJdj/63UVWQXt75UlhZ54NAgVrw1zNtrlhQwCcBnvny2ltzkxrHcA
 gJjd0dAf0Z94eL9XJ+10kDeoaMpjPhmaZoQVjkCCDWuEubTfAdrnEj1Oc3qzhLTKPlcD5sTFYFa
 hf7+wSkE
X-Proofpoint-GUID: x_JDB00sDeMa2vdQz1oUy0dyGolhzXzV
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ae015f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=B68cQ6cBXuK3sqdErf8A:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: x_JDB00sDeMa2vdQz1oUy0dyGolhzXzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 10:16:19PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Integrate MST framework APIs with atomic_commit_setup() and
> atomic_commit_tail() to support non-blocking atomic commits
> for DisplayPort MST.
> 
> This patch only applies to MST. For SST, non-blocking commits are
> already handled via commit_tail(), which internally calls
> drm_atomic_helper_wait_for_dependencies() in the DRM core.

I think this should be squashed into the the commit adding MST
atomic_check call.

Otherwise:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_atomic.c | 3 +++
>  drivers/gpu/drm/msm/msm_kms.c    | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 3aa0020dec3a90b693ad3d4171cfcffc091aad4c..b1656fb456d54af11ba8a30d4971fface114c7a1 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -4,6 +4,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -226,6 +227,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	trace_msm_atomic_commit_tail_start(async, crtc_mask);
>  
> +	drm_dp_mst_atomic_wait_for_dependencies(state);
> +
>  	kms->funcs->enable_commit(kms);
>  
>  	/*
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index 6889f1c1e72121dcc735fa460ea04cdab11c6705..09776be1d3d854f4c77d7df3afa8d56f53639411 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/sched/types.h>
>  
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_vblank.h>
> @@ -29,6 +30,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>  
>  static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>  	.atomic_commit_tail = msm_atomic_commit_tail,
> +	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
>  };
>  
>  static irqreturn_t msm_irq(int irq, void *arg)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

