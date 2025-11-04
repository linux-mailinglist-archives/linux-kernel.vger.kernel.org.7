Return-Path: <linux-kernel+bounces-885327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FFC3298F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113E546666E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8834889C;
	Tue,  4 Nov 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRogZ4Gl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC383347FCD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279840; cv=none; b=fF1G7sT9qc6ezn0UYPMK/kszlHXpr7KRtcgUKxUB0T5eURoe8t36oe62nycCUhqL59bbGh7rQ/WfcQiQ/1+Mi4MJqHbLdQR/Qdk/veWsWFqUew6Y/qtssk+ZIC40KUbxd9Xd4OiUj8w9xzduCKb+1pbxfdDPXQ/Uapb6WoIWwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279840; c=relaxed/simple;
	bh=I/Hk0/PHLO8sCGFPEQw+OU4WzVurFU0CE21OKjEm/Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPSAtfoS4x0VXGkq6P0uHlQIgI5eXLNwjhifGKS1r1195jqty3TXAhm3yePPixEXIWOlZXtysikVIHh64iDqKUSRmL/3MZ51Isb8JMZkIzEZWBfInUcRM5s+FGPBps9GljCC+WEdu2L9AFmTMyUj0SaHbjTX5RcpxpY5lw+7bA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRogZ4Gl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso78257975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279836; x=1762884636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZvB8XQL4XH/MG4JrDvft0iLE7MCAIYhxytBa3l55Ko=;
        b=gRogZ4Glf7DPPnHj1bDggoee5c/9CZMQRL2iR5Z6xqKd4o+whnrMAUiZ7Z4fbgus8t
         07pgPi0bq6sJvhbmGqSBzf7x+qYWMDDuuw2Jfxir0MlWr2UftutJmFTUBjOZMn4a+Zon
         FH5Ud21vLUGTIrmHerR8lkLjEeZGqq8whvg0FJ2otCUOtToAJx5c7kq8GYMPkoOCwmab
         67rOCm7i0NfHsmWmYC6KjshkNM5zoLLypoDTmn/0Pc6R5+GJIh1XgzcuFswIo7t7S3Jj
         YvB1yHN5PHhY5cv0NJt7nM5Yw8azkJdyBQ0QmaGPjx2YiNtiuL/aLN3AOYb28ifCRnXz
         Yy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279836; x=1762884636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZvB8XQL4XH/MG4JrDvft0iLE7MCAIYhxytBa3l55Ko=;
        b=rmLFxy5Gb3vYafx+uVctKu9sfZowBzmg+/REplbhCkeTtQL2i/4j+ExFKkMEsViuco
         LrILjvCuBRJKb80IMqahRIZJ3njUGzhdzkFoGMZw3kPUk4cIaiWgF6GrzlJgzuwK2Lvz
         aXbPQD5E2S5IV3K84zPcCbzyVmimNBpr/zNaMF9p8lL+zSEgBk869+/ZB2uJhsdezxD1
         MilB85CKdSVidRZE+Lws+VT6fWrPReANSNqNIfP8g6JyO1KOr2ywK/cMWJDcJWwqdyZq
         Rp7lSfCT+2uSK5KsAB5zr9uwPixeIpnVRGeJNY/6PIFkWnCv80vlhR9CkcH0D3M56kHx
         VsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJCFDs3jaZphC2RdXAke67dBYv1qP1QxG51PjJSuevu9/PCfhR+S3Id+Z2+ri09HvAjo8+6zKFLuBLAsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Q0oNT1jS3+iVgFiwfkEGwG0/XYMQGlB8TyVeYs9VNK74424/
	c5P6pRaNf+pi0LY4PbyWTwy/kVY385dlMOUZY4v5W7dNOgnYjPlqXy0Z
X-Gm-Gg: ASbGnct+pNRrEIKiEO5hHzRA8vjb2YC5lS33Ta7BmBhMlGQj8y8ZcRatYN5V6nBDs1I
	dpH7N6v6LXSqaCA8NtXsj9McYj9DysJgYxDeUcHa0FrEZtuTlPWgFRXXPL4pYb+NsF3KiL5YpOo
	xCYSlcf5rI7kcmeEbBVkWtGrA2mN6qHrpA9XU6e9GMtvAu8brm7G4ZaIHAoFnsyWI9DbKIiJLrm
	2+W2lmcPzzd/iQlM3hCXegN6xxJMNTryKqbxpqAQyNuRSUhcSIjyI7fEPll2fiRJ12rLTjAMFoq
	d1W6+Ti53bmYvoxXqOZ0FhexXxfQa54++V9ukDYMroCEMAbLsjIroy2c42qSagVWywJIzZPVDkH
	k5PFjBcut8GdA65q20vbb9S4xMUG5n0uYojo9Gt+3Td8csHWjJHyiGDDEPPkMeSnFkKrcvgBuh4
	moMbUUi+SF5YPjN6ocUATfcS3ETpWG
X-Google-Smtp-Source: AGHT+IGmzxfk1x8fnehx5VWjAyq7IZc2z//0VTUwWlUQBtF4GSFWekOx3YeV0AJtLvY7p2RmMGNybQ==
X-Received: by 2002:a05:600c:3110:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4775cdcfb32mr2222405e9.18.1762279835799;
        Tue, 04 Nov 2025 10:10:35 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:35 -0800 (PST)
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
Subject: [PATCH v2 27/30] drm/sun4i: mixer: split out layer config
Date: Tue,  4 Nov 2025 19:09:39 +0100
Message-ID: <20251104180942.61538-28-jernej.skrabec@gmail.com>
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

Later special plane only driver for DE33 will provide separate
configuration. This change will also help layer driver migrate away from
mixer structure.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- added missing .de_type kerneldoc

 drivers/gpu/drm/sun4i/sun8i_csc.c       |   2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 152 +++++++++++++++---------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  33 +++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  |   2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |   2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |   8 +-
 6 files changed, 123 insertions(+), 76 deletions(-)

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
index da3148f42646..4559e959a32d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -703,137 +703,173 @@ static void sun8i_mixer_remove(struct platform_device *pdev)
 }
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 432000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
-	.de_type = SUN8I_MIXER_DE2,
-	.vi_num = 2,
-	.ui_num = 1,
-	.vi_scaler_num	= 2,
-	.scaler_mask = 0x3,
-	.scanline_yuv = 2048,
-	.ccsc = CCSC_MIXER0_LAYOUT,
-	.mod_rate = 150000000,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 2,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
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
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0x1,
+		.scanline_yuv	= 1024,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0x1,
-	.scanline_yuv	= 1024,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 0,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER0_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 4096,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 4096,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
-	.ccsc		= CCSC_MIXER1_LAYOUT,
+	.lay_cfg = {
+		.ccsc		= CCSC_MIXER1_LAYOUT,
+		.de_type	= SUN8I_MIXER_DE2,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0x3,
+		.scanline_yuv	= 2048,
+		.de2_fcc_alpha	= 1,
+	},
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0x3,
-	.scanline_yuv	= 2048,
-	.de2_fcc_alpha	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
 
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
+	.lay_cfg = {
+		.de_type	= SUN8I_MIXER_DE3,
+		.vi_scaler_num	= 1,
+		.scaler_mask	= 0xf,
+		.scanline_yuv	= 4096,
+	},
 	.de_type	= SUN8I_MIXER_DE3,
 	.mod_rate	= 600000000,
-	.vi_scaler_num	= 1,
-	.scaler_mask	= 0xf,
-	.scanline_yuv	= 4096,
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
index 8c2e8005fc5b..5b6068755ad1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -164,34 +164,45 @@ enum sun8i_mixer_type {
 };
 
 /**
- * struct sun8i_mixer_cfg - mixer HW configuration
- * @vi_num: number of VI channels
- * @ui_num: number of UI channels
+ * struct sun8i_layer_cfg - layer configuration
  * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
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
- * @map: channel map for DE variants processing YUV separately (DE33)
  */
-struct sun8i_mixer_cfg {
-	int		vi_num;
-	int		ui_num;
+struct sun8i_layer_cfg {
 	unsigned int	vi_scaler_num;
 	int		scaler_mask;
 	int		ccsc;
-	unsigned long	mod_rate;
 	unsigned int	de_type;
 	unsigned int	scanline_yuv;
 	unsigned int	de2_fcc_alpha : 1;
-	unsigned int	map[6];
+};
+
+/**
+ * struct sun8i_mixer_cfg - mixer HW configuration
+ * @lay_cfg: layer configuration
+ * @vi_num: number of VI channels
+ * @ui_num: number of UI channels
+ * @de_type: sun8i_mixer_type enum representing the display engine generation.
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
2.51.2


