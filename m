Return-Path: <linux-kernel+bounces-885309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B752C32910
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89DD14F0D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651C34320F;
	Tue,  4 Nov 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6/Ls0Bc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000C33E361
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279820; cv=none; b=UnWHgrWL8vmfsui9fpV/MjcJ8wYWHUufz+menMTZ8qK9ljURTaqGjBfawtmeXtbjmQlacsWmbeBBx0I5ZeYkeYCKP8AgMvvbpENo13uNXJHinmdt7YzYjjpDnO1kXcj5cfxQ7CKmK/Iktl6+XPW4HgYdSOdxlZgb+yducjU1RoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279820; c=relaxed/simple;
	bh=vsQRDrwjNb3dB2XQvKOWy7fWTFXCX/LOwxxjT9gCKe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy4LFIXHG3X+A4GzWSx6RN7kpJV3RfrgnBnk09eGMDBl6luGwg6r+oxZzolDaGYAcJgbzmGKJ3ozEwfH/bUVPJEx+9hgxSQxig7wcMd/jMxwFyWFencBn2DnO/xrAH2K/KCcdUeNV0BWfAXsGqNkd901wDvi3wb72U3N90DgQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6/Ls0Bc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477563bcaacso7269415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279816; x=1762884616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd2rGfbR52BnpdSsNRlsO1gNn2vRHDyP0CX62x34+dg=;
        b=I6/Ls0BcPfhJ6emj3t1GrxGQh1vIQbw95zfgC/euyRrafuZnExlalwp0VxKruP3xUm
         k3mFoCgQJqI2Mwbr6+FDY6yawL7mZGSxPuPhI01m9lOVQIvMyZjYxV0EZuZ9GUK9WHUJ
         x590SwnPkJGn22lG1mv7pNfFOzGPy7HWV2O0JQTuvXD7v8FiETpO6CiAbBwneLcC926W
         7s/7QvqA2Ibcy3VC8joLThW2m1/hlLBC2rVykXf7w3pga1XmJK3NKPmvw18WgOZ1RUN9
         0ZeUI4XvnJG2OIeNJrww6Y3k6MYpvMaWN9xnuqfrfKGf0MKM2u3iw90G5JN7N0yb5qGs
         1Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279816; x=1762884616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd2rGfbR52BnpdSsNRlsO1gNn2vRHDyP0CX62x34+dg=;
        b=q/nfv0hGzUja3HELJ1Q0dmXIbe2M5drd/07dYU1sH27AXC6UC0WU6X1RbLiKh+T1D0
         F2dSk6uuEicYlwDhdbTbUwRrBjYpKlzrGYlLyXEWXiPaGagmwBBc6cDypqbGCrMNUYy0
         T7SULRoasfGX+XFzLjoDo7gIZFAG456pd6BUVbjZEA0osKZQtTrmb2RR3QB5za3UNtI+
         /5QHalZy5Eem+KSanacXQ2faIM4/u1nFhTs08cF196+G7kS3o92D3z2HY5L+spQbvPoB
         HFtusG0Zu8OesaFcBGadq4b9+afIFj3zIm1HRoZeoR9wEQnId0aQOb99BfZIAdQfgzf4
         itJw==
X-Forwarded-Encrypted: i=1; AJvYcCWyh+qr3lTkadXH8xR+k9EigZbGoS1edIgao5VBFn4dBTKHk25RvvBuB3WmEr4hES6fxILBPYBIqoFD+HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBj2FBR2uAaAmw7mShVlJwdCIx058bzeKB5xWSb8e8Hiny0xbW
	lMHe/y80QPwW61HoSamhKidq8XtCzGRGZ7L0ZGeX5uUtO/rXmyV6UtR+
X-Gm-Gg: ASbGncvWGMsdiPgBxiGlt6/HB438HmPDm/EBKAI00BfSjhYdAIkd6menQonKqEoiR1f
	zU33e2buM+NfIb4pw//tP5ZgSaNEzvTQqtQ1C+ZnTJXmp1PcnaZHgonP/Ytn9ZEyUgNBoBQJaXQ
	XsLZix9NnUaLk5Bd82QECzmMXs20nuv5WDAWU/dl7sYr9uxKZSibyfXDnyWuWpzqaqFBNooezFU
	n3ZA/NiAXQ65gH1y3d+Szr+I26HE5pLWcoAiWMD6nFO4nh49MaEpG4GwXtLVGAEQPZcvAJYXXTm
	ivAtY5r8CpS4o7wgW+KaOcChHTP73aw/wMeMYFBXj+QCflxq8S+eb96ohjwBq2ijEa54/f6jqnt
	4uZF/SC6rOUv3ROYEmUeayp20viHAuMd5U4WPO1lm9pKmhe4+AzLtCp0/bmxtI6LCo4N4teBHPu
	ZPAdwz3whBSXS9JF2sZVprFScXj3tQ
X-Google-Smtp-Source: AGHT+IG2sBblS49qAXjvkf0vtV34n/K/LEVc1O2UQPjWyBa6gyH0Uf01mtvCoKB5v5EtjbqR1NJhbg==
X-Received: by 2002:a05:600c:1994:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-4775ce9ba5cmr1913685e9.8.1762279815509;
        Tue, 04 Nov 2025 10:10:15 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:15 -0800 (PST)
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
Subject: [PATCH v2 11/30] drm/sun4i: de2/de3: Simplify CSC config interface
Date: Tue,  4 Nov 2025 19:09:23 +0100
Message-ID: <20251104180942.61538-12-jernej.skrabec@gmail.com>
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

Merging both function into one lets this one decide on it's own if CSC
should be enabled or not. Currently heuristics for that is pretty simple
- enable it for YUV formats and disable for RGB. DE3 and newer allows
YUV pipeline, which will be easier to implement these way.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c      | 89 ++++++++++----------------
 drivers/gpu/drm/sun4i/sun8i_csc.h      |  9 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 11 +---
 3 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index c100d29b1a89..cf0c5121661b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -107,23 +107,28 @@ static const u32 yuv2rgb_de3[2][3][12] = {
 	},
 };
 
-static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
-				       enum sun8i_csc_mode mode,
-				       enum drm_color_encoding encoding,
-				       enum drm_color_range range)
+static void sun8i_csc_setup(struct regmap *map, u32 base,
+			    enum sun8i_csc_mode mode,
+			    enum drm_color_encoding encoding,
+			    enum drm_color_range range)
 {
+	u32 base_reg, val;
 	const u32 *table;
-	u32 base_reg;
 	int i;
 
 	table = yuv2rgb[range][encoding];
 
 	switch (mode) {
+	case SUN8I_CSC_MODE_OFF:
+		val = 0;
+		break;
 	case SUN8I_CSC_MODE_YUV2RGB:
+		val = SUN8I_CSC_CTRL_EN;
 		base_reg = SUN8I_CSC_COEFF(base, 0);
 		regmap_bulk_write(map, base_reg, table, 12);
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
+		val = SUN8I_CSC_CTRL_EN;
 		for (i = 0; i < 12; i++) {
 			if ((i & 3) == 1)
 				base_reg = SUN8I_CSC_COEFF(base, i + 1);
@@ -135,28 +140,37 @@ static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
 		}
 		break;
 	default:
+		val = 0;
 		DRM_WARN("Wrong CSC mode specified.\n");
 		return;
 	}
+
+	regmap_write(map, SUN8I_CSC_CTRL(base), val);
 }
 
-static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int layer,
-					    enum sun8i_csc_mode mode,
-					    enum drm_color_encoding encoding,
-					    enum drm_color_range range)
+static void sun8i_de3_ccsc_setup(struct regmap *map, int layer,
+				 enum sun8i_csc_mode mode,
+				 enum drm_color_encoding encoding,
+				 enum drm_color_range range)
 {
+	u32 addr, val, mask;
 	const u32 *table;
-	u32 addr;
 	int i;
 
+	mask = SUN50I_MIXER_BLEND_CSC_CTL_EN(layer);
 	table = yuv2rgb_de3[range][encoding];
 
 	switch (mode) {
+	case SUN8I_CSC_MODE_OFF:
+		val = 0;
+		break;
 	case SUN8I_CSC_MODE_YUV2RGB:
+		val = mask;
 		addr = SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0);
 		regmap_bulk_write(map, addr, table, 12);
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
+		val = mask;
 		for (i = 0; i < 12; i++) {
 			if ((i & 3) == 1)
 				addr = SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE,
@@ -173,67 +187,30 @@ static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int layer,
 		}
 		break;
 	default:
+		val = 0;
 		DRM_WARN("Wrong CSC mode specified.\n");
 		return;
 	}
-}
-
-static void sun8i_csc_enable(struct regmap *map, u32 base, bool enable)
-{
-	u32 val;
-
-	if (enable)
-		val = SUN8I_CSC_CTRL_EN;
-	else
-		val = 0;
-
-	regmap_update_bits(map, SUN8I_CSC_CTRL(base), SUN8I_CSC_CTRL_EN, val);
-}
-
-static void sun8i_de3_ccsc_enable(struct regmap *map, int layer, bool enable)
-{
-	u32 val, mask;
-
-	mask = SUN50I_MIXER_BLEND_CSC_CTL_EN(layer);
-
-	if (enable)
-		val = mask;
-	else
-		val = 0;
 
 	regmap_update_bits(map, SUN50I_MIXER_BLEND_CSC_CTL(DE3_BLD_BASE),
 			   mask, val);
 }
 
-void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int layer,
-				     enum sun8i_csc_mode mode,
-				     enum drm_color_encoding encoding,
-				     enum drm_color_range range)
+void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
+		      enum sun8i_csc_mode mode,
+		      enum drm_color_encoding encoding,
+		      enum drm_color_range range)
 {
 	u32 base;
 
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE3) {
-		sun8i_de3_ccsc_set_coefficients(mixer->engine.regs, layer,
-						mode, encoding, range);
+		sun8i_de3_ccsc_setup(mixer->engine.regs, layer,
+				     mode, encoding, range);
 		return;
 	}
 
 	base = ccsc_base[mixer->cfg->ccsc][layer];
 
-	sun8i_csc_set_coefficients(mixer->engine.regs, base,
-				   mode, encoding, range);
-}
-
-void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer, int layer, bool enable)
-{
-	u32 base;
-
-	if (mixer->cfg->de_type == SUN8I_MIXER_DE3) {
-		sun8i_de3_ccsc_enable(mixer->engine.regs, layer, enable);
-		return;
-	}
-
-	base = ccsc_base[mixer->cfg->ccsc][layer];
-
-	sun8i_csc_enable(mixer->engine.regs, base, enable);
+	sun8i_csc_setup(mixer->engine.regs, base,
+			mode, encoding, range);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 828b86fd0cab..27b6807fc786 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -28,10 +28,9 @@ enum sun8i_csc_mode {
 	SUN8I_CSC_MODE_YVU2RGB,
 };
 
-void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int layer,
-				     enum sun8i_csc_mode mode,
-				     enum drm_color_encoding encoding,
-				     enum drm_color_range range);
-void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer, int layer, bool enable);
+void sun8i_csc_config(struct sun8i_mixer *mixer, int layer,
+		      enum sun8i_csc_mode mode,
+		      enum drm_color_encoding encoding,
+		      enum drm_color_range range);
 
 #endif
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 727117658c6c..adcd05acba1b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -213,14 +213,9 @@ static void sun8i_vi_layer_update_colors(struct sun8i_mixer *mixer, int channel,
 
 	fmt = state->fb->format;
 	csc_mode = sun8i_vi_layer_get_csc_mode(fmt);
-	if (csc_mode != SUN8I_CSC_MODE_OFF) {
-		sun8i_csc_set_ccsc_coefficients(mixer, channel, csc_mode,
-						state->color_encoding,
-						state->color_range);
-		sun8i_csc_enable_ccsc(mixer, channel, true);
-	} else {
-		sun8i_csc_enable_ccsc(mixer, channel, false);
-	}
+	sun8i_csc_config(mixer, channel, csc_mode,
+			 state->color_encoding,
+			 state->color_range);
 }
 
 static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-- 
2.51.2


