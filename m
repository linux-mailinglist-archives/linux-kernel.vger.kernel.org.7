Return-Path: <linux-kernel+bounces-885311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47807C32901
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658E218C2020
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F7344032;
	Tue,  4 Nov 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyq8AWhd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291813431E4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279822; cv=none; b=fndQLR/qCfmbnu9uGvR5c2bQq/p7tnEO1sdcYD7q960Yc1cwHuPmYTgq1OKSc6jFYpyvDJLG6ihCP85iZYGB6jguKMSHsLX0Ar3p+VTGzTvMGKwUmtXnzB36h5yXsSSovtXhg5gfGuuN6ScOeOJtRZoqfUFFvzemHlR2SoK5J0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279822; c=relaxed/simple;
	bh=t8mJW3Fat77+qlKNgT4jR7rPDxuiYTPXp7Gff1nhJ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTL0+1w96Pk41LP3bZgqOuAEs+vm4+UywNW4pYfSuafVGIf27TNG5IIn8VY4vyLASPD7GuMFzqff8/bDlmKCN5Mets7OzknRKUmdG6CnwmpTmO6K7z6KADIHK0woiBdD8akFzNhUm+kQZSXz+hSw040QTEdLsex9lvCMEJWimvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyq8AWhd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477563e28a3so789515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279818; x=1762884618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDQI5x1cDX0/wzl8C9wFmlja3WFbUj4VL1aXgGGHPcI=;
        b=lyq8AWhdI0MEhsI96t0x9wxWeaxLweKZc0aLSOwDiVDdrtwnfibgX7mhV/EHn2pmoz
         t6wMm7oTV35JXtHCF2eKJ7hKG45Gq0QZsgNJo070CePaVq5Gy8UH+qcJLa7KnY0bn6Vl
         +ubNzG3auc2GliayzLHTvyukog9ARkS7HdMlNFej5HAanmxSF+l8GywalwVrZmjSPhN7
         H7xQMzi/tslPDEbUIkXMHfbCk3qFJ8jed2cZZ4AElgxdMjTFGj7/0zHq+yCdu7u5IeiG
         aVUMGZgG2CQa9okzr/8RBHgoC+9SeOisPTI4UuN7ppE6KpMeYHFuvjcsIVimKek4a1FG
         y+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279818; x=1762884618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDQI5x1cDX0/wzl8C9wFmlja3WFbUj4VL1aXgGGHPcI=;
        b=vgSQehxJpj+6y92VdCt0txJ3K6iXhjWvCxcvUsvb92PL69eOdw6v42k/vfNygdPABB
         odN2VHME+8xtj38WWoDpulFtyCzMlBGDNr7cx21Nw3py1uf1gJe+ZYgMktT1PuACOfDi
         UQNqGoAAtYm8SKZ0gyF0nj6kh1EyyQAqXnGXLdJ+oZv7Oz9lTRzoz4k8JNF8W9sIBXGq
         oI3T3OD4O+a9LU/2HftYZj2G60F6JQ5A4XtdbZjqlHwx4hEpxNwaFBRNNJ3J4bKkYad4
         mHwj/NCTERL1U7uV0bChB6IM/xkPROY7vtU2WF026X+B3LDz/bTWzZYMmt4l5eW7w3Ay
         INCg==
X-Forwarded-Encrypted: i=1; AJvYcCXRoaf8bLOabZdVhvHeVwkkUhZZXZvemV9lEZrCxsw2I05P9qmQaQMHQX9cjfUdKmTASVdt2QAhe4pBqCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MsdT8JNNvTfrzAsPjijKIBCU6N7M4UdVAG3GBpxuKXQEB22k
	XCE/HoF2v/JuQlAFQabuybC+3wcrD88QPxH9wb2vveoYfgSOVzY+8qyd
X-Gm-Gg: ASbGnctP0oZT3gs3yDicUDCBp3CK6qpOm2t6UcwYGy8SAqNhX5oEBZh6zXHa5mhkPto
	E+DaWCFZeRynFuewbYpB3Tu38zGDiv352JRCpV70riAQDSJnyRBqZGqCQ06bDNvNYHp9uIk+xVV
	lHl98Nz04LLtequeZ3TES5THZAH1FaOkPT6GO7S06axY/9SzA66hRb6tOxeCK71D5k9A+0TTLIN
	iUC2crnfFijq+8nsF3R0qM4kBg+QY5S8ufE6+f5ETi3rFj3oo22oYMLQvp46gNUiy9HdzgQalZe
	44UVegQfnhhibCnAoOuCvwEZSSazQax6CCM/tUjtkdc4/nqIwnudbGEY1nlLfK02NLpBhYryYRa
	sgSk1YrErfVeTKJ/8RJDzAFTngr1wjCgGVuGLzGNAQ76ZDm5jhcbMbc3y0+kGx47ftZj73C1I93
	dlfXK8ksT+zLGz3BNPKg==
X-Google-Smtp-Source: AGHT+IE6+wQNQgsRWOAqTzJlZBlSMUgDJYtvMonE1RZ+OJOG9YLIca0WKWGS8Pz1WvOiR/sQSuop1A==
X-Received: by 2002:a05:600c:6dd3:b0:475:d278:1ab8 with SMTP id 5b1f17b1804b1-47754c1c553mr27491185e9.2.1762279818149;
        Tue, 04 Nov 2025 10:10:18 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:17 -0800 (PST)
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
Subject: [PATCH v2 13/30] drm/sun4i: de2/de3: Move plane type determination to mixer
Date: Tue,  4 Nov 2025 19:09:25 +0100
Message-ID: <20251104180942.61538-14-jernej.skrabec@gmail.com>
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

Plane type determination logic inside layer init functions doesn't allow
index register to be repurposed to plane sequence, which it almost is.

So move out the logic to mixer, which allows further rework for DE33
support.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- fixed commit message

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
2.51.2


