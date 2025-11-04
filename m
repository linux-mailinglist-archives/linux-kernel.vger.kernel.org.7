Return-Path: <linux-kernel+bounces-885323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4FC32934
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31DAB4F56B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCF347FC8;
	Tue,  4 Nov 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFY2ijT9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCA346E7D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279837; cv=none; b=P4ecrBIZVzFdrRS81HlcgvAB6QwsWHcAArGg5yJ3Gp8f2bKzKXst14vKr28enoVguFifK7+c0NthEVN6iArGL7MKMyPUXno8xJgvLtPZ97zf9RTd4BAlXp4sW/2CSq5to8Z2CS2UVo+3YkBEK5kWzkkK1GXo8E1QpUCkDm2eZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279837; c=relaxed/simple;
	bh=kPiLeYIsEiImYjtRwjEv/BEoeWdW4RbU08GWQ9yKjcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LejJibaVhNygiiUQAGnTPfy38gnZCisy2G1ohn9GTeE35x7oFKqawBiLrXHoTyexxqtUqoVfWl0xckZ2b+nHkjkIpBB9/E6QkNiTXg6g0oWpHzERuPfhdfskFPGXy4fmAaDP7Z8uS/BSKD0JMCJNJsl/As4ZwO6LWokUXBAqJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFY2ijT9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dae5d473so7380315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279832; x=1762884632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie7hWDcTxuQcquWuqifGQoLXnJlmFfjHvsfXK9+oj4E=;
        b=AFY2ijT9VSYKl0Iz3i9cwm8+/sRyGi3F2QHjlheICJxWKDyvla7GKJaoA8Uhd2t8pD
         MB/ND7RrXIiV6IR8F5MvWkj7DaTIg+W7vpvhZBbOZ6IIUaja+IElqrDCmHd2uye5G1tw
         6yGfsviQm+Jr12wMdppFfqQP9kPiby/Nal4dkPSzS+/yHDz2OdACE1mCwVevVrhnYN0M
         r4Z6YXs/s5zYnA1R7GXc2ltWYK2w/cZLe6qvmxBOucyi6gTjSiq5ZL+M2zRaVecc0UHc
         SkQy2Dnr54LlHiwS/BQo1axJ6nODaP0Pwd+cnOYtqM0MzihcZMyvXCdYdJkaQLQPPSDG
         X8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279832; x=1762884632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie7hWDcTxuQcquWuqifGQoLXnJlmFfjHvsfXK9+oj4E=;
        b=INqKM7yK+EZnwT+ifyp/SrpsEHnDZZGIH3lQmUHfFxwwy9PmOok6O0Yp44Mjhwm8/l
         WG2cTgnS6rqsB4lDa9btK5dQLC+uzjwenzERassbTtrvXiTYdJQy09wVsXCXdt2YsToo
         Uu4rCXXLz/+Bl6GqmeHTNgcbY6kEp/5+JSo0Pza1EspsqxwMyetsSq1VEz/Qz9x8H4wJ
         Fw/ExRXDQ4FQwHEgEJTDHggYkqwvqydGlVxciJgv7ayd6HcgtpoBW62wFnhoR7XvOPuy
         qsRv5oG27PQasFmxOF1jwmHK+v/hME/N1PnqH0cilew5sRPitwzQZdTk8+eX1NBzwTTd
         7GRw==
X-Forwarded-Encrypted: i=1; AJvYcCVQMPZZ+23roE1LMr94SqHYOyOnqUMTJol1VV80S7GBBSXZ8PeZM6b2HouXpIwT5VpEaQz8rBAnXwc5N3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hnXvgrY/7PTkcmc9kMESkfWUHhHabj6cXJcaatgu05L2709/
	I0xUycOsKwNyYuRQbRslxeI7zjJWB//LA3xiFhWJys9Wvc6jsZhNeQwU
X-Gm-Gg: ASbGnctsrx178vLn942vSxfKqNrAwrp36YkPEoyafQyt38TFvGaWeR2MKFBkAe+r2Zl
	JhdRXAmb4Xdqu1/o439pln81RqkzWWD2qqv/d8RYD2ucKfpdF8mNNS6CADzG22+Z/LAL+Ym6rRP
	AV1dC3ajPem5TFv0pY6rveBKhdhZRyBQi1YtVazUQThvKgDq7AR4EzWs2oXWNtBChn2NuGL18kO
	yHe3UbwtfCk6CQkj+yOzs0fMwQF52rKsRFBne58EZiYyUd3YTAmf9mPppoBlupMEuXCKB07vVie
	7EfwayD3Zt6eaTMV8L8fUZFauQ8OMPcC57gLz/duJrsKOQeRhyxJQyIQvL87vVhmX7EmiUcbj3I
	JUvOqdgqoDAu+Jk6dyhRw8htyh30DQx70f4z4/AcUDL7E7OXh8EqRTXzqvys0iXkoC0gaaa2kpS
	fqpp8LiqGDKu89sRowXg==
X-Google-Smtp-Source: AGHT+IEWn71DBw19df7j5vHe6/KdNSpZp9M6RzMXn87h8SZBHIPpRNzHDnrglGnelBkuvtMKpO/7HQ==
X-Received: by 2002:a05:600c:a00a:b0:475:d7b7:580c with SMTP id 5b1f17b1804b1-4775cdbfademr2635395e9.12.1762279832100;
        Tue, 04 Nov 2025 10:10:32 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:31 -0800 (PST)
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
Subject: [PATCH v2 24/30] drm/sun4i: mixer: Convert heuristics to quirk
Date: Tue,  4 Nov 2025 19:09:36 +0100
Message-ID: <20251104180942.61538-25-jernej.skrabec@gmail.com>
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

Determination if FCC unit can be used for VI layer alpha depends on
number of VI channels. This info won't be available anymore in future
to VI layer driver because of DE33 way of allocating planes from same
pool to different mixers.

While order is slightly changed, it doesn't affect anything due to
double buffering of registers. New order keeps related registers
together and quirk separate.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- updated commit message

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
2.51.2


