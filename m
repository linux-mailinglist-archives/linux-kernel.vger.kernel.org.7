Return-Path: <linux-kernel+bounces-849697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B0BD0B5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A033BF8F8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19B2F60A4;
	Sun, 12 Oct 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7y5aSN/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F02F49FE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297031; cv=none; b=RveX1FdxRdjRKc8fNffwMtp64TbjdckfUztfL1Q/7ji2LWyztQpM0OuRB+361dxBDFaxXJ5cK1n6CrFC/Fm50Lll81bT704O932sdGMl6+TmRpOrDMke9mRxtBuQfKPl9S+5mMpRaHkmN8FHCaJvQA/bvcU+eqK7q5ujgFNkCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297031; c=relaxed/simple;
	bh=MnVQaYVRpCuxuwcIoP09CCaM1HauxqazhwD06u6VpFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7iunlhlsO7IDECKROPXKSpoBO7dxsyVje3iw2uWDC8PBUtAb26Bq0RHwLhaSgo2JB46PYYpYG+mCTBQoC0BxYwRVjyTSCaA5IguaVSZqoqfJJWpc88wARvJ6qpP4TZL/erEq2m7V5H56oKnyygQHklzm77IkOiaJ+271EyyGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7y5aSN/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so36333366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297028; x=1760901828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG8bmd+ZBK/ghOVMNjmCpTsnMqAGeyE2Wx03CRuhE1M=;
        b=K7y5aSN/9rJWLGBITueD2VQiyKHJ851p8FbwhSJ6N6BvkpaqvOpjT+Whk9qflGFj6Y
         piOqQHPOnDDhPTUuvGtAUJMxKcYXN1NsoKCGh8SiGjmOSdEeCxFchaURrGL3jXKOM3Ic
         GnfNDUN7elDus5m2dOT71ogU3MANbJQw7Os9jQs0qQrbx2MGuYOvr8lz8OaPy8j5OxZv
         3TcRr6CjeIwKH2uTU9QpQnKgsjE2Ghs03HjRolKZpsrw5I3o/zhikKtXGS6VP2gYGAko
         1hgrw2xi1iCx2ptR6UgEwbTxh4KB8n6AXxYtkIxvPewhu6UQbhniO1aAJ08VFwapaXlo
         +8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297028; x=1760901828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG8bmd+ZBK/ghOVMNjmCpTsnMqAGeyE2Wx03CRuhE1M=;
        b=JClBtxX8WaZevHpTPdh9UoisBWXVqQlQTkJQEWdoIHZejzj0ITRpn7ZZYGzlniPEMp
         kqd9BR+3+g7+a6ahwhLoZjaB2xMnp8FAFvdW7DDvaQcf62bnxc5u2t/hVW4vLCcMuHUZ
         6ZzCFBYlnFZApEdmnazvV0YNirlRHvGoNWEh0lTxtC60qZficRSatbLiCBBG22Aut7L0
         nzFEfYKOlJwGxgmG7lMIiG8DVN/addjwAcTM9LRyhWqvs6MWey768iTCL6a9oFs2IiL9
         tbCdqDafQR5YY0zmRpQd20S5fKDdYrJ6VTfEEDQ6QEQ0wj/Sb9gQHm2j3vBMmRhCi6gX
         FkRg==
X-Forwarded-Encrypted: i=1; AJvYcCX7BRpvXnLlutk8OzX9kBOWdI5bfQj2brdWZPUjJXtQz/gzfgb1ofo3VitK7jKZFQ+KXa/aPPpXIMc7xls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikKfs9AI4iqxAQSS92iFDMZ4j776ZZyA/J2bHnWZ8M1gIo/qA
	95nMSWMgrjqnQO2fQOnXReF2YOsDBuLM1zr3wsKcKlbyxHV3eU2ewz+R
X-Gm-Gg: ASbGncuDnYlDVuPdTLrwqRxwxLDkUAkWp//HlzCoYV/3lfkInMLKYiQCSgMWszgdrpA
	djAkb3spz1CldcoJTISm/u25gf/POcCrWnlqfaRaiS4NSQJr7Sxl54jt/bfcxETr2bofR2nzTU9
	7VtFq79AOzLdZGB4gtOi32bv3GL1vkvJSxubmFDzWi8pZpv0R09yOOuijznRVGIxOtFVhK3ICtr
	3V3BxAwioj9jWtaKY7zYyo6NnUywYrKMuxN/zvbQEAgcbMyt+/E+A3yav1jtf/sfG9a+gpULdfm
	fEYgMRBZbIF8pdlvB+ysNsmpQANAKwQ/OmDvjC4BoPcnibTDqjRxbRFVX7YZicKlHkCd9hAlLTQ
	VPLUPRCgQMlZ2bAAr/IVTHM88iw93Yb31WMDhNOuKjlVTGEvArnXyNeHW/eUxUs1bGDAAWikzLp
	RpT4a+6LdrJW+fHnIAypdZAu1oz3EYUf8=
X-Google-Smtp-Source: AGHT+IEDIL5NJwC44TfJ1I5nI96VrWmynMGreSQjJO21/d5ma6GdYAfY8ReIx6RrzS2f3OpOdrWl4g==
X-Received: by 2002:a17:906:ef04:b0:b3c:8b25:ab74 with SMTP id a640c23a62f3a-b50aa393c32mr2123217066b.10.1760297027731;
        Sun, 12 Oct 2025 12:23:47 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:47 -0700 (PDT)
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
Subject: [PATCH 07/30] drm/sun4i: Move blender config from layers to mixer
Date: Sun, 12 Oct 2025 21:23:07 +0200
Message-ID: <20251012192330.6903-8-jernej.skrabec@gmail.com>
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

With upcoming DE33 support, layer management must be decoupled from
other operations like blender configuration. There are two reasons:
- DE33 will have separate driver for planes and thus it will be harder
  to manage different register spaces
- Architecturaly it's better to split access by modules. Blender is now
  exclusively managed by mixer.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 17 ++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 22 +++-------------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 22 +++-------------------
 3 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f7f210a925f8..a3194b71dc6d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -283,8 +283,8 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 
 	drm_for_each_plane(plane, state->dev) {
 		struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
+		int w, h, x, y, zpos;
 		bool enable;
-		int zpos;
 
 		if (!(plane->possible_crtcs & drm_crtc_mask(crtc)) || layer->mixer != mixer)
 			continue;
@@ -295,10 +295,14 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 
 		enable = plane_state->crtc && plane_state->visible;
 		zpos = plane_state->normalized_zpos;
+		x = plane_state->dst.x1;
+		y = plane_state->dst.y1;
+		w = drm_rect_width(&plane_state->dst);
+		h = drm_rect_height(&plane_state->dst);
 
-		DRM_DEBUG_DRIVER("  plane %d: chan=%d ovl=%d en=%d zpos=%d\n",
+		DRM_DEBUG_DRIVER("  plane %d: chan=%d ovl=%d en=%d zpos=%d x=%d y=%d w=%d h=%d\n",
 				 plane->base.id, layer->channel, layer->overlay,
-				 enable, zpos);
+				 enable, zpos, x, y, w, h);
 
 		/*
 		 * We always update the layer enable bit, because it can clear
@@ -312,6 +316,13 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 		/* Route layer to pipe based on zpos */
 		route |= layer->channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
 		pipe_en |= SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
+
+		regmap_write(bld_regs,
+			     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
+			     SUN8I_MIXER_COORD(x, y));
+		regmap_write(bld_regs,
+			     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
+			     SUN8I_MIXER_SIZE(w, h));
 	}
 
 	regmap_write(bld_regs, SUN8I_MIXER_BLEND_ROUTE(bld_base), route);
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 8baa1d0b53bd..12c83c54f9bc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -47,21 +47,17 @@ static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 }
 
 static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane,
-					unsigned int zpos)
+					int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 src_w, src_h, dst_w, dst_h;
-	struct regmap *bld_regs;
-	u32 bld_base, ch_base;
 	u32 outsize, insize;
 	u32 hphase, vphase;
+	u32 ch_base;
 
 	DRM_DEBUG_DRIVER("Updating UI channel %d overlay %d\n",
 			 channel, overlay);
 
-	bld_base = sun8i_blender_base(mixer);
-	bld_regs = sun8i_blender_regmap(mixer);
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	src_w = drm_rect_width(&state->src) >> 16;
@@ -113,17 +109,6 @@ static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		else
 			sun8i_ui_scaler_enable(mixer, channel, false);
 	}
-
-	/* Set base coordinates */
-	DRM_DEBUG_DRIVER("Layer destination coordinates X: %d Y: %d\n",
-			 state->dst.x1, state->dst.y1);
-	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
-	regmap_write(bld_regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
-		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
-	regmap_write(bld_regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
-		     outsize);
 }
 
 static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
@@ -230,14 +215,13 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	unsigned int zpos = new_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!new_state->crtc || !new_state->visible)
 		return;
 
 	sun8i_ui_layer_update_coord(mixer, layer->channel,
-				    layer->overlay, plane, zpos);
+				    layer->overlay, plane);
 	sun8i_ui_layer_update_alpha(mixer, layer->channel,
 				    layer->overlay, plane);
 	sun8i_ui_layer_update_formats(mixer, layer->channel,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index dae6f83cea6e..1f4fa63ef153 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -49,25 +49,21 @@ static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 }
 
 static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane,
-					unsigned int zpos)
+					int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *format = state->fb->format;
 	u32 src_w, src_h, dst_w, dst_h;
-	struct regmap *bld_regs;
-	u32 bld_base, ch_base;
 	u32 outsize, insize;
 	u32 hphase, vphase;
 	u32 hn = 0, hm = 0;
 	u32 vn = 0, vm = 0;
 	bool subsampled;
+	u32 ch_base;
 
 	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
 			 channel, overlay);
 
-	bld_base = sun8i_blender_base(mixer);
-	bld_regs = sun8i_blender_regmap(mixer);
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	src_w = drm_rect_width(&state->src) >> 16;
@@ -180,17 +176,6 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		     SUN8I_MIXER_CHAN_VI_VDS_UV(ch_base),
 		     SUN8I_MIXER_CHAN_VI_DS_N(vn) |
 		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
-
-	/* Set base coordinates */
-	DRM_DEBUG_DRIVER("Layer destination coordinates X: %d Y: %d\n",
-			 state->dst.x1, state->dst.y1);
-	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
-	regmap_write(bld_regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
-		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
-	regmap_write(bld_regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
-		     outsize);
 }
 
 static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
@@ -350,14 +335,13 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
-	unsigned int zpos = new_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!new_state->crtc || !new_state->visible)
 		return;
 
 	sun8i_vi_layer_update_coord(mixer, layer->channel,
-				    layer->overlay, plane, zpos);
+				    layer->overlay, plane);
 	sun8i_vi_layer_update_alpha(mixer, layer->channel,
 				    layer->overlay, plane);
 	sun8i_vi_layer_update_formats(mixer, layer->channel,
-- 
2.51.0


