Return-Path: <linux-kernel+bounces-815971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D396B56DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB1E3A2B76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A71DF987;
	Mon, 15 Sep 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cdr20FT1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97608288D2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899207; cv=none; b=dQRjO9xzdtnBez/Y1HRRqhTRjPcmzlxBdJtGVLFpDp4jfkxXwKyJe/Wa/hvY2iFCyBKET4xGj1a3XlKlpvI1u4GdvbvE7u2ZgNJCYqoc65IyTc7GJBzuk+3sZVkQ+OCkLFREHatSHn3BVZKbEeSrfJZ5ZsH3oySf/8tzOSd3qA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899207; c=relaxed/simple;
	bh=27ZG4agrMrG7nXm1CTlmx9zRVzABV9MF1oTTosQrwMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpe0dcOuiNOVX3qxkov5BgC+8r20EbPNX/mL8zGYLQV7Vt/57qj/8fabg8EHZYDneRuE82s8qZWGoJFcOuJ9TMA+O8/DDhJ+3L7SZPyFDJPFH0ZVtHkqgoTqoyGq/GiyQTcJ5cN/DaKx1yWhsztnU9pgaqKDeHAsdxBVBt1mLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cdr20FT1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ELcErS005251
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kC3dy0Ydy9pej0oh1AKYYFVt
	Xx1bBtEXYrmcDESrP0Y=; b=Cdr20FT198HdV3ipeZN72jm9E37fw/UB0p2aVu0Z
	G1VH7b8q1/BiNY48XCEl1NlnpeCDYrEcbgjjGiohjRRdzuidl7QsyPa/JkrJ4Gcm
	cA3vCvL+65XBj9cuTkJbmW3ix/G2wUBiDoot0bM5Iwd0loigNq2T+j0jbXTWugD+
	pm6vTEhWLQkAr4FsFglqaxyIBJcKf+Rbo0bNwNcO3YUVgZc6VSF7fV7ZpG/4Z+4B
	VWdHb33bWSgCBBf0BxXhb8MGRx3zrzeK42UbZhq6+kklNCMPbhWRCf5ZYUJ+KcHH
	WNTCZem0Q9pn50eNDzSYLQCWDIye6LotDqXc6oSfzpHdMQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma33cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:20:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e178be7eso111482161cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899203; x=1758504003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC3dy0Ydy9pej0oh1AKYYFVtXx1bBtEXYrmcDESrP0Y=;
        b=r57OGTEciIzq0pXG4ROmtD4F58XEeSPoCA8CO7lEnScSBB4bXdAB8NvuNxobGpX3gR
         aPIjGTittYXVJ6Aegmg0/Civ02j+QdMVNWFuj+O+0bbAR1g2FEy2tGhvorLfv8vCayp1
         nDBe/P25Xcr0mdQ0EQ50wISoaSrmmKrYggRS+EatbLOHfSWmNJzC/cc+6O2DJAAIBL04
         ZNvLedT1bEt9Xy8G0yeyCJqbf2rsoPB5PDZ+QsKH7yGlMpvyfIsKj3uISwovOmy/eHHs
         Ca8ScK6n5GPjnQE1wcdg/WbU07ksVR0BScotHBXmjFV/L3XGc7ALpls77v1F+8OiIVax
         J/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWRXwj67F1BD8VF8FxOkrAlw8xe7uxqA4k8vEsOsWVgnEYM0zyzQol3Qtt5HFzbb9uol3PjjQCHPq051GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByn1gSPWypEYs9yk6qhrxwvt3AMFAtQ5HdQxlkWDBR3RDfuxO
	6+ruifzd1oG5a3pVibY5w0HXiBU0p7++RawAaL29r0wuuFBNXejICEyBw15EhKq0BXBryU7Ovij
	G0ll81DksyhmAPPAfv1p8WwVNRk8NVKu8uX5GAR3iGi3DcP3Ab88gd1VCjSoJ2Mfqojc=
X-Gm-Gg: ASbGncvQV/3ZuoKuLWVke5RQAdbF1bnJWQbFm+FrdEoIZ1sUgRag9VJTYkEmbAfblAJ
	DwCR643Y1ODs/wPBBkja2KdAuvKoYUcdV5basf4NZyPg+1+EHEo3HB4xWBzupb0gZFPzPILCaNp
	NWjxN/0cz1l7ozKXrqrERKaw+9abpJ1LEhEQ5QaRaIX7asmXDsF2H9SXjaZpSUioWiDcGuNDFDF
	OLAI7rH1eUCTBm2NDNnw8v2IFqrq5oAH+Bxl9bwlJZRhxK1tuVQJqe760duVcds1CoU2c7bhAbq
	dHQnq4yrgxFRCQIG31FhQ6pp88qKe+QwWKgXKRHO/3Mek8MydQbPt0ahGXygplQxd64RDqmrncS
	BC8LMG3D37mT8ame2rbHAg5NzXxIdz7j0+PrPNP4oo6vesfgp6klu
X-Received: by 2002:a05:622a:82:b0:4b7:9a33:20a7 with SMTP id d75a77b69052e-4b79a3328e6mr57012811cf.44.1757899203093;
        Sun, 14 Sep 2025 18:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9CZYfSYW+TABFs6uglKtc4u48qpkkdh2gPDe08pCBH50zFvLoZZq/5tHLa55VxlaT2BybHQ==
X-Received: by 2002:a05:622a:82:b0:4b7:9a33:20a7 with SMTP id d75a77b69052e-4b79a3328e6mr57012481cf.44.1757899202573;
        Sun, 14 Sep 2025 18:20:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211d6sm25824891fa.43.2025.09.14.18.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:20:00 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:19:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <n3hycqdiupxhfuswrhckwel5q2qc2a354t5dueoaa3x2bviuza@xgqkkhfmr5o4>
References: <20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX6GkkZ0/iyfgc
 2pJPjsKcL8DkjjwSifqU8JA5kiH4c8utG9ap1cA/sckoUqPlMOEB6OXy/IyACarqmWXB/1WuK4I
 EaQPyj/+sF+8Rdm/MgtsP1o+ERW5bdhMT9oxpT2ewntYO/Ag5vxSQGPixRzGzdj45FK6xx4srY9
 QzhBoUoxl4w205SXuI00tnVlaBead62LIL7dk8MA1lA+iV87dFGG8GdiZM1mWtA61zz3P2F1N0x
 CgwZy5tWQ/7xCziTBDRrnzrtMM9TGLQibdGs6bK3Xzp8c0eCqCHtZU+hJ+27gx6DHBrUd/BcWBD
 YZRosIaGtaC9qaAb46jYFmb1OLM6799/BcEjpNGqK0jRxOlHeTyEPtxbrFSkpUURaqJh4KIwo8F
 ClVeclb/
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c769c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QKdoYT3tgUPYWJkqUfMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: v-C-mT3wXWyliOhtqHVHdco7LSApxluq
X-Proofpoint-GUID: v-C-mT3wXWyliOhtqHVHdco7LSApxluq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Thu, Sep 11, 2025 at 08:25:27PM +0530, Nilesh Laad wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
> 
> LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
> Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> Add support for DSI to LVDS bridge configuration.
> 
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>

Please send the driver together with the bindings, in one series.

The driver looks pretty similar to the existing LT9211 driver. Please
explain why you can't extend that one.

> ---
>  drivers/gpu/drm/bridge/Kconfig           |   13 +
>  drivers/gpu/drm/bridge/Makefile          |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9211c.c | 1105 ++++++++++++++++++++++++++++++
>  3 files changed, 1119 insertions(+)
> 
> +	const struct reg_sequence lt9211c_tx_ssc_seq[] = {
> +		{ 0x8234, 0x00 },
> +		{ 0x856e, 0x10 },
> +		{ 0x8181, 0x15 },
> +		{ 0x871e, 0x00 },
> +		{ 0x8717, 0x02 },
> +		{ 0x8718, 0x04 },
> +		{ 0x8719, 0xd4 },
> +		{ 0x871A, 0x00 },
> +		{ 0x871B, 0x12 },
> +		{ 0x871C, 0x00 },
> +		{ 0x871D, 0x24 },
> +		{ 0x871F, 0x1c },

lowercase the hex, please.

> +		{ 0x8720, 0x00 },
> +		{ 0x8721, 0x00 },
> +		{ 0x871e, 0x02 },
> +	};
> +

[...]

> +
> +static void lt9211c_atomic_enable(struct drm_bridge *bridge,
> +				struct drm_atomic_state *state)
> +{
> +	struct lt9211c *ctx = bridge_to_lt9211c(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	const struct drm_crtc_state *crtc_state;
> +	struct drm_connector *connector;
> +	struct drm_crtc *crtc;
> +	u32 bus_flags;
> +	int ret;
> +
> +	ret = regulator_enable(ctx->vccio);
> +	if (ret) {
> +		dev_err(ctx->dev, "Failed to enable vccio: %d\n", ret);
> +		return;
> +	}
> +
> +	/* Deassert reset */
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	usleep_range(20000, 21000);	/* Very long post-reset delay. */
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +	bus_flags = bridge_state->output_bus_cfg.flags;
> +	ctx->de = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +		ctx->bpp24 = false;
> +		ctx->jeida = true;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		ctx->bpp24 = true;
> +		ctx->jeida = true;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		ctx->bpp24 = true;
> +		ctx->jeida = false;
> +		break;
> +	default:
> +		/*
> +		 * Some bridges still don't set the correct
> +		 * LVDS bus format, use SPWG24 default
> +		 * format until those are fixed.
> +		 */
> +		ctx->bpp24 = true;
> +		ctx->jeida = false;
> +		dev_warn(ctx->dev,
> +			 "Unsupported LVDS bus format 0x%04x\n",
> +			 bridge_state->output_bus_cfg.format);
> +		break;
> +	}
> +
> +	/*
> +	 * Retrieve the CRTC adjusted mode. This requires a little dance to go
> +	 * from the bridge to the encoder, to the connector and to the CRTC.
> +	 */
> +	connector = drm_atomic_get_new_connector_for_encoder(state,
> +							     bridge->encoder);
> +	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> +	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	drm_mode_copy(&ctx->mode, &crtc_state->adjusted_mode);
> +
> +	dev_dbg(ctx->dev, "width=%d,height=%d,clock=%d\n",
> +			ctx->mode.hdisplay,
> +			ctx->mode.vdisplay,
> +			ctx->mode.clock);
> +
> +	ret = lt9211c_read_chipid(ctx);
> +	if (ret)
> +		return;
> +
> +	/* Lt9211c must enable after mipi clock enable */
> +	queue_delayed_work(ctx->wq, &ctx->lt9211c_dw,
> +		msecs_to_jiffies(100));

At this point MIPI clock should be enabled.

> +
> +	dev_dbg(ctx->dev, "LT9211 enabled.\n");
> +}
> +

[...]

> +
> +MODULE_DESCRIPTION("Lontium LT9211C DSI/LVDS/DPI bridge driver");
> +MODULE_LICENSE("GPL");

Missing MODULE_AUTHOR

> 
> ---
> base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
> change-id: 20250911-lt9211c-bridge-support-9209f7cc7697
> prerequisite-message-id: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
> prerequisite-patch-id: 79524a1aaba6b39f49603db725539cf11176820b
> 
> Best regards,
> --  
> Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

