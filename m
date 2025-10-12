Return-Path: <linux-kernel+bounces-849706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81837BD0B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15BA34EC25E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4162FABF8;
	Sun, 12 Oct 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUPJfZjc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB42F9D89
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297043; cv=none; b=e3d3W0vr6g8Gss3+tHkxT4MczNPmc2lsULtGkHikjdE66PiUuHofkOsMpGog7Lnvzonah8An6inkOWQ7xEhs9wbLZVOWnTpFhy0s0sKTqvPwx8QAuj/AsfSD3ITvXgJlcP1JCV7xuvAcdTAiWhLAN6q+AQqQnrMqv5UHOvMNIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297043; c=relaxed/simple;
	bh=zj1rOPUM5oZeeTycyM+Ty1Sv9Bs/6lqDALJplKv3ek4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ianZQZEoWNwQrSPIkUscz2aXSEbz8JBUy5FimdW2yYFpV8ZJZASO5e4nXwQwXm3CuzhP7zXyuA4c8M6oJpGkXGsLiU8hQQ/xd3QpMFgiIOzLXikEoBUkh/5QGabWx61P8ALVoHbLj4UYAE+GTNc/L1U0zRVWoqRTtHBKxOQU86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUPJfZjc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ae31caso728495366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297038; x=1760901838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7B5z/6FvG3I54OQ4ZNRVyTMbTdgGg3l1ZfyjU4MqtQ=;
        b=EUPJfZjcALr496N6wCmnjHAMDNXScWyhkGJuCK6EhUhxsxq+Baehl4tyFKfV4i4cZz
         CwJw3fz6I+fhCoKl7uXF1v2eUzDl0ATDHnSbRPtPJJ8sVQPq5umPyuLqE5XxgEw3mVAJ
         CtY6gg7d+yYvg3bsftaCN+GFv2XndJtt77ZnhLGrtRcPsQQ+Zjn7mQG/RQuJdlY2Caau
         9Of5CtMkx1AEc7SDvUnQ6WtKc/dAtNq03jKPLXF48pB0QMXpSIxuQqHhFdSX4CFSsHU+
         607wH6ByKIVSHDTksEx769knNK5R6HBhXKO+bXKC3p9FqRsi4kUqDL5fYSA0JBfVBw3p
         Acjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297038; x=1760901838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7B5z/6FvG3I54OQ4ZNRVyTMbTdgGg3l1ZfyjU4MqtQ=;
        b=Ex9lM2U6zcmjkAQwBtwmGnShNDiwbn5fgC+Z5cuHrDCoCciMAIFeIYb9DkuoAwGd2y
         VuzmnMyKcORIzQf3JUZJ/Rla51RPMv8qsJke6USUOsWyT34DXNItqB5zRKjMNAtfVPrg
         RIbZLKC7LExH58xzfDeZAY5+fJFHDZMcrkenAzCNM7buo7oGZ+pWd0QwlG8+ieGoSUNH
         300oi2kXI/IIu8IlNLBs6cOwBE2AmMvk9p78jmCXV4UnKCb85HH7gCs/B9hlVnk44sQN
         7zymMwgQwo6VL3pptgHLRf37k8JiWylxnD0PwvhQfo7naJvxzrO+OtfCa2HH+DiuxURN
         a+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWLR6IAq/qUwDhvCZPr/OhXLE4h9lfmh8RynDjSan01co13GTG+HrGML5tII/fU19Z5VItIgdF4Lc8lXFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDD/7k/KvsXteO/uaj3ewtIL2UP07EH2iS7uXSbnV0CGIVKyl
	df+GaONgmVUg02aQvaY7EMMQNmcFi+AEGP1gT5bOnt70r5PTYTQCT+vp
X-Gm-Gg: ASbGncvF7WMG/ZcPCaeIi1rYVc8grUFfHC8Zo8++f5EoPeAJC8Brd1gG5SGpKCrx/Is
	bRZ+NjDYYoXI4PNmUkW6f6wqFoXmHA3Iq5pIGFX+xkQ2cCAAeKCgc/KMBoC9v9YsvKyH9zQEvXs
	5aRiOIRf+ehKRSAlwp2xVtMEa4p7FCJ/d1tXaxTKlV6I0XkiD/Xo/tRGV1bTlXtliFkhakD4sJ6
	huBWOJ1GT9kMu0njztEnwCCw902Gh49fpAbPgj1RxXMofqPbioaOsa71/0+CJnn9/Ntj66VBYLQ
	k/yaOFRHnr0eqBH6y+0yITo9M+cZC0d28QsqqrGisCgxVcBM2GwHkH1uOly0dLQSS2+RYOvYlh6
	/4BAfsxhF/A5ThEDcx+JNONR60emGbfyT8E1qEzWqVgok30owWdg+vgOd8MC1LK7K7q3/qa9mkJ
	Dfx9+yMqkEvi9dbfIu5G9dO7huzlHWaDI=
X-Google-Smtp-Source: AGHT+IEht1RvYv+GrJVSKlpD0bZZHYXhupsubyTU9aRKjX6qUxe0ggNfr/uDwTEge6IoB2ejpquang==
X-Received: by 2002:a17:907:da2:b0:b3c:de0e:7091 with SMTP id a640c23a62f3a-b50aa28f291mr1959386666b.8.1760297038157;
        Sun, 12 Oct 2025 12:23:58 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:57 -0700 (PDT)
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
Subject: [PATCH 15/30] drm/sun4i: layer: move num of planes calc out of layer code
Date: Sun, 12 Oct 2025 21:23:15 +0200
Message-ID: <20251012192330.6903-16-jernej.skrabec@gmail.com>
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

With DE33, number of planes no longer depends on mixer because layers
are shared between all mixers.

Get this value via parameter, so DE specific code can fill in proper
value.

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
2.51.0


