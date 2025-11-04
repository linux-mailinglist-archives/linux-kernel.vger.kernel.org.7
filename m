Return-Path: <linux-kernel+bounces-885317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29099C3294C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5931142905B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33390345CD6;
	Tue,  4 Nov 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmex1Yg1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A63451DE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279830; cv=none; b=jA8VZ/NYSakZcEBxqo0TX0/7rvMKsH5UlQt9QYY9T9FmlS4sDyc9T7rI001wryITXVdzOSNcPwOO+33fNHIUqXOXjGV0rPW256I3/gG4u1ow1VkjS6yWBag6n0rN6mN7UNjg8MhuzJRPMQC8cqkwj0UoYnfikphhLklV798D++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279830; c=relaxed/simple;
	bh=orhvpCnZQU+YiM6vENmZY8xT+JzEBx7B3ZDTqYXr+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1xBKrlBGVM7kcMFDghsrZO/FM4OoMu55EhJpDjrB6XN7EDH8w+aDdO4JLCjHxYNg3W3hhTx7fyBZTbzP9+nw4sMUJKa5+RjsTVZlghueQcIpP0DqDEZT8rQjW0UGxz8rxv3JvLFc3L9YPGS7mPlKVmJa2vZ8Rg4Zk/diGUzAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmex1Yg1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47118259fd8so43597195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279826; x=1762884626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXvWsmt1Dzl8GlEdRb8uf55RYf0uTWm1vCPWOIYaG+k=;
        b=Hmex1Yg1ICjUlcSCIHe3Ke45UnPTDtFF3la5JlpnCJAO231/13EC3zTB3m2kNJuJZs
         lCMkLRLmTCel/2Zg0D2aMj2JuAOtYnPBTJTESj+8DXS8QNGqILpiZWn6EzsMjPDWiHoI
         WsKczcr0WxAxe+vlrIj2tPh7DyWT2mBhikC4oYf+yjh6kxbAUZS/vEBkdRHyCWB8NPMA
         MJLkKRoJot5x+toeRbz8qHVqbWko9UusKihZYoYcmkXlhFfJ5GOErt4Srp3Mgymlzb8S
         oJJhKIiU0SPDmcAblh8LEAfvixqiIlNPAMe7sdAP2km1tTNxjuE7UHnS7SF1JRmCdeeQ
         DJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279826; x=1762884626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXvWsmt1Dzl8GlEdRb8uf55RYf0uTWm1vCPWOIYaG+k=;
        b=AJFMYBTzmxmLFOUBBE+kTBLNYY/mWz1FuSuI7Qz7baUzKW3imy55Srmsn7DDA8Yvvq
         7AGgMD9bG4x+3A57r8lWwouCRh9oNnPGfidc1ZsaGBusDjvj0k/qyGkIzNuOMmnuPPzs
         oYu9QMwMVR6CWKSbGmVKqyZ4wbc0tm5Yp4SuzlyAoAu8yBHKSzfSjEGopr0fCPbgMSco
         s9nsbOo0VsljIMTb8rN9XbZf8/ESmC2t6R1izTMFRS72PQlBdelTCXVPyTpoReB02+ER
         3U4aDzSbIP2lyKbkW9bQf7xpiDMmMFW0orIpcNcMbT394Nn+Wo8wph/q5XMNtx9AARVa
         8mnw==
X-Forwarded-Encrypted: i=1; AJvYcCUQt8Vx9mDLdBepckfZGEmez67viHUNAr3wtNSdgnqA4ptZId3B0wH0Qq6XPEFIJVpbpbWv9nqDah0sug0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6dBudL+tUHQuloU/WlWIo7OXIVxop0fBwYUlJaNxU5enp9Hv
	RTYZFG0QCABxFOvF+ZQE6O9rKSWplYVqQjJkgf02+EUNRqU3DgQ9O9+aT99W6w==
X-Gm-Gg: ASbGncufV69Up7ADtQvSZcZUZKseM3f/MeR7aw4pXZN26GHbaE9TnhpbSYVcS7fJcul
	MkmvngiCibZXjAvUh1Q0c+nV+L3hAUnMzxdVOSZlrMiptcvqT1cFIrHPLtSlJaz8qapLOk+Gijs
	MxDzQcAs2ZkBUwxT8NOK1tadBd85XkySlf6UFcvOx6qBhY5ZjW110ytRXJuwZG0gcV3/6o7IOg1
	6RROvL3l2x9K9rSmDnHOsq7tIr+r5Gf/KTURTYti0w//rvAStu0tI+X3slABlTXl98ZCo3YOVoI
	c8jqtpQX/sWuIIq1HZjNlnKZndvPBR+vmDFrQJ9rcKEHd4G99AGo6hy7dJoVQYjmwsLJYfNcW4Z
	Q4qtYU9Wd4pFpRXC7a6NVKYAxQuTw8qOozi7ycAegGTBrq/74CnCjm83cSBUyFTZ7jbppfOkNMz
	B9ktDqsCdQmeR7hHUAZQ==
X-Google-Smtp-Source: AGHT+IFE3mxZcmB3xFrOwCz13wK7MeGXCTbyLCsueT8YPunx796HFToC9lCdkfkmFYbtx1fnK13ZUA==
X-Received: by 2002:a05:600c:46ce:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4775cdcfbb5mr2723405e9.17.1762279825932;
        Tue, 04 Nov 2025 10:10:25 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:25 -0800 (PST)
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
Subject: [PATCH v2 19/30] drm/sun4i: vi_scaler: use layer instead of mixer for args
Date: Tue,  4 Nov 2025 19:09:31 +0100
Message-ID: <20251104180942.61538-20-jernej.skrabec@gmail.com>
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

Layer related peripherals should take layer struct as a input. This
looks cleaner and also necessary for proper DE33 support later.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
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
2.51.2


