Return-Path: <linux-kernel+bounces-885321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF9C32962
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6230462D30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AC33F377;
	Tue,  4 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA2JEMtL"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946F345CD7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279833; cv=none; b=kNv2KCkGpr331aisTTKkZxCtkXySROjVfd/APdr+6vuEqQ9cz4A8lBRfoPEOnHQKsje28tDX+LfF36I1gtEitY2/m2KQhByqNgUNZ8169yCOoUP0m9leOUPKocpKd7wacbIVD5BgW6tWmjzJjhFfdjZqYg5k/MCsQQEoLd0wkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279833; c=relaxed/simple;
	bh=tLfdvt3kCCBnNflbYWB2jKViQDk0gZMYjhuWhiETf/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GddLyYWrtJF8WGAi43KZrU8VDyCXEY+40Vg8g1VO/xlCbwqjbzYdnVQ3s83+nE3dtpUr1GOs1aY5usgIMqrHPnxp8F5w0yC2bUIGwSpY1o8v17CyNBZylO3WhzgYIdV3ZBhXu9bDdNGsELiCMw8KW7CSEk2rhjlS7hymir/OV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA2JEMtL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so31864315e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279830; x=1762884630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9/AMl4xgUVEiUmyMxeIjWVAIaeS72AyB+f50sJb9qk=;
        b=hA2JEMtLQ/o2N1f5F97giONwuiwRfGf6+4cFihenMDUHLbCfPcYrK9Li1oa/CpL6uB
         morgRhJ3kgbP8buHbcqP7lUpvTyoPRt6c5JySfa6ehuXpO5zgQ8vjoQxhIHQkTwRdhF4
         nBju44NGuB5X3rF7eH7Jz748hsbbK62zUDFuQ9/DKIAPfxOu4u7voGmKbUGXRnt7h/dq
         kyK4YQiMyHTceZBtR2yMMxP043HbRw/9MqvMPAGu/wdlZX98MbV+T8baRQrykFlvfdpv
         2zySGpyLkzYnxuM3v2I7wPNJaKNnv0eE1wCL5Met7kxZP7VkCp+mPIz/v2DfSPzB7JqC
         MCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279830; x=1762884630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9/AMl4xgUVEiUmyMxeIjWVAIaeS72AyB+f50sJb9qk=;
        b=NuklVNz9mlbQSnyPufLNgW0DP6uSED25vapio+Gkj1xfjHNAb5MOCK48DxGiIn56Jt
         GiZTWmkdxmG6vtUJLeMbOHhkW8360daN2ae+4VKGak/v0P7SmBFpUe1fslRHs677KCVd
         hRQ2MdszXd8NtYKAAS7rMJtNjIXV4u80AuF6Cn+jnAuPuhz3C8neLLwpRs7Z0NnpvU3N
         BvgqFGQdLFohmunCPDrmRCiSL7Z2mpBs/Ivg11ON7ILMkg9vOlD+d6oBPQh0c20BjZQg
         +ezWld+xROlNmfsBH+WF/ZcHBtvvNcHwRknrkpFX8gk+V25uXeZUFeSvCX1OO/P5PMx9
         LYAg==
X-Forwarded-Encrypted: i=1; AJvYcCV1a6BTocR8oQ5Nspw2hvMEx7xRjdWcd8l0ndh++a5hR+ud+EGcx59YreRdSXG+3hMdxQniplZvQ2W0iNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyH7yD1PQWjSrz+QxqSCD2wKmx7f+sI8hXo60hgr1FgCH+10hu
	TKjbHJittP0Wiz0a28vsJvrRYSWD69wML3lvjZiMJSDDnZmusY0xNyKM
X-Gm-Gg: ASbGnct26i6u2FghioQLfpe10IJh51lOl5DMXZtlRTInuL68sLcRFIQfJHxcBKB5ET7
	aDfo88aE/RynPeabHyB3lh4a1iniyBi03SPOCk8LW8TvZTywzL5Ih/v0ZsTQWSKQGydjc1F4JNl
	uxRezgMulzRLSB5bk5ydQ7oQ9kV4gzIDg5I0TyYzy22Nd5NzlbxaKmE5yVfuEPT0I5moY2EfMG4
	NKWAgP8BzPP5WKHDr98qWLJyS+qiRfSzyemZz6jaz3ETe7alWYwwFscw0af6ldrOs5j8tV4xLZy
	kfVth71ipo24i9H+XxUAZJDLlxe+C+QTVB1dhVHfU0KIFvHJi22kZgbacd3IEkS/pVqSj5+N+E4
	mfWO3CWO7CCZnFJS/pUvtEsSZOtVYvz7ZGPJkBVCGTo6hbBVK4D9AWUdxEbiLxya9H49C7GYkxH
	HCTM5v7vEELYY5qdwUuQ==
X-Google-Smtp-Source: AGHT+IE8pg2fqunzszYJMCpOfAsCZLtKqT6X6xX+b+FBqXNTS7M6/iDgmxVd2/hVTJsg7USbpjI7+w==
X-Received: by 2002:a05:600c:5403:b0:477:54cd:201c with SMTP id 5b1f17b1804b1-4775cd9c25amr2654245e9.6.1762279829609;
        Tue, 04 Nov 2025 10:10:29 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:29 -0800 (PST)
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
Subject: [PATCH v2 22/30] drm/sun4i: layers: add physical index arg
Date: Tue,  4 Nov 2025 19:09:34 +0100
Message-ID: <20251104180942.61538-23-jernej.skrabec@gmail.com>
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

This avoids plane mapping in layers code, which allows future
refactoring, when layer code will move away from accessing mixer
structure.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
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
2.51.2


