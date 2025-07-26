Return-Path: <linux-kernel+bounces-746800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE065B12B57
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E291C2530A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C82868B2;
	Sat, 26 Jul 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjhTd7U4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D221348
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545929; cv=none; b=R9t4pz6/gmJ3DE6DVkN0a3nW2WZJEo54VfygetGZ48GZVOKEVHQyskjxoOk8sKXbaovUSGagCtaja8BsmffimbFYck2uLbV0gzG4NsAR6hZZaqCfj9Xpf3UeMCZuWoEP75g26bPn9nBvH11SofZG8qmjnPa4ebEBKJtocDa/sMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545929; c=relaxed/simple;
	bh=PUrkSozFkkeMnMfnlwvJVtzIMpS4at63Dd8X5r8YIHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goMXDhtiQeul4ujBw+GNexAhDu/+yotrGlb8XT4JScNPnrMREuoY1uH1ujogB4mQAKJERCaQihb5Fr7Ketxo9Ac6/HthPg+LNgxqGVPN0cIPdWmQemQ0RvD3O1iHfTUVFOcK/Fsu8UmVTRUgfWOJkPsdj+Kif/CD0EPAAYk8QlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjhTd7U4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QFqbRp028900
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OXCJSxoReTk8aiWjW4riny+3
	jOKSrw2PoehE9U+YV9g=; b=JjhTd7U4iMj86s7iNMFA2H2Wh5rj2XM+odGNkPu7
	E5MQ83XolqzPGDoctc9mKOdxZKwglV0KoVv55grDJnEJUksHTKbX+hB6weEzdBhU
	AkyZWWHxPKDtD148HbsJfhkmJCXwZiWwCQXRxzIYpbMwMiP8MSubaljJ+ChDMVVc
	/+iiG7BQ3O9qNrRqVPFP0bnTS+YKUmVnISjtOYzn4zVjkFlcxf8Syfj6Idi6L0Kf
	G3caJ2o4d4Om8EnlGT6UKzen2WuxKio50K/q4dpumjiPecM/6C4SLA1L7/RcXiaP
	t/6ZaJaBAkGpLK1bhgMfIlD7736GezM3cWLTwtZP/6XTPw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qgr81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:05:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70707168c59so26027696d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545926; x=1754150726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXCJSxoReTk8aiWjW4riny+3jOKSrw2PoehE9U+YV9g=;
        b=nobeMuIniG0YefQP3+NJ91ab55MwdpOKJmuztBZ5lTeo58th0DH8owVV+suVkBhu6r
         2Y2Wd+h4CBizQFHyOoRCvNKuW5BcjpprXKBpRLaSnL/O19hVv4Xan4Kmvc8MkQKNGm1m
         GGnX2aD5FajA2gGPG7qAvf66a70duqYDWHvVW7Ljy9ZD2nQB1WypPjGwtVI/GtmqVHrB
         RuCWbVq7WzX/Gjx8MJT3WYISwZzKCCseua33f8DIrTuw//CcfcSytaxnsaPdDDNOv2rg
         xpYsSpJl07oTRx+uH2FBDWgQxjJnigXq13BCFgdWhUfvu1NRE42HRMeRIgXu79veoFEM
         fekw==
X-Forwarded-Encrypted: i=1; AJvYcCUgTpLgl3N91Vxu+I4gaM8/AfXrKUnRAmPPqpRd5zsup2MpFLcNhotzEuV/M227QSxa5Mc8jdOuYz0cuqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOAmturxkzvBfRonjmfu9wREgHqXqdDdWSAJ5CXsejDKfc2LX
	f2EwckT3ve92ED7GvdEL6CLxqwSbDm5CMtS8bGUZU/mQIclX5fMRA6mO41ZPLqetg99ry+zPsC/
	OuQe3X4jKuid2sHs4As2Cop3WqnNgY/kYWTwgyLMBro4Tyftbv4xIFH/xAsRLTJKbsY0=
X-Gm-Gg: ASbGncsW7u4It0swyPEkM1VP2Bx2nb4L5x051DZNgZHBgCxv+hR1yVQzybCImDVuHuf
	Rw5yVYmOEiVJwvTPaB2MZ2iSUOERarfxCWduWYDBQiCSQzbqvmsSJBRAzmr4DXicm16G5bQ+wAD
	4nv7s51J2UQNqKjzlDW4QCJbN050Lf3SwvUbCbfnNKqDopCDcsGDEkoH0yZJBSGIvv/F9GYqK2e
	lNIBD7LGNGqm2WjzqZk/vZh648W/Jgpjok0DPQNcNZDpT2tPof0PGFBywujtEerVS8qfALj4AQP
	bm5RGLAxYBGui4gR4i3LPvyP6Ks4gLmK8G4CYmMawHFv8X2HjsIbT9F6i9YiWgVY813BdYmTD1O
	hsB3IJ7r6MTMrF2RK/K9L6ZPnUJiegr5YmCQ/CCcBSoKftPIcLfXA
X-Received: by 2002:a0c:f00c:0:b0:707:2390:2968 with SMTP id 6a1803df08f44-70723902d7dmr68085586d6.16.1753545925852;
        Sat, 26 Jul 2025 09:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtnleMjXXn50zHpTopz+EP+s9ry6QJ/sF5nQS8I6PAzpXZgZQCwe8doY8ASsjM8BU2ru14mQ==
X-Received: by 2002:a0c:f00c:0:b0:707:2390:2968 with SMTP id 6a1803df08f44-70723902d7dmr68085106d6.16.1753545925175;
        Sat, 26 Jul 2025 09:05:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f407aab0sm4870891fa.19.2025.07.26.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:05:24 -0700 (PDT)
Date: Sat, 26 Jul 2025 19:05:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 10/11] drm/hisilicon/hibmc: adapting
 modification for the former commit
Message-ID: <oxwapypy7ttxf7geysnatnowlhidioxbhfyvt5ljrhw4tjmbsr@zycqgbwmwqbc>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-11-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-11-shiyongbang@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE0MCBTYWx0ZWRfX2DKxiM3a5Z8E
 JR26mfxRJnCDf9MQ+tEQ0LwUaRjwOoSzXtOlyJrp5QINLvyII276UXCMb47q6bpZqe1bAZw1X1v
 x+Sjrq9UTU9VDgchQdP9DYiCY4Pxm5fYTe8St2YQz4OKTSRNoshI7bCyoltR234iAGjpZyQ9R5s
 ngR1AeLxGqxRr5QwxWJ271r5OLFHPjf8wABLB+iJJ5N8mBjUjGMAeFEawlo8Bm59YkNPRQWbULn
 R4XjAZsEdiNhQ3QudOQZ+qCfndqJOiqmWnOPFdvTR3BbmtPzVCdQ0PhuqzosIWs4qN3JXSmwk7C
 XRjtPHRAS/0UFh+RDsCfaGU2UDpjiNLoYRJ3EOvvwhpbLJzWeJJomflxvmW/CkLm8VGmtDWAPEJ
 0xUPCKxiQpdp9W9TeGXU7accICGiKkqc25+Fk5I2yTYBb+CCmIw+v+mYluQhSdTUOq3GOmjY
X-Proofpoint-ORIG-GUID: 0y1TyZyKNOUdKZc8HzyCie8vTF2RWJPl
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6884fcc7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=fbmvg8OnJgpNs0uOg7cA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 0y1TyZyKNOUdKZc8HzyCie8vTF2RWJPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260140

On Fri, Jul 18, 2025 at 02:51:24PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add colorbar disable operation before reset chontroller, to make sure
> colorbar status is clear in the DP init, so if rmmod the driver and the
> previous colorbar configuration will not affect the next time insmod the
> driver.

In this one and in the next one please fix commit subjects. Can't parse
them.

> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - fix the issue commit ID, suggested by Dmitry Baryshkov.
>   - split into 2 commits, suggested by Dmitry Baryshkov.
>   - add more comments in commit log, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 36daf7542d40..85499f1ace8b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -180,6 +180,8 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	/* int init */
>  	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>  	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> +	/* clr colorbar */
> +	writel(0, dp_dev->base + HIBMC_DP_COLOR_BAR_CTRL);
>  	/* rst */
>  	writel(0, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>  	usleep_range(30, 50);
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

