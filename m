Return-Path: <linux-kernel+bounces-828023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8F7B93C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501C616DBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3B1A9FB5;
	Tue, 23 Sep 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpq/IUVU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9312BD11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588824; cv=none; b=bncRYOzH1MsTpVgbSsnyznWQBKs52NvBCKHoUtkHXS7arYUS/CoDDOK/RZNgSzANR89U2tIdoZ43edFeP8zlO9slcYXI2CTttvabUeX5zDI8SChU3XSm6hwZipSuQZkW+k/uK9jMN4GXlNJo+GrUwlQcPEbEKg8bBdMt6l8okj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588824; c=relaxed/simple;
	bh=WWWkHOpn3IgGqTtSIOg05sK4Ccj2qE6ABMFEkhUu9uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJR1S/Q5a3J6dV5FEFF67PTQocww5gUSnIc0xSregTU/GsTNNv/2rMycZ4443MUIyrIkSKCCILBkFK4evs49RLql5ETkhS0ZeD933ajdvJAONKlkoHjeNl0fjjSiUg3wcuzck1SAbvoAM8R6dVgut+SXIfc32uOQ5uS6sRxDCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpq/IUVU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MG8VOj008465
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A0ejDteovNx3lutfqEZ0wERW
	05YuCdNkebjmQBOXb0g=; b=gpq/IUVUQeuJL29Sk9CaWGVUYqwfP4WdpIRvhTAF
	DGtqU5bpSnPDIFJ0xfnym2lQvxnN2xaf6HS4MCk/BAZlEb4e6cQf2uwqZ8xncyr+
	Ev716gHbvECMHcvaZ5GcEym/6Bf0aWUReZHV/uFqoHp24zP2AVKXE0whJ0BUFdNh
	vd4pXmThgaDkqgDSSaRLt0SXPiNzAC6UG72qEI6Ip62svVwx8a74Ms3RjL/F1vgT
	XqMzumsgN4BVlfomQ+9OKYNvpUHlDTUtFjkhWZmy/Q9GviB55q73k5Mcoshpbzv0
	rVqX8A/3N3g4mGkvwYN9/K3liaFlCuFiGNgsIrlWHzlMIw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7en7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:53:41 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-795cd25af0aso47525976d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588820; x=1759193620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ejDteovNx3lutfqEZ0wERW05YuCdNkebjmQBOXb0g=;
        b=Mf0XbzcKx6hzJDLxZaIRU7gzqAiIG4TWFQGfG7pcKJBB+9bdEzVJEBidb/jKx5ooIB
         e5+h6Qf9zvfc7LYd8R6IhVqYiCmtBlfPRduUBD9wRRxHmxBheN1a6zyuCUVZON+kZKuU
         yR50IYrRUcGqJr2vesQD7gmAFLIKIJU76DS61vaFKZmbqnMUnI6PhQD5M6lDtiw351Li
         XCp0iQYqpJXIZUtjCAwk2DHxh8/CcOCz6NnK8jvN++Uqeynzjy0eGoO6cARe2lLKuL1Q
         9aYdK60uwqV3oIshNt/APfTQ1ORiETmkh8m1jY7CK2i9bPDU1MQ6jmkihg6Lo7S+TE0h
         UfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMFgdh99PQ271Ua4WYo7MknTmCtQA2jvX6xGjml71zQkuHinLQVuT3/IINC+wp0lpNxPASGTXIj/AT+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9ICgvpZbZdbQJlw6uS8dZIxSIjK1vZQKpihJJa25fFtCwWWB
	e7bgymfyczLNMr/cJVQdy260iRnWKrstTXh0Sl+N8FXOoNqAhsxNkD2s3o0MSUcgsW9mEQMghjN
	ozpj/eBxjavLWrVRMWrk//KBVu9XFn9oI9VRAY1OdvIox0QHJGN6Z5yXzCmyD1NdsZiA=
X-Gm-Gg: ASbGnctQkUvAM4JwtXJqvcJFUTiUBrIKcnlcCpRHS0pB4YccZ87o/UyBqg4sP43BcsY
	Y/4Wpp2j2mRHg/blsrM83dfDqkos/JNHn4KHB7bbvM6lbrZ7734PakHKg8JRvwvIcilzr2dY3dp
	2pbgwgwWfTseeWo3+kgij79nfazn8cZP6n5+BX3P29vAp5Wfb4QF7qhy4Hg4PX6K+Ef6ry6PQD6
	wM29EyQE7UIwuFgJi+Y7SqP08s24eO14CtdJNyY+gSq/qWTaXEBpk41xovVDtzNdCqIToqje56d
	GhiAYB4JjJAJFxkfj+h58l6jXxL8BC13B7btIg3PY2Qv9dSZ7VR1QMzyQ40I6yHCv/Y3MomIpGZ
	SyZpZnBDlcLQ5we49+SfVgRfEavA4StfSlEvxDC9rAwJ5xkPK9W0/
X-Received: by 2002:a05:6214:dac:b0:792:50bd:2fa8 with SMTP id 6a1803df08f44-7e7027cf866mr10593236d6.30.1758588820090;
        Mon, 22 Sep 2025 17:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCVW+jgFymH6ugT8RZ+VX3dkHRF5VrlyFvp+GIT+bYXUiMJUgbOusL9ZRVnMDthCoKsQIBCA==
X-Received: by 2002:a05:6214:dac:b0:792:50bd:2fa8 with SMTP id 6a1803df08f44-7e7027cf866mr10592946d6.30.1758588819402;
        Mon, 22 Sep 2025 17:53:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b7e33b78bsm2160908e87.45.2025.09.22.17.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:53:38 -0700 (PDT)
Date: Tue, 23 Sep 2025 03:53:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Drew Fustini <fustini@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michal Wilczynski <m.wilczynski@samsung.com>,
        Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
Message-ID: <a46szgmjrwgqhv5issuijyvih4tof3xa45tdhxv4qjplekszpz@55tgbkeby7zr>
References: <20250921083446.790374-1-uwu@icenowy.me>
 <20250921083446.790374-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921083446.790374-4-uwu@icenowy.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfXx17XExpqN4qk
 96SAgjV82qhQL9iLBqtoMWups/G/fNiP9EEfOh1mGj9IUr7ea7KDURB/tKqQe8ni5ZAk9DXjASS
 8J55Ls2KgfLXOYRpUbQ4coFbxVywtJbdY2ux2O+rX6LwZanUJfSQVijS6pbLkHqv9bvzEaUZzNk
 O0mzQ18NTNvGZSeRn0jYiOyhsBpwWhAZz4N4aPWhGY6hOedOHvzioX7Q/FQ4NWJFh+wSK5SH3aL
 TLLS1ibKAxIg48NjM3woqLdYd81+HIOBI7ho5JXEucT7O0DUKSqq2hT8p8r0aq2lO4wXSfloGFi
 sc4GE28dJ1WFX6eUTVzv09mENzxLCUpWzY4E7YkGaQuN8V5Zb6LxhxsEVa6arEJP1WEjfdnIQ3j
 2Fx1j+JL
X-Proofpoint-GUID: FVhOfC0f0pvgn4FlNQO9Jb3Xv7M4ujrG
X-Proofpoint-ORIG-GUID: FVhOfC0f0pvgn4FlNQO9Jb3Xv7M4ujrG
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d1ef95 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=UYI74FSAo_19EvzY_j0A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Sun, Sep 21, 2025 at 04:34:41PM +0800, Icenowy Zheng wrote:
> This is a from-scratch driver targeting Verisilicon DC-series display
> controllers, which feature self-identification functionality like their
> GC-series GPUs.
> 
> Only DC8200 is being supported now, and only the main framebuffer is set
> up (as the DRM primary plane). Support for more DC models and more
> features is my further targets.
> 
> As the display controller is delivered to SoC vendors as a whole part,
> this driver does not use component framework and extra bridges inside a
> SoC is expected to be implemented as dedicated bridges (this driver
> properly supports bridge chaining).
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> Changes in v2:
> - Changed some Control flows according to previous reviews.
> - Added missing of_node_put when checking of endpoints for output type.
> - Switched all userspace-visible modeset objects to be managed by drmm
>   instead of devm.
> - Utilize devm_drm_bridge_alloc() in internal bridge.
> - Prevented the usage of simple encoder helpers by passing a NULL funcs pointer.
> - Let devm enable clocks when getting them.
> - Removed explicit `.cache_type = REGCACHE_NONE` in regmap config.
> - Fixed a debug print using a variable before initialization.
> - Fixed a wrong index when using bulk to handle resets.
> - Added missing configuration for DPI format (currently fixed RGB888).
> 
>  drivers/gpu/drm/Kconfig                       |   2 +
>  drivers/gpu/drm/Makefile                      |   1 +
>  drivers/gpu/drm/verisilicon/Kconfig           |  15 +
>  drivers/gpu/drm/verisilicon/Makefile          |   5 +
>  drivers/gpu/drm/verisilicon/vs_bridge.c       | 330 ++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_bridge.h       |  40 +++
>  drivers/gpu/drm/verisilicon/vs_bridge_regs.h  |  54 +++
>  drivers/gpu/drm/verisilicon/vs_crtc.c         | 217 ++++++++++++
>  drivers/gpu/drm/verisilicon/vs_crtc.h         |  29 ++
>  drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |  60 ++++
>  drivers/gpu/drm/verisilicon/vs_dc.c           | 205 +++++++++++
>  drivers/gpu/drm/verisilicon/vs_dc.h           |  39 +++
>  drivers/gpu/drm/verisilicon/vs_dc_top_regs.h  |  27 ++
>  drivers/gpu/drm/verisilicon/vs_drm.c          | 177 ++++++++++
>  drivers/gpu/drm/verisilicon/vs_drm.h          |  29 ++
>  drivers/gpu/drm/verisilicon/vs_hwdb.c         | 150 ++++++++
>  drivers/gpu/drm/verisilicon/vs_hwdb.h         |  29 ++
>  drivers/gpu/drm/verisilicon/vs_plane.c        | 102 ++++++
>  drivers/gpu/drm/verisilicon/vs_plane.h        |  68 ++++
>  .../gpu/drm/verisilicon/vs_primary_plane.c    | 157 +++++++++
>  .../drm/verisilicon/vs_primary_plane_regs.h   |  53 +++
>  21 files changed, 1789 insertions(+)
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_top_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> 
> +
> +static int vs_bridge_atomic_check(struct drm_bridge *bridge,
> +				  struct drm_bridge_state *bridge_state,
> +				  struct drm_crtc_state *crtc_state,
> +				  struct drm_connector_state *conn_state)
> +{
> +	struct vs_bridge *vbridge = drm_bridge_to_vs_bridge(bridge);
> +
> +	if (vbridge->intf == VSDC_OUTPUT_INTERFACE_DP &&
> +	    !vs_bridge_out_dp_fmt_supported(bridge_state->output_bus_cfg.format))
> +		return -EINVAL;

I still think that it's better to have per-interface type bridge funcs
rather than checking for the interface type inside the function.

> +
> +	vbridge->output_bus_fmt = bridge_state->output_bus_cfg.format;
> +
> +	return 0;
> +}
> +
> +
> +	bridge = devm_drm_bridge_alloc(drm_dev->dev, struct vs_bridge, base,
> +				       &vs_bridge_funcs);
> +	if (!bridge)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bridge->crtc = crtc;
> +	bridge->intf = intf;
> +	bridge->next = next;
> +
> +	if (intf == VSDC_OUTPUT_INTERFACE_DPI)
> +		enctype = DRM_MODE_ENCODER_DPI;
> +	else
> +		enctype = DRM_MODE_ENCODER_NONE;

Nit: DRM_MODE_ENCODER_TMDS ?

> +
> +	bridge->enc = drmm_plain_encoder_alloc(drm_dev, NULL, enctype, NULL);
> +	if (IS_ERR(bridge->enc)) {
> +		dev_err(drm_dev->dev,
> +			"Cannot initialize encoder for output %u\n", output);
> +		ret = PTR_ERR(bridge->enc);
> +		return ERR_PTR(ret);
> +	}
> +
> +	bridge->enc->possible_crtcs = drm_crtc_mask(&crtc->base);
> +
> +	ret = drm_bridge_attach(bridge->enc, &bridge->base, NULL,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	if (ret) {
> +		dev_err(drm_dev->dev,
> +			"Cannot attach bridge for output %u\n", output);
> +		return ERR_PTR(ret);
> +	}
> +
> +	bridge->conn = drm_bridge_connector_init(drm_dev, bridge->enc);
> +	if (IS_ERR(bridge->conn)) {
> +		dev_err(drm_dev->dev,
> +			"Cannot create connector for output %u\n", output);
> +		ret = PTR_ERR(bridge->conn);
> +		return ERR_PTR(ret);
> +	}
> +	drm_connector_attach_encoder(bridge->conn, bridge->enc);
> +
> +	return bridge;
> +}

Other than that LGTM.

-- 
With best wishes
Dmitry

