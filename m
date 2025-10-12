Return-Path: <linux-kernel+bounces-849710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53957BD0B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D27E3AFFBD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9F2FBDE9;
	Sun, 12 Oct 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwELOPZd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE362FB09A
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297050; cv=none; b=uOn452aTzeh92J8rNMju+7Gp4w33G7PABIBlQcsCe5Cjk1edsEsI8GOZEeR1E16qf6mOwZkSQ2LDCiWx0hlB13DGB1A2G4tL9txZtN6+RZLxTNfSpvriQkpNKwLv/iwj2loKsM1rBW/UqLda6hc9iC8xNyh7j7eokgaoULPe1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297050; c=relaxed/simple;
	bh=Ehh2XCdHpQvY/7YPtG6yogz1Wzyl7YtVdL/DWzi9Nzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M29cFG/Svz7Kwd6Y6Uqc7P/m7KtfMD2mHFsIKtRXzIwI3FjIjJMTcK6oL2xj4HU1aPtfZKM4K0edxRK3f2FoKipcD+DerDci7xjokFqPqGVKNXaZXwQaESiuwBtkXdlU9XiMxnTlex3FNPlHRyz1dg7cajQH1d2oyIkzhMz+s64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwELOPZd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78ead12so546196366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297044; x=1760901844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDedyHXZRi05h+yiSLUF3HPKeqGWy/zcBT6LVM4ULn4=;
        b=hwELOPZdul3axiy5+A08zWmgD1J45oZb9jLyotMFZGfjCdVVk6Yyz2Be8FqauFy7Lf
         znlEjPkp6I40Dlt4iGDZ01ADhjnoYRZOAcQpvThenrwstR9BXohI0/L/+vv7BgMBRLXU
         PrT5AlJxeXyp1Bs7UZXc/Ri7SyPR7khvQWVJaiffniSCBefYCC/VFGv0IMMy5c94Sh6H
         VjTXdK6iyLgnPDlHgVSkRaumoEtQc17BQeggx8PJ1klkJcnKnyRfY/p/UofPbwLaIBWf
         o9teyW24iVL2LM7PkSNTzyZfA6ZfNtOE0bYS0XS1+19TWhaw3swsIeMUvKPXRL7eRnIa
         yfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297044; x=1760901844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDedyHXZRi05h+yiSLUF3HPKeqGWy/zcBT6LVM4ULn4=;
        b=Hn4v2x60Y4iVxhtXl/HMyis6pGNfoXnYijFmIJOAVyNf99IFS9suv64a9GUeKcUKzx
         YvEoH/CcKMGF5ugnUSJff1xOtFzjN7dTuXbbsQDn90lhajZrZ+cx4bsvJZTrgf0IX5C6
         XlWwlOdxnPzazJoFOOUWHED/T0BbTYQPjc3pQkic8cbZGF6pWwv49/jSHucwTbE0qtcL
         7Z9KYpRYvq7bTWO5iXYSNqg6U9qJt8MBaWcZMKY7wRzQZIRZKE8iWpSAVyLqSXWRar1V
         ohgUrq5KzJarBLPoKVuyVGBNksb52fw7QmqSZ/vFllHMtPyZrEAagHMzQERb6Eozur5s
         jkXA==
X-Forwarded-Encrypted: i=1; AJvYcCVWlhIs73XGN8h+mmw9Hbdzh+Vd4fPMnQg3Yf3aaTK5zqYpJQ2EfXtU+Bv5qbMMDlvMmsT15F9QMBRg98Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VDl6MGc2eBO1EofPZdHwnYMobuwhRlmbDfauwgoTjWr8tKMY
	Ic/6wmObvXY0KtnZBdIAABQUSpDbwjKVjNvaCaFmIjSGBU+WPvDACze/
X-Gm-Gg: ASbGncuR2xqOPAPewLI8fdYLC8GNV4VbFcE+BVTT8hHgMekuUeWLot/zLZfdJyMkZ5U
	59pvt44+L0bwQ8xBIHu2uq5XwgwlyyrqAEyftXRc8WGHp1qBSyVCEuQmdIF3SMR4OoC/QPAYzKB
	rxNAW2uQJ4u1MFTJY40NJutNtdE+ho9RrW4V1PdFTkMn3dTf2tMjlaMTGjWalLPFFOuXcgyxpL+
	E8eAOT0eFhLF9jFHwF2nQQy41DAiCxjOOvN/7T+ZA/soidYWRudGwNQLPKnqtHgPg5EATfgC+pw
	lGGs1020qA28nZTeWZBwJ2PxR5M107ajJySe+WRVX4doPeAaZCmeKjkdGNtOJH5GpnskwNiEJGj
	k+X7kCS3hobz5wuAvt6ggBZZNipjFxgRaosPpaWnxAQ/mNYQt2gl9OLSfq6C8k6Islx5P6e3Hgb
	W85fgCYLdPt/ql183rLYJQJpJjgfyyi7A=
X-Google-Smtp-Source: AGHT+IExRv+GMaQElZOiBYi8D06q1t4JtHvZ0OQ67C2+WOBYzOxOgvcGPMSugeMHawmkzgGhW4vqWA==
X-Received: by 2002:a17:907:3e16:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b50ac1d014dmr2008689366b.33.1760297043846;
        Sun, 12 Oct 2025 12:24:03 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:03 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 20/30] drm/sun4i: layers: Make regmap for layers configurable
Date: Sun, 12 Oct 2025 21:23:20 +0200
Message-ID: <20251012192330.6903-21-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Till DE33, there were no reason to decouple registers from mixer.
However, with future new plane driver, this will be necessary.

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
2.51.0


