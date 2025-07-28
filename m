Return-Path: <linux-kernel+bounces-748290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503AB13F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56D3B0BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D254272815;
	Mon, 28 Jul 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6gBhE+m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D925A32E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717436; cv=none; b=Wv8/JNbX5r8vqhWGgYTC/ftIRzbrT72SxrNTIIYLUGh4aFndlu7xNNIGwhsfvgoXtp1d18GYi1Z+XImOeqoy40TKPrL+B1g3EWBtJMJW/y+e4mOxFksf6YZX01YbDP/2YqRs53gHUgKgwBJexEzjZokxsNkG7DHIqk6JNXKJCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717436; c=relaxed/simple;
	bh=p6jswuQ+V541U00bNC2MfY/rFbL8CPYowUsgW1LTeZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaJk4ncOrMJ90lu/FRNzy4voT1YnVWdOUNSkhtMWueC9YTbfINEf5EPT37H4zsfEx6hVbPEMUZTvqsM9DvRc7fAanuw3BRT5M+XVEgHwzvK2SZCvImd1xlkRgZmJq3IOcIEyTxQtYnofKIdB0BGUTCUO5zZ39tldc+0LduvcBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6gBhE+m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlKhX005041
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vravO/6khNRvhlPxzNQ/FnndOxyVsrk4qImwPP/3MTs=; b=F6gBhE+m6cQWFMBS
	FNPdejfcQVQlLWaI3KZQmslLdIpzC/Gp4sxo3nLGPPnL+RzpeMbm8WFmbyVaumOy
	oEx54W7hUEzCC9aH5hgyko40SF+WlBJieNNXiQ5zTT+HaDv7f6zLdSLqRDo8rJ16
	h+YF1v6YCp51kVWV9IcaQQFIBMxNOtIAoKxLkpzpF28T1yB3KdGq+LnrPGxOzx/Z
	V5nHCmMkZRXJRtpRlaIxdvl/1vuVKtOp937tqTOd/Ybocf78AxMJ1voGCnqu7BSu
	cWg2cFAO+4RfiJVCeL/ljOaJ2UZwiU16cXwUGg5fKWBT67b3Z9KwLJOlwu8CrYNL
	J/SdNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytw912-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:43:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073a52a800so28348976d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717431; x=1754322231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vravO/6khNRvhlPxzNQ/FnndOxyVsrk4qImwPP/3MTs=;
        b=WtlCfv2UDVJXwFznJntPQuVY0dLHyDYlJMZUA1lFXzdcU5Z+C+5qincnLUJOw0Qcrq
         Z4ZksjA2oYHHOQCtKdo462lPdSmO2tec48kO8oExLgg67BkRd3/w19jV3/WMZ5NsVKEr
         GlmfEoQ1fkHW/xttgpv2nMJVChtloCsTriAeONX90LXGwFxCqysH/hlPkpXC8B5+FnLM
         1DGcVHGcgTNnQ/I+RQrRFj2pukFNRwDeB6LIJI4aYWvhoNP5kkKXKcewh/6cndHHXbsZ
         91bbY6Fgv6wjepQODKYtrXhway0OnVWKBM9d4uPwwGhNjYXLa8d0BKEeYcPO7xhQf3nZ
         gLCw==
X-Forwarded-Encrypted: i=1; AJvYcCVEv3z6EkBAa+T8xRJiFLfk6FgPiqMHxvPOxivo5kY5PJhCd8Fbc21/48UytuxAkMcCC5gwFWzpT+un/so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yDglI+erjjf23y93I3fdXDGyw5ohsiXIzB4tkD90ferPk44y
	Oj1Nx7arQSE6BG+ia2unY0uxs7fUU1eJDi4nFTu+6z70iRBRPj+yU6Bm2C37d1Ev/8H0z6fD2s2
	ffIFaeNhfUyuki22Xt5H1EuNhOrPHrQk7shm1DoJYlyUiNzy3WKbeoOf4eOdM4Qmu/a4=
X-Gm-Gg: ASbGnctdOKiR/61JwsL2Rc15Q2PDYAtYqI0H+LjtS9waiyeTzSJfg+qFIJEiMK61LdJ
	F1P21yhrZ7CydZun3lsnUijQ41qcJK2lIYF+91dQPXGle+t1Nl56o2F5eDN4u7Ui7INiDy3g3VK
	CR+7tO/LlgjrHtuWsgmnZj4C2sAM1y63QWLNkLXvXcy2HOA4+B2sHB++8xlpsuyLnBO76XQeoaQ
	wBtZRxM/Qd4whE7J8WbaFNa4GQdIq/XJYOqBrcY70QvVbV6QX8o0GAZtDKa6TjtS7PELPgarZp2
	zafm/WwV5aKhpQGFP0yqp+bONhIFuJO2jGJ37Z1PEby0IEQuLTWj0gzpxjvVuZ6+nFcsCeLz42K
	tAsnYq3qX14TzXfmJUvMBAnkvL9s+dgynLtO5yDqQHU8b/gQfeBIr
X-Received: by 2002:a05:6214:2526:b0:707:49d9:2580 with SMTP id 6a1803df08f44-70749d928acmr45930356d6.32.1753717430547;
        Mon, 28 Jul 2025 08:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9IABiVxzBbfc7hwa3mCRlg2TuSRU6F+DG1TSpnai1vC7ywlpehy/nsTnNAXNFPNLKo10uXQ==
X-Received: by 2002:a05:6214:2526:b0:707:49d9:2580 with SMTP id 6a1803df08f44-70749d928acmr45929666d6.32.1753717429713;
        Mon, 28 Jul 2025 08:43:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316db8bsm1325177e87.5.2025.07.28.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:43:48 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:43:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] drm: sprd: register a DSI bridge and move init
 code to pre_enable
Message-ID: <h555ivhoyfykmw44xch6y3bwlqtewgqks33j4rqw4zkcbdkxih@y4pori4lff6h>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-5-e4344a05eb3d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719-ums9230-drm-v1-5-e4344a05eb3d@abscue.de>
X-Proofpoint-GUID: sjEC5l9qZLTqeRNarUW5X84tcUvc6nSs
X-Proofpoint-ORIG-GUID: sjEC5l9qZLTqeRNarUW5X84tcUvc6nSs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExMiBTYWx0ZWRfX4AZGD3ioBaaz
 e4MKFyVPQXUpFgG8h6hnLEmWJQZX8fNhQYBb8km6HaRSv/4lmwwkG3ejbb0Taf2h4dOPx8Y8jjq
 UDEZmns1lp0FeU35vlTcVtAaBiKgBZA/1vgUBIEw6KEQBH6Q39U0o21AOol0gk8XZWaCd+GByct
 +Dv+afSApZEygr3b7nd3Jy31sIWZaazHJiJNFZUKdS31odbHf8At2LPOHqD2IKMbq4oi9JIJhD4
 VZGA6l+D30l3bLxQkiRZPwk36P7q41deXcpCP5w1oSddVylaRMl6/4RwMkSzMOXgQQH0kpGfhTf
 PyRzyfVxcT+2Ue9xXCrnw1UCYv4Ni45IDv9jPG7OXPKA+vgJus28H+TkOyeh31L4d42USxEtg7x
 waIjCLEA54v3biFbA22LAAOK+UIxRXA29xc7oYhpoHAa28RDCocVLVDKg1k7nLHqloZxkA0b
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=68879aba cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=fR7qSs6sQ28PYmOJ40wA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280112

On Sat, Jul 19, 2025 at 02:09:41PM +0200, Otto Pflüger wrote:
> If a panel needs to send DSI commands during initialization, it sets the
> prepare_prev_first flag, which allows the DSI host to initialize itself
> before the panel's prepare function is called. To support this, the DSI
> host must register a bridge and perform the necessary initialization
> steps in its pre_enable function.
> 
> Implement this for the Unisoc DSI driver by moving the initialization
> code from the encoder callbacks to a bridge and simplify the remaining
> encoder-related code which no longer needs any callbacks.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  drivers/gpu/drm/sprd/Kconfig    |   2 +
>  drivers/gpu/drm/sprd/sprd_dsi.c | 143 +++++++++++++++++++++++++---------------
>  drivers/gpu/drm/sprd/sprd_dsi.h |   4 ++
>  3 files changed, 97 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> index e22b780fe82248296a7153d02269faf8cd63294f..1afcdbf6f0ee3304f2297835241c9bb10d422154 100644
> --- a/drivers/gpu/drm/sprd/Kconfig
> +++ b/drivers/gpu/drm/sprd/Kconfig
> @@ -2,6 +2,8 @@ config DRM_SPRD
>  	tristate "DRM Support for Unisoc SoCs Platform"
>  	depends on ARCH_SPRD || COMPILE_TEST
>  	depends on DRM && OF
> +	select DRM_BRIDGE_CONNECTOR
> +	select DRM_DISPLAY_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
> diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
> index 23b0e1dc547a5023ee6ad7d5e1c49e2cec986bf0..43fff12d73f12619da57606a3c4785924e2c1507 100644
> --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> @@ -11,8 +11,10 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "sprd_drm.h"
>  #include "sprd_dpu.h"
> @@ -778,19 +780,53 @@ static void sprd_dphy_fini(struct dsi_context *ctx)
>  	dsi_reg_up(ctx, PHY_INTERFACE_CTRL, RF_PHY_RESET_N, RF_PHY_RESET_N);
>  }
>  
> -static void sprd_dsi_encoder_mode_set(struct drm_encoder *encoder,
> -				      struct drm_display_mode *mode,
> -				 struct drm_display_mode *adj_mode)
> +static int sprd_dsi_encoder_init(struct sprd_dsi *dsi,
> +				 struct device *dev)
> +{
> +	struct drm_encoder *encoder = &dsi->encoder;
> +	u32 crtc_mask;
> +	int ret;
> +
> +	crtc_mask = drm_of_find_possible_crtcs(dsi->drm, dev->of_node);
> +	if (!crtc_mask) {
> +		drm_err(dsi->drm, "failed to find crtc mask\n");
> +		return -EINVAL;
> +	}
> +
> +	drm_dbg(dsi->drm, "find possible crtcs: 0x%08x\n", crtc_mask);
> +
> +	encoder->possible_crtcs = crtc_mask;
> +	ret = drm_simple_encoder_init(dsi->drm, encoder, DRM_MODE_ENCODER_DSI);

The drm_simple_* components are being deprecated. Please open-code
corresponding functionality.

> +	if (ret) {
> +		drm_err(dsi->drm, "failed to init dsi encoder\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

