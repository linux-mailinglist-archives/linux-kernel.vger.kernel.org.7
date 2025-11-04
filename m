Return-Path: <linux-kernel+bounces-885330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F274C3299B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9308A3B7621
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9E34A3C2;
	Tue,  4 Nov 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpTwq48K"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663A348884
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279844; cv=none; b=fGdhfTH5nLkll53zw4mAApi4x7iXvNWpeWU1gidH4cnPCBffRUHFQyNzRC/ojkqoC4RYkNPKgGihY1e3sChc8/BoEspRE/RttVLoAUURxsGtuzQLefc5usmb/BxwDdxOnp7IbtDUjlSD1etp7PjYu54h8QBTOGd+cUxfY1GTwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279844; c=relaxed/simple;
	bh=pwHyPYs+uvcIMdyUOYcnWKkfT8r4lZYUtB/lROjfyFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8THQco3M6iqH+nZCGfw8k/YIkn/xbTo1WKPHI6ZTR14B2Talew60NnHzsaZsRYMn/JTzl+d0cJ3bsZyz74vVrMWWsMC1fuWv4t1Exb4b5vSYlwAKMTmjdD3iavzAcayPsI1CRNbVuMM/SRVyP+vAE6D063kwCwixthYBOqju2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpTwq48K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47721743fd0so31654695e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279840; x=1762884640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhWx9NyFnSAm1+R2uJGg2k+MOsOqirwBc3PWmOrvwX4=;
        b=bpTwq48KhnZbCz6Cfc2ZSkFrBpQsnybsmY8YPdywa605JqN7+Lp5zszsjfbjheZGKJ
         ihVUxjuvTOTi8pUq4/cgCfluAKtQieCiYDtKecDRcAzittF6dG7A/yAiGwC7eLIFnqsa
         v6D8Zbze9zmIBl9adkteAX2svzxMzLkbemHdT8Pv0hDbpEsfaj0h6FmaYa/lfyaY5ubJ
         4u9yfJBgTjO4AvVOsP5wL8TAQvI9xtFRztpe1xCjTooQtCvNoofEktOjyc1BmFx9DLjZ
         rkCBYxfYO2z9vdQNCOVIvCa8WRqDF1lHRDCSLlZ2uQ6Dga4ioKn/vT6oDTqR8wRqJS+r
         7uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279840; x=1762884640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhWx9NyFnSAm1+R2uJGg2k+MOsOqirwBc3PWmOrvwX4=;
        b=lfxCTl8yS7JWa6Slnfat71Xm2I/Gew/y7CwS9Co3TN0qdsCkI0B+e//AO2v3DtfyB3
         IOC4sIFbm61FzmsTmny8TFVFi2aFNTJt0gqM7iUDsO/90QHDmpPqq6n1oN9DmA1XNftf
         l5M0W9giNkOe6omskvm8aogtYe92ndofPwA2GRFSbTGa7yTie+PN8SmYV69WEkPDKwmj
         dskUwNT0D+jyInOUkExppDY64gbYaBU+oMX2z0fRQ/IUb53uZg8T8jrZDXxwUpOackbz
         DVQ/YK18xJL03pKdiqGFqqMjDUvQNM6X87GAyZ2hrpWczk5EjO8gAxrXDEql+Pe9+Z5O
         bayw==
X-Forwarded-Encrypted: i=1; AJvYcCUzBJFMjPyZKCT00P5megiMqDFj7fdnhQpSmz7sg79JLBxR2sK1EyV19ORpsZ/btT53iihyVPWPvUNDnwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPI8NRM26RfT67NYNOD1xbq2jrEiAWQFfIIABh70FY4pGRJC9c
	TgPlfHPbG1fPujcBEantkGt4tzop7wpod7ohaw0XIW0clIuGFtci/u6P
X-Gm-Gg: ASbGnctrN/AWbiUEEbRRyR7W3hequqLCTg00AvEwRHkjprlIZvDdufTZghV6ZNRUUxg
	hyaiQ7hRCcIPalnVAueOCzeQ4WvmknhQ+AvijkG4Au7+OXzQSJPdtcXVHIYRCZ0BZ6C5gLw43Ju
	ORK6JlQrMb49wED6nfMCbEpCW/m/YP69LlB/cL/zx0bfyymjoBdRykv2aZSReWwJp5+G6AmxnFL
	yDUUhAs+6S0+kOU6PpoUHESAss3e1EwarYM4hqRYSrKW6mSx4+qj+8wTVrFRBOWp8BsKV1wRntc
	fOkPJ/7Non1mAy7E6aVBHIdXshPkA/clsUTvtS+aKHMy7PeHuYoUCcWmiiPfB8bEdLAvx3jbj9K
	RQFdvA/uTwuqTPxhjhr0OIn1S7wfkvHYXCye4bHk1nZM/vTTTx8yCt7KxH7/bBHgHvwm1QG3X9S
	BKnlQ0F6vp2iToTSnZhg==
X-Google-Smtp-Source: AGHT+IGiymh/TsRqhwN6N3A97NvG3Bqul+I8b68ZoyUR344zIADNYxpVaPkfS3GzPbVwVEx24Kp+Fg==
X-Received: by 2002:a05:600c:6388:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4775ce1874bmr2424725e9.29.1762279839699;
        Tue, 04 Nov 2025 10:10:39 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:39 -0800 (PST)
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
Subject: [PATCH v2 30/30] drm/sun4i: Nuke mixer pointer from layer code
Date: Tue,  4 Nov 2025 19:09:42 +0100
Message-ID: <20251104180942.61538-31-jernej.skrabec@gmail.com>
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

It's not used anymore, so remove it. This allows trully independent
layer state from mixer.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 +++++-------
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  1 -
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 --
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  1 -
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  2 --
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h |  1 -
 6 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 50fc20100c90..fde3b677e925 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -268,7 +268,7 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 		int w, h, x, y, zpos;
 		bool enable;
 
-		if (!(plane->possible_crtcs & drm_crtc_mask(crtc)) || layer->mixer != mixer)
+		if (!(plane->possible_crtcs & drm_crtc_mask(crtc)))
 			continue;
 
 		plane_state = drm_atomic_get_new_plane_state(state, plane);
@@ -336,9 +336,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
 			phy_index = mixer->cfg->map[i];
 
-		layer = sun8i_vi_layer_init_one(drm, mixer, type,
-						mixer->engine.regs, i,
-						phy_index, plane_cnt,
+		layer = sun8i_vi_layer_init_one(drm, type, mixer->engine.regs,
+						i, phy_index, plane_cnt,
 						&mixer->cfg->lay_cfg);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
@@ -362,9 +361,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
 			phy_index = mixer->cfg->map[index];
 
-		layer = sun8i_ui_layer_init_one(drm, mixer, type,
-						mixer->engine.regs, index,
-						phy_index, plane_cnt,
+		layer = sun8i_ui_layer_init_one(drm, type, mixer->engine.regs,
+						index, phy_index, plane_cnt,
 						&mixer->cfg->lay_cfg);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 3948023e095b..e2f83301aae8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -226,7 +226,6 @@ enum {
 
 struct sun8i_layer {
 	struct drm_plane		plane;
-	struct sun8i_mixer		*mixer;
 	int				type;
 	int				index;
 	int				channel;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index dc4298590024..185e4ae8a11a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -258,7 +258,6 @@ static const uint64_t sun8i_layer_modifiers[] = {
 };
 
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
-					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
 					    int index, int phy_index,
@@ -272,7 +271,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
-	layer->mixer = mixer;
 	layer->type = SUN8I_LAYER_TYPE_UI;
 	layer->index = index;
 	layer->channel = phy_index;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index c357b39999ff..1581ffc6d4e5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -50,7 +50,6 @@ struct sun8i_mixer;
 struct sun8i_layer;
 
 struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
-					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
 					    int index, int phy_index,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 4534998af825..40008c38003d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -409,7 +409,6 @@ static const uint64_t sun8i_layer_modifiers[] = {
 };
 
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
-					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
 					    int index, int phy_index,
@@ -426,7 +425,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
-	layer->mixer = mixer;
 	layer->type = SUN8I_LAYER_TYPE_VI;
 	layer->index = index;
 	layer->channel = phy_index;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index 6ec68baa2409..29cc5573691f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -55,7 +55,6 @@ struct sun8i_mixer;
 struct sun8i_layer;
 
 struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
-					    struct sun8i_mixer *mixer,
 					    enum drm_plane_type type,
 					    struct regmap *regs,
 					    int index, int phy_index,
-- 
2.51.2


