Return-Path: <linux-kernel+bounces-831694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543EB9D561
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD24A3258
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971712E5B32;
	Thu, 25 Sep 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guejtsj6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BE1400E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772280; cv=none; b=LrzoJuZ/aqlByZcnmdSrmiDBdkl/HO7sWxaMaicdb4HNlogFLZwNCOeBacDOsZL9EpLUqBW4y/IRbim8kJ0SRyRE49XgodddrgJMobdKvmRZdVDSqrCOmaK+LJlU16F2ejTMiVX2eVBqTCl6rHfvcZ5s+J41VoakuFNSUDBD07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772280; c=relaxed/simple;
	bh=Ql6z64ifa+Erc2RWTdrk8fTxf+qd1FJN2jUEYkUNLbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASwocaPZoP/DKGnCaj8bleBAicDY/ROMuLDHeE4uMVH2yPcEXgafQ8VRP0pLxw8E69hZQpy5P9RJLIHxBHS/3X6Dpxxv8cE1IRj0vtWRHvX6yVjozdI6q4Y9M6uhqe3eB0QUg9CqRT0449GGJxEL46HN2HV0jZ23C/JroMioD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guejtsj6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0A3IV016438
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7ozkG9Dgj29nLARaESWRLWoU
	qOVS3oTUDeo1vaR3PAA=; b=guejtsj6wGnbvnj+Jqxc5Jo69+SwHohBs7LVywMM
	fhKOYgETMJZ3G2VzCAUqdVx5tTrSL8LWSjLPgo2xt/BocgI1aUc7fYx8+OnrYobe
	J51QbCvBg2lRL1cMcFjBefvDpXTaTQiccjK8jA7QenBKQ0hjWBdKQIO9oFxaw/ao
	kBGwRsrSxRLzhi5rlMwHLrVmeZ4dajF5qhIb5MVXE4N/5pqE44Kd5cr5G+43Ic5C
	4izFxR5mTKZR510qpVgptH50YHoJGKwoCZVYZTyp4tAY+/NaRKaTWbv2YLC62ju8
	hXSTe3R55uwOfsMS5B2gBKcPZbySpMtueNxXfgs4zPROHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyjf7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:51:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cdcff1c0b1so18139741cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758772276; x=1759377076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ozkG9Dgj29nLARaESWRLWoUqOVS3oTUDeo1vaR3PAA=;
        b=Y+w8+Rtu8LXz19ZQV3vXzvz6x0q+FE8rLnvVa3/2MSZ6G3OBrGUPK/htyDMDdFKPge
         JUwaJuZWzNmtHha5PPKp7p78/YziFE9PJQVWz3S8yED4NbUswrtvFA9DFbLrb/d88P1M
         vjrmk9ixhpphMAA0Y99tZ1eGJRlOJLvHXeXe3VZHQnx+lLw5d+SYaDUmAdOar3tnPwMl
         Jr5R7USZrdZOfDJpW1twM4qmy1wXYG7ZSaDIvl9VEEF7i8mXjl9OJ4+2BGU7zgsRmhp4
         l63h2LI4xhe+IWUqZRIzqgaMAszjvkskmHF0VJ0I20NmFwTF38uOzTPrsE78cww/Ga7K
         uVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtgRY6Rcv1om0fSYj5Pfaz17Vs4W/wijzNM4pkHX6crMMX+8NdyugdCNZ2d0UXddB/9cZpWazd8AF9z2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeioijI4yd8hZgOu+YkOTRnQzy/lcE9JTmABf4svJtC9jl0MSc
	Kd4tUxkRV/Z3cmjuyqrRVtT30vHVMj3kTXr2ARbIbW+Lymn1Mx6IqrTpuGARIgldsV7Ed6vnuKt
	VeChQR1uEUUQMdYuN4lRMcaRiSTApvTdpIL5IfeUyM3JpobfpIBW98LrfHIqHa7WHUAo=
X-Gm-Gg: ASbGncsPnkyxHSdtjTlO4eZdi1Y7lYn55y7n5X1DSBQMtXPeDsBDZn5S7gMa2rsO4Jo
	Dm4xzWqsZ2gje1Iu8a1okjOfcDzfgmQGM7Nc6Tl1DiP/zYSmw12hh8IhVn0Tunlf+2Wsr9JzstQ
	6uaufUN9imelDahJGrILsS7C2wH+VcyVnW50DZA8/yON/q7H2PnQQEu1Lp8gedq620eM8RjkODt
	0OBEtqW/EIEX2cq8lkUuy2CgXIqgYKyo7hJ1vBZAjQDd57UbBiR4qgsYnsico1jIyniyj6jYb2Y
	4+46TUTxl2cs0SIBWgTi7whR6MW4ejJ4T1wdXp7BVX9+IhI5uT4Gm5kB7Cgqexg922NTmSfdghY
	OrSVXxtj5hW/H1IsoOJ+hXWfQ5Bv9Ys4CqLV2QjSGVz1yr5t11vWj
X-Received: by 2002:a05:622a:5e86:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4da48d793bbmr27150231cf.31.1758772275881;
        Wed, 24 Sep 2025 20:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq+gQ2uTMJaYoRjDF3ljF2rKR46SiHC9kfYf2V0HCxEWnaja8OPm5oiSPEIP93udw+G3Cuig==
X-Received: by 2002:a05:622a:5e86:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4da48d793bbmr27150081cf.31.1758772275403;
        Wed, 24 Sep 2025 20:51:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583134312ffsm310355e87.13.2025.09.24.20.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:51:13 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:51:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
Message-ID: <y6idr5f7cqtkls3oqnzaoc5u5zvrqns3xdl2ijyxegxvqgph7r@6hkc5zc6urql>
References: <20250922121902.88664-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3ef2b90a-ff78-413f-b853-99ebea0afc4a@emailsignatures365.codetwo.com>
 <20250922121902.88664-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922121902.88664-3-mike.looijmans@topic.nl>
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d4bc35 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Z6EfDJrRAAAA:8 a=MSl-rjlidl_CnpGKqg0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-GUID: WBIsVCxm1CGOGkhiMzYqtvpZ0HRVEDnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXzF+QVCtVwOd6
 p3JTfCM8neNk/LrKYDGbYBbLlUwVkJgy2NNdAghJh7HUy46SOSa0LvxtMq9JQABGWMkt0zGiNnR
 MYDpy2TKD7kmZRUw8qnqv1gan7BD8Tz7OH4XIYNpyWohQKbDm0EzcorY0fQ/WRguWg6DPQumPYs
 jM+F1LplC0deStMBzHTKvb1x4x91FlxgEKdAOEw68p9u7Peos0vD416r2RO/3G9v/0ac8PolwdA
 szR5hxSJpBQWNCccFlk1JNdrJRJ645jFMU/0URgVGXQ8/Eu+h/EeDvKGyM1bhL/p2bdME64fB/I
 MrGlIMXKnKA0BwC//BinwUWV7FYp+A7st/wJlP81zF238B+qOappOEl7sN+5/p/hwqQULW5DF65
 n5xHLCfD
X-Proofpoint-ORIG-GUID: WBIsVCxm1CGOGkhiMzYqtvpZ0HRVEDnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

On Mon, Sep 22, 2025 at 02:18:45PM +0200, Mike Looijmans wrote:
> The tmds181 and sn65dp159 are "retimers" and hence can be considered
> HDMI-to-HDMI bridges. Typical usage is to convert the output of an
> FPGA into a valid HDMI signal, and it will typically be inserted
> between an encoder and hdmi-connector.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v6:
> Add DRM_DISPLAY_HDMI_HELPER to Kconfig
> Change "ti,mode" to "ti,retimer-mode"
> 
> Changes in v5:
> Really added vcc/vdd regulator support
> "oe" gpio is now "reset" (reversed logic)
> devicetree enums ti,equalizer and ti,mode
> Always disable HDMI_SEL (formerly "dvi-mode")
> 
> Changes in v4:
> dev_err_probe, this_module, of_match_ptr
> Use fallback compatible
> Add vcc-supply and vdd-supply
> 
> Changes in v3:
> Lower-case hex values and use defines for EYESCAN registers
> Remove equalizer code (unlikely to be used)
> Remove attributes (no longer useful, undocumented)
> Fix build for 6.17 kernel
> Use devm_drm_bridge_alloc
> Sort includes and add linux/bitfield.h
> Check chip type and complain on mismatch
> 
> Changes in v2:
> Use atomic_enable/disable
> Use #defines for bit fields in registers
> Allow HDMI 2 compliance
> Filter modes on clock range
> Use cross-over pixel frequency instead of manual overides
> Devicetree bindings according to standards
> 
>  drivers/gpu/drm/bridge/Kconfig      |  12 +
>  drivers/gpu/drm/bridge/Makefile     |   1 +
>  drivers/gpu/drm/bridge/ti-tmds181.c | 427 ++++++++++++++++++++++++++++
>  3 files changed, 440 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ti-tmds181.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b9e0ca85226a..d679180b05b1 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -430,6 +430,18 @@ config DRM_TI_SN65DSI86
>  	help
>  	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
>  
> +config DRM_TI_TMDS181
> +        tristate "TI TMDS181 and SN65DP159 HDMI retimer bridge driver"
> +	depends on OF
> +	select DRM_KMS_HELPER

Do you need it here?

> +	select DRM_DISPLAY_HDMI_HELPER

missing select DRM_DISPLAY_HELPER

> +	select REGMAP_I2C
> +	help
> +	  Enable this to support the TI TMDS181 and SN65DP159 HDMI retimers.
> +	  The SN65DP159 provides output into a cable (source) whereas the
> +	  TMDS181 is meant to forward a cable signal into a PCB (sink). Either
> +	  can be set up as source or sink though.
> +
>  config DRM_TI_TPD12S015
>  	tristate "TI TPD12S015 HDMI level shifter and ESD protection"
>  	depends on OF

-- 
With best wishes
Dmitry

