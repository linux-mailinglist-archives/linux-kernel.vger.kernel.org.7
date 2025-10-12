Return-Path: <linux-kernel+bounces-849707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A944BD0B84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A154EC7E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45442FB093;
	Sun, 12 Oct 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drsYuEhF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF72FA0EE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297045; cv=none; b=sWLLu06DBhyya65HpirVwr4bbnUdDFXusfzGoio82vK0CBrwGvnw2weH0Twni9WWGk/9/2kq2JWpxrcKd8MXKTf9p2kGGSJ50y/CKDXMbIbE/DXL51U3aAL9ySLnqiebTYaOIEr0PMxgrJYT2+yihgIn14HNa1iEMxE81E2++xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297045; c=relaxed/simple;
	bh=VMGFXyUFgbi3kCmM6PTUqzyMycpO6B+C8ZN7eSBLhS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQPuWhP9CZYRjkYphNpm2ZdbCtnFIWrfQbInqk3dXxIsHxGPTS9yyXcUM+s8mi90ZwCkqt7XEWsnLKNdUFMVXbiXkPU5Oef/K8kIBUHzB0xNFNeng/iiWSqdLG7E2CBmlupgTTxYw6VnteXG6EQ4791mNJ1N5qBKLc+uvZJRW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drsYuEhF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so5241273a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297041; x=1760901841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL2EBWUDT3u08ZkUVEOOStqc7WgxRVhnqkwZQdEEL5M=;
        b=drsYuEhF9cdN+Ui0/hP90m5a0CIU629/FfzmjxioVFqDzGzLwb7QHTU13A5YdDXf5A
         QTne/qvKQ5GP6AsrYu9iX7F8fStr6jRe+2njCW0Ety+amurHccKFE+qAS8xWQZkU3g8y
         yLcS6M33UCAGUiCQtCO9z0H07XZalYmqCEKKGoOkGQX2Jmp4D91+SqzUJLnmYL2emoXF
         Js8/zciVftZJaxvZQ2vk/msD7I4HsSFqBKB6Dwk6gDYPIzL9F1uRiY3tKhAhtk1OaVak
         cirKjlBfqxGW86sGgNsITYzOV4oHrGjSO7ibuMQfjxsshDLqp0n4IAi3p0mAcb6yRsTd
         7i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297041; x=1760901841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL2EBWUDT3u08ZkUVEOOStqc7WgxRVhnqkwZQdEEL5M=;
        b=gQJF3sHcBgASe2nTSj4meDqeLTOxjh3GPABwn8n6rKrW70EoB7O+lbFFzPS/FkZ3Js
         8yEafBh1Uvs3mlS1nmHgZc0VOAsE1vtCrlhZnOnQcp1xS0IL0wG02tvuoJn1FTsqHvMc
         ht7LMNjYCIKdfrFuK603cXggJF19JvsaekQmp4SqABoWZLYNt99QJRW852sLxe3YHfQU
         vO8qj4ZKw2bg1vP8GhX96IjyiExzjg1rPikqxoXDdMibirntbv0UqDfakDjcdDfxHkBG
         Vp5RllaYn2Fwy47NeDvIZT2WtX+ijXVOrjSNOzH6GqYy+X4UEia43M/h5T/YF7jUlZDF
         OOrg==
X-Forwarded-Encrypted: i=1; AJvYcCU4D66kdJc7JLgP5mSV8PCgcM1VbY86j34iz/kca9aj3XWm2eEghIPDBA/GQV3ke7gEW/W4W8P69LedcRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzddp6DjB1t5rJhZ6np9UNU3MlVF5PhSCNJugxoyTnqmpoOpMW5
	jOVUq6wVwslJgXBXRo+T/LdkL5xucBUgzvTIoq8fG15gQs+oYuP9FRnO
X-Gm-Gg: ASbGncu7uCNhFtFu9UiA/xvmNehyUJ4khCV1HmnKSWqcGGSIQamXd/GtgtT25gYQlwl
	JN/B2ZQgbq9vJTEjb98B5NAqNA8xK2yVt7s+IdFziJYCKoMh+zlpraGZjcw3c1b2WLAVHGU8RVW
	raqmgOOPsoAQt0X4j5WwfIvMER/ijE5wmJBA+40EyyucK0KYw7/zmKo7BgN7tE6XxGOsNuOO5Ks
	us3fjuPgl45QUx40Mrf4MLULlBCfFnlHDZq2+L51s8D194chS4IAZEksC84uLOVw7bGLsby1Pod
	nZ6LNcAlH3ZupxITVRWnWCtBs+hBUawrm6BQLT5AWk2f5vymyd6BKtqt8SYlTVvN0TF2BZfJYCu
	9phr45BOgEiZmSV8SlTvni5/LO00BrWRvYcF+8CAOS2GQcQDZT1+YlsIx3iYiHRMbOq99KSutqK
	NfT33DRx1sTgRh4tRtjJLtSHRTWz3T5+EpHM47VHn7fQ==
X-Google-Smtp-Source: AGHT+IGPkp7VdpjnXUyPQLeT83O0qdM4azwPi4L4aE39Db/9aQTPTuI9Yl565PGYAFHx9WevGbF8Hg==
X-Received: by 2002:a17:907:3e21:b0:b41:e675:95e5 with SMTP id a640c23a62f3a-b50aaa98160mr1845501866b.23.1760297040342;
        Sun, 12 Oct 2025 12:24:00 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:00 -0700 (PDT)
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
Subject: [PATCH 17/30] drm/sun4i: vi_layer: use layer struct instead of multiple args
Date: Sun, 12 Oct 2025 21:23:17 +0200
Message-ID: <20251012192330.6903-18-jernej.skrabec@gmail.com>
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

This change is equally a cleanup (less arguments) and preparation for
DE33 separate plane driver. It will introduce additional register space.

No functional changes.

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
2.51.0


