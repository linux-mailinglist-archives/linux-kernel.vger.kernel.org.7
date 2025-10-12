Return-Path: <linux-kernel+bounces-849717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A2BD0B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9494ED85C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7A2FD7A7;
	Sun, 12 Oct 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3rNHeqT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7E2FC02A
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297056; cv=none; b=hoG79SmA92ywnr+i+bWolns1v0ADknZml+SrIEadqKOhQ1Lm+1XV0CLBCp3d9FGqLgEZJakvCQ+Lk3QYuxceW+dykuJYkecU4AUcNd2bEwf3Kf17IgjEETPMcmWIIKMzYzm3VSO7LU1OhbkgxkWhkIkeGvvChHN1Lp/t8Pggms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297056; c=relaxed/simple;
	bh=tujLjutgBntT+dXd3d7n3u+p14RLIvtn3qv3lUiYySI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ4CBpOxDMqd+wMNT3FaT+vqJrKlTMLv+yXXk7HcAhMcml1+//DCN2HMGsi8+e0gXSD2i+teHStSSNZemPwMLgCELbDyLlAuS0iOtLXO6A/0VK4wvNG5PykexyBE1vL2GXK5sDUBgU4bXFVcmN5RqEsNPMQ3fK2+80tFhB0Lr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3rNHeqT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3b27b50090so653305166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297052; x=1760901852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaJPE4L65CXDkqyIuBABLqdOxJoCd3GcyPIY1yQyHic=;
        b=j3rNHeqTQKKweg+mWyLFYU3mV8RO8VLYgRcF4Vl53QemcHYPwrCC1lycBgAWQSRTUb
         JE/vZSWwpDeuxJdYisMG8osC95H4BXF7yQv6nnzpbcwIR6UuJih9sFW05RXCcMknwsJ4
         Kmg2lH2KUS48RF4yyViXDbXoriXomFOl+YGiiIMQBeNN2aYKWoB0Bx9Q1dZiytUCcy/9
         0Ao3TFezx+8nZFqP+gS3Df8yn/tZ2R6+S8NWdAJT+OuthJ0zA1yYqM6ZmLcXSyCrGVSA
         34iVSl/QXyaIjzf28nOBrLp1Eq5iJkQif1RBcYwINCcDLI6RTjTz3X7emoiyMh4ZhVHI
         y/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297052; x=1760901852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaJPE4L65CXDkqyIuBABLqdOxJoCd3GcyPIY1yQyHic=;
        b=pDAmWpnzt12cqwEhzkK5rdmAqDZs/dMwL0tbCacjb8NlUuOL8Jw6lqp1A4rdq6Sndp
         PwCzrKFOf5TmNwhPWgl8t1TP6OGOujdjHI5dFmyaFd3szhQ+4QfMr0JNl7lZETfJKWiV
         KysV36qwf+LITaIQW3XSHrREeP4uQLgyKJRsPE6S5tQb+KzM1fQ0FpE6iOB7V37E1+CN
         zgTEf2IOm1Q3eBT6sI9rwnnGg13fUz9gzPtk/HEmhel1tNwlNAcPEb9UcP4nfhd7pvbq
         A6us/Nj0YjCmTD11ouQ3ECt0YVrjzDT7SXOpYPJQenLGK8DGHqsiTdCXVVfCmMpQ7DVQ
         0axA==
X-Forwarded-Encrypted: i=1; AJvYcCUgzJnEGLQyzV6ptu6blRKmX2BvsJGyMGZLqJzjcIhUeOtujWlZwSSU7ZLZUkNhJE2mYc5Fdr9g5NG5XKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlb+5WDssk8qZUGjVbvhb616+/jXU+kWgmLrAlBpeoHXeR7Cj
	ze/7fNEofAGcvot4nIQnOh4TbwGH0TOpBl4YfgUhmhAj2SkmyIvhCjOU
X-Gm-Gg: ASbGnct6BaLHv7CYSoC/xxPKtBESK6CrrN0b7my8gPDzXossEd0lW4SZ03jPM665QBh
	CGOYMvLuGHSh0GGFhJQ0re04QRiS59iF9JSKF2awcUpzkhXdp/RklHNjgYUy1h7dLBvyCXhEO9Z
	IAcrzoQqYgv5DDvG+dS7gv14Ps/Erd4YsFDDkAGKWShJV4u61M1caeoZ0EaGv34xeX4qx7C4KeN
	ywBjlbSs/+ApFjp4oBXp5kZ+I+XjHqy3Mp1mb3NdI43tCQ/xQceeB5U8JcQpGzz33eishfZQkeW
	1+5lvFwd9jTSMazoqmwI0sorMnEn9oWq94GdOxRkdFW/LDxqCtMokBPotodx9NxGpca5Tebbthi
	05wMcwfcIQn1QKt5OVXgQ0QIJtIKnDO11I6pHDqihQWuu9l8QUdtOE/FHw8Vb2EJgGCecDD8Rgg
	SCHfcpgBiSzzUjUT3bLYbVjSYZwkR85GY=
X-Google-Smtp-Source: AGHT+IFQEmoHaQY1HSeHivRc7zOWRD2roSYeAHB1g5htc57RrShWiGIm59M++o32pnXdabZt6E9p4w==
X-Received: by 2002:a17:907:94ca:b0:b46:1db9:cb7c with SMTP id a640c23a62f3a-b50ac1c6951mr1943566866b.33.1760297051775;
        Sun, 12 Oct 2025 12:24:11 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:11 -0700 (PDT)
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
Subject: [PATCH 27/30] drm/sun4i: mixer: split out layer config
Date: Sun, 12 Oct 2025 21:23:27 +0200
Message-ID: <20251012192330.6903-28-jernej.skrabec@gmail.com>
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

Later special plane only driver for DE33 will provide separate
configuration. This change will also help layer driver migrate away from
mixer structure.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c       |   2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 152 +++++++++++++++---------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  32 +++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  |   2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |   2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |   8 +-
 6 files changed, 122 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index c371e94b95bd..30779db2f9b2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -240,7 +240,7 @@ void sun8i_csc_config(struct sun8i_layer *layer,
 		return;
 	}
 
-	base = ccsc_base[layer->mixer->cfg->ccsc][layer->channel];
+	base = ccsc_base[layer->mixer->cfg->lay_cfg.ccsc][layer->channel];
 
 	sun8i_csc_setup(layer->regs, base,
 			mode, state->color_encoding,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f9131396f22f..a01eccfca3a9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -703,137 +703,173 @@ static void sun8i_mixer_remove(struct platform_device *pdev)
 }
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 432000000,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
-	.de_type = SUN8I_MIXER_DE2,
-	.vi_num = 2,
-	.ui_num = 1,
-	.scaler_mask = 0x3,
-	.scanline_yuv = 2048,
-	.vi_scaler_num	= 2,
-	.ccsc = CCSC_MIXER0_LAYOUT,
-	.mod_rate = 150000000,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.vi_scaler_num	= 2,
+	},
+	.de_type	= SUN8I_MIXER_DE2,
+	.mod_rate	= 150000000,
+	.vi_num		= 2,
+	.ui_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
-	.ccsc		= CCSC_D1_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_D1_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x1,
+		.scanline_yuv	= 1024,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0x1,
-	.scanline_yuv	= 1024,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 0,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 4096,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 4096,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
-	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
+	.lay_cfg = {
+		.de_type	= SUN8I_MIXER_DE3,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 4096,
+		.vi_scaler_num	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE3,
 	.mod_rate	= 600000000,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 4096,
-	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_h616_mixer0_cfg = {
+	.lay_cfg = {
+		.de_type	= SUN8I_MIXER_DE33,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 4096,
+	},
 	.de_type	= SUN8I_MIXER_DE33,
 	.mod_rate	= 600000000,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 4096,
 	.ui_num		= 3,
 	.vi_num		= 1,
 	.map		= {0, 6, 7, 8},
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 40b800022237..8629e21f9cf6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -164,34 +164,44 @@ enum sun8i_mixer_type {
 };
 
 /**
- * struct sun8i_mixer_cfg - mixer HW configuration
- * @vi_num: number of VI channels
- * @ui_num: number of UI channels
+ * struct sun8i_layer_cfg - layer configuration
  * @scaler_mask: bitmask which tells which channel supports scaling
  *	First, scaler supports for VI channels is defined and after that, scaler
  *	support for UI channels. For example, if mixer has 2 VI channels without
  *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
  * @ccsc: select set of CCSC base addresses from the enumeration above.
- * @mod_rate: module clock rate that needs to be set in order to have
- *	a functional block.
  * @de_type: sun8i_mixer_type enum representing the display engine generation.
  * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
  * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
  *	Most DE2 cores has FCC. If number of VI planes is one, enable this.
  * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
- * @map: channel map for DE variants processing YUV separately (DE33)
  */
-struct sun8i_mixer_cfg {
-	int		vi_num;
-	int		ui_num;
+struct sun8i_layer_cfg {
 	int		scaler_mask;
 	int		ccsc;
-	unsigned long	mod_rate;
 	unsigned int	de_type;
 	unsigned int	scanline_yuv;
 	unsigned int	de2_fcc_alpha : 1;
 	unsigned int	vi_scaler_num;
-	unsigned int	map[6];
+};
+
+/**
+ * struct sun8i_mixer_cfg - mixer HW configuration
+ * @lay_cfg: layer configuration
+ * @vi_num: number of VI channels
+ * @ui_num: number of UI channels
+ * @mod_rate: module clock rate that needs to be set in order to have
+ *	a functional block.
+ * @map: channel map for DE variants processing YUV separately (DE33)
+ */
+
+struct sun8i_mixer_cfg {
+	struct sun8i_layer_cfg	lay_cfg;
+	int			vi_num;
+	int			ui_num;
+	unsigned int		de_type;
+	unsigned long		mod_rate;
+	unsigned int		map[6];
 };
 
 struct sun8i_mixer {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index e65dc313c87d..f71f5a8d0427 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -190,7 +190,7 @@ static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
 	min_scale = DRM_PLANE_NO_SCALING;
 	max_scale = DRM_PLANE_NO_SCALING;
 
-	if (layer->mixer->cfg->scaler_mask & BIT(layer->channel)) {
+	if (layer->mixer->cfg->lay_cfg.scaler_mask & BIT(layer->channel)) {
 		min_scale = SUN8I_UI_SCALER_SCALE_MIN;
 		max_scale = SUN8I_UI_SCALER_SCALE_MAX;
 	}
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index 0ba1482688d7..4d06c366de7f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -91,7 +91,7 @@ static const u32 lan2coefftab16[240] = {
 
 static u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int channel)
 {
-	int offset = mixer->cfg->vi_scaler_num;
+	int offset = mixer->cfg->lay_cfg.vi_scaler_num;
 
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_VI_SCALER_UNIT_BASE +
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 8eb3f167e664..0286e7322612 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -53,7 +53,7 @@ static void sun8i_vi_layer_update_attributes(struct sun8i_layer *layer,
 	regmap_write(layer->regs,
 		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay), val);
 
-	if (mixer->cfg->de2_fcc_alpha) {
+	if (mixer->cfg->lay_cfg.de2_fcc_alpha) {
 		regmap_write(layer->regs,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
 			     SUN8I_MIXER_FCC_GLOBAL_ALPHA(state->alpha >> 8));
@@ -152,7 +152,7 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 		}
 
 		/* it seems that every RGB scaler has buffer for 2048 pixels */
-		scanline = subsampled ? mixer->cfg->scanline_yuv : 2048;
+		scanline = subsampled ? mixer->cfg->lay_cfg.scanline_yuv : 2048;
 
 		if (src_w > scanline) {
 			DRM_DEBUG_DRIVER("Using horizontal coarse scaling\n");
@@ -278,7 +278,7 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
 	min_scale = DRM_PLANE_NO_SCALING;
 	max_scale = DRM_PLANE_NO_SCALING;
 
-	if (layer->mixer->cfg->scaler_mask & BIT(layer->channel)) {
+	if (layer->mixer->cfg->lay_cfg.scaler_mask & BIT(layer->channel)) {
 		min_scale = SUN8I_VI_SCALER_SCALE_MIN;
 		max_scale = SUN8I_VI_SCALER_SCALE_MAX;
 	}
@@ -452,7 +452,7 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(ret);
 	}
 
-	if (mixer->cfg->de2_fcc_alpha || mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
+	if (mixer->cfg->lay_cfg.de2_fcc_alpha || mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		ret = drm_plane_create_alpha_property(&layer->plane);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't add alpha property\n");
-- 
2.51.0


