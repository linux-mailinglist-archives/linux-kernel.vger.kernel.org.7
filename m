Return-Path: <linux-kernel+bounces-812111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516FB53316
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B823B188D190
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783431E0EA;
	Thu, 11 Sep 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMPIOm8A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983531E0E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595769; cv=none; b=s2uGuT5BQP61ayrSny/BXYVwCDwMFDkljHddKlQke4Un9MbhyqhbRD8MHhbJcoSoTxfQOPVJFyw6miyjj7L52a4S9hr8Cz9QgVzO7DJI5ql+pCm7EBOxyYm9BJ5LyhKl2qwdMnfXwWFZnTlIzJzvdbDWUd+QzOn6fKyKx+ZjDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595769; c=relaxed/simple;
	bh=A/d9B+F1+seir7iNB0L7KE5Pg1ky59wbEws9IQYbYRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk4QEg5j4sSv1olcoq3c9gEUxzf63hfu/GrNV2MGfYDHP0onsaiHyqbtAhiZvA2EI2pUHsNEPo9zgYdXx02u1zIF5pwp5qHy96QFAj/pwGNosbT2Yw+Ciq8phH1yHtnh9kOscevvGFSngm827o2D7QjrxPWypSEku8ULVujjJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMPIOm8A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BD0SFO019591
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WOjKakWSJUNAIQxWsQlAPujB
	r+5TdOe/svr2H2na+E4=; b=FMPIOm8Awg8n6eaKaddTiTh3sj+RnU56NbVJ87hz
	NIBlaXAAIkvKo9pYDptzD3yqHm8DJBEOs0yYNKTLay5mxJY9D0WOsxnodTlo5hxi
	xR7+vm5RPDaoguYR9ZBi46k05KFoOD5f7Kt7cy4tioE45QskcOYQGUOsCONy3s05
	Q+6/WBFo9eU21CNfir16Os/a0iGz9/VfLR84RQ8LzNCi6uFRrd1RgTU0NZTrZBsq
	d0EKUsDiVUyjUz4mnRvBJyfUsxUbwORJa1Hgd0DuyWS8IhyK1IvDRJIrbweDT/Vi
	aYnm6VKk+hH4kIspiUYJcvqCdZ7O+XlwNJRUS7v7Nuvlbw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphsex8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:02:46 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-61bd4e3145fso682431eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595766; x=1758200566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOjKakWSJUNAIQxWsQlAPujBr+5TdOe/svr2H2na+E4=;
        b=qUT8uGanksH5O2RNSlSmEaQDZKyZuPtWs8AT1yFDBcpQv3B45C1trLWu/WXSU+D2Ay
         ijxjC+4N++xKE1Pwqqcm23NxfiFmmM1qnwE7NUHgpUIbgjAD60ppoTbSd1TundkOhFZl
         p3W6Vl+uljx4sOv1k7RZ/aJU7NorFX1+237Ro/xIY0OWdOVzx9T6M8Zvmd8knKiIS25D
         uJRqyfzYYTJ6At/yIBqHn/xUTXl1jifiIqox7/8C+lfhQSitxHn3hNoFEGHe0Syx15zd
         q225b7oxyZNOQq58ge6qMvSiwDtWenMsOTkIhOo50FcRvgDwvEfZ/iHiyh2XU4hQ2mtz
         ELRA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFvOWsACzLdysmuu5AezsRvBz12HnjU+nASy9JfgZXMJsxUQOoA+Fd50h0RTaY9JYuqqHvzXFm0n0pMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyogv2B6im8MmxVTAqkq45NVn0QcjL/axqV1Lnb7n1Wsuh285W
	H/dzSFvAxTfj2BU2VjkNfdWjgxMABBRmn2Sh7Fym76+RWOsBwPGtiGVsMFcgWHDIR5PzaQJ66CY
	X1rXcYkrwkLRfOsdQfng+lUHWRPBLNt0kiKrI3gA+jqlf6dMVLk+HR8O+Kwl4bRT3Wcs=
X-Gm-Gg: ASbGnctp2XE7HKYSAhBsP04GbsgI+D0RS0pnxz0yl9G+WVYO+NL/OKJXij59u0m34Wl
	EMleMgTgnC/h/pyic/jjdcxLTGygFyqLjo0YfMddV8nxfY0hHuuCe7MTBKWB7VZxxKmw9d4NEee
	fVS8w7G3872UaGdwy0xmp4UhtYO4sECQbFigOCEKf0gkq7MCsTxxdyoI47cem2S/a6l2+PKiaME
	+L4Yk6iU9aN1lwyLo0voNWcOgqhsiGiLOIkWbMr7Jb1U59dDS9CbSqbHzVW6LQXMG/2UX+F3u4l
	3sx9cXLwHCKP1CzmhFnZ+7ptyOTCGZHuEoPWAxGFDBCfMlBVFjCs3DjQd6L7lbmrtGgPHeJBbzO
	Eh/9+rBbqVnn21+YeB/FcByfdgBkGUpIkL3uCRU+B4QSXbi1deOjp
X-Received: by 2002:a05:6871:9f23:b0:329:8747:1653 with SMTP id 586e51a60fabf-32987569accmr6700539fac.49.1757595765363;
        Thu, 11 Sep 2025 06:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHllAsg+d3b0kcKub7S1vojdU22rC6Gpz9ONEV9J6SRbyOSxxcJp+ShDd6GhvzKBP0tyHSfqg==
X-Received: by 2002:a05:6871:9f23:b0:329:8747:1653 with SMTP id 586e51a60fabf-32987569accmr6700417fac.49.1757595764406;
        Thu, 11 Sep 2025 06:02:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5cf2f446sm425872e87.42.2025.09.11.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:02:42 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:02:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/msm: Add display support for Glymur platform
Message-ID: <xjtg6emrb7svloz2fkaotfbj4m2wzmddxdsdnjk5wkbmocqzmd@l656suk46pkd>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c2c877 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=cOPp_-mWbVNMstl9cqoA:9 a=CjuIK1q_8ugA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lOD4PpPFJWQZS9QrNOosZgRk4iEtH5En
X-Proofpoint-ORIG-GUID: lOD4PpPFJWQZS9QrNOosZgRk4iEtH5En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX/xQaqLkLOTWJ
 ZvZR5kUlWdFU8s34wMp/mpWHqFxXxN7Mk8m9vRJC7XVWrjCE3F3JJbKzEBU3xe5kIyPB2hdEg2Z
 hLh8WeqSBTGKTDmhqkZLliJ4CHjEeiCTHXlJkDq7jmgTpXhRch1FsSeBhy+9VdvCUj/nXDkSIKz
 o1DyXHr5F0mOJOt1FV7r4iX5fURhxKiSq9zOns3o1czHMOQVA3L6prIZPRqAM61CQdKlv0r1BnO
 HadltIjZK6Hu9Ei0gGWjgSd4tdvgVSviCylp0iN/CVxt+k81nyzue7lz6DkwP5p6l2QfjOSpSvs
 A4grA0JNdHyvSeD7ENODsPBH5dzVaCFEDMnpyc3JgiL1daj5UdbuamSNYjR5zVpIWG1KtTRoYr7
 IBHdAB36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On Thu, Sep 11, 2025 at 03:28:47PM +0300, Abel Vesa wrote:
> The Glymur MDSS is based on the one found in SM8750, with 2 minor number
> version bump. Differences are mostly in the DPU IP blocks numbers and
> their base offsets.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Abel Vesa (6):
>       dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem
>       dt-bindings: display: msm: Document the Glymur Display Processing Unit
>       dt-bindings: display: msm: Document the Glymur DiplayPort controller
>       drm/msm/mdss: Add Glymur device configuration
>       drm/msm/dpu: Add support for Glymur
>       drm/msm/dp: Add support for Glymur
> 

This will not work without the UBWC config for this paltform. Please
include it into the next submission.

-- 
With best wishes
Dmitry

