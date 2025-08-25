Return-Path: <linux-kernel+bounces-785319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF9B34903
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DBF68088A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D45305E0C;
	Mon, 25 Aug 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fPuI7xgC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A87307494
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143354; cv=none; b=E0VAhXrXSR75wGWe1SYdU/7q/495xoBUxBb5Id9Svkpf2IKDrDhyL/EjhtFDFD0stC/FJnw8dnwVjjAhSnBq8KtssofWQp3wt1NgIxrHGVmNvBx2dKKDLoW6ZGy1yq9jc2pBw6+Q+DSSO1SXbWe0JuPZNUytX3p5VQEn8iDgIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143354; c=relaxed/simple;
	bh=BOyBU6FwOBa3s5GaJJW7i4euH9xw6aUAb1TTNkN8MNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO3PxwzbJbQcx5Dyl6WsNeV8cD14gbWhqGY22R5RvuoU5e5lVactzQpX1hJip+dTgqFf0j+PzMiDLqLM74fSe1WntUTB6PmFMYMRr6hAirWVYhUHYAZJW3Ogy4enhp6I9m52029C+xvyUjKVULx9GnasprwjEt1tFHHDKw08zHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fPuI7xgC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGunl4024239
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kwa3vdgYtv702TKjlFEOUh4f
	oh4EffxBoohd+2TNwQ0=; b=fPuI7xgCZfYig0MelwbZl/WiuZxk9xEJf4+qVP/U
	euVwGsfDiQaNX9IVShE/1HWHt2YyS5lASSrMkJFCBxbMHQNrckcW3zDu4OCWONSG
	i8ySVPHaiVRitazJkR6LGBeTvKM0iy6sDqyPNBiUn9krj8qZ/IxWdoq3Uloxqr7P
	jH6VV0V1z8yAT0KuYWu3EY5jPsD3lQ8AcW1nDry4aXfRwRf+fy5VwuOe/OLPJ9xE
	quiI+uxUGZdivA1drOhdtZlcwR9FMBYBAUnemKfpr5JRzYFKoJug2rNjicCjs4qk
	VeXPBBsBe5yaqxoxAHrsZnnoHPSQ8QB3C5858cTbtnz0gA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rusk83gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:35:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b134a9a179so48242481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143351; x=1756748151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwa3vdgYtv702TKjlFEOUh4foh4EffxBoohd+2TNwQ0=;
        b=sxV7gEjDR3VFXzKnToP+P4MlflI6MpMT5Gf0Emx3rZ4DSfkNeuSPxiNAW9FxFgCPaX
         kNOenAU2CGHcHXW3NVsVk/+CIIbRw05AKTU7xC7aYFV7BKHLy3VesaKSbr5tVU2Vu/j4
         c58ARprtgxy8DYXNEEzQRA+4RUVfy9kt482UX9XFNyLmjtXp/0su6cTxF4B2H7CCwHGt
         xsJlwLcOYkV+0qqdSePQFnS8CQ2DMS+BRxNnWz8OnHQiSaZ8OzDKQEdzUKo9ueSzlo5Q
         Qtumvmlt+BXdCE4fAOESAWXec1zHU5sx4WmloNPpdmlO9SuALERDQsYiXpWVuKX1JulK
         oVmA==
X-Forwarded-Encrypted: i=1; AJvYcCXSUUlLFoptFY/4rRHi/5vqucNE5kVJ4IcX5J/2lrF8imd0cpCZUT5phKXm90SvBG3zA+4AeIHNaiYU1/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvd53g23fbWTuE/lStrQqnttOLlT1f8aIjkiqQdlgx3n/SNqMC
	l6DsSffyDqQ2tTDfpk/4fE10YzRRgjSyZVz+IHRcydiRR/35ES6YIjVCgEXhRtq+x3917hoXury
	kVbMGTlEy5q/3w0uZF5cPRp7/VG53Pcql3B98JJxocuIOc5XsX0p/xL4old2o7uFV70Q=
X-Gm-Gg: ASbGncsLR9euu8hsF2+kgF4Ltk5vPTwUoI/3L+vs6ROiw8ykK5VHY6q0uZa3F7P6w5/
	jSo6Z0xwbXaTRGsuR5vPZYCBJZmvAPNISB3NAgiVOUa9zQTXCeLS9+QWL951j+pZbplidj75Um/
	Z3Mf05KUzjva0Rs3y9CUYiGiDPTFLEtuAHgu+9z3/weuBdpMEpZmgzxG6pmVXHfJjhlQz1F5aSe
	Se0PkwQIWpcHNHqmHRfhILp2iCV+i5LRVe9VAXcoEW6D+uOyCgAUtu9Eaw6VqAyeNggHOVM/REq
	gzdVrCf521xIkIeaKliwYd1Dj8+oC30yDM5M2NwTrvX4yQ9MG5/VlKfnRMGbu8AHy2a29sRtZrw
	n2MhxpGgUsm1Cdxj0NiGlvpBS0pO9WGW5ni8xs+TNHPqU+yI3aHPJ
X-Received: by 2002:ac8:5885:0:b0:4b2:8ac4:ef8a with SMTP id d75a77b69052e-4b2aab57b3bmr163573701cf.69.1756143351086;
        Mon, 25 Aug 2025 10:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEnoMIrJ7Zrpfy4CLQqO45/pFwcr6T7pVHZ+N32uTDgh7RXtgJOi343oTo0GJcof/9i3w5fw==
X-Received: by 2002:ac8:5885:0:b0:4b2:8ac4:ef8a with SMTP id d75a77b69052e-4b2aab57b3bmr163573211cf.69.1756143350550;
        Mon, 25 Aug 2025 10:35:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e609f72sm16550321fa.71.2025.08.25.10.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:35:49 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:35:48 +0300
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
Subject: Re: [PATCH v3 09/38] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
Message-ID: <5g73qgwgog2ch36faqiyluhsci7ungrxnovm4qgidk6n52qa3w@lpkgkzlofyvb>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-9-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-9-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SY73duRu c=1 sm=1 tr=0 ts=68ac9ef8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=z21d-uj4LOo1IgCTbOgA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0pCPIMP38B_qod7xl3OGHfSakmd3Qk40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE1MyBTYWx0ZWRfX77hgk26wW/4n
 5qpAjM1pZLU4WfaVYaOD3ld57+Pc5glaLJw5bLDo3/VJf2VIy3wUMkkYuekOrEpvJRGhcqEZwlN
 8Xuc9R+FEUou5Qc4k7sV8tmr8PcR2rmFu02NVyJWw/1Azx8Y7jy+CVQf1oBfOsdRBbsgsaT7hSb
 3cF0fyMEYoDVymv/HGnCgcAgUS/fEDuKai4P7aCJYrfl3izPV3EmJJET0UguaZkfXpZIGNV9smx
 yUWMZW5iZJh9BAhUjZvvLh52+VJ6r02FYH2QtyXAPEpOxhHaP9IE64C/ohjTnZPDycFi968ofAn
 QnYe5JJl2PRLEXYPKlezCC4m73oiI0NWwnPYeeUPdgbGqb5X464Du2aqjMqcEU+/1bF8Ao+O44T
 BlBVYqpY
X-Proofpoint-ORIG-GUID: 0pCPIMP38B_qod7xl3OGHfSakmd3Qk40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250153

On Mon, Aug 25, 2025 at 10:15:55PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Split dp_ctrl_off() into stream and link parts so that for MST
> cases we can control the link and pixel parts separately.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 8 ++++----
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    | 3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++--
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

