Return-Path: <linux-kernel+bounces-849703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560ABD0B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E71897F6E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553D2F99BC;
	Sun, 12 Oct 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mahHmJYC"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AF2F83CC
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297039; cv=none; b=cXhbcDQ8om57fCxHAy00sZSS+ezW6KRyBoV4SUrRHdP+MBWB0PWB1Zytw83f9tPwlNrcGt+37yneXkEURFpOhSe4s6Yl7lcLy3I8CQpIEAenuEIt7YkfCGdAoLt2IAc8m018QlmT9n+IvDObNcRMnRTMHj9sej+JNrbc7VbvXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297039; c=relaxed/simple;
	bh=pQyLYLt8MK5Nc3WPWpve6V5LNVyLoCfjLR7JWOrVrEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnqAlUBmkeoVxkM5TjGLzUKaJEfiQS3hbXskGU8AgOKhgWEUhkB9RKB/MgvbvFUvnO/AFU0KHazDMZua9+Hh1bs84uK/cqP0V0pQCdSQNbsaUNLWAWlej1yxyt93mas9xeIap4ZDmcWkHPxwocdI4+l21fuvh4VbyE0S0fKQhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mahHmJYC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3da3b34950so600180166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297036; x=1760901836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQIOjRIdDsBl/wnqSd50NloWouLj/f2wu4NfISu0ViQ=;
        b=mahHmJYChAiAvqAKzmk48l0utsVppjScF/HYRo8ngdI5BkZIs7TXcLs9DV1Mo7dkW7
         7sKA1oGMQrDvCTmtMSKAzQzkq0RadbVfnhiwTSopjb+1/DCWeNYR9jwNpJ1tq+YxbaEn
         mJa8C5eiGOhlObKNKqTte8KttrZpznuk+4zsoX7B31QAkbtrcjJaGD+IEURz+xWT5EQ+
         4BMQPskXxwEMofybVnUYSposkGOW+BgGuig21y5J61Ab/7Djrcc8o/9nYZJuoNsfO9CL
         sw6yn/dBLjDjr6+OUtfwRa0J2Nzfv5y715gEaNfX9SHwVAKJPOKFGvS1A0oaXvxfcRqx
         VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297036; x=1760901836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQIOjRIdDsBl/wnqSd50NloWouLj/f2wu4NfISu0ViQ=;
        b=V2shkbE1uhVDNhMJvTeWJjr0LZ0eAF4aksRc7tHlV07hrhoZB3RzXAq9aze6E06ou8
         /uOWsfv6JxGOcuH4iaWYrRTRz8tE6+1BFc3B1lT1dKcINQV9/d1QPgh2k5TDVIpJCXxb
         z20wCd6mlpHQvTRJqzw6abZ2TGFwZeHoz6YEfIvuBxGnnTw0EghvvGYNWnm1qwakeKxN
         D2RMNhJGQjqBj2klTdsSQja4jmfUe63W7lx82SWmncO1RAb+F1DRkrtyds363BTna2Fg
         6SrMozYb85TUWnSzJStm7PcxyS9+YeaZ4k0w9GtOXvryUstXVl/mI+ZN8pMutJSGblWC
         DsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsXyIAARuLePenfKxb8kY1db3MAeXwJbaK6fEV8o7B18TFppkKRv7wl8YIXMYZD2JksKaELxySMFLusOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGn4YKFx+XAMmzOy7tuHdSFgfr0lZQzGvkx6vrSxsD2hR3W0X
	k/TzDsKVyJNz666bZjpGQSa2BaWuEXnBucgLCyPx4vBRDZfy9SImAbN0
X-Gm-Gg: ASbGncuoF3AJozqNFjrA67sJ+qQKA7nxf/JoGBbCmFnCQCcKMCTYsKrNoW01rn/e815
	U/flCYhV17i5spIQY5dOOrb3P70h1StRny83Sl7e0kqyAmm9ayFgNX0WrjpDMlnYbpkOpXT1oIB
	juq/2V99870XG1zC3uI90WbjJHrDdgQVuCsOx2VfYEIfa34msUwIZRRvBjLiLyVkT0FBNGP1YnV
	/DSgaf1vcGM3ru12ouDvUiI+g50576XcRF6tqts1RQ3fbIYREgybT+slkZaO4oUyKM7owBR1xYp
	gBit7yPG01LH6UIrzp7hILVNVTrGGpsHqWBz9P+CtBlvVGCMCAf5OX7xO22accNKVr48cikiFEe
	Q+ChM4aF0ktm9NTdLGQXIe3mvfedVN4xhXfVG3DIX8u3R0yCSce1jx+dg4qsMRg7TOS8DxVMNzW
	f2nwggxgSYmubGohmtpBHF1TZiDvoDse4=
X-Google-Smtp-Source: AGHT+IEo0mmA5QLs7FFLs9zM7BuOIhHX0fkAtfXbVZQzrSvZ8WwfBQOC4GT4ec3HCn2JTDhgwgWT7g==
X-Received: by 2002:a17:906:f589:b0:b41:abc9:6154 with SMTP id a640c23a62f3a-b50abaa45a1mr2062111266b.30.1760297035817;
        Sun, 12 Oct 2025 12:23:55 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:55 -0700 (PDT)
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
Subject: [PATCH 13/30] drm/sun4i: de2/de3: Move plane type determination to mixer
Date: Sun, 12 Oct 2025 21:23:13 +0200
Message-ID: <20251012192330.6903-14-jernej.skrabec@gmail.com>
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

Plane type determination logic inside layer init functions doesn't allow
index register to be repurposed to plane sequence, which it almost is.

So move out the logic to mixer, which allows furter rework for DE33
support.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  5 +----
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  1 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  5 +----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h |  1 +
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 1fca05a760b8..e7a66d9b622a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -315,6 +315,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 {
 	struct drm_plane **planes;
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	enum drm_plane_type type;
 	int i;
 
 	planes = devm_kcalloc(drm->dev,
@@ -326,7 +327,12 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	for (i = 0; i < mixer->cfg->vi_num; i++) {
 		struct sun8i_layer *layer;
 
-		layer = sun8i_vi_layer_init_one(drm, mixer, i);
+		if (i == 0 && !mixer->cfg->ui_num)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		layer = sun8i_vi_layer_init_one(drm, mixer, type, i);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
 				"Couldn't initialize overlay plane\n");
@@ -339,7 +345,12 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	for (i = 0; i < mixer->cfg->ui_num; i++) {
 		struct sun8i_layer *layer;
 
-		layer = sun8i_ui_layer_init_one(drm, mixer, i);
+		if (i == 0)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		layer = sun8i_ui_layer_init_one(drm, mixer, type, i);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 9d5d5e0b7e63..8d74eddaa294 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -267,9 +267,9 @@ static const uint64_t sun8i_layer_modifiers[] = {
 
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
+					    enum drm_plane_type type,
 					    int index)
 {
-	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	int channel = mixer->cfg->vi_num + index;
 	struct sun8i_layer *layer;
 	unsigned int plane_cnt;
@@ -284,9 +284,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	layer->channel = channel;
 	layer->overlay = 0;
 
-	if (index == 0)
-		type = DRM_PLANE_TYPE_PRIMARY;
-
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_ui_layer_funcs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index 83892f6ff211..7745aec32d76 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -51,5 +51,6 @@ struct sun8i_layer;
 
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
+					    enum drm_plane_type type,
 					    int index);
 #endif /* _SUN8I_UI_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index cf83f7ce6c78..1192b17726d1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -412,9 +412,9 @@ static const uint64_t sun8i_layer_modifiers[] = {
 
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
+					    enum drm_plane_type type,
 					    int index)
 {
-	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	u32 supported_encodings, supported_ranges;
 	unsigned int plane_cnt, format_count;
 	struct sun8i_layer *layer;
@@ -438,9 +438,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 		format_count = ARRAY_SIZE(sun8i_vi_layer_formats);
 	}
 
-	if (!mixer->cfg->ui_num && index == 0)
-		type = DRM_PLANE_TYPE_PRIMARY;
-
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_vi_layer_funcs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index 655440cdc78f..fc22b9a6bd8d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -56,5 +56,6 @@ struct sun8i_layer;
 
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
+					    enum drm_plane_type type,
 					    int index);
 #endif /* _SUN8I_VI_LAYER_H_ */
-- 
2.51.0


