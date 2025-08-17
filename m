Return-Path: <linux-kernel+bounces-772482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A6B2933F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A94E11EB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69520239567;
	Sun, 17 Aug 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAQpf3JN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBA4AEE2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436694; cv=none; b=fXr1zt/Ni09N0XOaWAzFcTgGkARGaiCiiM5maIqhltQICrgw8BPlR6UcSf2fHXy30mIpdwaKUh3/CLA3vsR/DlJdSnVsiYaIrlMgm0Nr3OkzbbYZtRIln2hHN/blKRZh91CKurIQja2GHg3bkr9VjM5sPZot/3JXXg7ZBDvLdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436694; c=relaxed/simple;
	bh=xzB+x1yx9vQtt1FOL3dGuthW+Hehequ7jNUK/9R4c18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwRP0viHX5yh/AjHEh3WWYP1gwfsTV4rszt+0TcburuypaKf8Zrk7mXhJUgyKebSlRTOHPsegkIt6k+XPq8DLbm5uYJ2wC31E2uCqqvD9rrWmtLCN4FMZqVOjeOzqqgK3LolZxpqRp6galOKELWGy8zAZ1rLvD8fQ1CvmiVpD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAQpf3JN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H8U6jZ013434
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oAGXV53yq54GmVDSezzSfGAI
	LBzENgFTlXwMi7xO3HA=; b=dAQpf3JNk0gzP+d4ayqlqi6GntmH9EceCuJ3Difb
	SC0YrK12HHMwsTwWH78I0I4Y1+QhQXgwM+5HFyTM0xlfD6gSb14aXKZOiog1a4nK
	xktpR4q4zEIUNFloKw2UwLau1Kob2tyEuxnY0nFwU72cfEg4k8uFRpFnzRyCkHvH
	z66pkrv6VLpFjQhMcqxgFLNXvkT7DeKQEoF1BZTMcipi+WAisPAOsdGChsN+u9dD
	5kSd2P04zdiMAAHGaKEyw2eTRGoq8Zl+p2VPF+sU9wzyJ7U6TnD7Z36WbOcqjYlu
	+iO7Na2r07c6ziyfDF1MqbHq27lxsWPgmsPVRfckQrR1qQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfbnabka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:18:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70baf7ecf04so35923226d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755436691; x=1756041491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAGXV53yq54GmVDSezzSfGAILBzENgFTlXwMi7xO3HA=;
        b=KS6aJWI9ygLh4/BW9+zo/kqYZT7uIz1Wl7LRWT4AMusRGRvoYXXGED6DvAf4Pimx7E
         kJZDJYI0M1K8/hHWEJxMFXr9QDO7ZF68l7UuM97zPF2cJkZMXqCF683go/586I1NQzhg
         MrnHvPtapdyEZFa4Jo3g9TmQ0ZgVVhMgIDwRrLJCQN8yC0Zy+73JQHXoI5siy4VOMMNd
         qyTCg5joCFAXejb7Fly7i8AgrgXO7pTf96FzAVhG/dtL+gr41IjkQm6n3y55WhKWTOGu
         S9kcMLdTmonnAUQyfaa5fLbHjhOZlwj9GDQl/EkPML+sD5PP3FTf21R7g6CE25ATh6is
         I9pg==
X-Forwarded-Encrypted: i=1; AJvYcCXdv0Pv2aogSHB+l1r69vhx5XgyYsfMIitIl98snxcw0PkVN7YFu8W0Fns2/ZvxmUiAx1jhcQwGDFICA9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1+6xK23KdSO9BFXT499lqGabNRE9PzK0nBJRNJn2H8pXjMdU
	+IoQT7V8HbrVKdeh9EKvDKWI+/MvaJw4WAcpIqhebmjNmK6tQgFE3JY6rgyi+SjUvwZPeb5/Ba0
	365HYD2kErHyu20qRz3+B7Bpu/1pAajXMSolT5eqylz3TvBQ3X8fmLjQBFO+qY/WvHS0=
X-Gm-Gg: ASbGncsjOM2J8Sh8uR0Xu6fbyJGe8UebAZAZ+uQokpJbHab9bFI5Y3BOzcKFm1MQ3tz
	pQmAv/XVqB6BypJsfMcI3hCaLbTphFnaxveyqMlDc11DzOMfVg7uJLgv0mMc+z5lfz8dudjk5+S
	aK/xB9kgz01kgNqx/UGfUAkH/FIFtRWadw9VylN6kUZcSdFYRMb9HmuUGQ6CEm9P9q0oRK4JEta
	58BsDohQ3Jis2Gxbr6tjVaF4Re6AYjWHZc9VzxYS20Z4v7uoO62uXROydIj34Wsq8GoE8u4huWO
	19yQtWwWuQih2y2gyE2hu0bCBglI646cWAYhyFBCt2km9FR2hhhgjrFn/3PPtlQdr59YhtnZb1q
	Q4UIDCVyvY0Dor3lQieyAwdICZ5tj4cl0Ps5iypVBwxaKQQ04b3kG
X-Received: by 2002:a05:6214:c8b:b0:707:5d28:2b80 with SMTP id 6a1803df08f44-70ba7a5e815mr111699056d6.7.1755436689481;
        Sun, 17 Aug 2025 06:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSDqT3iD33oZdpkHdLqjraNe1W3lPhWgqyY6IdZPo1p3C3OrKZWTpPFVi/pEP+VGhfTMPtw==
X-Received: by 2002:a05:6214:c8b:b0:707:5d28:2b80 with SMTP id 6a1803df08f44-70ba7a5e815mr111696356d6.7.1755436686769;
        Sun, 17 Aug 2025 06:18:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef359970sm1269185e87.40.2025.08.17.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:18:05 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:18:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 11/11] drm/hisilicon/hibmc: moving HDCP cfg
 after the dp reset operation.
Message-ID: <vsnpvyvebdzvythe3q4xj6ks5ionjtnd5jcsjjfbv3ptgdrw46@3ccvex2wqjho>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-12-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-12-shiyongbang@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX3e9G61530rYO
 QsOlabhw07IQe92ZU1Fscz0IfmV/hQM438Q/+GMZfnWrgseyNab3a8XsH6cVIBqq3opzIia3Jtm
 wnK3bzdf1JWjOquSEJGqOD2KdC4AgFVknjz81zctYsNAISwVMf+8jVoZL79upABtiEW1sLVEMQZ
 P++v6TkwXSU0abrIK0rPzD1C2amjTAMN00dQCupQtfwZJYcaw3KfgtvlUOAQHW3SdWRXf6cCuKc
 W+THhP8xIHslzTvDwf7+Z/VBbjdxoJvutTzFcpmCJYvbHUihbVi1z0/MlTxcWWqaUijcMtmhU6R
 2btQd7JIhMqYZtStM1U65kDxQftySGIaDFhATTS43jhcAhJhcYE5KYmM+S7s0wZmEtYnl/YeKG3
 zRe0EYuH
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=68a1d693 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=ETqUBGNnfF6ie6NgWnwA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 3iksJMKohlwxOuiJ3uBsaw_nzLxBXYBo
X-Proofpoint-ORIG-GUID: 3iksJMKohlwxOuiJ3uBsaw_nzLxBXYBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160001

On Wed, Aug 13, 2025 at 05:42:38PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> The DP reset was adding in the former commit, so move HDCP cfg after DP
> controller deresets, so that configuration takes effect.
> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>

This should be squashed into reset commit.

> ---
> ChangeLog:
> v3 -> v4:
>   - fix the commit subject, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - split into 2 commits, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 18beef71d85f..73a0c0156092 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -176,8 +176,6 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	dp_dev->link.cap.lanes = 0x2;
>  	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
>  
> -	/* hdcp data */
> -	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>  	/* int init */
>  	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>  	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> @@ -187,6 +185,8 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	writel(0, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>  	usleep_range(30, 50);
>  	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
> +	/* hdcp data */
> +	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>  	/* clock enable */
>  	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
>  
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

