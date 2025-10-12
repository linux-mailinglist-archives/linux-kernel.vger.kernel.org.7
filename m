Return-Path: <linux-kernel+bounces-849705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B314ABD0B78
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4989E4EC576
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F122FABF7;
	Sun, 12 Oct 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3DAwSF/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D82F9C3C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297043; cv=none; b=ek4UcHGc505sHKsMXuFOcZ0Wt7ib6UYNe2gzQm0x3cAX7jahmnqot7xxzSbdGpv5xmHFObRyWtHkwBFnikZUEFtpjE93EYVEOXjloyqInOc9Hub9Hfvb9sT5U5Mo9nXO46Qmsb7mwqStVDg+DlHhc5kUtjzb4Yxj00bN6WRuqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297043; c=relaxed/simple;
	bh=k6sfFLRDZy5wK4Z9n6cVxPJtWPapLDCxQAuqb+LuH0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4f3CIZy38DDq0TNcnHCpc2jRKJp9XqsItSt6skYLBuTPX8B2p8QApwvfZoe7gRkUj7paOPecOcKQdIkwvrtHMIbfw8miz/46um4+DbezY2sSvloK3JVMr1aLCjLBU58st7+zWv2Nb/52USSaU75EbUU1y+QT7HNVzzIONsCHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3DAwSF/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e9d633b78so652798566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297039; x=1760901839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE7z3Ym6vzsdMqeurGEJ9WmMXX0dMfNPsEVDzikE/Uo=;
        b=G3DAwSF/ucpDfozs9pdZycjkw5Vr2pVvdlvonJNaF93k5kz/xHMnDWouz4nBM4Qu/c
         GeBdvAhZW9hxgpkN4bPad09CgDhur9O+5hPtRZy8zoU8uJDzq7eEiNSXIxGH24oab2Gb
         iVuUkqwBCCWcm1igWmEaTk+12RwM2eRnCSV56eM/noBMX0P1+ftKVIchDkrNdr6WXQkW
         p1J/BfMPaNhwQJsF1out/2ZoSu9NNwkb0SmROlkQ/JNSB6xViO7XZa25xAgFyz9fejN5
         EL+51OqZGzAFX0DD3nGn5Pc01sEg6JQHrOn+O/h8qxRtFjKbG2fFDFcb3XOrMv5hdQ2R
         7UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297039; x=1760901839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OE7z3Ym6vzsdMqeurGEJ9WmMXX0dMfNPsEVDzikE/Uo=;
        b=tAiPPPgkjDuOtKhlVNW0csvLKhJWyaC/8mMPDjPNVlMpLnY5A5/1Fph916gN07+cX3
         rwJgHwx3gOhCg4Ui1Y6SxX0U2L5IbDSHz7s0VMKLJNP2MirIQwQ4yx3AniUsy8txW4Wy
         4chg8Z8cMt4W4WwwprUmNlJeY74KACIH8gSao7JBraBsticdiApiSr2s630bi/I/lkWt
         1nDDlvwQ5V3/w+YfxBxOh5LaUDKQSMzRHp0IvqmYPShsfKMP4if9e7PYWEH4Fe+tPrLc
         2u8ojw0/JCzCavHM4Scrdc4LT8RjTuKHykYS83TjMFYDQgtEW3djLGJ4LlJIUNxrIvqb
         DkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgiUy3FODq33tbfH+58XIJBn1w1pvyneWDuBLhEZQAhg5Sykxi/3v6w4Av4PhHA1JQhiG5OwgaR2FWZRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVM4Fu7NL3T7h6ciHSmoulix9xU5DIvV27nkvzYQSHUBTOkMyQ
	TqHcN4tF3bK5c+11qMWIiQcGZPW/mKdglQop0VCT5x3q1BpHWcrQJGsE
X-Gm-Gg: ASbGncsEO23A+8sK6krKBUndREaUZB7Eg1koVSLc1009to0XkOCs/0e1Q2NTZh3JfxG
	8chzxOZa4Y7BJknPaThDrjcMnvilX91dz+nwTxCBoG4INBpXQHqSBNAfBfP1IGdwwUpRq+7Iwwd
	AR0YIMI6dn8c7souCStNpLARZRX70mIc1J+3PjYR5sgY8qaEiD4/BS820zvPylEhhuPsZJ8vsyi
	7YCJHXmzoXV2kM0CU2uihNAwT5uvRsUyol4UOmxF6qg5famBw7YCPf3JEVHmzWbtvFGihrNdM02
	gnxbix8Lw9OrdcXl+146ForB6+qH141Ej4zbieU5ZLuJbW33s2VmKlsgcPExiZ5j/puSyMPy3Xs
	ozZ6bv/7CRfVjnPl5/fRNNEpyI+hIZPsdzgwKb7UON9zrq7AlpPcNlfEJ/LnY7t7/KBV/zmFKBf
	/3HlC6cGpLYxJMmveWUcpO
X-Google-Smtp-Source: AGHT+IF1xOKgWuyI+oCZN9C/Rgac5TfDhPy4n+lEBLcOmhbH8TpPGj6H1LBb8Yf8EpbwReOe4/+GPA==
X-Received: by 2002:a17:907:d48d:b0:b4d:71e9:1662 with SMTP id a640c23a62f3a-b4f43730a39mr2759401266b.30.1760297039238;
        Sun, 12 Oct 2025 12:23:59 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:58 -0700 (PDT)
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
Subject: [PATCH 16/30] drm/sun4i: ui_layer: use layer struct instead of multiple args
Date: Sun, 12 Oct 2025 21:23:16 +0200
Message-ID: <20251012192330.6903-17-jernej.skrabec@gmail.com>
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

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 62 +++++++++++++-------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 8f6fcdfcf52a..d5b7241acdea 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -25,24 +25,24 @@
 #include "sun8i_ui_scaler.h"
 #include "sun8i_vi_scaler.h"
 
-static void sun8i_ui_layer_disable(struct sun8i_mixer *mixer,
-				   int channel, int overlay)
+static void sun8i_ui_layer_disable(struct sun8i_layer *layer)
 {
-	u32 ch_base = sun8i_channel_base(mixer, channel);
+	struct sun8i_mixer *mixer = layer->mixer;
+	u32 ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), 0);
+		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, layer->overlay), 0);
 }
 
-static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
-					     int channel, int overlay,
+static void sun8i_ui_layer_update_attributes(struct sun8i_layer *layer,
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
 
@@ -54,22 +54,23 @@ static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
 	val |= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), val);
+		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, layer->overlay), val);
 }
 
-static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_coord(struct sun8i_layer *layer,
+					struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
 	u32 ch_base;
 
 	DRM_DEBUG_DRIVER("Updating UI channel %d overlay %d\n",
-			 channel, overlay);
+			 layer->channel, layer->overlay);
 
-	ch_base = sun8i_channel_base(mixer, channel);
+	ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	src_w = drm_rect_width(&state->src) >> 16;
 	src_h = drm_rect_height(&state->src) >> 16;
@@ -87,7 +88,7 @@ static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 			 state->src.x1 >> 16, state->src.y1 >> 16);
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch_base, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch_base, layer->overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch_base),
@@ -102,37 +103,38 @@ static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		vscale = state->src_h / state->crtc_h;
 
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33) {
-			sun8i_vi_scaler_setup(mixer, channel, src_w, src_h,
+			sun8i_vi_scaler_setup(mixer, layer->channel, src_w, src_h,
 					      dst_w, dst_h, hscale, vscale,
 					      hphase, vphase,
 					      state->fb->format);
-			sun8i_vi_scaler_enable(mixer, channel, true);
+			sun8i_vi_scaler_enable(mixer, layer->channel, true);
 		} else {
-			sun8i_ui_scaler_setup(mixer, channel, src_w, src_h,
+			sun8i_ui_scaler_setup(mixer, layer->channel, src_w, src_h,
 					      dst_w, dst_h, hscale, vscale,
 					      hphase, vphase);
-			sun8i_ui_scaler_enable(mixer, channel, true);
+			sun8i_ui_scaler_enable(mixer, layer->channel, true);
 		}
 	} else {
 		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-			sun8i_vi_scaler_enable(mixer, channel, false);
+			sun8i_vi_scaler_enable(mixer, layer->channel, false);
 		else
-			sun8i_ui_scaler_enable(mixer, channel, false);
+			sun8i_ui_scaler_enable(mixer, layer->channel, false);
 	}
 }
 
-static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_buffer(struct sun8i_layer *layer,
+					 struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun8i_mixer *mixer = layer->mixer;
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_gem_dma_object *gem;
 	dma_addr_t dma_addr;
 	u32 ch_base;
 	int bpp;
 
-	ch_base = sun8i_channel_base(mixer, channel);
+	ch_base = sun8i_channel_base(mixer, layer->channel);
 
 	/* Get the physical address of the buffer in memory */
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
@@ -150,13 +152,13 @@ static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch_base, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch_base, layer->overlay),
 		     fb->pitches[0]);
 
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &dma_addr);
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, layer->overlay),
 		     lower_32_bits(dma_addr));
 }
 
@@ -208,19 +210,15 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!new_state->crtc || !new_state->visible) {
-		sun8i_ui_layer_disable(mixer, layer->channel, layer->overlay);
+		sun8i_ui_layer_disable(layer);
 		return;
 	}
 
-	sun8i_ui_layer_update_attributes(mixer, layer->channel,
-					 layer->overlay, plane);
-	sun8i_ui_layer_update_coord(mixer, layer->channel,
-				    layer->overlay, plane);
-	sun8i_ui_layer_update_buffer(mixer, layer->channel,
-				     layer->overlay, plane);
+	sun8i_ui_layer_update_attributes(layer, plane);
+	sun8i_ui_layer_update_coord(layer, plane);
+	sun8i_ui_layer_update_buffer(layer, plane);
 }
 
 static const struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
-- 
2.51.0


