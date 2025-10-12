Return-Path: <linux-kernel+bounces-849720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1878DBD0BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F2D3BFB1F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8A2FDC43;
	Sun, 12 Oct 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhSyiElS"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932D2FD1DD
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297060; cv=none; b=k8gPhkowtBWE8ewxpst9NBbjHsvb3Dvh99fXrZw4FnRx80by/lbaqlq8Oc6AL6/1wpNWLoHNT1/eYg7BJBSm/bcXYd5tkrj41cO1gHiVIeCwkSKq/HHw+/tbdQUJMDLZBf+3a+4gvlfXV4y8HEHQR1RUAkdyAU9/2Qj9t+nkSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297060; c=relaxed/simple;
	bh=ErqsMLJpxzUTMtTz2Dz7Gq5FTD1dwcKP3WwZLtDrtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKY2g6h2EAAj3fNCGVoJpwvFQ0QVOoGwJRnlHv/gGGZKUXX4jhctwvtOfcF2faMl2umg5ZT9vvn1wS4UZUUSno9yUBTktQi7CXFwhqPjufwg8TEHoDwDV3aKB0HP0dlfLEJkaVrkJtyDvrZqQpCBNYRPH1YqH5Bni00gT6ySr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhSyiElS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3ee18913c0so549788566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297055; x=1760901855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRrJwhH9ddhv+15LnO8TBX702Sbu4XiFGKBFd7hqCR4=;
        b=WhSyiElSZGsNLHb3pp6o0Us3lJDUnESpI0rtlpeRmrDMqKdff+FCdvhfVJqTqEQCiE
         0ms7gOrAEfz27vROAAyOuHLyUvYLX167KaTdzB7/1f+ClZRcG/HNLCCsgsNIxhvIBIIb
         quHpykrp8cW8zRYHc1Al4fNO/HQVv0pB+r5/TWFUaTW+xycvDZtZ/OT43csGZ6tnBLi8
         owNTE6c/cGtna7ZVm3e5cEbuzVQSqjS3NRYciMm4If77CCkNhtwJSGkn/UriiIfom9vD
         mOgWXm2TLxnoEXehtDqPYXZ0lWZwrj8T/MlfqWv+QsbDEjPT0OeldW1wHDFd4bExKbg7
         hdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297055; x=1760901855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRrJwhH9ddhv+15LnO8TBX702Sbu4XiFGKBFd7hqCR4=;
        b=U3O4LgSRbfUqcMXamioxEaApsd6AHopg28ttEyvQQ00wXsrahtEs9mhEJ2Z6GqD3d4
         mM8eYTRBn5W8TTU6+T3I+rs1qPSxD0ukTR7PO6nCzPInUXCnTPa9QhCK95k02Ui06MKL
         ew+9sXNEyIEF3mJPzH2OeX1HVkmVXcvJdgoLB8BFbCQwZmyhfliXX156DeeaLy7kvsqr
         HY/iD3xq0TR57Fi1EbF/U1FX2vIQ82nZJF8jwWHldYIeYff5i5Af79JOrsf2V/ZUGKd6
         AxfjC1rL9qUpgRIF2zN7lDG1ascMil1VysXZkxQogY2iQ39+8rT9U/YFh2hjnhw7oV49
         hOHw==
X-Forwarded-Encrypted: i=1; AJvYcCXMdfOFLi55SNyd7JhI4VXaN6PySaCqYsswGIku5I7c72EayFgCLQg4PJVO3Q0rMiRGlRebTTZGWusJH30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZDKRz37jY6yrHSRavTzXv1EMacTnUbhdUdvtyjOVbJ6tDbvx
	psmsISdozHm5DvVljxD/CbzA4GGPz1qII5O5BkqCg9z9d96ztWqN/e3g
X-Gm-Gg: ASbGncsKfdSXk9zEGc3Alz9qcSHVS2zr7u3c35aPwVAXuRY8kgOi3H9aWlHjeW/FSd7
	KYmubyzUMBlEqVqbTaVRBqUxZgOhgSBKFX4PyHbsag5czlB09I3OI3Cmh7Z2dP+ODhEWUDaD0j7
	qL50GCfET1+CXKVMJECnX42Ae2Mto5BArEkTb2JAprCYOTmiqXqSXCAfLMV5jcXrpekRcmJ8Z/P
	J5vH89byFV9p2JRanK07pNyB79jtAimC85WNg2Q+e04hCK0Y/pF5GKpz3AdRVJtpYZzwpa6Nyap
	CLYCIGerGzpJuIduRYPC2M8YyaismGiW/gYhfeGFVpKe8TBGxZUD3do41sdqMGTGlrSjaVWU1SS
	MXDh/AQo59isBnuONCUfQBqT0uGDoZtw029zd2PWNExeFf5jvlgcwwihK4A34a5VkDa0eGE5CmM
	judJ2R1UqaF/wfhQ5LEqgJ
X-Google-Smtp-Source: AGHT+IHJQrrQMxeS8oZx8uyeW6QR9xFsch3rBeFPh8aSvtGAg80UGkiRC2h+N6V1nwsHDzVkAOCO0g==
X-Received: by 2002:a17:906:c113:b0:b29:e717:f0b0 with SMTP id a640c23a62f3a-b50ac4d3497mr2029519966b.59.1760297055250;
        Sun, 12 Oct 2025 12:24:15 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:14 -0700 (PDT)
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
Subject: [PATCH 30/30] drm/sun4i: Nuke mixer pointer from layer code
Date: Sun, 12 Oct 2025 21:23:30 +0200
Message-ID: <20251012192330.6903-31-jernej.skrabec@gmail.com>
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

It's not used anymore, so remove it. This allows trully independent
layer state from mixer.

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
index 10e40ec9a67a..5de68cbb6060 100644
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
index 52d1b40ab71e..6b59c52ba4d5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -225,7 +225,6 @@ enum {
 
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
2.51.0


