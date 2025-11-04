Return-Path: <linux-kernel+bounces-885310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AAC328FE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F83618C1F63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DB344020;
	Tue,  4 Nov 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULzCLor7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AC342CBD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279821; cv=none; b=nftxpba0Tdw/hm9yxUCaMoA7pAbd4GCscSd0IfkWc7mnKgKfbT6NM3z3oS0fjjjVpcyWbH/CRe8S8MgDYak5MUtSFRflrHqEH/iCXqVYhdxZxmEFgU+o7ur4pKNuWNdLzw1s90i6A2iDMvTcfE201eWhdjENUG0E6/ABnFm7KoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279821; c=relaxed/simple;
	bh=sUrIHtojc8Cq5HvYFoOttAp1S2R8CQHc4BYGDanaEHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed0efUsXIYb/tVuBaNFkm+MCQlLu7OJIKQUPOnhH2F7uSCFWWJ+ZU/rRFJ5mkc1t7u4Y0UPf2x4FWmwODU6Ar7vI0hwWpSJDKUEtmg8DF+8FjzSxvSblHwUU/A3U4/gASw8xurcsaen8nHtnAFjOYVseL8vq6zjjmOL8LmrrWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULzCLor7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dae5d473so7378975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279817; x=1762884617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdhmcynnandPsql64nAYpaShGCfSEifyPJ/Np9JnIqU=;
        b=ULzCLor7fTSYL7Sg/0Nyup36fgBQ4s2XTrYvaBnHHYObtEQliI8B1ZODnZKnrxYyhQ
         QG89W5pLd23WCnOr129F1XVoLUv9oy3TvDDKISJVKpmHv6yeGmE/wP9mDPJdGixM+vGw
         ZznN8cQUmLXqIPZmD3eMNEIE32ph1egdDbJFeuq/g2F+R+89S5Rrp4aByY39xUr8m+SJ
         9j+jZ1czPB31LaHtUqoCSyObdwPos19P31vEzv2PDGqh3BTUFC0cYzjW5M0PWj6Ft9Ah
         ejiBMe9FU3dzPb66mTDJNXXj7BanDIvSJqJ1SSufks+W7lM8ohbBO7f2883WGpDwSjLV
         onkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279817; x=1762884617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdhmcynnandPsql64nAYpaShGCfSEifyPJ/Np9JnIqU=;
        b=d5n5dMoWCiislOI0qhkybx+/BaDFDllfJzVtisQR7pBbK8EGGzhqZgogOtwenDX456
         atszYWwH4Mmzb7XdL5TF8f1zY0cdgvKDZiaaUgK5sN8JcwjiYQCBO+ehNkVqWY8LKQAO
         V6cd2L6SUhmV78MMDQjR0GLMMeX8N+L/t5eY54GyEJQDPOWmBDc/hF36fWkZKHg6abaG
         kAOxPTLwtzpiejzjASND/7RG/y3hB87FrfvHKrfq7nk/lbwjJOvyMTZ4b4U78iWUWACO
         YvpMVCIxut1VFaXlZV+lqg46b0UiNpZSKAPhVA03d2wJHfUczdgMWVIpEE1AilKlZOGW
         q6gA==
X-Forwarded-Encrypted: i=1; AJvYcCWkSYRC1DssNi+2Oh644wbsaUzT/LFTywi6MVBstfJ2aIivpEFUB02nuSgLJcIo33oVgKaWtjDtIBuwf1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxNkC42jc5kDgV4CYVvKtgM5lDofo9ulyjDpJSUP8dJDmJbc7
	O1UOqHwtVmQyHxIC1Coqg4tdtvf4Hd5pvbRPb2IU5gFl0iNVhe0KD9ZV
X-Gm-Gg: ASbGncu2l3c0PYPPfTsj2RvPAAWZm6v2IolHr0HMlQXjbcwd+gGRjcG4a5p7boulPit
	KAtYRlrEM3+tAfMJD/wefLWdxc2DV4RH8RmaV3A8/4L4Hfdmo4V8zD/cVue73C38F3UExpo4dCp
	16lMc9rAWk5XnbLad1kbNPhHdk8pyPvGCicMt053LS1u8csZQ/5Sk3MHqogh8aZ12oXNIwyWH12
	FV03i2qbbwS80oJeu9i2ZEOM9mxnBBOcvVxtrlpj5Vaa23wd7RZfZSle4wLFskKaXvL1+4jJ+qA
	t1A93ZtQxJCQxNGtYBpVCSi4ACDkZFDApopvWw8y2EKxQVYgYO2tzvaN24UfJ7cNgK/nR+c4GiW
	qqnb1L87GP/ZBX11ssJPZCWvoD+JlS+181XsJlaiIc1VLJKDEMF/qOH1+jnUKaGzZgkNMSugAzP
	PrujPZvi5r82jcupsYrwruMT4Sqg6J
X-Google-Smtp-Source: AGHT+IHAn9E17efLdK3gkIKUuQG/k5i67Pxhzd6m2tYSUMyKeGk6z7xhuvIzYFMNgqNcBWlY1dxfwQ==
X-Received: by 2002:a05:600c:524d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-4775ce12cbcmr2349175e9.25.1762279816823;
        Tue, 04 Nov 2025 10:10:16 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:16 -0800 (PST)
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
Subject: [PATCH v2 12/30] drm/sun4i: csc: Simplify arguments with taking plane state
Date: Tue,  4 Nov 2025 19:09:24 +0100
Message-ID: <20251104180942.61538-13-jernej.skrabec@gmail.com>
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

Taking plane state directly reduces number of arguments, avoids copying
values and allows making additional decisions. For example, when plane
is disabled, CSC should be turned off.

This is also cleanup for later patches which will move call to another
place.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c      | 42 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_csc.h      | 11 ++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 33 +-------------------
 3 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index cf0c5121661b..ac7b62adc7df 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -3,11 +3,20 @@
  * Copyright (C) Jernej Skrabec <jernej.skrabec@siol.net>
  */
 
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 
 #include "sun8i_csc.h"
 #include "sun8i_mixer.h"
 
+enum sun8i_csc_mode {
+	SUN8I_CSC_MODE_OFF,
+	SUN8I_CSC_MODE_YUV2RGB,
+	SUN8I_CSC_MODE_YVU2RGB,
+};
+
 static const u32 ccsc_base[][2] = {
 	[CCSC_MIXER0_LAYOUT]	= {CCSC00_OFFSET, CCSC01_OFFSET},
 	[CCSC_MIXER1_LAYOUT]	= {CCSC10_OFFSET, CCSC11_OFFSET},
@@ -196,21 +205,44 @@ static void sun8i_de3_ccsc_setup(struct regmap *map, int layer,
 			   mask, val);
 }
 
+static u32 sun8i_csc_get_mode(struct drm_plane_state *state)
+{
+	const struct drm_format_info *format;
+
+	if (!state->crtc || !state->visible)
+		return SUN8I_CSC_MODE_OFF;
+
+	format = state->fb->format;
+	if (!format->is_yuv)
+		return SUN8I_CSC_MODE_OFF;
+
+	switch (format->format) {
+	case DRM_FORMAT_YVU411:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU444:
+		return SUN8I_CSC_MODE_YVU2RGB;
+	default:
+		return SUN8I_CSC_MODE_YUV2RGB;
+	}
+}
+
 void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
-		      enum sun8i_csc_mode mode,
-		      enum drm_color_encoding encoding,
-		      enum drm_color_range range)
+		      struct drm_plane_state *state)
 {
+	u32 mode = sun8i_csc_get_mode(state);
 	u32 base;
 
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE3) {
 		sun8i_de3_ccsc_setup(mixer->engine.regs, layer,
-				     mode, encoding, range);
+				     mode, state->color_encoding,
+				     state->color_range);
 		return;
 	}
 
 	base = ccsc_base[mixer->cfg->ccsc][layer];
 
 	sun8i_csc_setup(mixer->engine.regs, base,
-			mode, encoding, range);
+			mode, state->color_encoding,
+			state->color_range);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 27b6807fc786..ce921521aaca 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -8,6 +8,7 @@
 
 #include <drm/drm_color_mgmt.h>
 
+struct drm_plane_state;
 struct sun8i_mixer;
 
 /* VI channel CSC units offsets */
@@ -22,15 +23,7 @@ struct sun8i_mixer;
 
 #define SUN8I_CSC_CTRL_EN		BIT(0)
 
-enum sun8i_csc_mode {
-	SUN8I_CSC_MODE_OFF,
-	SUN8I_CSC_MODE_YUV2RGB,
-	SUN8I_CSC_MODE_YVU2RGB,
-};
-
 void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
-		      enum sun8i_csc_mode mode,
-		      enum drm_color_encoding encoding,
-		      enum drm_color_range range);
+		      struct drm_plane_state *state);
 
 #endif
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index adcd05acba1b..cf83f7ce6c78 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -188,36 +188,6 @@ static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
 }
 
-static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
-{
-	if (!format->is_yuv)
-		return SUN8I_CSC_MODE_OFF;
-
-	switch (format->format) {
-	case DRM_FORMAT_YVU411:
-	case DRM_FORMAT_YVU420:
-	case DRM_FORMAT_YVU422:
-	case DRM_FORMAT_YVU444:
-		return SUN8I_CSC_MODE_YVU2RGB;
-	default:
-		return SUN8I_CSC_MODE_YUV2RGB;
-	}
-}
-
-static void sun8i_vi_layer_update_colors(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
-{
-	struct drm_plane_state *state = plane->state;
-	const struct drm_format_info *fmt;
-	u32 csc_mode;
-
-	fmt = state->fb->format;
-	csc_mode = sun8i_vi_layer_get_csc_mode(fmt);
-	sun8i_csc_config(mixer, channel, csc_mode,
-			 state->color_encoding,
-			 state->color_range);
-}
-
 static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 					 int overlay, struct drm_plane *plane)
 {
@@ -333,8 +303,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 					 layer->overlay, plane);
 	sun8i_vi_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane);
-	sun8i_vi_layer_update_colors(mixer, layer->channel,
-				     layer->overlay, plane);
+	sun8i_csc_config(mixer, layer->channel, new_state);
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 }
-- 
2.51.2


