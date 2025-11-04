Return-Path: <linux-kernel+bounces-885313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5FC32937
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C941B4216D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410313446CE;
	Tue,  4 Nov 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHAKDcIF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A533F370
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279825; cv=none; b=sKUbbRR1NyTqSVXPdVymwV6ne/eq44OLSvrfsBr2dXw8fvHvh9Ul1tMFPLvVgCOgPISmVxrHV83BVpulIiAoqtW8HGk6NYWP18Hf7H5O7FovVrDaI+F7fEDGO1K2ecxh78N8zn1V4fy+0BKgIe+fyLlUZT/aA6X1qkl0e+tCiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279825; c=relaxed/simple;
	bh=fMfk5XrNq9l01XQk+tz08bGQKmauEMShCmc9xdALUaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0fASaNwZmrwMnb0D2WxeIkrzSb94uZkAcUWHVsiI7Lz5uPM0JMz+3L+rPwBRvBvc3mczUu7apyKDK02wxEG/RDiBnRV2bNj+wO2s5x9Y1wjZyEwwn1hmEogw+8UAd3s3sL812DOoA/FutL6qMvuqrXBWwoA97OsTGzlgxWwQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHAKDcIF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso7992515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279821; x=1762884621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clITce3FS5MOzvHgr4+g3DvGcjeJNYVgPXmRoIAMUA4=;
        b=PHAKDcIFolhYO8fisAoTGhevaF8l70DF05nD4vVCCKDqEX9tKoaMfjdcAf/Iodt8qs
         rIX6L+8LeQn6sEi4zxAj+Trfh98cJQ7F5jUmRusH2J98FPv58wHUJiXaQ2wug5wyoRPs
         7JHa0Y//agZJpSkh4DQbSWb26mNg6FRUE4WJoNGRFhcr+o0K1UlbqULxkF0vXVxn5tgd
         CQKBBBMXCWdfVHYC8Monyvol15VFbB7gYt7jRzBzHCjJg9hFTde6ilm9U3EDpD7YX8Y/
         poNCB7wJ3/GcRojZ2NZibYYkUfXVp7PZswpqEahqvo2bzQ/nU+0bVcjNIl74m8BfkRdH
         S24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279821; x=1762884621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clITce3FS5MOzvHgr4+g3DvGcjeJNYVgPXmRoIAMUA4=;
        b=kyhOnQHrGtMRah2Bt2Nch56AjAhDBrHVAOs+zNsq/vEYW0eXGzNHVc0NCluz8t+hA1
         SLGXsw9hDrNZ/d+UtpPt/TN8o78QP47OvImijYohSfFc6HmUuF8DRo6xlFnmp3JH/Xy6
         xvke4i/9G45oqEvP1CFCa0ToGhpsIyjzlijpoK3yI/CRQyFAtPmxQAmG15gECnwg2M6W
         iIcDAJepzJQdGDSA02QgZ40LZvSQUD2+HMZB38cxQm/X17NZR16EIINgZsI2qwiUWz0w
         8ke44P4XympfjKbl0j6SgGOfZmh0vONU6uVg47j53Nl3HRbWbVuoS2j8199leMXZz7yI
         3t1A==
X-Forwarded-Encrypted: i=1; AJvYcCXj7OfyJlIcfS0SfHVic87IPHlBRfeXAnI5Xqau/Ca9GpIKMgDab5F2zl6g7hI6kjc142NnTyuo4hSAy8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLMwFX+DzpfsO4OKRqgVD5DXXaXAYO8yeg7HaryD+FUChcU97
	bKbwzIFrdiasezP68BjLcSQSSruVnschjWCj8/7sb9pAOkiw3jYhvOzU
X-Gm-Gg: ASbGncu/W18y52oFSgtQ3fOdZ9Q76AYR3F/P/ImDhd+GmS89ZJ2DtYbczR4DtecQeO+
	PKdNMW/IgSLWUP/RgQ6cb9GICHVii0i3Wr7msn/LH3SEU+dfPXf5v+OjKo2K150VPddqxigUEkY
	Wst22kGvkqwCggVE0wFOqU93j/R49/+2AxU/4cQgLsEWhqqr39NPVXLDAgV7PvxZSTiob7rNxZb
	boM8J5WNffyoQbB4ZSIZl198+vOzCZUdlDzWZpsoDOa+lknDEeIts8m/i9/wbXLbcNolofYbrh9
	8RU+9u8BlAgmaqM6WlJN8fmJPgGbqII80s7yUU/nan+0garllNPZ8WdYOyObJJbv0tIObL+EH4d
	JiGXpzHC6RdN1xNdF//9gvB5e77Hm/6mv4lowWKW6eGQZti2np+Bn3qujs/BjkglRaLt1QxKy7a
	lVK7+1FYHZ5JPw1kB3Dw==
X-Google-Smtp-Source: AGHT+IEpdaIz/ZPa95URReRW4HZDMqPLVxE4VqmgVrqWeDCwzW1Bh5UB6FP8v4QdEMy5HSG3J/kMpg==
X-Received: by 2002:a05:600c:1994:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-4775ce9ba5cmr1916885e9.8.1762279821052;
        Tue, 04 Nov 2025 10:10:21 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:20 -0800 (PST)
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
Subject: [PATCH v2 15/30] drm/sun4i: layer: move num of planes calc out of layer code
Date: Tue,  4 Nov 2025 19:09:27 +0100
Message-ID: <20251104180942.61538-16-jernej.skrabec@gmail.com>
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

With DE33, number of planes no longer depends on mixer because layers
are shared between all mixers.

Get this value via parameter, so DE specific code can fill in proper
value.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 10 +++++-----
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  6 ++----
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  3 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  7 +++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h |  3 ++-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 17c0ab5860b5..18dd998364ae 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -315,12 +315,11 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 {
 	struct drm_plane **planes;
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	int plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 	enum drm_plane_type type;
 	int i;
 
-	planes = devm_kcalloc(drm->dev,
-			      mixer->cfg->vi_num + mixer->cfg->ui_num + 1,
-			      sizeof(*planes), GFP_KERNEL);
+	planes = devm_kcalloc(drm->dev, plane_cnt, sizeof(*planes), GFP_KERNEL);
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
@@ -332,7 +331,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		layer = sun8i_vi_layer_init_one(drm, mixer, type, i);
+		layer = sun8i_vi_layer_init_one(drm, mixer, type, i, plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
 				"Couldn't initialize overlay plane\n");
@@ -351,7 +350,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		layer = sun8i_ui_layer_init_one(drm, mixer, type, index);
+		layer = sun8i_ui_layer_init_one(drm, mixer, type, index,
+						plane_cnt);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 4f6c8b0acba6..8f6fcdfcf52a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -268,10 +268,10 @@ static const uint64_t sun8i_layer_modifiers[] = {
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
-					    int index)
+					    int index,
+					    int plane_cnt)
 {
 	struct sun8i_layer *layer;
-	unsigned int plane_cnt;
 	int ret;
 
 	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
@@ -294,8 +294,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(ret);
 	}
 
-	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
-
 	ret = drm_plane_create_alpha_property(&layer->plane);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't add alpha property\n");
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index 7745aec32d76..0613b34d36e0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -52,5 +52,6 @@ struct sun8i_layer;
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
-					    int index);
+					    int index,
+					    int plane_cnt);
 #endif /* _SUN8I_UI_LAYER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 1192b17726d1..805db4ea714b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -413,10 +413,11 @@ static const uint64_t sun8i_layer_modifiers[] = {
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
-					    int index)
+					    int index,
+					    int plane_cnt)
 {
 	u32 supported_encodings, supported_ranges;
-	unsigned int plane_cnt, format_count;
+	unsigned int format_count;
 	struct sun8i_layer *layer;
 	const u32 *formats;
 	int ret;
@@ -449,8 +450,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(ret);
 	}
 
-	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
-
 	if (mixer->cfg->vi_num == 1 || mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		ret = drm_plane_create_alpha_property(&layer->plane);
 		if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index fc22b9a6bd8d..a568e1db1e19 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -57,5 +57,6 @@ struct sun8i_layer;
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
-					    int index);
+					    int index,
+					    int plane_cnt);
 #endif /* _SUN8I_VI_LAYER_H_ */
-- 
2.51.2


