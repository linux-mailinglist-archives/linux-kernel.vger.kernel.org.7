Return-Path: <linux-kernel+bounces-890498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C885CC4032C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82F614F12D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30661319875;
	Fri,  7 Nov 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+TqKBDb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K6tWOqaB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BB22423A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523525; cv=none; b=hoIzOI8qivfJlvPHbfcdztqcTXIYy6EOnsYAoN4U/vL8C3Uw14f2tNePoqlF85q3pro3ipL3i3VYtcTQCLud6eIi5tHazMEXMlrERllcRDgSa3Sdlu54E1utT2U9ABq9BRXPT6W76o+fCYCnahRLok3L6cYheyMgw4zaL8YDO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523525; c=relaxed/simple;
	bh=vsK0p/F1FtsnUIlMlYy3b6sdTy0h09GjLOEkWzgm6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmdhbrz5L2gpqbR/LOrZ0PdxUojcNXJPAOQojn6hbcXmy3xGz1NrQlP8LiZVTO9jYWH7y6SPAee9aBQ2F/Dio8lcZ1QpHvruAbD8b3Tac3CUlLZo85YTwrSasyXaV6KXWMXlrabRsvi1aBJiPIeNu0bkJ2hxM7O+WJQ4fMZFO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+TqKBDb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K6tWOqaB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A77MKtS629503
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 13:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MCwp2yKgRDbiKLKvcUZpR1sV
	O2SWRlEpJ9zJU9FUvCo=; b=R+TqKBDbKj/6rKVtAZQdBLGkTnvPLUZCeuR4Ggg3
	b+NbL6AD8iBsfw+3bAXkk7G26U8aRHcPOKNRiMGMF/PsE94FWGIb5cLurF87uu+e
	5cWZmulbGSucLrwNCbojlL+f/BUrN7o+PXXL4WU/9/OL5XyUCJMUswYv3Ez2SvK4
	1D2ok9jRm9yvcCgDArgTOR/UMKQSH2WpJ7W8PTcilCSKiHCH0tgoPut8uCY7cBge
	JM99atXVBiAvuJKFBJkcjz5Bm3YceCs3Q1LZ0EoIdVGlLsjLjp/RYRBHbEyUqUv7
	9gIcxOsgSeAOARG2hOp0/+NiBOV47p/GcM2sqlSrb9nDog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a92232sc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:52:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2904e9e0ef9so19085815ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762523519; x=1763128319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCwp2yKgRDbiKLKvcUZpR1sVO2SWRlEpJ9zJU9FUvCo=;
        b=K6tWOqaBsnwpMIf6z1JBNgOTeyNQeG9RsmfEzKY+mO0cLJZmEDE8TDg1eitJhV4ups
         EeB/xPwLVq+GaqlFlAbPwkoDSt7obvQYXeYisctrUcww+3cO6B52G4VUw2vidggvLNY1
         aUmABg1OJ1puhMM+bP67qPsrtH1bWl0q5W+OKfhoVXbUBpiXzLquwQOSrBq7RgYC4g21
         6IvKg5jn6wXEBmwmZ8XbNV28yiUpQ1l1v/22Z3jYJLjasaMGj69DJNvbTnHzpBKJEzEF
         eOB0sAOswWk1In8EOvXZv9EXUxrQQtjyZulVeWL4KHqWsDEENXZag6H3DgKe2i1kh6ZU
         lfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523519; x=1763128319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCwp2yKgRDbiKLKvcUZpR1sVO2SWRlEpJ9zJU9FUvCo=;
        b=ugQ9SBTZ+mWucOmrybYGjGumH7Adi7g3bWdySiedlOxf8l5A2WFETsy4/9BRpYBFxq
         O7uUBIr1STlJBi1RTE7/firtbFeB5Eqcp1FA6Sw/WxVa9fYAFKkJDmYTH6yQqIgEXo7d
         3E0KgRy19Vb20eZMUsxVBFNjCj7/naER5kVWhZMxSn6Er06SMMUWlpNxKOtC/gGIE7cx
         nUQRunDOYcS5wqBnTXZxBmgscX3pWcOMzumiqd6aAGt6vLBv9lbGV4AMb4xGGP/lxWYS
         O5vyLcB4XnQEEhTAwk+4nG5MPYu6WoDDtZo4VkvTjBvim00D8mWtfB3t5GEiPo2N5phM
         sqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuelJ4oLFVUfhfAlnVt/EJ5JCCI8OKImNyVhd+7tNF1xyZbodQLM+b/Hy/nLo+bmp/eHj00UcKD2GaHQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIe9qV7GLWQYcWdiDnBoiTCjU2L54fLHbdLJWoYACrcSkoXx9
	QaPD33NOGEfQgW8h3P5fs7fbputUCOt741PCGH/7pZ6QdVXStDcQXT3FUtkyNds0yy/Nzg1DiSJ
	TwfM5tetmzvyMfoDNnBOjhUFAjd49kpZzGBbpUfIqrbzH7gaH6tZO+C9HCHPPCswhUg==
X-Gm-Gg: ASbGncv1wMYCpJrhz2dvRi9UD0IXW4hPFpr4XSrZrNXbXIWyDPBQgy+a5twVn82v2Jj
	1jAYKB2Xoo8JaiyDHZfRLncTxGVQFtVSPsbbIhJY7ONSYBf+rMHtzZQ7PCk3ODjqOLk1wbkP7qk
	bwiOiH4qqd2RBYgbJv/2OGY6T4AR0aSNBd/7EbxCzcOWZb2ZzZ/3/HXW9RmifyxdzVEKhT7MDiJ
	AXId1X3zOhMuUM8LxqSO3QSiekyujN+TMPUHnn40I9AXqyScdYGOYd0t+6ydKadHz+2QhePiSoG
	rTIu3hEZHRx1xLfimIMd2vjcw8lL5dwTQieVQ9wHiDSAdRqJA2897vCVG4K8Z73oiFpepA3XpbR
	2JRDfa4jMk1sg7fMQiZ7O5wzn
X-Received: by 2002:a17:902:db07:b0:295:39d9:8971 with SMTP id d9443c01a7336-297c03a6069mr56742435ad.1.1762523519066;
        Fri, 07 Nov 2025 05:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3HJZJpW76pJqwIeIsZ2hbm5brwn6HSUBfJ7QroBwBmNe0D+4y6WwifSEuJ1CUZ2VLMgu18w==
X-Received: by 2002:a17:902:db07:b0:295:39d9:8971 with SMTP id d9443c01a7336-297c03a6069mr56741865ad.1.1762523518491;
        Fri, 07 Nov 2025 05:51:58 -0800 (PST)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc6595sm61506885ad.98.2025.11.07.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:51:57 -0800 (PST)
Date: Fri, 7 Nov 2025 19:21:51 +0530
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aQ35d3ehnW6Pi+BT@hu-nlaad-hyd.qualcomm.com>
References: <20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com>
 <n3hycqdiupxhfuswrhckwel5q2qc2a354t5dueoaa3x2bviuza@xgqkkhfmr5o4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n3hycqdiupxhfuswrhckwel5q2qc2a354t5dueoaa3x2bviuza@xgqkkhfmr5o4>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExNCBTYWx0ZWRfX0k9u67dXK7K/
 8X4fsTF4HRg+49DpVvR4126IfVXVIeGmcgbZI+NV533vlEmhgt5ibs4/QylQ0DFJjaos4i/0UmR
 Ja4Lu/b6095w49Uk0gkf0vzJobPAwk2Sex1AiAcs8RBTTH5OFEgf4JQR/tKVIAIyOYGsjNcJ+m8
 GNbK1OMJqYwhebb/feSv9lS4++lY6QUNPFCu70o57B3y7b8YOaqOo+PNBQETIs8FNg9LGPx2Vo/
 pYKwK/IBh7YFRkwWi8MmCOEHDHQB4dRekUSNx4M5hq1zLda2e+OpT4rQPAmILCpkGOiJbyaXlEq
 5Ooh0qxjTh00qM2OCDrvDdE69FQGmrVvnooa36AS/0mvSsvl4waFYAA9MxmiUvIRD/2WbcXNUZH
 gd8RXgmZhvk1vfaKEEfoFkAQKqk5bA==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690df980 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=h0J1ii3O1rLK1nQplmoA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: kMi0iCsHnDatEwohc-TYslPj8Vwu3OsT
X-Proofpoint-ORIG-GUID: kMi0iCsHnDatEwohc-TYslPj8Vwu3OsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070114

On Mon, Sep 15, 2025 at 04:19:57AM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 08:25:27PM +0530, Nilesh Laad wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > 
> > LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > Add support for DSI to LVDS bridge configuration.
> > 
> > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> 
> Please send the driver together with the bindings, in one series.
Addressed in https://lore.kernel.org/lkml/20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com/
> 
> The driver looks pretty similar to the existing LT9211 driver. Please
> explain why you can't extend that one.
LT9211 and LT9211C differ completely in register programming sequences.
Even lontium mentioned that register configuration are different for lt9211 and lt9211c.
Nearly every function would require duplicated logic with if (chip_type) branching,
as register sequence are completely different.
Having both sequences in single file is not looking good, hence want to merge as separate driver.
> 
> > ---
> >  drivers/gpu/drm/bridge/Kconfig           |   13 +
> >  drivers/gpu/drm/bridge/Makefile          |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9211c.c | 1105 ++++++++++++++++++++++++++++++
> >  3 files changed, 1119 insertions(+)
> > 
> > +	const struct reg_sequence lt9211c_tx_ssc_seq[] = {
> > +		{ 0x8234, 0x00 },
> > +		{ 0x856e, 0x10 },
> > +		{ 0x8181, 0x15 },
> > +		{ 0x871e, 0x00 },
> > +		{ 0x8717, 0x02 },
> > +		{ 0x8718, 0x04 },
> > +		{ 0x8719, 0xd4 },
> > +		{ 0x871A, 0x00 },
> > +		{ 0x871B, 0x12 },
> > +		{ 0x871C, 0x00 },
> > +		{ 0x871D, 0x24 },
> > +		{ 0x871F, 0x1c },
> 
> lowercase the hex, please.
> 
> > +		{ 0x8720, 0x00 },
> > +		{ 0x8721, 0x00 },
> > +		{ 0x871e, 0x02 },
> > +	};
> > +
> 
> [...]
> 
> > +
> > +static void lt9211c_atomic_enable(struct drm_bridge *bridge,
> > +				struct drm_atomic_state *state)
> > +{
> > +	struct lt9211c *ctx = bridge_to_lt9211c(bridge);
> > +	const struct drm_bridge_state *bridge_state;
> > +	const struct drm_crtc_state *crtc_state;
> > +	struct drm_connector *connector;
> > +	struct drm_crtc *crtc;
> > +	u32 bus_flags;
> > +	int ret;
> > +
> > +	ret = regulator_enable(ctx->vccio);
> > +	if (ret) {
> > +		dev_err(ctx->dev, "Failed to enable vccio: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	/* Deassert reset */
> > +	gpiod_set_value(ctx->reset_gpio, 1);
> > +	usleep_range(20000, 21000);	/* Very long post-reset delay. */
> > +
> > +	/* Get the LVDS format from the bridge state. */
> > +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> > +	bus_flags = bridge_state->output_bus_cfg.flags;
> > +	ctx->de = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
> > +
> > +	switch (bridge_state->output_bus_cfg.format) {
> > +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> > +		ctx->bpp24 = false;
> > +		ctx->jeida = true;
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> > +		ctx->bpp24 = true;
> > +		ctx->jeida = true;
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> > +		ctx->bpp24 = true;
> > +		ctx->jeida = false;
> > +		break;
> > +	default:
> > +		/*
> > +		 * Some bridges still don't set the correct
> > +		 * LVDS bus format, use SPWG24 default
> > +		 * format until those are fixed.
> > +		 */
> > +		ctx->bpp24 = true;
> > +		ctx->jeida = false;
> > +		dev_warn(ctx->dev,
> > +			 "Unsupported LVDS bus format 0x%04x\n",
> > +			 bridge_state->output_bus_cfg.format);
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * Retrieve the CRTC adjusted mode. This requires a little dance to go
> > +	 * from the bridge to the encoder, to the connector and to the CRTC.
> > +	 */
> > +	connector = drm_atomic_get_new_connector_for_encoder(state,
> > +							     bridge->encoder);
> > +	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> > +	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> > +	drm_mode_copy(&ctx->mode, &crtc_state->adjusted_mode);
> > +
> > +	dev_dbg(ctx->dev, "width=%d,height=%d,clock=%d\n",
> > +			ctx->mode.hdisplay,
> > +			ctx->mode.vdisplay,
> > +			ctx->mode.clock);
> > +
> > +	ret = lt9211c_read_chipid(ctx);
> > +	if (ret)
> > +		return;
> > +
> > +	/* Lt9211c must enable after mipi clock enable */
> > +	queue_delayed_work(ctx->wq, &ctx->lt9211c_dw,
> > +		msecs_to_jiffies(100));
> 
> At this point MIPI clock should be enabled.
> 
Yes, MIPI clock is enabled here but a delay is required for lt9211c to
detect the mipi signals. Added queue_delayed_work() to defer execution
without blocking main thread.
> > +
> > +	dev_dbg(ctx->dev, "LT9211 enabled.\n");
> > +}
> > +
> 
> [...]
> 
> > +
> > +MODULE_DESCRIPTION("Lontium LT9211C DSI/LVDS/DPI bridge driver");
> > +MODULE_LICENSE("GPL");
> 
> Missing MODULE_AUTHOR
> 
> > 
> > ---
> > base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
> > change-id: 20250911-lt9211c-bridge-support-9209f7cc7697
> > prerequisite-message-id: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
> > prerequisite-patch-id: 79524a1aaba6b39f49603db725539cf11176820b
> > 
> > Best regards,
> > --  
> > Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > 
> 
> -- 
> With best wishes
> Dmitry

