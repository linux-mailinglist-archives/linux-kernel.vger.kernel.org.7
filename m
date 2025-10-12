Return-Path: <linux-kernel+bounces-849709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0193BD0B81
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE0E3B885F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03092FB0B6;
	Sun, 12 Oct 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksm1p0Vp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844482FABFE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297046; cv=none; b=lPm+mK8ecECMrBzu4zu+Fi2alNPKPVGWW0OO9HocXom92/pAo4MdePV1e+sJh9yu7WEB8zjLi4AcT62NwmvL+qDPusqcBrm0hbbwkpfKYFK5nczNJtxbnqsRhqSW4p/npY3WPz8Gm+8/Q3IHabodt85041EReT0G+g4g0a3meHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297046; c=relaxed/simple;
	bh=zbt5I065g6BO3drjKwx+RPXT/JavcO/tn3lo2YFsv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijULzyfN9ekPS8vRLc8JXNRlRda7Ccky9jbPgot2LW1Jtg3amCrftP1gdXqwqnSjjEXHWIXGERxXRqxZRqfHvl8O7zK+gTiJo/vkW6iy5YG9B/d13Z51CxEHo4Vnj7wRWkJrcG50WVO4wF21ZAMJzWiMlnB2C8N3+7ssM/z7tAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksm1p0Vp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e44f22f15so514477566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297043; x=1760901843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPg7C4Ufc4hWFOGmxU8Q0n2wES7W0TyH0ijKt94tsok=;
        b=Ksm1p0VppWCUhkeI04XZKMfxic5q/klt9iagrrBistACeqRfQ4UEWBfWsrt1o0/mfI
         LMtNYVGovakPTD5WpU2z73qRTzyTA4V5+xx8R+WmyHSwEbLQhN9iF+Q3L9mcYHZdOh6x
         Vb3Ia0V+F4gOvdIPKirkQPRsVdYp+wLXkSXgr8pY37VojKElfK/5M43QagTtcxt4cSRu
         5I9U6KkgJplqEreDGnTnNVOJXytLTAciJS6vn8zZT29Lo8357Z5G35utXpD6tqK37nG3
         RxM0fxhKPUf3AKZofHhB1FymUT73nDTl4C+J242fUOJ1P65cbo1dlsOFiVbIDNSt6rSY
         MLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297043; x=1760901843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPg7C4Ufc4hWFOGmxU8Q0n2wES7W0TyH0ijKt94tsok=;
        b=dKxcRxAuaf8hvz4SZzBJ5Q/X5HxbbmXvZQbaaGiWdZUtWD3oUVRAm2XZKQqRe8gn3z
         Rg7ATUwHfEsqXaQghC6NSz60hnNmffaofTeh8ye5SG8NGA02jrZWGozdP7v565sXP5O6
         XfRati/Yl4pn/FKtyvJNcCtOI02gptiWx7O0Vu9p9itPXM+I08uASa1t7K5ozJ1bW0Mx
         qqOolI1Se3Mh2Ai5BlC90I1o1hZzlkpWWC6cT1RV4yxpHvGSvf5anHtJKonvmaNKycR8
         jOlM+KNS8JgwkqQ7NuD9s+aLSWudDOILyao4Tk+MADFWNHYEIGw7HNBXSmCEquqVtids
         0W+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWfcTb1RcyCEBQBuV1rKJDEWumv3Jn2M3Gqpg5WMTlcqps9EkQakwbyYGs64Mhw9ZaF6H+sVturpTl1wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYmuOIak3ePAMZ3+sosvIO4MX/aVWCasvCtNi8kkOUjN6A+rs
	JkzZl7A6eNeAu5VIsIsTxka3xBJ9iVPGU4LX3rlLDO/Pg2NGPERSS9mp
X-Gm-Gg: ASbGncubrzutdJXTolOz0yQoTP5HND58+60yL4aXh1/i+T3P+P5bwFG8yC99GcLaiER
	ORexPMrvLgYGamh+KH7GpGW5svQ9nalcxSb4vHzt7NxfZHT61T05uE/xfvV4mLaS1BNfkQ5uVGR
	LLemOXVIKttsHpcUD6B4WnaL9OH1jvlnGvie3vWLkpOHFkWz+qq3wdtTI9SM1Kmy7YdphPyrEal
	WGcN/5uQFu+2u2YQubgiGMy6KzmsG6W2hs3YDRdl5Al9ztBTvCE5YipjwSeiDp2Tot87+gGIRx4
	MBMe0wGPAE8seaXF3VpoW/43itnrapcaTEAwjbOhcKU4IVwgCn8qKLe2LdZU0uw41s+RK8yAzLq
	NaYCd7RIEg2vev5M/f86NMahOjOY1Yuo/wNplVl2JnlIcQYUWUlztYe6GeKRJdWLboT0Ueq1nXk
	3A4gHLvToE7Pizh6xtnbe6jZrnmM9COpBybK3vbWWFtQ==
X-Google-Smtp-Source: AGHT+IFPlXF14w6080DzNThJvuRd4CnTuWjkOojD58VBx0OnrlrRgYOo8wgfu/qp0NZs9oaJy8dhYg==
X-Received: by 2002:a17:907:72cf:b0:b42:1324:7986 with SMTP id a640c23a62f3a-b50a9b61f8emr1913954466b.6.1760297042759;
        Sun, 12 Oct 2025 12:24:02 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:02 -0700 (PDT)
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
Subject: [PATCH 19/30] drm/sun4i: vi_scaler: use layer instead of mixer for args
Date: Sun, 12 Oct 2025 21:23:19 +0200
Message-ID: <20251012192330.6903-20-jernej.skrabec@gmail.com>
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

Layer related peripherals should take layer struct as a input. This
looks cleaner and also necessary for proper DE33 support later.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  |  9 ++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |  9 ++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 10 ++++++----
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 9b938e3dae9c..5167c9d7b9c0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -103,11 +103,10 @@ static void sun8i_ui_layer_update_coord(struct sun8i_layer *layer,
 		vscale = state->src_h / state->crtc_h;
 
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33) {
-			sun8i_vi_scaler_setup(mixer, layer->channel, src_w, src_h,
-					      dst_w, dst_h, hscale, vscale,
-					      hphase, vphase,
+			sun8i_vi_scaler_setup(layer, src_w, src_h, dst_w, dst_h,
+					      hscale, vscale, hphase, vphase,
 					      state->fb->format);
-			sun8i_vi_scaler_enable(mixer, layer->channel, true);
+			sun8i_vi_scaler_enable(layer, true);
 		} else {
 			sun8i_ui_scaler_setup(layer, src_w, src_h, dst_w, dst_h,
 					      hscale, vscale, hphase, vphase);
@@ -116,7 +115,7 @@ static void sun8i_ui_layer_update_coord(struct sun8i_layer *layer,
 	} else {
 		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
 		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-			sun8i_vi_scaler_enable(mixer, layer->channel, false);
+			sun8i_vi_scaler_enable(layer, false);
 		else
 			sun8i_ui_scaler_enable(layer, false);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index ba9c03f04f03..ce71625fa06f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -162,13 +162,12 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 		hscale = (src_w << 16) / dst_w;
 		vscale = (src_h << 16) / dst_h;
 
-		sun8i_vi_scaler_setup(mixer, layer->channel, src_w, src_h, dst_w,
-				      dst_h, hscale, vscale, hphase, vphase,
-				      format);
-		sun8i_vi_scaler_enable(mixer, layer->channel, true);
+		sun8i_vi_scaler_setup(layer, src_w, src_h, dst_w, dst_h,
+				      hscale, vscale, hphase, vphase, format);
+		sun8i_vi_scaler_enable(layer, true);
 	} else {
 		DRM_DEBUG_DRIVER("HW scaling is not needed\n");
-		sun8i_vi_scaler_enable(mixer, layer->channel, false);
+		sun8i_vi_scaler_enable(layer, false);
 	}
 
 	regmap_write(mixer->engine.regs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index 82df6244af88..a76677a1649f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -909,11 +909,12 @@ static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
 	}
 }
 
-void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable)
+void sun8i_vi_scaler_enable(struct sun8i_layer *layer, bool enable)
 {
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 val, base;
 
-	base = sun8i_vi_scaler_base(mixer, layer);
+	base = sun8i_vi_scaler_base(mixer, layer->channel);
 
 	if (enable)
 		val = SUN8I_SCALER_VSU_CTRL_EN |
@@ -925,16 +926,17 @@ void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable)
 		     SUN8I_SCALER_VSU_CTRL(base), val);
 }
 
-void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
+void sun8i_vi_scaler_setup(struct sun8i_layer *layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase,
 			   const struct drm_format_info *format)
 {
+	struct sun8i_mixer *mixer = layer->mixer;
 	u32 chphase, cvphase;
 	u32 insize, outsize;
 	u32 base;
 
-	base = sun8i_vi_scaler_base(mixer, layer);
+	base = sun8i_vi_scaler_base(mixer, layer->channel);
 
 	hphase <<= SUN8I_VI_SCALER_PHASE_FRAC - 16;
 	vphase <<= SUN8I_VI_SCALER_PHASE_FRAC - 16;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
index 68f6593b369a..73eecc4d1b1d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -69,8 +69,8 @@
 #define SUN50I_SCALER_VSU_ANGLE_SHIFT(x)		(((x) << 16) & 0xF)
 #define SUN50I_SCALER_VSU_ANGLE_OFFSET(x)		((x) & 0xFF)
 
-void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable);
-void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
+void sun8i_vi_scaler_enable(struct sun8i_layer *layer, bool enable);
+void sun8i_vi_scaler_setup(struct sun8i_layer *layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase,
 			   const struct drm_format_info *format);
-- 
2.51.0


