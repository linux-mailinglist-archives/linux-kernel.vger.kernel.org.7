Return-Path: <linux-kernel+bounces-885315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01895C32943
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A168B4288C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01934575F;
	Tue,  4 Nov 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu4WgjhP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53C3446A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279827; cv=none; b=CM1kXikMAkGNHnYo8USLr4ewwAJP7eCDFZTuy4G0NXs+o5SfR9zi7NvJJ9sNBOx4ggR2QeaZhW/sQ+yRgq/X4gjvwr+nXF/V7Nrf57E1JK+OkEugdSwfrTFJSq+o8LYZ9Rw7kttuSo2IzuV3TCKfl6j2D6QdJsmoeGPptZ9HwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279827; c=relaxed/simple;
	bh=GiArxfeMeAL0CBeo7YtFoMvlFTq7fgoVCY+irBH9sNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVnjiAOZerZ6mpj2o+8UOpWlSkPH3WVcGnbBhByXtXZbDhdYztwWUVXkZu3B3o+UzLi2NPgi08ksHBCotRMQj5Hu0UUTQ5OzmnE7fqsXi0seQJpzh8y1ZFasxrKAvPIeY+CF3ty+2DOsjjtg5H2dIp4w86bwnY4IpQhUDcH53nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu4WgjhP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso7992765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279824; x=1762884624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3EV/MxibVMeuKGvb6vWmFsIs3Yu10QpUHip3gqCW54=;
        b=mu4WgjhPKp6qrR5epybAfQky9fBwZKJWp6CeC2depbYDwUp3loqCu65OPzPvZfY+qT
         QvlUU0yP2zVWC4aVgqoIZyBn47UOWzdYSRNp9nlz01oJM6TVtxWu/qEfqG+Hgyyv9d0t
         x0Ly2wFWDvC3c/jFCOxTDpWvkDBhBm5rO92FKYN6X3nKA79RyTXFYPE4IgGx9LwCOPg3
         /7FSixo+70WCpVUMfKoaYHMi6LP7hHEfWkaQF8RlHFZhK9hFXsaL6WRJLMjMNMJ2Q6bv
         FHR1/Fe8lLwxRLWTbzIQlqnb/ltD9guMcWM7g+gyTylzmGWI7yenJ4asuDrdVYDKF5Pd
         ZBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279824; x=1762884624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3EV/MxibVMeuKGvb6vWmFsIs3Yu10QpUHip3gqCW54=;
        b=TjCa/5GxaC/3AsHHBHpTNNr+90FsJu6FGc3xiZEPfKMCwK10bEc5LNt3z2rNAnsjlJ
         FrvFJGc+OXQKTkfUGc2/62R3edJ6qujTpL+7znncv8qgpswyAb6xznBmf9SrBexLrmDR
         0yRuc9KVc+81DsLDgvi6123esYJcSdlGSRz+81Je1Azgik4QjDw58fJFt0pGT+dabu57
         nkGgSIYiQloBDAtgDkyrGHK6Ma5rI2e7E6SZA+gjlkHOsUShL1ZB4dnb6GD+JUxr3jVq
         DtjJ4eTFqBMwIHxT9mmVmoLcEqtHp4aD7881r8GT/kujdtTuSznCGFStGA6QYU3+5mxR
         Qd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMzTiXw1pr5WvwPD+DbShTbCWusss4dwbN4Fz5BOrDFyPjbVSut1v3QE/UOJ0MW/U7gltDUB4IayUizf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAD9WY7iXPM1gz6XUKl9U8vUoJuGxoKMD7adkbZc24f9j1lfh
	G/ddcrTKXm9E1kpEhqtSc8G60q1fEvDenc24qPffw/20MEw0UlnZcwTe
X-Gm-Gg: ASbGncssmjsc9GThKLwmVVOsAvudP3zSd8bpolmaTm+adpwGR5AifH+rmJJOWNKZEZe
	7vMHiMUYPX5wbakN4RmaAvkn9VTLd2yqYuZaeNOiuCWZiRXBWvPUo4dRp0VJ54gIS/U0fcMPzPU
	X7slbbifGiYX4dwL6PwieFUmuh2KHxHfePkQpNhsYnXTo4PZU3TWL8jPHUzV1kfiDkxdaPKgHXu
	ylA6hf/iBmKQFPWS/g3y/x2sy3W90lVGYelG+JTbOUkVjed1FLHYbzSbzOpt61G/bKVsr1PNflp
	bGwOVAOpO/yVvRrAuULv1o5Wqi1VEM6wcl0UCKiv0rZ2RvitacINQhS6qMsl5eH8PxMyl/rANYB
	6vG1pEoCCjr+cIPft1p+XW5MkWiIEEiTQpeFGnWSXpC+n3xwIvNZEQWj7a3QHVb7MKJc/goYYqh
	mVZZqtbFej1J0K1n1tpcLZxw74x+nt
X-Google-Smtp-Source: AGHT+IG3T52xUW38yiQP+ctGCFR1rUHrIm69DPF54UH5khemOeYMj6ikOX9GGLBlfNHgLEUvN0EOGw==
X-Received: by 2002:a05:600c:6286:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-4775ce61516mr2003715e9.23.1762279823483;
        Tue, 04 Nov 2025 10:10:23 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:23 -0800 (PST)
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
Subject: [PATCH v2 17/30] drm/sun4i: vi_layer: use layer struct instead of multiple args
Date: Tue,  4 Nov 2025 19:09:29 +0100
Message-ID: <20251104180942.61538-18-jernej.skrabec@gmail.com>
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

This change is equally a cleanup (less arguments) and preparation for
DE33 separate plane driver. It will introduce additional register space.

No functional changes.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 58 +++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 805db4ea714b..ba9c03f04f03 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -18,24 +18,24 @@
 #include "sun8i_vi_layer.h"
 #include "sun8i_vi_scaler.h"
 
-static void sun8i_vi_layer_disable(struct sun8i_mixer *mixer,
-				   int channel, int overlay)
+static void sun8i_vi_layer_disable(struct sun8i_layer *layer)
 {
-	u32 ch_base = sun8i_channel_base(mixer, channel);
+	struct sun8i_mixer *mixer = layer->mixer;
+	u32 ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay), 0);
+		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), 0);
 }
 
-static void sun8i_vi_layer_update_attributes(struct sun8i_mixer *mixer,
-					     int channel, int overlay,
+static void sun8i_vi_layer_update_attributes(struct sun8i_layer *layer,
 					     struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun8i_mixer *mixer = layer->mixer;
 	const struct drm_format_info *fmt;
 	u32 val, ch_base, hw_fmt;
 
-	ch_base = sun8i_channel_base(mixer, channel);
+	ch_base = sun8i_channel_base(mixer, layer->channel);
 	fmt = state->fb->format;
 	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
 
@@ -55,14 +55,15 @@ static void sun8i_vi_layer_update_attributes(struct sun8i_mixer *mixer,
 	}
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay), val);
+		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), val);
 }
 
-static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
+					struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *format = state->fb->format;
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
@@ -72,9 +73,9 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	u32 ch_base;
 
 	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
-			 channel, overlay);
+			 layer->channel, layer->overlay);
 
-	ch_base = sun8i_channel_base(mixer, channel);
+	ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	src_w = drm_rect_width(&state->src) >> 16;
 	src_h = drm_rect_height(&state->src) >> 16;
@@ -112,7 +113,7 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 			 (state->src.y1 >> 16) & ~(format->vsub - 1));
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch_base, overlay),
+		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch_base, layer->overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch_base),
@@ -161,13 +162,13 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		hscale = (src_w << 16) / dst_w;
 		vscale = (src_h << 16) / dst_h;
 
-		sun8i_vi_scaler_setup(mixer, channel, src_w, src_h, dst_w,
+		sun8i_vi_scaler_setup(mixer, layer->channel, src_w, src_h, dst_w,
 				      dst_h, hscale, vscale, hphase, vphase,
 				      format);
-		sun8i_vi_scaler_enable(mixer, channel, true);
+		sun8i_vi_scaler_enable(mixer, layer->channel, true);
 	} else {
 		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
-		sun8i_vi_scaler_enable(mixer, channel, false);
+		sun8i_vi_scaler_enable(mixer, layer->channel, false);
 	}
 
 	regmap_write(mixer->engine.regs,
@@ -188,10 +189,11 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
 }
 
-static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
+					 struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun8i_mixer *mixer = layer->mixer;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
 	struct drm_gem_dma_object *gem;
@@ -200,7 +202,7 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	u32 ch_base;
 	int i;
 
-	ch_base = sun8i_channel_base(mixer, channel);
+	ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	/* Adjust x and y to be dividable by subsampling factor */
 	src_x = (state->src.x1 >> 16) & ~(format->hsub - 1);
@@ -232,7 +234,7 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 				 i + 1, fb->pitches[i]);
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
-							     overlay, i),
+							     layer->overlay, i),
 			     fb->pitches[i]);
 
 		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
@@ -240,7 +242,7 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
-								 overlay, i),
+								 layer->overlay, i),
 			     lower_32_bits(dma_addr));
 	}
 }
@@ -292,20 +294,16 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!new_state->crtc || !new_state->visible) {
-		sun8i_vi_layer_disable(mixer, layer->channel, layer->overlay);
+		sun8i_vi_layer_disable(layer);
 		return;
 	}
 
-	sun8i_vi_layer_update_attributes(mixer, layer->channel,
-					 layer->overlay, plane);
-	sun8i_vi_layer_update_coord(mixer, layer->channel,
-				    layer->overlay, plane);
-	sun8i_csc_config(mixer, layer->channel, new_state);
-	sun8i_vi_layer_update_buffer(mixer, layer->channel,
-				     layer->overlay, plane);
+	sun8i_vi_layer_update_attributes(layer, plane);
+	sun8i_vi_layer_update_coord(layer, plane);
+	sun8i_csc_config(layer->mixer, layer->channel, new_state);
+	sun8i_vi_layer_update_buffer(layer, plane);
 }
 
 static const struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
-- 
2.51.2


