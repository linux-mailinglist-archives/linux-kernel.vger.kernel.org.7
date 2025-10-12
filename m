Return-Path: <linux-kernel+bounces-849696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF7BD0B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E14EA4A2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D62F5A01;
	Sun, 12 Oct 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHO4k0aG"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528182ED16C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297030; cv=none; b=hT6Z2FXODebXpQQ37Zujzp+xQHdGQpd9qw/SWHGrw7u6aShtjmdqQeePjD4b5b28Z9qaorBVQnIo1TBaoM/Xnc6LW7KULt8jmy+Sc6yMfLPMklqdstB7ZyU0fGG3HqaliqKloa9kDa3ErQvmRc08AnMLueRTzxJ3ZCI7HvpmaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297030; c=relaxed/simple;
	bh=fYfxHjveYeIdJwIqKXkDSJoPX/pUtAR0Msi7yyPkYBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtbXwVwDNSRkXU0n2cE44LP5erX8ikf9Yc24owAkEffrUscVA+2lbo5W9zAHUF9ye8NJmWqT5dJLZLqRKp6zreFvd1ZMddi7vXZP3OuH0Uf/TckW4NG4FSutvb7bti+J1EdUxSLdDj5YDdRZzP3a6L6uMN1VaPctTs9wrY5c4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHO4k0aG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so5668998a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297027; x=1760901827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhSOMeyyVEb/JHhqKdNE9M8XBPkXN/GvjKAdeA1KvOU=;
        b=GHO4k0aG5nkzItHEM3+ypmrqIkS7GMv18SNZ/Ar9eTkNMGpyMFGBNybQCZ52pPMbOY
         SZIZFQCpxX4Cget5PgXb86rt/tFcsPxetwdF+IguBE02RTK3QKsrBxUEIqiwOox88O+L
         Sa0aFgqV15ahbbEEiOK3pCKz6dUNXpD0dqK6uIugm7eFuPUAoPdOXlDtJ1z78LNHSmU2
         U/MCmnEHFgSHvZrbUa2b70FTiGTlBVhdw255ucSmOZ7ljmLnSqY9zQ3b5RTJaGqjnQ54
         SM5szO4nuaiWoioT96CIGKGm5vLnY/cArjp8Sikq+PP4NhR+HE3vJVtl3IHO7JE5cnVS
         7wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297027; x=1760901827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhSOMeyyVEb/JHhqKdNE9M8XBPkXN/GvjKAdeA1KvOU=;
        b=uaygFxNi8gAm+ixH6AexY/SHw031I+c3rcF8QwIvcz2NE3SwV04EcA4lzoBdln7doW
         kWzv0BxGZl6IaCLavWvvwTBdYYpe3/OwjA0fsqJMe27dBAXSf4em7/VyypXoyTpRCsh6
         XjZSnT+Xs2BpT1p25Oss0iYIr0vAJ5Hs8ATQRtWLFmZATlTA4Zp/zsvfwFGIFYz2sbCZ
         uyUNI/ai3t/CFkeKSzxDkAR8fBSknv7Wvl/IMc1s4di3AhBTtQtyPixzOHnIk6xv0qMZ
         ijKntpXdskkKUD51AhQOLCx14eNPIFJPvwuCrXKaJgjhcdwNj8/HaiQ3w9Z0vnw0vwgM
         XYnA==
X-Forwarded-Encrypted: i=1; AJvYcCVizrzzpm3BlQI4/MSs55e2dShqNvWokVasYHRK2qCuNQ9NyXh0g1crT8/9OaIFl/aeREqhTES1Gj5Q5a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFr/h30areIl/KYWIT2b6O++pXUvr1jiRzpCPTY2/uJBdNzKE
	NAMk7TD3L/1CJ89ggnzvZolUw/G2CrPvoraBHUq4nusmvFTLbURmwtGe
X-Gm-Gg: ASbGncvegl1vJ+/cHCAhdUoTV+eFTfaZ1IzVv0Lk+iLyRCU3+ykCu+c+TWFMG6KbhCI
	qMh60xuqXT20S/F/W7uMHprZTxEIYc3+MFcrsAaOcYeOxOmcWYhE+UWJrSJm1hprw0CwQGECFq+
	nQ4REpL+g+J66+jWSYyvFdJmqNxHNCK2yux9VE5xyKi65XxfREyNKXXO9XiXx3fXQ2kp5OuVySf
	DXjB94g4KARs1farsajlq2fFDlNj8cjICeRHKOHsLWWwzA31s1NCmqHb09efaHMS7tOKjSa1/K9
	subDMkdUX+euiUwjL+gzHFf1sH2LY7yskSJ4J0YDdDPY7zdUnmvIrrwQcCU1EXUu1uVT4AsFJKV
	JhIYZOlmLh7TEfw53nRGocBlo7zYIRXLLWA84I2m34ws6tci4W70yZiCHWnUFGu/iv3kb++ijnZ
	R3DmfXZZTVHHuRWxC29m18
X-Google-Smtp-Source: AGHT+IFUbJ+FjAjKKsg6YJWZVxyDF8HU9W9iTbhFx8UICuTNacj1eC7uib49tuv2zK9lGVgNU785TQ==
X-Received: by 2002:a17:907:72cf:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b50aa69e311mr1981823466b.7.1760297026601;
        Sun, 12 Oct 2025 12:23:46 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:46 -0700 (PDT)
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
Subject: [PATCH 06/30] drm/sun4i: layers: Make atomic commit functions void
Date: Sun, 12 Oct 2025 21:23:06 +0200
Message-ID: <20251012192330.6903-7-jernej.skrabec@gmail.com>
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

Functions called by atomic_commit callback should not fail. None of them
actually returns error, so make them void.

No functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 20 +++++++-------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 +++++++-------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index fce7b265c5d8..8baa1d0b53bd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -46,9 +46,9 @@ static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 			   mask, val);
 }
 
-static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-				       int overlay, struct drm_plane *plane,
-				       unsigned int zpos)
+static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane,
+					unsigned int zpos)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 src_w, src_h, dst_w, dst_h;
@@ -124,12 +124,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(bld_regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
-
-	return 0;
 }
 
-static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
+					  int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *fmt;
@@ -144,12 +142,10 @@ static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
-
-	return 0;
 }
 
-static int sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
@@ -184,8 +180,6 @@ static int sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
 		     lower_32_bits(dma_addr));
-
-	return 0;
 }
 
 static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index c80bdece5ffc..dae6f83cea6e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -48,9 +48,9 @@ static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
-static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-				       int overlay, struct drm_plane *plane,
-				       unsigned int zpos)
+static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane,
+					unsigned int zpos)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *format = state->fb->format;
@@ -191,8 +191,6 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(bld_regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
-
-	return 0;
 }
 
 static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
@@ -211,8 +209,8 @@ static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
 	}
 }
 
-static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
+					  int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 val, ch_base, csc_mode, hw_fmt;
@@ -246,12 +244,10 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
-
-	return 0;
 }
 
-static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
@@ -305,8 +301,6 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 								 overlay, i),
 			     lower_32_bits(dma_addr));
 	}
-
-	return 0;
 }
 
 static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
-- 
2.51.0


