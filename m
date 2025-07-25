Return-Path: <linux-kernel+bounces-746466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5AFB12705
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E47AC1715
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04D258CE1;
	Fri, 25 Jul 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAd7xqbV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349810FD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484395; cv=none; b=eXhz2l8W1SD3I5QSNVpyX/LIYGBVdyaSvA2Bro95gB1onxH/fptT6bP8PpYV6eZASwooNdk62BCZmL/GS8ckHKh3o/GPmnPRbcLpweRw4Ga9ngpD6cmpw3uTZ/tha84FSYzJSVoiODudvfXEhTrtLZWwsArwdkueBVss9DcrSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484395; c=relaxed/simple;
	bh=N8e1kdafjcd8n8CUehxkPxDQvMbFHTTKeQYYd9Ny/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDM7/yx624m3TTMbcUSlgcL5nxQXJejO5wpxnuszR4spvNCJBjFWLHli3+XN3yGMDAiKKGUlsFmA1hyRimNIiFXM8cjqkY3ZxHqYUOSdoB2yZoZysUEOs6GA5Q6HeOzQAHZ6LeCBnnzVHdmyniuA1wmYQefIXFtipVbk/55NYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAd7xqbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PJIwC5024427
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YIKA470xrZiayxUPdNqdVwH4
	9IURz2Ovf5lBbRciHu0=; b=iAd7xqbV3jp6RDE5Fx3/yt4s3TANlAx+gbRcqWdJ
	2ZuEzjtHfbMvxgU/plgYgmHf9UF9xaDloJChlIOZyQsSL6kljdlyrDwRRmuKl0LK
	xAjr8q/wi35M4fd9C7A9qG2/6pN3f+4WQfrMOYP/YvOAcPNruAeZXoMjGijukDzu
	iz3WtBbeOw/zSoJ2+eZsubfUVApOmXDNdETD55wGVte+/lQHdRDB7Rbjf7zFPp7I
	9dnMATe9MfiTb8BAoWoLYsK7WkCYf7E1VBZkqrkfq/qeV7lEwnfYYhGBY/wt1BLf
	l+n1UWd0MnYHZ9+7x1e3KHJ0eHKzYXctMIU4WqKLFnHjiQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2rbu47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:59:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd5e0bc378so44336666d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753484392; x=1754089192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIKA470xrZiayxUPdNqdVwH49IURz2Ovf5lBbRciHu0=;
        b=mHV2P0Cuf/F7OQ9DoKtdE0lk/FrlIbeo+BpglB6adWkDlpiuyGZw0FJcv51tGqRCG8
         ANtmGjyExmD6j4PGlcvpESZXp2tscivVHJvhHj+RhVZPDGneOvnYyTN950QIDwk0zBRE
         g7mTyxxxzvauzMTsSe8tGGH/dtdDRLNeNkdfJOjYpCVdYQNfnWMfPTy1YU0Z+fgUuHWz
         n8JSNIucesSdTB8q4P+3RBL7WM+PDawq94NzfUxUXRI3XGLDPcmHpR0NlAO2KYf+Q5OT
         NtQ4ZBQZEd8Si3Q/8TVpW0foaydfLhtNAF+1KRIPRvejg5E+RONqvW2t3QZ4BrhoyX7s
         GYQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBU/wNSdruf7igaqzN8nyaayzlNpG7uruFYNCqXbpfmdyVuPcSk2ZIje9rXE2zSU113ZAArMXE5/p6BmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfp+/d/FNuGDf2woy33+DnYQY+5gzPyFGiwCFHbt8oCTk+IspR
	PjwBGmqBKZ61Vtix/gzfQ5HIl6VUtjmmiiIjMXK3lJ0bIx/PSsnxS9JfEq8uRVIpKgIiknFOMVb
	CCAzJ3Tdu+9FrzwkfJDByojw5cnKWGmNwKAjWKibLrHCTrS5Xx3BKDAI8B6Wgkp5JNEk=
X-Gm-Gg: ASbGncs4FhY5PppFZrX3sqnlRYc7JoW+SZL0V75J8m6flbA1nwCGduM4zskHMUPQl6W
	OAMaZbLF/cxD/CiQETZyLTwZGLtHlalC5gx9fDYSFeObOuf/ttL4bUgP5f5xSXsCt4iHrmrq8j+
	Mp88jMRap80h62FBxBbOrJ/G9YyHgFYD/XYQsuUAya8Fnv64trWQdY5xxzDsiXX4GDKSUV7JrKn
	e36TYHVNGnm23rQfwhO7+BcdYshQDs9PsstT5RVVpS7YA/6nFEPPxQMzGGkmaCm08VleWSXm+F1
	W2nSOjtAlwhEOpYNCh+AzpaIelas8umD/9Q3Jh5LIBiSJsTgQzi1RT9nTM5Yq6k66efaxEzaFvd
	6jh5xwuc3r8PwClu2yvR9qZIdbhU8cF9eo0yUg3l/iZB9R5U72S9M
X-Received: by 2002:a05:6214:2021:b0:702:d6e6:aab8 with SMTP id 6a1803df08f44-707205d08fdmr50274526d6.38.1753484391712;
        Fri, 25 Jul 2025 15:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiRRVVhBi4an9ryBUjXC1SCWBg0iBp7Xv7AcbxFmoNVWkRbiK75bGzcC12xTzL/6iwaeU2SQ==
X-Received: by 2002:a05:6214:2021:b0:702:d6e6:aab8 with SMTP id 6a1803df08f44-707205d08fdmr50274156d6.38.1753484391196;
        Fri, 25 Jul 2025 15:59:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63363b6csm165468e87.98.2025.07.25.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 15:59:49 -0700 (PDT)
Date: Sat, 26 Jul 2025 01:59:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com,
        stephen@radxa.com, cristian.ciocaltea@collabora.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh@kernel.org,
        sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v5 02/10] drm/bridge: synopsys: Add DW DPTX Controller
 support library
Message-ID: <bznw5qg3ag7rugqrvoxtqm4njrnxclbohzd64jajhspe6w65w7@ya4wpxpibpli>
References: <20250716100440.816351-1-andyshrk@163.com>
 <20250716100440.816351-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100440.816351-3-andyshrk@163.com>
X-Authority-Analysis: v=2.4 cv=NfTm13D4 c=1 sm=1 tr=0 ts=68840c69 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=r9cyQ1YxkPkt54pAdh4A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 5cBBEBaWA2lFOYiQWJ6PlKfed6j7LHq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5OSBTYWx0ZWRfX+/NfCgVG3QWO
 neK/gPH+Hwj/5oA0LiGydtEsebIsyJaqcUo7q0oaISu7XYx/BXNLhDHEPxUCBKCtR5CjCvlYv+Y
 eWUKgv2l8qhUOkiy9/PYTYubn4rbWCQX3MLHyd/SDLV0nvIxYjVN3wJl3ACopMialQb2QxbZ/oU
 krHI5U2A+BIN6ySEB398cHwytaNBrL+toejsxKSEeNt2JxG4fjySoNYPZbTYRxlkRjIaHDTkHYH
 71d+A+ZUlpcwcMbJtW7oz5GZYqZe8jswwvw08OHcu+RCXnhkwM0NTz+trT+EOsKy1hl1+PyyB2s
 zuI8TR+oNBRhKTkbgFR1GiHhWmwNEwE4lILZNFnq5TyaluhGHu79vLgpih3edXm7+DBxQNxc2ks
 BYD6dM1JHu4GrzjYjC7rD2bZtXf1wvvG7h0A453Bbk7RWmAE38/tnWeoE2X53WzZKetvaF3t
X-Proofpoint-GUID: 5cBBEBaWA2lFOYiQWJ6PlKfed6j7LHq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250199

On Wed, Jul 16, 2025 at 06:04:29PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The DW DP TX Controller is compliant with the DisplayPort Specification
> Version 1.4 with the following features:
> 
> * DisplayPort 1.4a
> * Main Link: 1/2/4 lanes
> * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> * AUX channel 1Mbps
> * Single Stream Transport(SST)
> * Multistream Transport (MST)
> * Type-C support (alternate mode)
> * HDCP 2.2, HDCP 1.3
> * Supports up to 8/10 bits per color component
> * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> * Pixel clock up to 594MHz
> * I2S, SPDIF audio interface
> 
> Add library with common helpers to make it can be shared with
> other SoC.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v5:
> - Use drm_dp_read_sink_count_cap instead of the private implementation.
> 
> Changes in v4:
> - Drop unnecessary header files
> - Switch to devm_drm_bridge_alloc
> 
> Changes in v3:
> - Rebase on drm-misc-next
> - Switch to common helpers to power up/down dp link
> - Only pass parameters to phy that should be set
> 
> Changes in v2:
> - Fix compile error when build as module
> - Add phy init
> - Only use one dw_dp_link_train_set
> - inline dw_dp_phy_update_vs_emph
> - Use dp_sdp
> - Check return value of drm_modeset_lock
> - Merge code in atomic_pre_enable/mode_fixup to atomic_check
> - Return NULL if can't find a supported output format
> - Fix max_link_rate from plat_data
> 
>  drivers/gpu/drm/bridge/synopsys/Kconfig  |    7 +
>  drivers/gpu/drm/bridge/synopsys/Makefile |    1 +
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c  | 2044 ++++++++++++++++++++++
>  include/drm/bridge/dw_dp.h               |   20 +
>  4 files changed, 2072 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
>  create mode 100644 include/drm/bridge/dw_dp.h
> 

> +
> +/*
> + * Limits for the video timing for DP:
> + * 1. the hfp should be 2 pixels aligned;
> + * 2. the minimum hsync should be 9 pixel;
> + * 3. the minimum hbp should be 16 pixel;
> + */
> +static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
> +				     struct drm_bridge_state *bridge_state,
> +				     struct drm_crtc_state *crtc_state,
> +				     struct drm_connector_state *conn_state)
> +{
> +	struct dw_dp *dp = bridge_to_dp(bridge);
> +	struct dw_dp_video *video = &dp->video;
> +	struct drm_display_mode *m = &video->mode;
> +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> +	const struct dw_dp_output_format *fmt;
> +	int min_hbp = 16;
> +	int min_hsync = 9;
> +
> +	fmt = dw_dp_get_output_format(bridge_state->output_bus_cfg.format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	video->video_mapping = fmt->video_mapping;
> +	video->color_format = fmt->color_format;
> +	video->bpc = fmt->bpc;
> +	video->bpp = fmt->bpp;

This unfortunately is a bad part. You are updating your bridge structure
from the atomic_check() callback. There is no guarantee that this state
will be applied immediately. In fact there is no guarantee that this
state needs to be applied at all (the state can be verified w/o
comitting). So, these parts of dw_dp_video should be converted into a
structure containing drm_bridge_state. You will have to update state
allocation accordingly. Then you are safe to touch and change those
fields in .atomic_check() and use them in other atomic_*() callbacks.

> +
> +	if ((adjusted_mode->hsync_start - adjusted_mode->hdisplay) & 0x1) {
> +		adjusted_mode->hsync_start += 1;
> +		dev_warn(dp->dev, "hfp is not 2 pixeel aligned, fixup to aligned hfp\n");
> +	}
> +	if (adjusted_mode->hsync_end - adjusted_mode->hsync_start < min_hsync) {
> +		adjusted_mode->hsync_end = adjusted_mode->hsync_start + min_hsync;
> +		dev_warn(dp->dev, "hsync is too narrow, fixup to min hsync:%d\n", min_hsync);
> +	}
> +	if (adjusted_mode->htotal - adjusted_mode->hsync_end < min_hbp) {
> +		adjusted_mode->htotal = adjusted_mode->hsync_end + min_hbp;
> +		dev_warn(dp->dev, "hbp is too narrow, fixup to min hbp:%d\n", min_hbp);
> +	}
> +
> +	drm_mode_copy(m, adjusted_mode);
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

