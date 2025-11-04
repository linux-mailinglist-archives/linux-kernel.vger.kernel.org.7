Return-Path: <linux-kernel+bounces-885318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0AC32913
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC0818C22AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1A345CC6;
	Tue,  4 Nov 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmDVmnRZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC63446CD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279831; cv=none; b=O6pSvBRbqoIEU9aT8HG0Z24mVNNZ1W1QmUuaVu1EXmnbRIfVuMgsyo+3ERv8DFmZLNUes41CJUzmM7C8sjmWkXfQbrrwM7BgOTmQ3IPpn3ylkuJGXjOljQu9aUNU0F58UubF9Jy99GLd69ZbsGfkRecCxhHnyjIDHo8aeXDqxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279831; c=relaxed/simple;
	bh=JYeyE7LbbFjoG+88syiaKUyvUvp80MIbf6YBKHpoLyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQsd5FJXhnO9V8fYA2mdIM31hQ5npWYp559//gzgOh1JE1etAW0utcP1Lx5I9bGRJ8jSEv8B1OgsiuEjdokA20ZZTbhEeunaaEFB97ugKsSFnXojxC0V7dVxB+1NZ/3h2GP989Gp69qemH9HrNCc4WIdcm0FCC76deRkzE5GhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmDVmnRZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755de027eso7476395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279827; x=1762884627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9e8rf9e6LHkBiOZlGLaNm4D4EkbWbTfTmdYI52rOx4=;
        b=JmDVmnRZzurYJYRXTST1g1Es5KlHwZyMKojsQ593+jHT0c0bItxIcdevnmfzDSHLol
         Jhh/4DNjK/nUZlX3/wpcb2uTV3zsUS/QogDyEmrhs2tGBgeXY4xm+L5OtBUSvPy96r6y
         EpweHoIxDG3df2VQEW3pnYh9KZTtC8R+vuEoNIksYMX3Mf6g/tl3XbyjjMM1lRz1GeWo
         GxUTLXSR5if/3jgA4cmEC3cQTKPUmU+okfe4J+Ho5gHolbJjL23knfbOS9x1pTFesa5/
         ow6fab+4DSmqqPhgPGoJhLsB2rcaH9AxsNL0bUXKXbFLUsR46ucf2N/nNLeCuZUMFMmk
         6POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279827; x=1762884627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9e8rf9e6LHkBiOZlGLaNm4D4EkbWbTfTmdYI52rOx4=;
        b=uiAZc7VfW6h8XGV/oxdOMaS6SYXV2cGFcGMc+UMhWUFhjgoxkyey9KV+H546FN/vu9
         HYidTx1RgYh4Eo+WcpRNCPOiHLBEA9X+3l3pVjJoHc/DhOj41RLC2InxGkNVorLq31ZL
         8HiaD+A6QuGc5lyvsCd9Iqul00+Uv2oZzxDie2JpDhaNj+rtCMTvMmT8z5yB1dLqu0zQ
         kWSWJkH2heSNQQszF3ZrH6yux2QZzw1jQZP2BOfo8G8+VboFnneLL44FSS2O3SpsUHa8
         VdMWprqKxqJ8rpg5Iabe9Rm8vCz4J9ifUbTUAtzY/+sgqDAeJR2Kjwzm3LntIMxEVId2
         qUOA==
X-Forwarded-Encrypted: i=1; AJvYcCXZO5zpjwEcU5jFv+IeE1nw7T8Pz2H4nw0d3kAUjOeCqVVt5xCJIg+FcYU4J5wniN6GQA2LJh+KTrKrxts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXJ7uiytwIA3c2xbJD1QG08BBO6KyZWxLUQLOHL2IBdQ2s1vU
	9kmq1kaue5Er7DrQoA3ArcvA+inPg2BtCM+RmLl8aR/YDcK5FEucoJF0
X-Gm-Gg: ASbGncuNoPahKJSsHvcofu43qtY2hsXUDoTqNoihZVsUGWDG1KmwWif+MUksY7i86Ds
	LYEQMMj4q1ku99p52arn8C/DrLorIhrfq9PAK8WXB4l7Ik8jotwJmV2qjHr0AMfLrIJC5YtG1O2
	4eA8FmlX8F8Jby0FAQBMw0iiqGBjVihje/3/6C45Q9fWYVliBwsxs+xsDg8iH7q5GKodrS6voY5
	CabFdQkmN/Yi7akZKrbrL5Wu10F8OJWYHbnfKS7ChnrW1v+U5zJxMOCuCd6KR07zVh6qxDwXmIK
	gqXH4FsXUXuh9dsGyjXCR2F1G/P/Tv58pfYBRhlNDl8zydHWKxBpQf0mcLYDGcIGEVcX6YwUFMk
	QDUZvNDdqSgNtXsOX+C7bm0mEJFCT1RIbLZbCTbysiASTlV+L+SP/BDNM7CaVqm+5bAlg02HW6H
	sFStqddgbcddLDPgcwmA==
X-Google-Smtp-Source: AGHT+IELopkSWYIIl/VfNpl6r5Rq+Y8BoYl0VoNX5IZB/3eyJjkFq08R9m6g4B9BfaHixSE6+v7NTA==
X-Received: by 2002:a05:600c:4f0d:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-4775cdc0ed2mr2735205e9.14.1762279827150;
        Tue, 04 Nov 2025 10:10:27 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:26 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 20/30] drm/sun4i: layers: Make regmap for layers configurable
Date: Tue,  4 Nov 2025 19:09:32 +0100
Message-ID: <20251104180942.61538-21-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Till DE33, there were no reason to decouple registers from mixer.
However, with future new plane driver, this will be necessary.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c     |  7 ++++--
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  1 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  | 12 ++++++----
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  |  1 +
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 16 ++++++-------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 22 ++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |  1 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 31 ++++++++++++-------------
 8 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 18dd998364ae..d2b7fc552a76 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -331,7 +331,9 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		layer = sun8i_vi_layer_init_one(drm, mixer, type, i, plane_cnt);
+		layer = sun8i_vi_layer_init_one(drm, mixer, type,
+						mixer->engine.regs, i,
+						plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
 				"Couldn't initialize overlay plane\n");
@@ -350,7 +352,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		layer = sun8i_ui_layer_init_one(drm, mixer, type, index,
+		layer = sun8i_ui_layer_init_one(drm, mixer, type,
+						mixer->engine.regs, index,
 						plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index b5badfa2c997..2e3689008b50 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -214,6 +214,7 @@ struct sun8i_layer {
 	int			type;
 	int			channel;
 	int			overlay;
+	struct regmap		*regs;
 };
 
 static inline struct sun8i_layer *
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 5167c9d7b9c0..dd6cb09c2c01 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -53,7 +53,7 @@ static void sun8i_ui_layer_update_attributes(struct sun8i_layer *layer,
 	val |= hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	val |= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, layer->overlay), val);
 }
 
@@ -87,10 +87,10 @@ static void sun8i_ui_layer_update_coord(struct sun8i_layer *layer,
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 state->src.x1 >> 16, state->src.y1 >> 16);
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch_base, layer->overlay),
 		     insize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch_base),
 		     insize);
 
@@ -149,13 +149,13 @@ static void sun8i_ui_layer_update_buffer(struct sun8i_layer *layer,
 
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch_base, layer->overlay),
 		     fb->pitches[0]);
 
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &dma_addr);
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, layer->overlay),
 		     lower_32_bits(dma_addr));
 }
@@ -264,6 +264,7 @@ static const uint64_t sun8i_layer_modifiers[] = {
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
+					    struct regmap *regs,
 					    int index,
 					    int plane_cnt)
 {
@@ -278,6 +279,7 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	layer->type = SUN8I_LAYER_TYPE_UI;
 	layer->channel = index;
 	layer->overlay = 0;
+	layer->regs = regs;
 
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index 0613b34d36e0..e0b2cfa02749 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -52,6 +52,7 @@ struct sun8i_layer;
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
+					    struct regmap *regs,
 					    int index,
 					    int plane_cnt);
 #endif /* _SUN8I_UI_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index fcd72c4fd49a..2fc54dc20307 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -143,7 +143,7 @@ void sun8i_ui_scaler_enable(struct sun8i_layer *layer, bool enable)
 	else
 		val = 0;
 
-	regmap_write(mixer->engine.regs, SUN8I_SCALER_GSU_CTRL(base), val);
+	regmap_write(layer->regs, SUN8I_SCALER_GSU_CTRL(base), val);
 }
 
 void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
@@ -168,22 +168,22 @@ void sun8i_ui_scaler_setup(struct sun8i_layer *layer,
 	insize = SUN8I_UI_SCALER_SIZE(src_w, src_h);
 	outsize = SUN8I_UI_SCALER_SIZE(dst_w, dst_h);
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_OUTSIZE(base), outsize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_INSIZE(base), insize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_HSTEP(base), hscale);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_VSTEP(base), vscale);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_HPHASE(base), hphase);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_GSU_VPHASE(base), vphase);
 	offset = sun8i_ui_scaler_coef_index(hscale) *
 			SUN8I_UI_SCALER_COEFF_COUNT;
 	for (i = 0; i < SUN8I_UI_SCALER_COEFF_COUNT; i++)
-		regmap_write(mixer->engine.regs,
+		regmap_write(layer->regs,
 			     SUN8I_SCALER_GSU_HCOEFF(base, i),
 			     lan2coefftab16[offset + i]);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index ce71625fa06f..2290c983e177 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -49,12 +49,12 @@ static void sun8i_vi_layer_update_attributes(struct sun8i_layer *layer,
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
 	} else if (mixer->cfg->vi_num == 1) {
-		regmap_write(mixer->engine.regs,
+		regmap_write(layer->regs,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA(state->alpha >> 8));
 	}
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), val);
 }
 
@@ -112,10 +112,10 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 			 (state->src.x1 >> 16) & ~(format->hsub - 1),
 			 (state->src.y1 >> 16) & ~(format->vsub - 1));
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch_base, layer->overlay),
 		     insize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch_base),
 		     insize);
 
@@ -170,19 +170,19 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 		sun8i_vi_scaler_enable(layer, false);
 	}
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_HDS_Y(ch_base),
 		     SUN8I_MIXER_CHAN_VI_DS_N(hn) |
 		     SUN8I_MIXER_CHAN_VI_DS_M(hm));
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_HDS_UV(ch_base),
 		     SUN8I_MIXER_CHAN_VI_DS_N(hn) |
 		     SUN8I_MIXER_CHAN_VI_DS_M(hm));
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_VDS_Y(ch_base),
 		     SUN8I_MIXER_CHAN_VI_DS_N(vn) |
 		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_VDS_UV(ch_base),
 		     SUN8I_MIXER_CHAN_VI_DS_N(vn) |
 		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
@@ -231,7 +231,7 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
 				 i + 1, fb->pitches[i]);
-		regmap_write(mixer->engine.regs,
+		regmap_write(layer->regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
 							     layer->overlay, i),
 			     fb->pitches[i]);
@@ -239,7 +239,7 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
 				 i + 1, &dma_addr);
 
-		regmap_write(mixer->engine.regs,
+		regmap_write(layer->regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
 								 layer->overlay, i),
 			     lower_32_bits(dma_addr));
@@ -410,6 +410,7 @@ static const uint64_t sun8i_layer_modifiers[] = {
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
+					    struct regmap *regs,
 					    int index,
 					    int plane_cnt)
 {
@@ -427,6 +428,7 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	layer->type = SUN8I_LAYER_TYPE_VI;
 	layer->channel = index;
 	layer->overlay = 0;
+	layer->regs = regs;
 
 	if (mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		formats = sun8i_vi_layer_de3_formats;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index a568e1db1e19..70766d752fa6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -57,6 +57,7 @@ struct sun8i_layer;
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
+					    struct regmap *regs,
 					    int index,
 					    int plane_cnt);
 #endif /* _SUN8I_VI_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index a76677a1649f..0e308feb492a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -911,10 +911,9 @@ static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
 
 void sun8i_vi_scaler_enable(struct sun8i_layer *layer, bool enable)
 {
-	struct sun8i_mixer *mixer = layer->mixer;
 	u32 val, base;
 
-	base = sun8i_vi_scaler_base(mixer, layer->channel);
+	base = sun8i_vi_scaler_base(layer->mixer, layer->channel);
 
 	if (enable)
 		val = SUN8I_SCALER_VSU_CTRL_EN |
@@ -922,7 +921,7 @@ void sun8i_vi_scaler_enable(struct sun8i_layer *layer, bool enable)
 	else
 		val = 0;
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CTRL(base), val);
 }
 
@@ -968,36 +967,36 @@ void sun8i_vi_scaler_setup(struct sun8i_layer *layer,
 		else
 			val = SUN50I_SCALER_VSU_SCALE_MODE_NORMAL;
 
-		regmap_write(mixer->engine.regs,
+		regmap_write(layer->regs,
 			     SUN50I_SCALER_VSU_SCALE_MODE(base), val);
 	}
 
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_OUTSIZE(base), outsize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_YINSIZE(base), insize);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_YHSTEP(base), hscale);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_YVSTEP(base), vscale);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_YHPHASE(base), hphase);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_YVPHASE(base), vphase);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CINSIZE(base),
 		     SUN8I_VI_SCALER_SIZE(src_w / format->hsub,
 					  src_h / format->vsub));
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CHSTEP(base),
 		     hscale / format->hsub);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CVSTEP(base),
 		     vscale / format->vsub);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CHPHASE(base), chphase);
-	regmap_write(mixer->engine.regs,
+	regmap_write(layer->regs,
 		     SUN8I_SCALER_VSU_CVPHASE(base), cvphase);
-	sun8i_vi_scaler_set_coeff(mixer->engine.regs, base,
+	sun8i_vi_scaler_set_coeff(layer->regs, base,
 				  hscale, vscale, format);
 }
-- 
2.51.2


