Return-Path: <linux-kernel+bounces-746537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C747B127DF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CE84E81B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0FE53BE;
	Sat, 26 Jul 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkcdKEWc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E47E9
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488779; cv=none; b=s+5cWbdeQirvJXXhGq1x5P6ueF5P0DOQec+JZHtk2vtGPR21xRkqHiXKnQHNIYVfcttT18Ep3zK5Y3N/duBnsyH57DQQTq/ikknT/F+CwMkl7GYixT+Htxl+94JhPZyonz26idH8TQgGz6a/f+Ld3eCgKlQ7pVR9i8lSe8KhVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488779; c=relaxed/simple;
	bh=EPGGGTD7cN5q6eseR9hSqcJxHvinkh0G4fVaE4dqQI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B72vWpFso7ExC1e3UjfNBTGu862Q6+bIw36Fu5qbbHjMxwwLgqjZIsIRPsRWOGpvgIWJV/mvdUA7H4hpJWfHEPpxUkO6B17ML6L7XaXhqCLn0APH7Lk1Q+kfNg35Zj6ifRcEjc5ABCkNJ70pbF/Gh/KxVhckuUOqzA2ecU04OFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkcdKEWc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PJFwiL018836
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DoBs6OVTwFF+JmRKLxgaU515
	KdcbQmUXJDbYvNv8Tsk=; b=AkcdKEWch4hN0ZdD5TgDOmbaOcmN27fIS/ZlHbWe
	3ULXqdAcgmVi41jdu/XZjfaiA3D7okA2KiiMsqLdEVWadDDOTywEvW0cb9vaNYcH
	BZte5R7/RAjP9G30k/XrAEZQoSPGAzuoI1m7cBtt+qwTY0JWPGJSJOIr6Cq+GyFo
	NFbF/T6c/D7WKznCMg8bU3AWiToqyIHXEdleQLztsN9ljT5ZMoeIebuFk4agoqoI
	cSCm9nKK3HTqFL/9Vh/zr3Th+7Z94MSdGtRntAg4M8H66eC/jQzOk0nZrKgO6EOP
	wXNcFxn88yKgJLj8/B3MvF9G6u1enWDcHWWnp4BGwfzSeg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2s3rbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:12:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad2a25b65so50101536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488774; x=1754093574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoBs6OVTwFF+JmRKLxgaU515KdcbQmUXJDbYvNv8Tsk=;
        b=K7M13wHEZn1RIn1YwjgnT+YfnT1/WvrEM4WHoVbc5jkARV1sC5ACDyzHU4ljn6M64a
         jJgGZVcFN8tL50Z/S50VCgEcC7qfuq8YpI5wdzc3ka/zmt8UH/ZHpvn1xUgmByKRwYjX
         hYpXpSogaJkO0H06d2BuvCw6oNrbqsFJnFRkOjrg98tj3+lGTZ3H/fOw15SotdqxSXme
         tCeQtdAoD/OxbnLFHwILWyoe+U8IkmLs+KqRe1H12/TgzWCyfG0GeioQY7E6uufMp2al
         axqyvXjvSahj2d68digQY+FQOCbJLMIu600d/lPUi0Wz9ZIWTjLZpTx4YFS9ja+NRypd
         ClYg==
X-Forwarded-Encrypted: i=1; AJvYcCVxEcmSbzsi5mvHoNJpTPhlCxkf3xl5stZ4EKqKcP0s6x0Rsy79iZS/otPW8j9RwCqGEcl1tzx3K60A/+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeDAt+0xgtq8xoq5pntHH1NJxqQXeZtRm6VnXiq7C8v2MYSqI
	zmB2kHZlKlyELcmmD84huL0Zk0+kq0pSff5UMarb2xngJtXyl2MdziWGh9e23Q2CEXNCjut87y2
	kekxF174YoOEEQJGbDWjya/rHDv7WUk7G451wxywlT2gscxKit4mkt4OPo5vXsIPCkSohD1UaVa
	Q=
X-Gm-Gg: ASbGncvdVYjTZbcKIffCuy4EciP7TAV6rOBKIU0GruTG0OVKr5lol3PljajJl5BJzSq
	Y9+z8yUY9sckmhZIYGfqgf/YxGLePzvdqASB/fATpYDh8qZKjgS66P1byV9pwXz4/HhLbgvBfHR
	lbfd2XQ7UpHv50dLfL/cY8Exc4uzdwLAd32mm9fqznAPgNVYsaXlzWXV8HXFoU+Dl4ji+xUpejM
	XzoMC/MwDZtWfXY0AJaws/Y7ZekWGKdoWGY5k6oS7IPhF3XrNciH/yHrYj1oqpXDvKT4HN+E39e
	S60/TFxUXDUYbK300gZ7bEVkNWNin12zl7Q01YW0GULVizlbDGk0cUcjLemwfsEvNFgUsd8Qjwl
	e89noQfa7Nxg/E+3wVs+5NmA7YrbHh5Lvd6WCJgZg3K+wstU9uOr9
X-Received: by 2002:a05:6214:e4a:b0:706:ffcd:d3ef with SMTP id 6a1803df08f44-707204d91f1mr65699786d6.11.1753488774211;
        Fri, 25 Jul 2025 17:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbddedN9+X5RQ+51/olzP++4eSaSJsPJ6FulQapEa8W/10AV19KAs7kk0J58zSr+jFJwBgmQ==
X-Received: by 2002:a05:6214:e4a:b0:706:ffcd:d3ef with SMTP id 6a1803df08f44-707204d91f1mr65699336d6.11.1753488773736;
        Fri, 25 Jul 2025 17:12:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633760e6sm186357e87.160.2025.07.25.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:12:51 -0700 (PDT)
Date: Sat, 26 Jul 2025 03:12:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 03/14] drm/rockchip: analogix_dp: Apply
 drmm_encoder_init() instead of drm_simple_encoder_init()
Message-ID: <6psjcrhbnk7czdrdtxh65kr6qvygkwogvert75dg2svbm2cqd3@uhffyfdxqpec>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-4-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-4-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: PaqRmOWlPQMrcTtRPQRp7iG8blf1dfM6
X-Authority-Analysis: v=2.4 cv=IZyHWXqa c=1 sm=1 tr=0 ts=68841d87 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=HslhmZ87janovOCoqE8A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: PaqRmOWlPQMrcTtRPQRp7iG8blf1dfM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwOCBTYWx0ZWRfX9hN27rUm/xre
 DBOHwxw8nmptuwOLWNEsTUn6n5GgsnuacfZG4TN1jn12uE6PP7ECmfWqQ2yGMzkbxQmogR1Sr7B
 5vb8XRX+xb1XScrc+K1RuU+dds1p2gxsoVnJf2H8DJcG03V3kSNbI5/tjb4Rsrl3TdHTYu/SKhs
 jWgC2IHtn+wj2frAMt+3aM8IhNg96qcgC0zXmnTztzMg9jP1MxQZ8DkXsm13/7xnPaCix9kZBL/
 NGH3HE0WqxD7PUqr5s+IJ8Zk1GZ62+OB/GUQbybnmWeLzWQ0g9EAzx4DNGuJDT8BbI2ZAzoB95S
 PdtsZatiZcn464d/Q8zkMkTGYKZcDG0/wNKo97sU522Vm4Qzl1a6ZwAUbW7hM00En4+Z5V/upJJ
 KfA3EwaEs/PLUYOO5xFvhbCn/Qb5PY5gZFK3PTaRnKwZ5N8mQtMxJsLrOYNPIOs/JY3nYnf/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 mlxlogscore=701 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250208

On Thu, Jul 24, 2025 at 04:02:53PM +0800, Damon Ding wrote:
> Compared with drm_simple_encoder_init(), drmm_encoder_init() can handle
> the cleanup automatically through registering drm_encoder_cleanup() with
> drmm_add_action().
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index d30f0983a53a..4ed6bf9e5377 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -29,7 +29,6 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "rockchip_drm_drv.h"
>  
> @@ -377,8 +376,7 @@ static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
>  							     dev->of_node);
>  	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
>  
> -	ret = drm_simple_encoder_init(drm_dev, encoder,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret = drmm_encoder_init(drm_dev, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);

It's not possible to use drmm_encoder_init() here. Per the documentation
the encoder data structure should be allocated by drmm_kzalloc().
However this drm_encoder is a part of struct rockchip_dp_device. It's
allocated by rockchip_dp_probe() via devm_kzalloc(). This means that it
can potentially be freed before the drm device is completely released,
creating a use-after-free error.

>  	if (ret) {
>  		DRM_ERROR("failed to initialize encoder with drm\n");
>  		return ret;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

