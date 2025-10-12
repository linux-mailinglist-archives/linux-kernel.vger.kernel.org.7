Return-Path: <linux-kernel+bounces-849713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B5BD0B90
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A55584EC8BB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562722F28F6;
	Sun, 12 Oct 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O69Y+jn6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B42FB608
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297051; cv=none; b=p1+h6QuFmpzjnrbvpjYvOCJIxGhqgaefjI+GXLe8KD7X79AwPlurxNhn7B0CqU8KWUmBXpSMKlPrOu5FpVNretUZzi6woWBMMMin+LNlTSpaH+937IjtU51act7zOFq/NQdI9o7ra2MG38A7nLqSwmgdC+HlK/ENHPXrGwqKAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297051; c=relaxed/simple;
	bh=iZauC4bq3j0IteUuEC4xJ1yNrvVQr9i4sppPKzvfY2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=org9GQWv63kmsiKCBhetw4tsnVz+OyN4CRxKWZErtsz1BFQzF2sVPSG6JbBolSWAIDEoY+mny/X+4wYgKVPAAXF4c0mQUDpd9tRaIgqlIyDG9l6eq3AfxW6RipaGVJiWrOehe/RlCbzC5C7Wru3D3WlpWgdfNXd5aDTHH+OBe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O69Y+jn6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d80891c6cso703919766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297046; x=1760901846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQOv5yUZt16sUnKDbEIh6jBa6S1wacoD7LiibO9kAbE=;
        b=O69Y+jn64mAeXIGqyi1t7rn6WMleXjdUjFLrrhQSjgByQLC2SaZq0mEb1j4EtikcQN
         ouxfwlK4CP5R9zGm+4M24eAR7Q4/V2QddN33WeTnJDcNk+plco1MfXN4Tbnuiy3p3Uhu
         hEnLA+RxP15Ungg/4WyoApGtDbSTBXoR9TzHUYqALUgJ7Dhied2XvFilCetmVwRYZ82d
         LY9AKmIVOOujHZcCNrLU1wl9nZ43OVhCMPYrRsZqpYO57APoxXCD4FRv8fU7jF9SpV6g
         bz1xZTdutcYluaNzOfYriuPpBg0TD/sfJGELTyYRPvfIXaqv4iRxcCxVkwPKY+aZv0Gt
         K3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297046; x=1760901846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQOv5yUZt16sUnKDbEIh6jBa6S1wacoD7LiibO9kAbE=;
        b=cSHzQ3d4CQUEeAIYV7auin3p5glrfgZy6hZjU74T0HXuwUOS6qM/rShzvMTMLGYSZL
         ZBVKuDhJoopCXcvf3EGI6p7kTbK5mhU3QgrlvIDxG2SV5gcEUD7vCk20GyAYq0ybN6F3
         LQKEuDaS80WfE8aMfQahP3oUyfaAzDYR3n/MfaO5tVbWW1wBDpUSrAZtHYzxldLlqidg
         5Yt9uw8z5iRCCYgWM0wsWEGSo8PXP6K5uxEiNcbqxqmuxVEGvCjzbdDc7AFrHmeFIrLT
         WVwbcG+zPH3xzsyTmKxCKU5+hTjZkWAlBDT2RY2nSp+4wu2mQsBtaCyJiOK3k4Ayd9Qv
         ktBA==
X-Forwarded-Encrypted: i=1; AJvYcCXNhSAoGDREQSDf/n3n6BC8SWHdvQTXGhuFF/EwHwiDeUA/dtGhl9qikao7fmbHEFtfnBuY4Wvhlvqv/go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MuIpLHs7dolceonzv/ATSIFYstMr4fsUzzc7knzTnwigH12B
	a25ULSVClIFlrQja5ie5fCuSxkoS0ucA84J7SnpDDO1SMQ57Fgf5dZov51ZzLBx2
X-Gm-Gg: ASbGncvUX4/3ObMskvdU+RzN1jclnG/sJvqVH7ALVpQ/TuG5tzw0StfnZlhHu9Q8O9f
	TA3VmCubxaiSvYV0x4nHFYn04qfaynwJoyL8M7nYmxgSG5KnPwSevs2p/T1sOjDHcDBKPYc1agq
	coJY3+eUFwneaJqKx/d8OLn3etdiWQnEv7np/YnDNMkrv9HJIqMsDqKnMGvUrl3RNEUsSR/BYlq
	hwGhcEZWkuqDcJ25/E2jgjRlfkGP+PQLqPVimZ2o3hz1w17b8H6QxsG2iYYfh2fqxRIgylq1bkm
	cCEUccA/I9xWSIbSHwlnGTVi1/aTxl1eq6+daoCAE0zs5KjOM7lPImxi1we828YTT8zKPwE4R9W
	idUTdhLdqR27ecMFv7B5pUuPiyEtY/Ou4RzszkKjhOkYBUQ1OWQ8wbEKtKWXKhrvTpCZ1pHl7Sq
	JRVrYAEppe7PLy5kn73NVI
X-Google-Smtp-Source: AGHT+IFHVFCcqMPLSnre0bX8uQT71SYCPAmz7n1qrIGlKmWTvSTA93x89NSp8O+T0B6bETl+ErANjg==
X-Received: by 2002:a17:907:c717:b0:b3d:e757:8c36 with SMTP id a640c23a62f3a-b4f40789b30mr2665949966b.3.1760297046143;
        Sun, 12 Oct 2025 12:24:06 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:05 -0700 (PDT)
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
Subject: [PATCH 22/30] drm/sun4i: layers: add physical index arg
Date: Sun, 12 Oct 2025 21:23:22 +0200
Message-ID: <20251012192330.6903-23-jernej.skrabec@gmail.com>
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

This avoids plane mapping in layers code, which allows future
refactoring, when layer code will move away from accessing mixer
structure.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 17 +++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 ++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  5 +++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  5 +++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h |  2 +-
 6 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index d2b7fc552a76..267a6f75feb2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -283,14 +283,14 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 		h = drm_rect_height(&plane_state->dst);
 
 		DRM_DEBUG_DRIVER("  plane %d: chan=%d ovl=%d en=%d zpos=%d x=%d y=%d w=%d h=%d\n",
-				 plane->base.id, layer->channel, layer->overlay,
+				 plane->base.id, layer->index, layer->overlay,
 				 enable, zpos, x, y, w, h);
 
 		if (!enable)
 			continue;
 
 		/* Route layer to pipe based on zpos */
-		route |= layer->channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
+		route |= layer->index << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
 		pipe_en |= SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
 
 		regmap_write(bld_regs,
@@ -317,6 +317,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
 	int plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 	enum drm_plane_type type;
+	unsigned int phy_index;
 	int i;
 
 	planes = devm_kcalloc(drm->dev, plane_cnt, sizeof(*planes), GFP_KERNEL);
@@ -331,9 +332,13 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
+		phy_index = i;
+		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
+			phy_index = mixer->cfg->map[i];
+
 		layer = sun8i_vi_layer_init_one(drm, mixer, type,
 						mixer->engine.regs, i,
-						plane_cnt);
+						phy_index, plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
 				"Couldn't initialize overlay plane\n");
@@ -352,9 +357,13 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
+		phy_index = index;
+		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
+			phy_index = mixer->cfg->map[index];
+
 		layer = sun8i_ui_layer_init_one(drm, mixer, type,
 						mixer->engine.regs, index,
-						plane_cnt);
+						phy_index, plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 2e3689008b50..d14188cdfab3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -212,6 +212,7 @@ struct sun8i_layer {
 	struct drm_plane	plane;
 	struct sun8i_mixer	*mixer;
 	int			type;
+	int			index;
 	int			channel;
 	int			overlay;
 	struct regmap		*regs;
@@ -246,7 +247,7 @@ static inline u32
 sun8i_channel_base(struct sun8i_mixer *mixer, int channel)
 {
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-		return DE33_CH_BASE + mixer->cfg->map[channel] * DE33_CH_SIZE;
+		return DE33_CH_BASE + channel * DE33_CH_SIZE;
 	else if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_CH_BASE + channel * DE3_CH_SIZE;
 	else
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index dd6cb09c2c01..e65dc313c87d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -265,7 +265,7 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
-					    int index,
+					    int index, int phy_index,
 					    int plane_cnt)
 {
 	struct sun8i_layer *layer;
@@ -277,7 +277,8 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 
 	layer->mixer = mixer;
 	layer->type = SUN8I_LAYER_TYPE_UI;
-	layer->channel = index;
+	layer->index = index;
+	layer->channel = phy_index;
 	layer->overlay = 0;
 	layer->regs = regs;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index e0b2cfa02749..9383c3364df3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -53,6 +53,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
-					    int index,
+					    int index, int phy_index,
 					    int plane_cnt);
 #endif /* _SUN8I_UI_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 4f0c929faf36..44e699910b70 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -411,7 +411,7 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
-					    int index,
+					    int index, int phy_index,
 					    int plane_cnt)
 {
 	u32 supported_encodings, supported_ranges;
@@ -426,7 +426,8 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 
 	layer->mixer = mixer;
 	layer->type = SUN8I_LAYER_TYPE_VI;
-	layer->channel = index;
+	layer->index = index;
+	layer->channel = phy_index;
 	layer->overlay = 0;
 	layer->regs = regs;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index 70766d752fa6..89d0c32e63cf 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -58,6 +58,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
-					    int index,
+					    int index, int phy_index,
 					    int plane_cnt);
 #endif /* _SUN8I_VI_LAYER_H_ */
-- 
2.51.0


