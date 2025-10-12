Return-Path: <linux-kernel+bounces-849714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C806BD0B93
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FACF4EC0CD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD742FC027;
	Sun, 12 Oct 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGd892BY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFC2FB967
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297052; cv=none; b=HjEzVHBOUSN8WFI+B4WBCYrL82JL9hznPjmwFDhiw4i8G8oGjWtdjR4e7FPXIMbix3M1OcaF2tvvKBGjIQNtPnAc3iNa/enZaLhrGJRjE8aTGVOSnDCuBhz0Np3vGV5m4ffD7p6uJYP7lBzX07HX0XGl/U9SRkl5BBs5AASH6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297052; c=relaxed/simple;
	bh=Q1zvYB3flC6Y+FU4UXXFlPiLBwxnmOrVYL/JdQWlsDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8/RizNfUUgS3guEYkElN0fxjXwKTCHlaFMZ7+u+heyC/fUuzs9qRSRn09JBvHbYJynnVxYhbiEtkv8rcOomYeTrIbSadK+/KQ1OCbrP9n4hEdSIxgbsk3WHz0iTaLRlJ2V7UkR394uu8PVQgsUL5vqBUC0UcIDp1li//ESQltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGd892BY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b00a9989633so650788466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297048; x=1760901848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DrFRmdaEbeeGFVkadVtzvz8t+dwN3rT/7iEQHdomrY=;
        b=aGd892BY9gIr6OtvsJDhBJA5QNz/v7RukcujwLl49rHQIdIgKktkyxgvn0p4wmhliY
         ERM/YeYZ1vmDeinQCXIG7RChN0cYgUYSpmKv3elHCqccyapSGIFXz0GlqboEMjE1tSu1
         WOJcdej5dxlCjGzfMnbP4xiUGkmnAdfe0ulio8R3c0+0ovGNAiJvaowZyrHd7BPTh5Fp
         AksZlvp5OjK6tKo+ujqo2i/+O0rlZHoZowjGlqGIi8id9lANjYknvHKcnnUdL/MIOF6W
         lBeZuAKIYIJ1uKmUlDaHezt/NoiryiFTqrWAuxBNjjORTGrVF30hS7OYK1UJW94udCDS
         3xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297048; x=1760901848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DrFRmdaEbeeGFVkadVtzvz8t+dwN3rT/7iEQHdomrY=;
        b=uEA3qcDSOxat65+gV9HhYkCPu64HL9Ye/og0vFzFSltb473Sxb2Ewaxl8Bmmj/90M9
         74XRNPWsiSJUqwTTRzIT7sgkaVOK0qd8SULE3cgmtisD8S10ecAoSPTGi5FcybunCvbJ
         PaYL0pAWWM7irFlQlo/xqBoCZQoniVr/ca8VPFxzXlVZ34zEhUfaAXdXQpikJzT9hdmO
         4ISXOlZDLyzf9hfjE8ESmGmScCxMnYncReu16B/QuRi/G+54kT2cajrKbWz3hjG6Zn5s
         wpRCZk6xZkq/ggxO2zaNLksiDDdz4hwH1Y4Fm6RcU6HMMg8vDpEqKKwQxXQwt0ZGT/0K
         QSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWAZ7G+/Cm3Vt138zg9m12uO2TjYhlVJaRqJSnXvCC9kYmDocMpOSjMxF+8LRLfA9gnsnqFAM1PT0CTBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsuRYND+FKdmHo0MSlfTGCIwCSABCiCqUc5r2e4bXVYNYIOGT
	yYmDH/p0t8b3BcmmrnPeAmzx945udS4T1RVx4i6NIQuFdFo0aRMY5B9F
X-Gm-Gg: ASbGncv+vUUkUYfGKoTDBsYtxgd1eJ5wiOXQna354hXgVHgoKzqrHlwtSHBMTHgz09i
	PcbrUdDlspRkCil7joCgw50DYtzi6y5Ydbb5/7sgCz7m5j5bVR6wvrOhrFNd9DPh06ftrVESywr
	i15PDEPVBBE6t1eT+BDxwVWeek5Bg/fdr7Xp4/PsQPLFe/NFn/3IgZjYvhhEHSTa6mK2AyJA/24
	e60BRmdth2K4HTNt6Lp0gpUr2pnPJu4hK7CIwwK9Bhz2VUp73ddL2SXWhJbY0CDoGYSfa3QVlt2
	HSI+IqPvrO5Gp5nBkxsyJEynNyoz6q+KKJR+KlVDNUjN8cvk4+lD8k3qBI/GU9ScPzSwWWcgnKF
	lwA44dEll2ApeSDfGejirN3PboWREfkjntEXVLBvqb/kIWedaFJdJYyjPT3usjILhrxN45V+RMP
	cCEelNQJyKm0BXtuU97ZHe7++lHCBnIJQ=
X-Google-Smtp-Source: AGHT+IER01mRpg7q1Zer+a2Fi+tE48PQj5/njKDNX56YMkXj51QtTvzlx/6vPlXBx59MZeSRaZhVJA==
X-Received: by 2002:a17:906:ee87:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b50bf7eb3cfmr2100938966b.30.1760297048395;
        Sun, 12 Oct 2025 12:24:08 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:08 -0700 (PDT)
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
Subject: [PATCH 24/30] drm/sun4i: mixer: Convert heuristics to quirk
Date: Sun, 12 Oct 2025 21:23:24 +0200
Message-ID: <20251012192330.6903-25-jernej.skrabec@gmail.com>
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

Determination if FCC unit can be used for VI layer alpha depends on
number of VI channels. This info won't be available anymore in future
to VI layer driver because of DE33 way of allocating planes from same
pool to different mixers.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    |  9 +++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 +++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 +++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 267a6f75feb2..78bbfbe62833 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -707,6 +707,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 	.de_type	= SUN8I_MIXER_DE2,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -716,6 +717,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 	.de_type	= SUN8I_MIXER_DE2,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -726,6 +728,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.mod_rate	= 432000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -736,6 +739,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -746,6 +750,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -766,6 +771,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -776,6 +782,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x1,
 	.scanline_yuv	= 1024,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 0,
 	.vi_num		= 1,
 };
@@ -786,6 +793,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -796,6 +804,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index d14188cdfab3..def07afd37e1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -176,6 +176,8 @@ enum sun8i_mixer_type {
  *	a functional block.
  * @de_type: sun8i_mixer_type enum representing the display engine generation.
  * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
+ * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
+ *	Most DE2 cores has FCC. If number of VI planes is one, enable this.
  * @map: channel map for DE variants processing YUV separately (DE33)
  */
 struct sun8i_mixer_cfg {
@@ -186,6 +188,7 @@ struct sun8i_mixer_cfg {
 	unsigned long	mod_rate;
 	unsigned int	de_type;
 	unsigned int	scanline_yuv;
+	unsigned int	de2_fcc_alpha : 1;
 	unsigned int	map[6];
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 44e699910b70..8eb3f167e664 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -48,14 +48,16 @@ static void sun8i_vi_layer_update_attributes(struct sun8i_layer *layer,
 		val |= (state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
-	} else if (mixer->cfg->vi_num == 1) {
+	}
+
+	regmap_write(layer->regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), val);
+
+	if (mixer->cfg->de2_fcc_alpha) {
 		regmap_write(layer->regs,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA(state->alpha >> 8));
 	}
-
-	regmap_write(layer->regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), val);
 }
 
 static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
@@ -450,7 +452,7 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(ret);
 	}
 
-	if (mixer->cfg->vi_num == 1 || mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
+	if (mixer->cfg->de2_fcc_alpha || mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		ret = drm_plane_create_alpha_property(&layer->plane);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't add alpha property\n");
-- 
2.51.0


