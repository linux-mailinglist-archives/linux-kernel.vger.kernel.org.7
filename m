Return-Path: <linux-kernel+bounces-831142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81AB9BAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC2C427740
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D00265CDD;
	Wed, 24 Sep 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYt3irBd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490341A0BD6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741713; cv=none; b=LqK4hVOT7IoI2fiiI1ktc8Ce7DLSJa9+jkiz9z66u6JajZ6GtPZnerBmiQsOozfic20CLEaQJPm4EZ6PxjlIbFykf/DD/WFH+hbtVec1lSWFF42VmX04mnhg/vkAGgj41gn5gYU1R2+FlQzUzQTcMyxtRlmX6qYc98O/VoIwMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741713; c=relaxed/simple;
	bh=fCDcNvXPeCb6M3hXJIxhsSMcNmiBoWRBaGg9SWvAhEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vee0+QCQX1QGdPKSEkOat+qChNztK6XKSWqt3T+H3gaXFq921bymUsHvU26Y3NNsDEd0WelUmpuX3pKb82HnsDOwx/K5X6XfxfBNa9Gw4uf+8V3XZniwV8TKlsWgZ/ly3vQS9nzOQ1SUsMO+pI8YF050dxF7GqnDuEQqORTVY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYt3irBd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODNUYf029443
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0iu1Wjnwv+f5AYYfHw58qhf/
	bG3HYMyGpWsuOD72KVE=; b=OYt3irBdhpx9aAiIMdbkqDlTw+/XKF7xO+0lhAON
	cEPYRnzCWanMF+8BQc0OnILdjgc9xSUkvQpbkXk+z8XSJ77l131fsYU6AaDvzqtd
	K4XSBQX5yz3mnzO8w9FBT6U0j1end7RQjLG5622rl8qYnGY6qUlMXuYoOQ8sl981
	yltphA8af1Bqh0PoOlEykCKHpJ+8v52Gjb859XYpOaAS0O67NWPIhBpvxDgGSGC3
	ewau2muRbr95q2NycC1Bwu806tZaERN4Ic8ZraY/bGk0sGhzc4Sc5OvJZuEr/Xpa
	P6kbDBGpUeoR+/x2jiBwU4o8BhxZAejcnzf+cy/IRrvW7g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fndpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:21:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d374dd29d1so4948631cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758741710; x=1759346510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iu1Wjnwv+f5AYYfHw58qhf/bG3HYMyGpWsuOD72KVE=;
        b=BHzUlHO8GS2jzRlEdtxdls9g/byR5kCeIWMLZxNzThuSXoNJ3oE5ideDwibQQBovlb
         mF2N/Ht0eZhGGWw71Cdbav/yTkN+tmi2AqwtOjScNLhNKbBxp7p8uMUXZRoZ/I1XOJzQ
         Y+BYun65Mfae32Zwjctzl2gIVcuy0CuWwlgaf9mMXr4phleIbtSuKHzJM87RpM61NOEL
         F7e4Ix1DC1LMxlkBD31hken53/WPXDFEzIKWwP+VsTdYNMHzfdqSwEUIK847pF+dvCWK
         sS7v2vN0VKNrdtTaRRpr1MUdHO5MT8Jao/fD5S0W71A3G9e3WkZCXR4iiSGSk7JWFSlA
         WPBg==
X-Forwarded-Encrypted: i=1; AJvYcCWwvCSWsjZNdt+u71Z+y2W/k049NZmRvP9TUXxb4TjULREmpNis5m796UH84G31gPe5/UxSKRqExT5D0x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1PtvKaibRLtrvizxqerHMcR8RkVm3RInENDS9mPGec5brVZ0
	f1SY4cZdtm1Oi8O8Y0U+GbZnDuvyUiHj5Bmx4vERNq7pvBgcI1vqAkDV40fKDKkgLtKzs0YdVvx
	iGYAx2damm+Q+VVJGwUOFp8y2eA8Hl4QW94MvnQrpnuA/6DAJ/irLsf8Ca2tu5r6Dx8U=
X-Gm-Gg: ASbGnctp9CtT6YJ/NEMTsPb9UsuvjNc2NqYYlsCHBi8Oa83YKWdIf7VOr9AzZVYdsor
	aMd5qA5BkdIdKDV2zx2hgILuEWNjbz13elG1pwp0eFP3MM9Fu7yw1jSa7uyGGQc0yGrvhlg3RoV
	7NLQz40qCqRb0ymSmUQpxKvrhYxWj+4A3yAbhLtlrJ7PvBopAh11xtPAohCkoavGXIKw+nxfm6O
	VYT12EhfScurdDdL+AFP020GyYSBO/86q5xK49rG8cWoeyw40zL1/02MSQWjDjr1EBOJ0pKI9R6
	gG4scdyKaznTA1O2oADZ2sAo/MwyPVs6JStWigFZHrKe8w72xHxXWwkrkv67YKX9jfJVMK+RT5J
	fvwBol2UXNNkVRbuHYcw+d5Huqb4G5VLIQmNUzQsMsSowe+5GySp1
X-Received: by 2002:ac8:7c42:0:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4da4b428df9mr11723641cf.47.1758741709951;
        Wed, 24 Sep 2025 12:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaFsspAyH/V3Y+WNKmm+luXg2sxoUJuUxgT3PD4jQ2JdvLW6f6tdlPbuRxY0RMCgn1FJCFVg==
X-Received: by 2002:ac8:7c42:0:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4da4b428df9mr11723151cf.47.1758741709377;
        Wed, 24 Sep 2025 12:21:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57f477153bdsm2419549e87.29.2025.09.24.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:21:48 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:21:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/msm/dsi: Support dual panel use case with
 single CRTC
Message-ID: <v3tfzspjck2oqppelx7bmi5uflhs47ixw6tjmq2d7inauzfo7k@gxebj3buyuni>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-3-6927284f1098@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dsi-dual-panel-upstream-v3-3-6927284f1098@linaro.org>
X-Proofpoint-ORIG-GUID: lUkI7fwHHPxfpsextB6P2vNjJBvgQsRy
X-Proofpoint-GUID: lUkI7fwHHPxfpsextB6P2vNjJBvgQsRy
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d444cf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8 a=BVByBJJp0cfCRiHu0pEA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX51FAWGUMx2r2
 63xLneUYdfg7DLKNdU0LR4h6H1qk21XfHZ6XY2K0G9bz7prCGYNHU0UyQV7b+IASBJIwcWF8dSV
 UXd5tGQ1JzUs2612ESSTmnb0ssiXJ4qh2WHyWcwclkH4mmkhHpysm/c8BmlSC0Qv/fTmrbcc83/
 BV7eEHzO10fs41ipyvvlQQ6kkXP0Q5HEapZ4hBPK23w4vYkHGvI4kWA5oZNo6oM8J9/sG10jbCD
 ke8/nKW5Ku+7dSBEDdDhzqfreuC077RChN4sZsozQ8PBm954vm5ozziucVgwsf180YufgY3y/tm
 sV0DidU4cROgT7hmwTfyQGf9B0idQJd2aeNnAa5LBrU7alZhhfg/zZHAobsoBHJSINNMBSX1HLw
 Rf+swCrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 11:08:12PM +0800, Jun Nie wrote:
> Support a hardware configuration where two independent DSI panels are
> driven by a single, synchronous CRTC. This configuration uses a bonded
> DSI link to provide a unified vblank for both displays.
> 
> This allows application software to treat the two displays as a single,
> wide framebuffer with a synchronized refresh cycle, simplifying rendering
> logic for side-by-side panel arrangements.

I'd like to understand how is it framed on the overall system design
level. If it's a panel controlled over the DSI interface, it's fine
since we can broadcast commands over two DSI links. What if the panel
(or bridge) is controlled via I2C / SPI?

> 
> At the DSI host level, the frame width for each link must be that of an
> individual panel. The driver therefore halves the CRTC's horizontal
> resolution before configuring the DSI host and any DSC encoders, ensuring
> each panel receives the correct half of the framebuffer.

> 
> While the DSI panel driver should manage two panels togehter.
> 1. During probe, the driver finds the sibling dsi host via device tree
> phandle and register the 2nd panel to get another mipi_dsi_device.
> 2. Set dual_panel flag on both mipi_dsi_device.
> 3. Prepare DSC data per requirement from single panel.
> 4. All DSI commands should be send on every DSI link.
> 5. Handle power supply for 2 panels in one shot, the same is true to
>    brightness.
> 6. From the CRTC's perspective, the two panels appear as one wide display.
>    The driver exposes a DRM mode where the horizontal timings (hdisplay,
>    hsync_start, etc.) are doubled, while the vertical timings remain those
>    of a single panel. Because 2 panels are expected to be mounted in
>    left/right position.
> 
> To maintain synchronization, both DSI links are configured to share a
> single clock source, with the DSI1 controller using the clock provided
> to DSI0 as below.
> 
> &mdss_dsi1 {
>    assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
> 		     <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
>    assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> }
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index de51cb02f267205320c5a94fc4188413e05907e6..1fddcea7f86547258be18a51a0a3e3f96f6c3838 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -177,6 +177,7 @@ struct msm_dsi_host {
>  	bool registered;
>  	bool power_on;
>  	bool enabled;
> +	bool is_dual_panel;
>  	int irq;
>  };
>  
> @@ -935,7 +936,10 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  			return;
>  		}
>  
> -		dsc->pic_width = mode->hdisplay;
> +		if (msm_host->is_dual_panel)
> +			dsc->pic_width = hdisplay;
> +		else
> +			dsc->pic_width = mode->hdisplay;
>  		dsc->pic_height = mode->vdisplay;
>  		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
>  
> @@ -1609,6 +1613,7 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
>  	if (dsi->lanes > msm_host->num_data_lanes)
>  		return -EINVAL;
>  
> +	msm_host->is_dual_panel = dsi->dual_panel;
>  	msm_host->channel = dsi->channel;
>  	msm_host->lanes = dsi->lanes;
>  	msm_host->format = dsi->format;
> @@ -2492,6 +2497,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>  	if (!msm_host->dsc)
>  		return MODE_OK;
>  
> +	if (msm_host->is_dual_panel)
> +		pic_width = mode->hdisplay / 2;
> +
>  	if (pic_width % dsc->slice_width) {
>  		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>  		       pic_width, dsc->slice_width);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

